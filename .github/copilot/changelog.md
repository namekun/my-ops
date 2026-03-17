# my-ops Changelog Generation

When the user asks to "changelog", "변경 로그", "릴리즈 노트", or "release notes", run this process.

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Determine Range
- Since last tag: `git describe --tags --abbrev=0`
- Since specific date or commit
- Default: last 2 weeks if no tags

### 2. Collect and Categorize Commits
Run `git log <range> --oneline --no-merges` and group by type:
- Features (`feat`), Bug Fixes (`fix`), Performance (`perf`), Refactor, Docs, Tests, Chore

### 3. Generate Changelog
Format as markdown with categorized sections.

### 4. Output
- Display in terminal
- Write to `CHANGELOG.md`
- Copy to clipboard
