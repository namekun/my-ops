#!/bin/sh
# my-ops: archive the raw conversation transcript before detail is lost.
#
# Runs on PreCompact (context is about to be summarized away) and SessionEnd
# (session finished without ever compacting). Pure file copy — no model call,
# no token cost, no interpretation. Preserving the original is the whole job;
# reading it back is the `recall` skill's problem.
#
# Reads hook JSON on stdin: transcript_path, session_id, cwd.
# Reads archive settings from <cwd>/.my-ops-config.json.
# Exits 0 in every non-fatal case so it can never block compaction.

set -u

INPUT=$(cat)

# --- JSON field extraction -------------------------------------------------
# Prefer jq, then python3, then a grep/sed fallback. Values we need are flat
# strings (filesystem paths, ids) with no escaped quotes, so the fallback holds.
json_get() {
  _key=$1
  _src=$2
  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$_src" | jq -r --arg k "$_key" '
      if type == "object" and .[$k] != null then .[$k] else empty end' 2>/dev/null
  elif command -v python3 >/dev/null 2>&1; then
    printf '%s' "$_src" | python3 -c '
import json,sys
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
v = d.get(sys.argv[1])
if isinstance(v, (str, int, float)):
    print(v)
' "$_key" 2>/dev/null
  else
    printf '%s' "$_src" \
      | grep -o "\"$_key\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" \
      | head -1 \
      | sed 's/.*:[[:space:]]*"\(.*\)"$/\1/'
  fi
}

# Nested lookup for config keys like obsidian.vaultPath.
config_get() {
  _path=$1
  _file=$2
  [ -f "$_file" ] || return 0
  if command -v jq >/dev/null 2>&1; then
    # Not `// empty` — jq's alternative operator treats a literal `false` as
    # absent, which would silently ignore `archive.enabled: false`.
    jq -r "if (.$_path) == null then empty else (.$_path) end" "$_file" 2>/dev/null
  elif command -v python3 >/dev/null 2>&1; then
    python3 -c '
import json,sys
try:
    d = json.load(open(sys.argv[1]))
except Exception:
    sys.exit(0)
cur = d
for part in sys.argv[2].split("."):
    if not isinstance(cur, dict) or part not in cur:
        sys.exit(0)
    cur = cur[part]
if isinstance(cur, bool):
    print("true" if cur else "false")
elif isinstance(cur, (str, int, float)):
    print(cur)
' "$_file" "$_path" 2>/dev/null
  else
    # Fallback handles only the leaf key name; adequate for our flat settings.
    _leaf=$(printf '%s' "$_path" | sed 's/.*\.//')
    grep -o "\"$_leaf\"[[:space:]]*:[[:space:]]*\(\"[^\"]*\"\|true\|false\)" "$_file" \
      | head -1 \
      | sed 's/.*:[[:space:]]*//; s/^"//; s/"$//'
  fi
}

TRANSCRIPT=$(json_get transcript_path "$INPUT")
SESSION_ID=$(json_get session_id "$INPUT")
PROJECT_DIR=$(json_get cwd "$INPUT")

[ -n "${PROJECT_DIR:-}" ] || PROJECT_DIR=$(pwd)
[ -n "${TRANSCRIPT:-}" ] || exit 0
[ -f "$TRANSCRIPT" ] || exit 0

CONFIG="$PROJECT_DIR/.my-ops-config.json"
[ -f "$CONFIG" ] || exit 0

# --- resolve destination ---------------------------------------------------
ENABLED=$(config_get 'archive.enabled' "$CONFIG")
[ "$ENABLED" = "false" ] && exit 0

VAULT=$(config_get 'obsidian.vaultPath' "$CONFIG")
[ -n "${VAULT:-}" ] || exit 0

# Expand a leading ~ (config files commonly store it unexpanded).
case "$VAULT" in
  "~"/*) VAULT="$HOME/${VAULT#\~/}" ;;
  "~")   VAULT="$HOME" ;;
esac
[ -d "$VAULT" ] || exit 0

FOLDER=$(config_get 'obsidian.folder' "$CONFIG")
[ -n "${FOLDER:-}" ] || FOLDER="Sessions"

RAW_FOLDER=$(config_get 'archive.rawFolder' "$CONFIG")
[ -n "${RAW_FOLDER:-}" ] || RAW_FOLDER=".transcripts"

# Dot-prefixed by default so Obsidian keeps raw JSONL out of the note graph
# while it still travels with the vault.
DEST_DIR="$VAULT/$FOLDER/$RAW_FOLDER"
mkdir -p "$DEST_DIR" 2>/dev/null || exit 0

PROJECT=$(basename "$PROJECT_DIR")
DATE=$(date +%Y-%m-%d)
SHORT_ID=$(printf '%s' "${SESSION_ID:-unknown}" | cut -c1-8)
DEST="$DEST_DIR/$DATE-$PROJECT-$SHORT_ID.jsonl"

# --- copy, never shrink ----------------------------------------------------
# A session can fire this hook several times (repeated compaction, then
# SessionEnd). The transcript grows, so the latest copy is the most complete —
# but guard against a truncated/lagging read replacing a good archive.
if [ -f "$DEST" ]; then
  OLD_SIZE=$(wc -c < "$DEST" 2>/dev/null | tr -d ' ')
  NEW_SIZE=$(wc -c < "$TRANSCRIPT" 2>/dev/null | tr -d ' ')
  [ -n "${OLD_SIZE:-}" ] || OLD_SIZE=0
  [ -n "${NEW_SIZE:-}" ] || NEW_SIZE=0
  [ "$NEW_SIZE" -lt "$OLD_SIZE" ] && exit 0
fi

cp "$TRANSCRIPT" "$DEST" 2>/dev/null || exit 0

# --- index -----------------------------------------------------------------
# One TSV line per archive so `recall` can narrow candidates without opening
# any JSONL. Rewrites the row on repeat fires instead of appending duplicates.
# Strip tabs/newlines from every field — a stray one corrupts the TSV row and
# silently breaks dedup. `rev-parse` prints "HEAD" *and* exits non-zero in a
# repo with no commits, so take the first line rather than trusting the status.
sanitize() { printf '%s' "$1" | head -1 | tr -d '\t\r\n'; }

BRANCH=$(sanitize "$(git -C "$PROJECT_DIR" rev-parse --abbrev-ref HEAD 2>/dev/null)")
[ -n "${BRANCH:-}" ] || BRANCH="-"
EVENT=$(sanitize "$(json_get hook_event_name "$INPUT")")
[ -n "${EVENT:-}" ] || EVENT="-"
PROJECT=$(sanitize "$PROJECT")
INDEX="$DEST_DIR/index.tsv"

if [ ! -f "$INDEX" ]; then
  printf 'date\tproject\tbranch\tevent\tsession\tfile\n' > "$INDEX" 2>/dev/null || exit 0
fi

TMP="$INDEX.tmp.$$"
grep -v "	$SHORT_ID	" "$INDEX" > "$TMP" 2>/dev/null || cp "$INDEX" "$TMP" 2>/dev/null
printf '%s\t%s\t%s\t%s\t%s\t%s\n' \
  "$DATE" "$PROJECT" "$BRANCH" "$EVENT" "$SHORT_ID" "$(basename "$DEST")" >> "$TMP"
mv "$TMP" "$INDEX" 2>/dev/null || rm -f "$TMP" 2>/dev/null

exit 0
