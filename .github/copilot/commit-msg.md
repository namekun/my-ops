# my-ops Commit Message Recommendation

When the user asks to "recommend commit message", "커밋 메시지 추천", or "commit msg", run this process.

## Prerequisites
- Verify the current directory is a git repository.
- Check if `.my-ops-config.json` exists. If not, tell the user to run setup first.

## Steps

### 1. Load Configuration
Read `commitConvention` and `commitLanguage` from `.my-ops-config.json` in the project root.

### 2. Analyze Changes
Run the following to understand the changes:
- `git status` — list of changed files
- `git diff` — unstaged changes
- `git diff --cached` — staged changes

If there are no changes, inform the user: "No changes to commit."

### 3. Generate Commit Messages
Analyze the changes and recommend **3** commit messages matching the user's convention.

Each message should:
- Follow the user's configured convention format
- Be written in the user's configured language
- Focus on "why" rather than "what"
- Be concise, 1-2 lines

### 4. Display Results
Show the recommended messages with numbers:

```
Recommended commit messages:
1. feat: add OAuth2 support to user auth flow
2. feat: implement OAuth2 login
3. feat(auth): integrate Google/GitHub OAuth2
```

Let the user know they can pick a number or write their own.
Only recommend messages — do NOT commit.
