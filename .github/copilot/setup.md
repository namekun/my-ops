# my-ops Setup

When the user asks to "setup my-ops", "my-ops setup", or "초기 설정", run this setup process.

Ask the user the following questions in order. Proceed to the next question after each answer.

## Questions

### 1. Git Commit Message Convention
Ask which commit message convention they use. Show examples:
- **Conventional Commits**: `feat: add login feature`, `fix: fix button click bug`
- **Gitmoji**: `:sparkles: add login feature`, `:bug: fix button click bug`
- **Plain**: Free-form (no convention)
- **Custom**: User describes their own format

### 2. Commit Message Language
Ask which language to write commit messages in:
- Korean
- English
- Mixed (e.g., type in English, description in Korean)

### 3. Notion Session Log Page
Configure where to save session logs in Notion.
- Ask the user for their Notion page URL or ID.
- Ask whether to use an existing page/database or create a new one.
- Record the selected page ID.

### 4. Session Log Format
Ask what to include in session logs:
- Conversation summary (included by default)
- Changed file list
- Commit history
- Lessons learned / TIL
- Any other custom fields the user wants

## Save Configuration

After all questions, save the collected settings to `.my-ops-config.json` in the current project root.

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

Show a summary of the settings and ask if anything needs to be changed.
If `.my-ops-config.json` already exists, show the current settings and only ask about items to change.
