---
name: push
description: 현재 브랜치를 원격에 push합니다.
---

# Git Push

## 실행 순서

### 1. 상태 확인
- 현재 디렉토리가 git 저장소인지 확인
- `git status`로 커밋되지 않은 변경이 있는지 확인
- 커밋되지 않은 변경이 있으면 사용자에게 알리고, 먼저 커밋할지 물어보세요

### 2. 브랜치 및 리모트 확인
- `git branch --show-current`로 현재 브랜치 확인
- `git remote -v`로 리모트 확인
- 리모트 트래킹 브랜치가 설정되어 있는지 확인

### 3. Push 실행 전 확인
사용자에게 다음을 보여주고 확인을 받으세요:
- 현재 브랜치: `feature/xxx`
- 리모트: `origin`
- push할 커밋 수 (있다면)

**주의**:
- `main` 또는 `master` 브랜치에 force push는 절대 하지 마세요
- `--force` 플래그는 사용자가 명시적으로 요청한 경우에만 사용

### 4. Push
- 리모트 트래킹이 없으면 `git push -u origin <branch>` 사용
- 트래킹이 있으면 `git push` 사용

### 5. 결과 표시
push 결과를 간단히 보여주세요.
