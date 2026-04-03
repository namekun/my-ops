# my-ops — Dev Workflow Automation

Personal dev workflow toolkit. Responds to natural language commands for git operations and session logging.

## Commands

When the user says any of the following, execute the corresponding workflow:

| Trigger | Workflow |
|---------|----------|
| "my-ops setup", "설정", "초기 설정" | [Setup](#setup) |
| "commit-msg", "커밋 메시지 추천" | [Commit Message](#commit-message) |
| "commit", "커밋해줘", "커밋" | [Commit](#commit) |
| "push", "푸시해줘", "푸시" | [Push](#push) |
| "session-log", "세션 기록", "세션 로그" | [Session Log](#session-log) |

---

## Setup

Ask the user the following questions in order:

### 1. Git Commit Message Convention
- **Conventional Commits**: `feat: add login feature`, `fix: fix button click bug`
- **Gitmoji**: `:sparkles: add login feature`, `:bug: fix button click bug`
- **Plain**: Free-form (no convention)
- **Custom**: User describes their own format

### 2. Commit Message Language
- Korean / English / Mixed

### 3. Notion Session Log Page
- Search the user's Notion workspace and choose a location together
- Ask whether to use an existing page/database or create a new one
- Record the selected page ID

### 4. Session Log Format
What to include: conversation summary, changed file list, commit history, TIL, custom fields.

### Save
Save to `.my-ops-config.json` in the project root:
```json
{
  "commitConvention": "conventional | gitmoji | plain | custom",
  "commitConventionDetail": "detailed description if custom",
  "commitLanguage": "ko | en | mixed",
  "notion": {
    "pageId": "notion page ID",
    "pageName": "page name",
    "type": "page | database"
  },
  "sessionLog": {
    "includeSummary": true,
    "includeFiles": true,
    "includeCommits": true,
    "includeTIL": true,
    "customFields": []
  }
}
```

---

## Commit Message

### Prerequisites
- Verify git repo. Check `.my-ops-config.json` exists.

### Steps
1. Load `commitConvention` and `commitLanguage` from `.my-ops-config.json`
2. Run `git status`, `git diff`, `git diff --cached`
3. If no changes: "No changes to commit."
4. Recommend **3** commit messages matching the user's convention
5. Let the user pick a number or write their own
6. Do NOT commit — only recommend messages

---

## Commit

### Prerequisites
- Verify git repo. Check `.my-ops-config.json` exists.

### Steps
1. Load config from `.my-ops-config.json`
2. Run `git status`, `git diff`, `git diff --cached`
3. If no changes: "No changes to commit."
4. Show changed files and ask which to stage. Use explicit filenames (not `git add -A`). Warn about `.env`, credentials.
5. Recommend 3 commit messages (same as Commit Message workflow)
6. User picks or writes their own
7. Commit with HEREDOC. Do NOT use `--no-verify`. If pre-commit hook fails, fix and create new commit (never amend).
8. Show result with `git log --oneline -1`. Do NOT push.

---

## Push

### Steps
1. Verify git repo. Check for uncommitted changes.
2. `git branch --show-current`, `git remote -v`, check remote tracking
3. Show branch, remote, commit count. Get user confirmation.
4. NEVER force push to main/master. Only `--force` if user explicitly requests.
5. If no tracking: `git push -u origin <branch>`. If tracking: `git push`.
6. Show result.

---

## Session Log

### Prerequisites
- Check `.my-ops-config.json` exists. Verify Notion access.

### Steps
1. Load Notion settings from `.my-ops-config.json`
2. Collect from current session:
   - **Summary**: 3-5 lines of what was done, key decisions
   - **Changed files**: `git diff --name-only`, categorize created/modified/deleted
   - **Commits**: `git log --oneline --since="today"`
   - **TIL**: New discoveries, solved problems
3. Create Notion page:
   - Title: `[project-name] YYYY-MM-DD Session Log`
   - Sections: Summary, Changed Files, Commits, TIL, Notes
   - If database: add entry matching schema
4. Show Notion page link. Ask if changes needed.
