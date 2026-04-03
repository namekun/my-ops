---
name: recap
description: "Use when the user asks to summarize yesterday's work, daily recap, or work history. Triggers: 'recap', '어제 작업', '작업 요약', '데일리 정리', 'work recap', 'what did I do yesterday', '어제 뭐 했어'"
---

# Work Recap

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Determine Time Range
- Default: yesterday (from 00:00 to 23:59)
- If the user specifies a different range (e.g., "last 3 days", "this week"), adjust accordingly
- Use absolute date formats for git commands (e.g., `--since="2025-01-15" --until="2025-01-16"`)

### 2. Collect Commit History
Run:
- `git log --oneline --since="yesterday 00:00" --until="today 00:00" --author="$(git config user.name)"` — commits from yesterday
- If no commits found with author filter, try without it and note the authors

### 3. Collect Changed Files
Run:
- `git log --since="yesterday 00:00" --until="today 00:00" --name-status --pretty=format:""` — files changed with status (A/M/D)
- Categorize: created, modified, deleted
- Deduplicate file entries

### 4. Summarize Branches Worked On
Run:
- `git log --since="yesterday 00:00" --until="today 00:00" --pretty=format:"%D" | sort -u` — branches referenced
- Or `git reflog --since="yesterday 00:00" --until="today 00:00"` for branch switch history

### 5. Display Results
Present the recap in a clear format:

```
📋 Work Recap — 2025-01-15 (Yesterday)

## Commits (N total)
- abc1234 feat: add login page
- def5678 fix: resolve button alignment
- ...

## Files Changed
- Created: src/login.tsx, src/auth.ts
- Modified: src/app.tsx, package.json
- Deleted: src/old-login.tsx

## Branches
- feature/auth (5 commits)
- main (1 commit)

## Summary
(Brief AI-generated summary of the day's work based on commit messages)
```

### 6. Offer Next Steps
Suggest useful follow-ups:
- "Need a standup message? I can format this for you."
- "Want to see a specific commit in detail?"
