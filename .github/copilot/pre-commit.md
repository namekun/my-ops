# my-ops Pre-Commit Check

When the user asks to "pre-commit", "check", "검사", "린트", or "커밋 전 검사", run this process.

## Prerequisites
- Verify the current directory is a git repository.
- Ensure there are changes to check.

## Steps

### 1. Detect Tools
Scan for linter, formatter, type checker, test runner from `package.json`, `Makefile`, config files.

### 2. Show Detected Checks
List what will run with pass/fail indicators.

### 3. Run Checks
Execute in order: format → lint → type check → tests.
Show results for each with error summaries.

### 4. Offer Fixes
- Auto-fix lint errors
- Auto-format files
- Proceed to commit if all pass
