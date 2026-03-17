---
name: issue
description: Create a GitHub issue from a natural language description.
---

# GitHub Issue Creation

## Prerequisites
- Verify the current directory is a git repository with a GitHub remote.
- Check that `gh` CLI is installed and authenticated.

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
Use `gh issue create`:
```
gh issue create --title "title" --body "body" --label "label"
```

### 6. Show Result
Display:
- Issue URL
- Issue number
- Suggest: "Want to create a branch for this? Use `/my-ops:branch`."
