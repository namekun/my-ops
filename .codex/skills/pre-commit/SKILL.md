---
name: pre-commit
description: "Use when the user asks to run checks before committing, verify code quality, or lint/test before a commit. Triggers: 'pre-commit', '커밋 전 검사', '린트 실행', 'run lint', 'run tests', '테스트 실행', '커밋 전 확인', 'check before commit'"
---

# Pre-Commit Check

## Prerequisites
- Verify the current directory is a git repository.
- Check that there are staged or unstaged changes.

## Steps

### 1. Detect Project Tools
Scan the project to identify available tools:

| Check | Detection |
|-------|-----------|
| Linter | `eslint`, `pylint`, `flake8`, `rubocop`, `golangci-lint` in config/package.json |
| Formatter | `prettier`, `black`, `gofmt`, `rustfmt` in config/package.json |
| Type checker | `tsc`, `mypy`, `pyright` in config/package.json |
| Tests | `jest`, `pytest`, `go test`, `cargo test` in config/package.json |

Look for:
- `package.json` (scripts: lint, format, test, typecheck)
- `Makefile` (lint, format, test targets)
- Config files: `.eslintrc*`, `pyproject.toml`, `.prettierrc*`, `tsconfig.json`

### 2. Show Detected Checks
Display what will be run:

```
Detected checks:
  ✅ Lint: npm run lint (eslint)
  ✅ Format: npm run format:check (prettier)
  ✅ Type check: npm run typecheck (tsc)
  ✅ Test: npm run test (jest)
  ❌ Not found: security scan
```

Ask the user to confirm or skip specific checks.

### 3. Run Checks Sequentially
Execute each check in order (stop on critical failure or continue based on user preference):

1. **Formatter check** — verify formatting is correct
2. **Linter** — static analysis
3. **Type checker** — type safety (if applicable)
4. **Tests** — run test suite

For each check, show:
- ✅ Pass or ❌ Fail
- Brief error summary if failed

### 4. Display Results

```
Pre-commit results:
  ✅ Format check — passed
  ❌ Lint — 3 errors in 2 files
  ✅ Type check — passed
  ✅ Tests — 42 passed, 0 failed

Issues found:
  src/auth.ts:15 — 'unused-var' no-unused-vars
  src/auth.ts:22 — 'any' type @typescript-eslint/no-explicit-any
  src/utils.ts:8 — missing return type
```

### 5. Offer Fixes
If issues are found:
- "Want me to auto-fix the lint errors?" (run with `--fix`)
- "Want me to format the files?" (run formatter)
- "Ready to commit despite warnings?"

If all checks pass:
- "All checks passed! Ready to commit with `$commit`."
