# my-ops Code Review

When the user asks to "review", "코드 리뷰", "리뷰해줘", or "check my code", run this process.

## Prerequisites
- Verify the current directory is a git repository.

## Steps

### 1. Determine Scope
- Staged changes: `git diff --cached`
- Branch diff: `git diff main...HEAD`
- Specific PR: `gh pr diff <number>`

### 2. Analyze Changes
Check for:
- Correctness — logic errors, edge cases
- Security — injection risks, hardcoded secrets
- Performance — unnecessary loops, N+1 queries
- Code Quality — naming, complexity, duplication
- Style — consistency with codebase

### 3. Display Results
Group by severity:
- 🔴 Critical (must fix)
- 🟡 Suggestion (recommended)
- 🟢 Nitpick (optional)
- ✅ Looks Good (positive feedback)

### 4. Offer Next Steps
- Fix critical issues
- Add as PR comments
