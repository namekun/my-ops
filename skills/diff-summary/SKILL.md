---
name: diff-summary
description: Summarize staged or unstaged changes with impact analysis.
---

# Diff Summary

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Collect Changes
Run:
- `git diff --cached --stat` — staged changes summary
- `git diff --stat` — unstaged changes summary
- `git diff --cached` — full staged diff
- `git diff` — full unstaged diff

If no changes exist, inform the user: "No changes to summarize."

Prioritize staged changes. If nothing is staged, summarize unstaged changes instead.

### 2. Analyze Changes
For each changed file, determine:

**Change Type**:
- New file, modified, deleted, renamed

**Change Category**:
- Logic change (behavior modification)
- Refactor (structure change, same behavior)
- Style (formatting, naming)
- Config (configuration files)
- Test (test files)
- Docs (documentation)

**Impact Level**:
- 🔴 High — core logic, API changes, database schema, security-related
- 🟡 Medium — feature code, significant refactors
- 🟢 Low — tests, docs, config, formatting

### 3. Display Summary

```
## Diff Summary

### Overview
- Files changed: 5
- Lines added: +142
- Lines removed: -38
- Net change: +104

### Changes by Impact

🔴 High Impact
- **src/api/auth.ts** (+45/-12) — Modified token validation logic, added refresh token support
- **prisma/schema.prisma** (+8/-0) — Added RefreshToken model

🟡 Medium Impact
- **src/components/Login.tsx** (+52/-8) — Added OAuth login button and handler

🟢 Low Impact
- **src/utils/format.ts** (+12/-6) — Renamed helper functions for clarity
- **tests/auth.test.ts** (+25/-12) — Added tests for refresh token flow

### Risk Areas
- Token validation change affects all authenticated endpoints
- New database model requires migration

### Suggested Reviewers
(Based on git blame of changed files)
- @username — most recent author of auth.ts
```

### 4. Offer Next Steps
- "Ready to commit? Use `/my-ops:commit`."
- "Want a detailed review? Use `/my-ops:review`."
- "Want to run checks first? Use `/my-ops:pre-commit`."
