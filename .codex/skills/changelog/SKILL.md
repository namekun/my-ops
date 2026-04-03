---
name: changelog
description: "Use when the user asks to generate a changelog, release notes, or commit history summary. Triggers: 'changelog', '체인지로그', '릴리즈 노트', 'release notes', '변경 이력', 'generate changelog', '변경 내역 정리'"
---

# Changelog Generation

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Determine Range
Ask the user or detect automatically:
- **Since last tag**: `git describe --tags --abbrev=0` to find latest tag, then log from there
- **Since specific date**: user-provided date
- **Since specific commit/tag**: user-provided reference
- **All history**: full commit log

If no tags exist, ask the user for the range or default to the last 2 weeks.

### 2. Collect Commits
Run:
- `git log <range> --oneline --no-merges` — commit list
- `git log <range> --pretty=format:"%h %s" --no-merges` — hash + subject

### 3. Categorize Commits
Group commits by type (auto-detect from commit message prefixes):

| Category | Prefixes |
|----------|----------|
| Features | `feat`, `feature`, `:sparkles:` |
| Bug Fixes | `fix`, `bugfix`, `:bug:` |
| Performance | `perf`, `:zap:` |
| Refactor | `refactor`, `:recycle:` |
| Docs | `docs`, `:memo:` |
| Tests | `test`, `:white_check_mark:` |
| Chore | `chore`, `build`, `ci` |
| Breaking Changes | commits containing `BREAKING CHANGE` or `!:` |

Commits that don't match any prefix go under "Other".

### 4. Generate Changelog
Format:

```markdown
# Changelog

## [Unreleased] — YYYY-MM-DD

### 🚀 Features
- Add OAuth2 login support (abc1234)
- Implement dark mode toggle (def5678)

### 🐛 Bug Fixes
- Fix button alignment on mobile (ghi9012)

### ⚡ Performance
- Optimize image loading pipeline (jkl3456)

### 🔧 Other
- Update dependencies (mno7890)
```

### 5. Output Options
Ask the user:
- **Display only**: show in terminal
- **Write to file**: append/prepend to `CHANGELOG.md`
- **Copy to clipboard**: if supported

### 6. Show Result
Display the generated changelog and confirm the action taken.
