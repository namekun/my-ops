---
name: recall
description: Search archived session transcripts to recover detail that context compaction dropped. Use when the user asks why something was built a certain way, what was tried before, or to dig up specifics from a past session.
---

# Recall (Archived Session Detail)

Compaction replaces conversation history with a summary — the specifics (what
was tried, what failed, why an approach was rejected) are gone from context but
still exist in the archived transcript. This skill digs them back out.

## Prerequisites
- Check `.my-ops-config.json` exists. If not, tell the user to run setup first.
- Resolve the archive directory: `<obsidian.vaultPath>/<obsidian.folder>/<archive.rawFolder>`
  (defaults: folder `Sessions`, rawFolder `.transcripts`).
- If the directory or `index.tsv` is missing, tell the user no sessions have been
  archived yet and stop. Do not fall back to reading the current conversation.

## Core rule: never load a whole transcript

Archived transcripts are raw JSONL and can be very large. Loading one into
context defeats the purpose. Always narrow first, then extract only matching
regions. If a candidate file is over ~200KB, extraction via shell is mandatory —
never `Read` it whole.

## Steps

### 1. Narrow with the index (cheap)
Read `<archive>/index.tsv`. Columns: `date  project  branch  event  session  file`.

Filter to the current project by default (directory name of the repo root).
Apply whatever the user gave you — a date, a branch, "last week", a feature name.

If more than ~8 candidates remain, show them and ask the user to narrow before
searching. Otherwise search all remaining candidates directly.

### 2. Search inside candidates
Derive 2-4 search keywords from the user's question, including likely synonyms
and any identifiers (file names, function names, error strings).

Search across candidate files without loading them:

```bash
grep -ril "<keyword>" <archive>/*.jsonl
```

Then pull matching regions only. Prefer `jq` when available, since it turns
JSONL into readable text instead of raw JSON noise:

```bash
# readable text of matching messages
jq -r 'select(.message.content != null)
       | .message.content
       | if type == "array" then map(select(.type=="text") | .text) | join("\n")
         else tostring end' <file> 2>/dev/null | grep -i -C 3 "<keyword>"
```

Fallback when `jq` is unavailable:

```bash
grep -i -o '.\{0,300\}<keyword>.\{0,300\}' <file>
```

Cap what you pull into context. Aim for the ~10 most relevant excerpts; if
matches are overwhelming, tighten the keywords and search again rather than
widening the excerpt window.

### 3. Answer from evidence
Answer the user's actual question, citing which session each finding came from:

```
🔍 Recall — "왜 인증을 미들웨어로 뺐지"

## 2026-07-14 (feature/auth)
- 라우트별 처리로 먼저 시도 → 3개 라우트에서 토큰 갱신이 중복됨
- 미들웨어로 옮긴 이유: 갱신 로직을 한 곳으로 모으기 위해
- 검토했다 버린 안: 데코레이터 방식 (테스트에서 mocking이 어려움)

## 2026-07-16 (feature/auth)
- 미들웨어 순서 이슈 — CORS보다 뒤에 와야 함
```

State plainly when the archives do not contain the answer. Do not fill gaps
with plausible reconstruction — an invented rationale is worse than "기록에 없음",
because the whole point of the archive is that it is the record.

### 4. Offer to promote (optional)
If the finding is durable knowledge — a decision, a constraint, a trap worth
remembering — offer to write it into a permanent note so it never has to be
recovered from a transcript again:

- `<vaultPath>/<folder>/<project> Decisions.md` — why something was built this way
- `<vaultPath>/<folder>/<project> Gotchas.md` — traps, ordering constraints, footguns

Append an entry with the date, a wikilink back to the session note, and the
finding. Only do this when the user agrees.

```markdown
## 2026-07-14 — 인증을 미들웨어로 통합
라우트별 처리는 토큰 갱신이 중복됨. 데코레이터 방식은 테스트 mocking 문제로 제외.
미들웨어는 CORS 뒤에 위치해야 함.

출처: [[2026-07-14-myproject]]
```

This is the payoff: recovered detail becomes a note you can read directly next
time, so the same question never costs a transcript search twice.
