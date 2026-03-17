# my-ops Branch Creation

When the user asks to "branch", "브랜치 만들어", "새 브랜치", or "create branch", run this process.

## Prerequisites
- Verify the current directory is a git repository.
- Warn about uncommitted changes if any.

## Steps

### 1. Get Branch Purpose
Accept a description or issue reference from the user.

### 2. Determine Type
Infer or ask: `feature/`, `fix/`, `hotfix/`, `refactor/`, `docs/`, `test/`, `chore/`

### 3. Generate Name
Pattern: `<type>/<short-description>`
- Lowercase, hyphens, 3-5 words max
- Include issue number if provided

### 4. Recommend 2-3 Options
Let the user pick or type their own.

### 5. Create and Checkout
- `git fetch origin`
- `git checkout -b <branch-name>`
- Confirm with `git branch --show-current`
