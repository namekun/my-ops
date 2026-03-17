---
name: pr
description: Create a GitHub pull request with auto-generated title and description.
---

# Pull Request Creation

## Prerequisites
- Verify the current directory is a git repository.
- Check that `gh` CLI is installed and authenticated.
- Ensure there are commits to include in the PR.

## Steps

### 1. Analyze Current Branch
Run:
- `git branch --show-current` — current branch name
- `git log main..HEAD --oneline` (or `master..HEAD`) — commits on this branch
- `git diff main...HEAD --stat` — changed files summary

If the branch is `main` or `master`, inform the user: "You're on the default branch. Create a feature branch first."

### 2. Determine Base Branch
- Try `main` first, then `master`
- If neither exists, ask the user which branch to target

### 3. Generate PR Title and Description
Based on the commits and diff:

**Title**:
- If `.my-ops-config.json` exists, follow the commit convention style
- Keep under 70 characters
- Focus on the overall change, not individual commits

**Description**:
- Generate a `## Summary` section with 1-3 bullet points
- Generate a `## Changes` section listing key modifications
- Generate a `## Test plan` section with a checklist
- If there are multiple commits, summarize the progression

### 4. Show Preview and Confirm
Display the generated title and description. Ask the user:
- Confirm or edit the title
- Confirm or edit the description
- Add labels, reviewers, or assignees (optional)

### 5. Push and Create PR
- If the branch has no remote tracking: `git push -u origin <branch>`
- Create PR using `gh pr create`:
  ```
  gh pr create --title "title" --body "body"
  ```
- Add labels if requested: `--label "label1,label2"`
- Add reviewers if requested: `--reviewer "user1,user2"`

### 6. Show Result
Display:
- PR URL
- PR number
- Status
