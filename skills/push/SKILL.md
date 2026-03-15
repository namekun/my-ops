---
name: push
description: Push the current branch to the remote.
---

# Git Push

## Steps

### 1. Check Status
- Verify the current directory is a git repository
- Run `git status` to check for uncommitted changes
- If uncommitted changes exist, inform the user and ask whether to commit first

### 2. Check Branch and Remote
- `git branch --show-current` — current branch
- `git remote -v` — remote info
- Check if a remote tracking branch is set

### 3. Confirm Before Push
Show the following and get user confirmation:
- Current branch: `feature/xxx`
- Remote: `origin`
- Number of commits to push (if any)

**Important**:
- NEVER force push to `main` or `master`
- Only use `--force` if the user explicitly requests it

### 4. Push
- If no remote tracking: `git push -u origin <branch>`
- If tracking exists: `git push`

### 5. Show Result
Briefly display the push result.
