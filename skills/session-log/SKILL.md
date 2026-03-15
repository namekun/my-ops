---
name: session-log
description: Summarize today's session and log the work to Notion.
---

# Session Log (Notion)

## Prerequisites
- Check if `.my-ops-config.json` exists. If not, tell the user to run `/my-ops:setup` first.
- Verify the Notion MCP server is connected.

## Steps

### 1. Load Configuration
Read Notion settings and session log format from `.my-ops-config.json`.

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

### 3. Create Notion Page
Use Notion MCP tools to write to the configured page/database.

#### Page Format
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

#### Database Format (if type is database)
Add a new entry to the database. Map properties to match the database schema.

### 4. Confirm
- Show the user the created Notion page link
- Ask if anything needs to be added or changed
