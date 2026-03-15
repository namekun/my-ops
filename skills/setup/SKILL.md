---
name: setup
description: my-ops 플러그인 초기 설정. 커밋 컨벤션, Notion 페이지 등을 설정합니다.
---

# my-ops 초기 설정

사용자에게 아래 항목들을 **순서대로 질문**하여 설정을 수집하세요.
각 질문에 대해 사용자가 답변하면 다음 질문으로 넘어가세요.

## 질문 항목

### 1. Git 커밋 메시지 컨벤션
사용자에게 어떤 커밋 메시지 컨벤션을 사용하는지 물어보세요. 예시를 보여주세요:
- **Conventional Commits**: `feat: 로그인 기능 추가`, `fix: 버튼 클릭 버그 수정`
- **Gitmoji**: `:sparkles: 로그인 기능 추가`, `:bug: 버튼 클릭 버그 수정`
- **Plain**: 자유 형식 (컨벤션 없음)
- **Custom**: 사용자가 직접 형식을 설명

### 2. 커밋 메시지 언어
커밋 메시지를 어떤 언어로 작성할지 물어보세요:
- 한국어
- 영어
- 혼합 (타입은 영어, 설명은 한국어 등)

### 3. Notion 세션 기록 페이지
세션 기록을 저장할 Notion 페이지 또는 데이터베이스를 설정합니다.
- Notion MCP 서버를 사용하여 사용자의 워크스페이스를 검색하고, 기록할 위치를 함께 정하세요.
- 기존 페이지/데이터베이스를 사용할지, 새로 만들지 물어보세요.
- 선택한 페이지의 ID를 기록하세요.

### 4. 세션 기록 형식
세션 기록에 포함할 내용을 물어보세요:
- 대화 요약 (기본 포함)
- 작업한 파일 목록
- 커밋 내역
- 배운 점 / TIL
- 기타 사용자가 원하는 항목

## 설정 저장

모든 질문이 끝나면, 수집한 설정을 **현재 프로젝트 루트**의 `.my-ops-config.json` 파일에 저장하세요.

```json
{
  "commitConvention": "conventional | gitmoji | plain | custom",
  "commitConventionDetail": "custom인 경우 상세 설명",
  "commitLanguage": "ko | en | mixed",
  "notion": {
    "pageId": "노션 페이지 ID",
    "pageName": "페이지 이름",
    "type": "page | database"
  },
  "sessionLog": {
    "includeSummary": true,
    "includeFiles": true,
    "includeCommits": true,
    "includeTIL": true,
    "customFields": []
  }
}
```

설정이 완료되면 사용자에게 설정 내용을 요약하여 보여주고, 수정할 부분이 있는지 확인하세요.

이미 `.my-ops-config.json`이 존재하면, 기존 설정을 보여주고 변경할 항목만 물어보세요.
