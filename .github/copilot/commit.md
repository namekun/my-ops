# my-ops Git Commit

When the user asks to "commit", "커밋", or "커밋해줘", run this process.

## Prerequisites
- Verify the current directory is a git repository.
- Check if `.my-ops-config.json` exists. If not, tell the user to run setup first.

## Steps

### 1. Load Configuration
Read commit-related settings from `.my-ops-config.json` in the project root.

### 2. Check Changes
Run:
- `git status` — overall status
- `git diff` — unstaged changes
- `git diff --cached` — already staged changes

If there are no changes, inform the user: "No changes to commit."

### 3. Show Changed Files and Stage
Show the list of changed files and ask the user which files to stage.
- If "stage all" is selected, `git add` the relevant files
- If specific files are selected, `git add` only those
- Warn about sensitive files like `.env`, credentials, etc.

Use explicit filenames instead of `git add -A` or `git add .`.

### 4. Recommend Commit Messages
Analyze the staged changes and recommend 3 commit messages following the user's convention.
The user can pick a number or write their own.

### 5. Execute Commit
Commit with the selected message.
- Do NOT use the `--no-verify` flag
- If a pre-commit hook fails, investigate the cause, fix it, and create a new commit (never amend)

### 6. Verify Result
Show the result with `git log --oneline -1`.
Do NOT push.
