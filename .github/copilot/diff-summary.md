# my-ops Diff Summary

When the user asks to "diff summary", "변경 요약", "뭐 바꿨지", or "what changed", run this process.

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Collect Changes
- `git diff --cached --stat` / `git diff --cached` — staged
- `git diff --stat` / `git diff` — unstaged
- Prioritize staged; fall back to unstaged

### 2. Analyze
For each file determine:
- Change type: new, modified, deleted, renamed
- Category: logic, refactor, style, config, test, docs
- Impact: High, Medium, Low

### 3. Display Summary
- Overview (files, lines added/removed)
- Changes grouped by impact level
- Risk areas
- Suggested reviewers (from git blame)

### 4. Next Steps
Suggest: commit, review, or pre-commit check.
