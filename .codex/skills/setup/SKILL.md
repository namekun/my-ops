---
name: setup
description: "Use when the user asks to set up my-ops, configure commit conventions, or initialize project settings. Triggers: 'my-ops setup', '설정', '초기 설정'"
---

# my-ops Initial Setup

Ask the user the following questions **in order**. Proceed to the next question after each answer.

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

### 3. Session Log Destination
Ask where to save session logs:
- **Notion**: Save pages/database entries via the Notion API
- **Obsidian**: Save markdown files into a local Obsidian vault
- **Both**: Save to both destinations

#### If Notion is selected
- Search the user's workspace and choose a location together.
- Ask whether to use an existing page/database or create a new one.
- Record the selected page ID and type (`page` or `database`).

#### If Obsidian is selected
- Ask the user for the absolute path to their Obsidian vault.
- Ask which folder inside the vault should hold session logs (default: `Sessions`).
- Ask for the filename format (default: `YYYY-MM-DD-{project}.md`). Tokens: `YYYY`, `MM`, `DD`, `{project}`.
- Ask whether to append to an existing daily note or always create a new file (default: append).

### 4. Session Log Format
Ask what to include in session logs:
- Conversation summary (included by default)
- Changed file list
- Commit history
- Lessons learned / TIL
- Any other custom fields the user wants

## Save Configuration

After all questions, save the collected settings to `.my-ops-config.json` in the **current project root**.

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
  "obsidian": {
    "vaultPath": "/absolute/path/to/vault",
    "folder": "Sessions",
    "filenameFormat": "YYYY-MM-DD-{project}.md",
    "appendIfExists": true
  },
  "sessionLog": {
    "destination": "notion | obsidian | both",
    "includeSummary": true,
    "includeFiles": true,
    "includeCommits": true,
    "includeTIL": true,
    "customFields": []
  }
}
```

> Only include the `notion` block if Notion is selected, and the `obsidian` block if Obsidian is selected.

Show a summary of the settings and ask if anything needs to be changed.

If `.my-ops-config.json` already exists, show the current settings and only ask about items to change.
