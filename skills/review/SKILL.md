---
name: review
description: Review code changes and provide structured feedback (GitHub, GitLab, Bitbucket).
---

# Code Review

## Prerequisites
- Verify the current directory is a git repository.
- Detect the git platform (see "Platform Detection" below) when reviewing a PR/MR.
- Determine what to review (staged changes, branch diff, or specific PR/MR).

## Platform Detection
Detect the platform from the remote URL by running `git remote get-url origin`:
- Contains `github.com` → **GitHub** (use `gh` CLI)
- Contains `gitlab.com` or `gitlab` in hostname → **GitLab** (use `glab` CLI)
- Contains `bitbucket.org` or `bitbucket` in hostname → **Bitbucket** (use Bitbucket API via `curl`)

If `.my-ops-config.json` has a `gitPlatform` field, use that as override.
If the platform cannot be detected, ask the user.

## Steps

### 1. Determine Review Scope
Ask the user or detect automatically:
- **Staged changes**: `git diff --cached`
- **Branch diff**: `git diff main...HEAD` (or `master...HEAD`)
- **Specific PR/MR**: GitHub `gh pr diff <number>` / GitLab `glab mr diff <number>` / Bitbucket API
- **Specific commits**: `git diff <commit1>..<commit2>`

### 2. Collect Changes
Run the appropriate diff command and collect:
- List of changed files
- Full diff content
- Statistics (`--stat`)

### 3. Analyze and Review
For each changed file, check:

**Correctness**
- Logic errors or bugs
- Edge cases not handled
- Off-by-one errors

**Security**
- SQL injection, XSS, command injection risks
- Hardcoded secrets or credentials
- Improper input validation

**Performance**
- Unnecessary loops or computations
- Missing indexes or N+1 queries
- Large memory allocations

**Code Quality**
- Naming clarity
- Function length and complexity
- Code duplication
- Error handling

**Style**
- Consistency with existing codebase
- Formatting issues

### 4. Display Results
Present findings grouped by severity:

```
## Code Review Results

### 🔴 Critical (must fix)
- **file.ts:42** — SQL query uses string interpolation, vulnerable to injection

### 🟡 Suggestion (recommended)
- **utils.ts:15** — Consider extracting this logic into a helper function

### 🟢 Nitpick (optional)
- **app.ts:8** — Unused import `lodash`

### ✅ Looks Good
- Clean separation of concerns in the new module
- Good error handling in the API layer
```

### 5. Offer Next Steps
- "Want me to fix the critical issues?"
- "Should I add these as PR comments?"
