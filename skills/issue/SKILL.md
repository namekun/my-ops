---
name: issue
description: Create an issue (GitHub, GitLab, Bitbucket) from a natural language description.
---

# Issue Creation

## Prerequisites
- Verify the current directory is a git repository with a remote.
- Detect the git platform (see "Platform Detection" below).
- Check the appropriate CLI is installed and authenticated.

## Platform Detection
Detect the platform from the remote URL by running `git remote get-url origin`:
- Contains `github.com` → **GitHub** (use `gh` CLI)
- Contains `gitlab.com` or `gitlab` in hostname → **GitLab** (use `glab` CLI)
- Contains `bitbucket.org` or `bitbucket` in hostname → **Bitbucket** (use Bitbucket API via `curl`)

If `.my-ops-config.json` has a `gitPlatform` field, use that as override.
If the platform cannot be detected, ask the user.

## Steps

### 1. Get Issue Details
Ask the user to describe the issue. Accept natural language like:
- "The login button doesn't work on mobile"
- "Add dark mode support"
- "Refactor the auth module for better testability"

### 2. Determine Issue Type
Infer from the description:
- **Bug**: problem, broken, doesn't work, error, crash, fix
- **Feature**: add, implement, create, new, support
- **Enhancement**: improve, update, refactor, optimize
- **Documentation**: docs, readme, document, guide

### 3. Generate Issue Content
Create a structured issue:

**Title**: concise, under 70 characters

**Body** (adapt based on type):

For bugs:
```markdown
## Description
(what's happening)

## Steps to Reproduce
1. ...
2. ...

## Expected Behavior
(what should happen)

## Actual Behavior
(what actually happens)

## Environment
- OS: (if relevant)
- Version: (if relevant)
```

For features/enhancements:
```markdown
## Description
(what and why)

## Proposed Solution
(how to implement, if known)

## Alternatives Considered
(other approaches, if any)

## Additional Context
(related issues, references)
```

### 4. Show Preview and Confirm
Display the generated title and body. Ask the user:
- Confirm or edit
- Add labels (suggest based on type: `bug`, `enhancement`, `documentation`)
- Assign to someone (optional)

### 5. Create Issue
Use the detected platform CLI:

**GitHub** (`gh`):
```
gh issue create --title "title" --body "body" --label "label"
```

**GitLab** (`glab`):
```
glab issue create --title "title" --description "body" --label "label"
```

**Bitbucket** (API via `curl`):
```
curl -X POST -u "$BITBUCKET_USER:$BITBUCKET_APP_PASSWORD" \
  "https://api.bitbucket.org/2.0/repositories/{owner}/{repo}/issues" \
  -H "Content-Type: application/json" \
  -d '{"title": "title", "content": {"raw": "body"}, "kind": "bug|enhancement|proposal|task"}'
```

If the CLI for the detected platform is not installed, show installation instructions.

### 6. Show Result
Display:
- Issue URL
- Issue number
- Suggest: "Want to create a branch for this? Use `/my-ops:branch`."
