---
name: setup
description: Initial setup for my-ops plugin. Configures commit conventions, Notion page, etc.
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

### 3. Git Platform (Auto-detect)
Automatically detect the git hosting platform by running `git remote get-url origin`:
- Contains `github.com` → **GitHub**
- Contains `gitlab.com` or `gitlab` in hostname → **GitLab**
- Contains `bitbucket.org` or `bitbucket` in hostname → **Bitbucket**

Show the detected platform and ask the user to confirm or override.
If no remote is configured, ask the user to choose manually.

### 4. Git Workflow
Ask which branching strategy they use:
- **Git Flow**: `feature/`, `release/`, `hotfix/` branches + `develop` branch
- **GitHub Flow**: `feature/` branches → merge directly to `main`
- **Trunk-based**: short-lived branches → fast merge to `main`
- **Custom**: user describes their own strategy

Based on the selection, configure:
- Default base branch (`main`, `master`, or `develop`)
- Branch prefixes (`feature/`, `fix/`, `hotfix/`, `release/`, etc.)
- Whether a `develop` branch is used

### 5. Session Log Destination
Ask where to save session logs:
- **Notion**: Save pages/database entries via the Notion MCP server
- **Obsidian**: Save markdown files into a local Obsidian vault
- **Both**: Save to both destinations

#### If Notion is selected
- Use the Notion MCP server to search the user's workspace and choose a location together.
- Ask whether to use an existing page/database or create a new one.
- Record the selected page ID and type (`page` or `database`).

#### If Obsidian is selected
- Ask the user for the absolute path to their Obsidian vault (e.g. `~/Documents/ObsidianVault`).
- Ask which folder inside the vault should hold session logs (default: `Sessions`). Create it if it does not exist.
- Ask for the filename format (default: `YYYY-MM-DD-{project}.md`). Tokens: `YYYY`, `MM`, `DD`, `{project}`.
- Ask whether to append to an existing daily note or always create a new file (default: append).

### 6. Session Log Format
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
  "gitPlatform": "github | gitlab | bitbucket",
  "gitWorkflow": "git-flow | github-flow | trunk-based | custom",
  "branches": {
    "main": "main",
    "develop": "develop",
    "prefixes": {
      "feature": "feature/",
      "fix": "fix/",
      "hotfix": "hotfix/",
      "release": "release/"
    }
  },
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

> Only include the `notion` block if Notion is selected, and the `obsidian` block if Obsidian is selected. Omit the unused destination keys to keep the config tidy.

Show a summary of the settings and ask if anything needs to be changed.

If `.my-ops-config.json` already exists, show the current settings and only ask about items to change.
