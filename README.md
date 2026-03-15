# my-ops

나만의 개발 워크플로 자동화 플러그인 for Claude Code.

## 기능

| 스킬 | 설명 |
|------|------|
| `/my-ops:setup` | 초기 설정 (커밋 컨벤션, Notion 페이지 등) |
| `/my-ops:commit-msg` | 변경 사항 분석 후 커밋 메시지 3개 추천 |
| `/my-ops:commit` | 파일 스테이징 + 추천 메시지로 커밋 |
| `/my-ops:push` | 현재 브랜치를 원격에 push |
| `/my-ops:session-log` | 세션 대화 요약 및 작업 내역을 Notion에 기록 |

## 설치

```bash
# Claude Code 세션에서
/plugin marketplace add namekun/my-ops
/plugin install my-ops
```

## 시작하기

### 1. 초기 설정 (최초 1회)

```
/my-ops:setup
```

다음 항목들을 설정합니다:
- Git 커밋 메시지 컨벤션 (Conventional Commits, Gitmoji, Plain, Custom)
- 커밋 메시지 언어 (한국어/영어/혼합)
- Notion 세션 기록 위치
- 세션 기록 포함 항목

설정은 프로젝트 루트의 `.my-ops-config.json`에 저장됩니다.

### 2. 일상 워크플로

```
코딩 작업...
    ↓
/my-ops:commit          # 변경분 확인 → 메시지 추천 → 커밋
    ↓
/my-ops:push            # 원격에 push
    ↓
/my-ops:session-log     # 하루 마무리 → Notion에 기록
```

## 설정 파일

`.my-ops-config.json` 예시:

```json
{
  "commitConvention": "conventional",
  "commitLanguage": "en",
  "notion": {
    "pageId": "your-notion-page-id",
    "pageName": "Dev Log",
    "type": "database"
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

## 요구 사항

- [Claude Code](https://claude.com/claude-code) CLI
- Notion MCP 서버 연결 (`/my-ops:session-log` 사용 시)

## 라이선스

MIT
