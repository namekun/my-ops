# my-ops Recall (Archived Session Detail)

When the user says "recall", "예전에 왜 이렇게 했지", "전에 뭐 시도했지", or asks for
specifics from a past session, run this process.

Compaction replaces conversation history with a summary — specifics survive only
in the archived transcript. This digs them back out.

## Prerequisites
- Check `.my-ops-config.json` exists. If not, tell the user to run setup first.
- Archive directory: `<obsidian.vaultPath>/<obsidian.folder>/<archive.rawFolder>`
  (defaults: folder `Sessions`, rawFolder `.transcripts`).
- If the directory or `index.tsv` is missing, say no sessions are archived yet and stop.

> Transcript archiving is written by the Claude Code hook. In Copilot you can read
> and search existing archives, but new sessions here are not auto-archived.

## Core rule: never load a whole transcript

Archived transcripts are raw JSONL and can be large. Narrow first, then extract
only matching regions. Never read a large transcript whole.

## Steps

### 1. Narrow with the index
Read `<archive>/index.tsv` — columns `date  project  branch  event  session  file`.
Filter to the current project, then apply the user's hint (date, branch, feature name).
If more than ~8 candidates remain, show them and ask the user to narrow.

### 2. Search inside candidates
Derive 2-4 keywords (include identifiers: file names, function names, error strings).

```bash
grep -ril "<keyword>" <archive>/*.jsonl
```

Extract matching regions only:

```bash
jq -r 'select(.message.content != null)
       | .message.content
       | if type == "array" then map(select(.type=="text") | .text) | join("\n")
         else tostring end' <file> 2>/dev/null | grep -i -C 3 "<keyword>"
```

Fallback without `jq`:

```bash
grep -i -o '.\{0,300\}<keyword>.\{0,300\}' <file>
```

Aim for the ~10 most relevant excerpts. If matches overwhelm, tighten keywords
rather than widening the excerpt window.

### 3. Answer from evidence
Answer the question, citing the session each finding came from (date + branch).

Say plainly when the archives do not contain the answer. Never fill gaps with
plausible reconstruction — an invented rationale defeats the purpose of a record.

### 4. Offer to promote (optional)
If the finding is durable, offer to append it to a permanent note so it never has
to be recovered again:

- `<vaultPath>/<folder>/<project> Decisions.md`
- `<vaultPath>/<folder>/<project> Gotchas.md`

Include the date, the finding, and a `[[wikilink]]` back to the session note.
Only write when the user agrees.
