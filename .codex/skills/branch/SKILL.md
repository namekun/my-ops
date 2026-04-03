---
name: branch
description: "Use when the user asks to create a branch, switch branches, or start new work on a feature/fix. Triggers: 'branch', '브랜치 만들어', '브랜치 생성', 'create branch', 'new branch', '새 브랜치', 'feature branch', '피처 브랜치'"
---

# Branch Creation

## Prerequisites
- Verify the current directory is a git repository.
- Check for uncommitted changes and warn the user if any exist.

## Steps

### 1. Load Workflow Config
If `.my-ops-config.json` exists, read `gitWorkflow` and `branches` settings:
- Use configured prefixes instead of defaults
- Determine base branch from config (`main`, `master`, or `develop`)
- For **Git Flow**: feature branches come from `develop`, hotfix from `main`
- For **GitHub Flow** / **Trunk-based**: all branches come from `main`

If no config exists, use defaults.

### 2. Get Branch Purpose
Ask the user what they're working on. Accept either:
- A description: "login page with OAuth"
- An issue reference: "#42" or "PROJ-123"

### 3. Determine Branch Type
Ask or infer from the description. Use configured prefixes if available, otherwise defaults:
- `feature/` — new functionality
- `fix/` — bug fix
- `hotfix/` — urgent production fix
- `refactor/` — code restructuring
- `docs/` — documentation
- `test/` — test additions
- `chore/` — maintenance tasks

### 4. Generate Branch Name
Create a branch name following the pattern: `<prefix><short-description>`

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

### 5. Recommend and Confirm
Show 2-3 branch name options:

```
Recommended branch names:
1. feature/oauth-login-page
2. feature/oauth-login
3. feature/42-oauth-login-page
```

Let the user pick or type their own.

### 6. Create and Checkout
- Ensure the base branch is up to date: `git fetch origin`
- Checkout the correct base branch first:
  - **Git Flow**: `develop` for feature/fix, `main` for hotfix/release
  - **GitHub Flow / Trunk-based**: `main` (or `master`)
- Create and switch: `git checkout -b <branch-name>`
- Confirm creation: `git branch --show-current`

### 7. Show Result
Display:
- Created branch name
- Base branch it was created from
- Suggest next steps: "Start coding! When done, use `$commit`."
