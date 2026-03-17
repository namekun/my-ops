---
name: branch
description: Create and checkout a branch with a conventioned name.
---

# Branch Creation

## Prerequisites
- Verify the current directory is a git repository.
- Check for uncommitted changes and warn the user if any exist.

## Steps

### 1. Get Branch Purpose
Ask the user what they're working on. Accept either:
- A description: "login page with OAuth"
- An issue reference: "#42" or "PROJ-123"

### 2. Determine Branch Type
Ask or infer from the description:
- `feature/` — new functionality
- `fix/` — bug fix
- `hotfix/` — urgent production fix
- `refactor/` — code restructuring
- `docs/` — documentation
- `test/` — test additions
- `chore/` — maintenance tasks

### 3. Generate Branch Name
Create a branch name following the pattern: `<type>/<short-description>`

Rules:
- Lowercase only
- Use hyphens for spaces
- Keep concise (3-5 words max)
- Include issue number if provided: `feature/42-oauth-login`
- Remove special characters

**Examples**:
- "login page with OAuth" → `feature/oauth-login-page`
- "#42 fix button alignment" → `fix/42-button-alignment`
- "update README" → `docs/update-readme`

### 4. Recommend and Confirm
Show 2-3 branch name options:

```
Recommended branch names:
1. feature/oauth-login-page
2. feature/oauth-login
3. feature/42-oauth-login-page
```

Let the user pick or type their own.

### 5. Create and Checkout
- Ensure the base branch is up to date: `git fetch origin`
- Create and switch: `git checkout -b <branch-name>`
- Confirm creation: `git branch --show-current`

### 6. Show Result
Display:
- Created branch name
- Base branch it was created from
- Suggest next steps: "Start coding! When done, use `/my-ops:commit`."
