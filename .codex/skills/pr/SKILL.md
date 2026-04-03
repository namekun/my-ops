---
name: pr
description: "Use when the user asks to create a pull request, open a PR/MR, or submit changes for review. Triggers: 'pr', 'pull request', 'PR 만들어줘', 'PR 생성', 'merge request', 'MR 생성', 'create pr', '풀리퀘스트'"
---

# Pull Request Creation

## Prerequisites
- Verify the current directory is a git repository.
- Detect the git platform (see "Platform Detection" below).
- Check the appropriate CLI is installed and authenticated.
- Ensure there are commits to include in the PR/MR.

## Platform Detection
Detect the platform from the remote URL by running `git remote get-url origin`:
- Contains `github.com` → **GitHub** (use `gh` CLI)
- Contains `gitlab.com` or `gitlab` in hostname → **GitLab** (use `glab` CLI)
- Contains `bitbucket.org` or `bitbucket` in hostname → **Bitbucket** (use Bitbucket API via `curl`)

If `.my-ops-config.json` has a `gitPlatform` field, use that as override.
If the platform cannot be detected, ask the user.

## Steps

### 1. Analyze Current Branch
Run:
- `git branch --show-current` — current branch name
- `git log main..HEAD --oneline` (or `master..HEAD`) — commits on this branch
- `git diff main...HEAD --stat` — changed files summary

If the branch is `main` or `master`, inform the user: "You're on the default branch. Create a feature branch first."

### 2. Determine Base Branch
If `.my-ops-config.json` exists, use `gitWorkflow` and `branches` settings:
- **Git Flow**: feature/fix branches → `develop`, hotfix/release branches → `main`
- **GitHub Flow / Trunk-based**: always → `main` (or `master`)
- **Custom**: use configured `branches.main` value

If no config exists, try `main` first, then `master`.
If neither exists, ask the user which branch to target.

### 3. Generate PR Title and Description
Based on the commits and diff:

**Title**:
- If `.my-ops-config.json` exists, follow the commit convention style
- Keep under 70 characters
- Focus on the overall change, not individual commits

**Description**:
- Generate a `## Summary` section with 1-3 bullet points
- Generate a `## Changes` section listing key modifications
- Generate a `## Test plan` section with a checklist
- If there are multiple commits, summarize the progression

### 4. Show Preview and Confirm
Display the generated title and description. Ask the user:
- Confirm or edit the title
- Confirm or edit the description
- Add labels, reviewers, or assignees (optional)

### 5. Push and Create PR/MR
- If the branch has no remote tracking: `git push -u origin <branch>`
- Create PR/MR using the detected platform CLI:

**GitHub** (`gh`):
```
gh pr create --title "title" --body "body"
```
- Add labels: `--label "label1,label2"`
- Add reviewers: `--reviewer "user1,user2"`

**GitLab** (`glab`):
```
glab mr create --title "title" --description "body"
```
- Add labels: `--label "label1,label2"`
- Add reviewers: `--reviewer "user1,user2"`

**Bitbucket** (API via `curl`):
```
curl -X POST -u "$BITBUCKET_USER:$BITBUCKET_APP_PASSWORD" \
  "https://api.bitbucket.org/2.0/repositories/{owner}/{repo}/pullrequests" \
  -H "Content-Type: application/json" \
  -d '{"title": "title", "description": "body", "source": {"branch": {"name": "<branch>"}}, "destination": {"branch": {"name": "main"}}}'
```

If the CLI for the detected platform is not installed, show installation instructions:
- GitHub: `brew install gh` / `apt install gh`
- GitLab: `brew install glab` / `apt install glab`
- Bitbucket: Requires `BITBUCKET_USER` and `BITBUCKET_APP_PASSWORD` env vars

### 6. Show Result
Display:
- PR/MR URL
- PR/MR number
- Status
