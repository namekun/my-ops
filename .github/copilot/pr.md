# my-ops Pull Request Creation

When the user asks to "create PR", "PR 만들어", "풀리퀘", or "PR", run this process.

## Prerequisites
- Verify the current directory is a git repository.
- Check that `gh` CLI is installed and authenticated.

## Steps

### 1. Analyze Current Branch
- `git branch --show-current` — current branch
- `git log main..HEAD --oneline` — commits on this branch
- `git diff main...HEAD --stat` — changed files

If on `main`/`master`, tell the user to create a feature branch first.

### 2. Generate PR Title and Description
- Title: under 70 characters, follows commit convention
- Body: Summary (1-3 bullets), Changes list, Test plan checklist

### 3. Show Preview and Confirm
Display generated content. Let user edit, add labels or reviewers.

### 4. Push and Create PR
- Push if needed: `git push -u origin <branch>`
- Create: `gh pr create --title "..." --body "..."`

### 5. Show Result
Display PR URL and number.
