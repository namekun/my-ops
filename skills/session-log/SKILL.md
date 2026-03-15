---
name: session-log
description: 오늘 세션의 대화 내용을 요약하고, 작업 내역을 Notion에 기록합니다.
---

# 세션 기록 (Notion)

## 사전 조건
- `.my-ops-config.json` 파일이 있는지 확인하세요. 없으면 `/my-ops:setup`을 먼저 실행하라고 안내하세요.
- Notion MCP 서버가 연결되어 있는지 확인하세요.

## 실행 순서

### 1. 설정 로드
`.my-ops-config.json`에서 Notion 설정과 세션 기록 형식을 읽으세요.

### 2. 세션 내용 수집
현재 대화에서 다음 정보를 수집하세요:

#### 대화 요약 (includeSummary)
- 이번 세션에서 어떤 작업을 했는지 3-5줄로 요약
- 주요 의사결정이나 논의 사항 포함

#### 작업 파일 목록 (includeFiles)
- `git diff --name-only HEAD~N` 등으로 세션 중 변경된 파일 파악
- 새로 생성된 파일, 수정된 파일, 삭제된 파일 구분

#### 커밋 내역 (includeCommits)
- 세션 중 만들어진 커밋 목록
- `git log --oneline --since="today"` 등 활용

#### 배운 점 / TIL (includeTIL)
- 세션 중 새로 알게 된 것, 해결한 문제, 유용한 패턴 등
- 대화 내용을 기반으로 추출

### 3. Notion 페이지 생성
Notion MCP 도구를 사용하여 설정된 페이지/데이터베이스에 기록합니다.

#### 페이지 형식
```
제목: [프로젝트명] YYYY-MM-DD 세션 기록

## 요약
(대화 요약 내용)

## 작업 파일
- 생성: file1.ts, file2.ts
- 수정: file3.ts
- 삭제: file4.ts

## 커밋 내역
- abc1234 feat: 로그인 기능 추가
- def5678 fix: 버튼 버그 수정

## TIL
- (배운 점들)

## 기타
(사용자 커스텀 필드)
```

#### 데이터베이스 형식 (type이 database인 경우)
데이터베이스에 새 항목을 추가하세요. 속성(property) 이름은 데이터베이스 스키마에 맞게 매핑하세요.

### 4. 완료 확인
- 생성된 Notion 페이지 링크를 사용자에게 보여주세요
- 추가하거나 수정할 내용이 있는지 물어보세요
