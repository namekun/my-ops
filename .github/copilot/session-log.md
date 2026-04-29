# my-ops Session Log (Notion / Obsidian)

When the user asks to "session log", "세션 기록", or "오늘 기록", run this process.

## Prerequisites
- Check if `.my-ops-config.json` exists. If not, tell the user to run setup first.
- Read `sessionLog.destination` (`notion`, `obsidian`, or `both`).
- For Notion: Notion API access is required.
- For Obsidian: `obsidian.vaultPath` must exist and be writable.

## Steps

### 1. Load Configuration
Read session log destination, Notion settings, Obsidian settings, and session log format from `.my-ops-config.json`.

### 2. Collect Session Content
Gather the following from the current conversation:

#### Conversation Summary (includeSummary)
- Summarize what was done in this session in 3-5 lines
- Include key decisions and discussion points

#### Changed Files (includeFiles)
- Use `git diff --name-only HEAD~N` etc. to identify files changed during the session
- Categorize: created, modified, deleted

#### Commit History (includeCommits)
- List commits made during the session
- Use `git log --oneline --since="today"` etc.

#### Lessons Learned / TIL (includeTIL)
- New discoveries, solved problems, useful patterns from the session
- Extract from conversation content

### 3. Write Session Log

Branch on `sessionLog.destination`:

#### If destination is `notion` or `both`
Use the Notion API to write to the configured page/database.

##### Page Format
```
Title: [project-name] YYYY-MM-DD Session Log

## Summary
(conversation summary)

## Changed Files
- Created: file1.ts, file2.ts
- Modified: file3.ts
- Deleted: file4.ts

## Commits
- abc1234 feat: add login feature
- def5678 fix: fix button bug

## TIL
- (lessons learned)

## Notes
(user custom fields)
```

##### Database Format (if type is database)
Add a new entry to the database. Map properties to match the database schema.

#### If destination is `obsidian` or `both`
Write a markdown file into the configured Obsidian vault.

1. Resolve target path: `<vaultPath>/<folder>/<filename>`. Substitute `YYYY`, `MM`, `DD` with today's date and `{project}` with the current project's directory name.
2. Create the folder if it does not exist.
3. If the file exists and `appendIfExists` is true, append a new section under a `## HH:MM Session` heading. Otherwise, create the file.
4. Include YAML frontmatter only when creating a new file.

##### Markdown Format
```markdown
---
title: "[project-name] YYYY-MM-DD Session Log"
date: YYYY-MM-DD
project: project-name
tags: [session-log, my-ops]
---

# [project-name] YYYY-MM-DD Session Log

## Summary
(conversation summary)

## Changed Files
- Created: file1.ts, file2.ts
- Modified: file3.ts
- Deleted: file4.ts

## Commits
- abc1234 feat: add login feature
- def5678 fix: fix button bug

## TIL
- (lessons learned)

## Notes
(user custom fields)
```

### 4. Confirm
- Show the user what was created:
  - For Notion: the page link.
  - For Obsidian: the absolute file path.
- Ask if anything needs to be added or changed.
