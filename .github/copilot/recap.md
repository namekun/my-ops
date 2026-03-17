# my-ops Work Recap

When the user asks to "recap", "어제 뭐했지", "작업 내역", or "standup", run this process.

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Determine Time Range
- Default: yesterday (00:00 to 23:59)
- Adjust if user specifies a different range

### 2. Collect Data
- `git log --oneline --since="yesterday 00:00" --until="today 00:00" --author="$(git config user.name)"` — commits
- `git log --since="yesterday 00:00" --until="today 00:00" --name-status --pretty=format:""` — changed files
- `git reflog --since="yesterday 00:00" --until="today 00:00"` — branch activity

### 3. Display Results
- Commits with hashes
- Files changed (created, modified, deleted)
- Branches worked on
- Brief summary of the day's work

### 4. Offer Next Steps
- Format as standup message
- Show specific commit details
