# my-ops Issue Creation

When the user asks to "issue", "이슈 만들어", "이슈", or "bug report", run this process.

## Prerequisites
- Verify git repo with a remote.
- Detect platform from `git remote get-url origin`:
  - `github.com` → GitHub (`gh` CLI)
  - `gitlab.com` or `gitlab` → GitLab (`glab` CLI)
  - `bitbucket.org` or `bitbucket` → Bitbucket (API)
- Check the appropriate CLI is installed.

## Steps

### 1. Get Description
Accept natural language description of the issue.

### 2. Determine Type
Infer: Bug, Feature, Enhancement, Documentation

### 3. Generate Content
- Title: concise, under 70 chars
- Body: structured template based on type

### 4. Preview and Confirm
Show generated content. Let user edit, add labels, assign.

### 5. Create Issue
- GitHub: `gh issue create --title "..." --body "..." --label "..."`
- GitLab: `glab issue create --title "..." --description "..." --label "..."`
- Bitbucket: API via `curl`

### 6. Show Result
Display issue URL and number. Suggest creating a branch.
