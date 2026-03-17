# my-ops Pull Request / Merge Request Creation

When the user asks to "create PR", "PR 만들어", "풀리퀘", or "PR", run this process.

## Prerequisites
- Verify the current directory is a git repository.
- Detect platform from `git remote get-url origin`:
  - `github.com` → GitHub (`gh` CLI)
  - `gitlab.com` or `gitlab` → GitLab (`glab` CLI)
  - `bitbucket.org` or `bitbucket` → Bitbucket (API)
- Check the appropriate CLI is installed.

## Steps

### 1. Analyze Current Branch
- `git branch --show-current` — current branch
- `git log main..HEAD --oneline` — commits on this branch
- `git diff main...HEAD --stat` — changed files

If on `main`/`master`, tell the user to create a feature branch first.

### 2. Generate PR/MR Title and Description
- Title: under 70 characters, follows commit convention
- Body: Summary (1-3 bullets), Changes list, Test plan checklist

### 3. Show Preview and Confirm
Display generated content. Let user edit, add labels or reviewers.

### 4. Push and Create PR/MR
- Push if needed: `git push -u origin <branch>`
- GitHub: `gh pr create --title "..." --body "..."`
- GitLab: `glab mr create --title "..." --description "..."`
- Bitbucket: API via `curl`

### 5. Show Result
Display PR/MR URL and number.
