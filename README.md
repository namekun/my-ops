# my-ops

나만의 개발 워크플로 자동화 도구. Claude Code와 Cursor를 지원합니다.

## 기능

| 기능 | 설명 |
|------|------|
| setup | 초기 설정 (커밋 컨벤션, Notion 페이지 등) |
| commit-msg | 변경 사항 분석 후 커밋 메시지 3개 추천 |
| commit | 파일 스테이징 + 추천 메시지로 커밋 |
| push | 현재 브랜치를 원격에 push |
| session-log | 세션 대화 요약 및 작업 내역을 Notion에 기록 |

## 설치

### Claude Code

```bash
# Claude Code 세션에서
/plugin marketplace add namekun/my-ops
/plugin install my-ops
```

### Cursor

이 레포를 클론하고 `.cursor/rules/` 디렉토리를 프로젝트에 복사하세요:

```bash
git clone https://github.com/namekun/my-ops.git
cp -r my-ops/.cursor/rules/ your-project/.cursor/rules/
```

또는 이 레포를 서브모듈로 추가:

```bash
cd your-project
git submodule add https://github.com/namekun/my-ops.git .my-ops
cp -r .my-ops/.cursor/rules/ .cursor/rules/
```

## 사용법

### Claude Code

```
/my-ops:setup          # 초기 설정
/my-ops:commit-msg     # 커밋 메시지 추천
/my-ops:commit         # 스테이징 + 커밋
/my-ops:push           # push
/my-ops:session-log    # 세션 → Notion 기록
```

### Cursor

Cursor에서는 자연어로 호출합니다. 각 rule의 `description`에 정의된 트리거 문구를 사용하세요:

```
"my-ops setup"         # 초기 설정
"커밋 메시지 추천"       # 커밋 메시지 추천
"커밋해줘"              # 스테이징 + 커밋
"푸시해줘"              # push
"세션 기록"             # 세션 → Notion 기록
```

## 시작하기

### 1. 초기 설정 (최초 1회)

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
commit         # 변경분 확인 → 메시지 추천 → 커밋
    ↓
push           # 원격에 push
    ↓
session-log    # 하루 마무리 → Notion에 기록
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

## 프로젝트 구조

```
my-ops/
├── .claude-plugin/          # Claude Code 플러그인 메타데이터
│   ├── plugin.json
│   └── marketplace.json
├── skills/                  # Claude Code 스킬
│   ├── setup/SKILL.md
│   ├── commit-msg/SKILL.md
│   ├── commit/SKILL.md
│   ├── push/SKILL.md
│   └── session-log/SKILL.md
├── .cursor/rules/           # Cursor 룰
│   ├── setup.mdc
│   ├── commit-msg.mdc
│   ├── commit.mdc
│   ├── push.mdc
│   └── session-log.mdc
└── README.md
```

## 요구 사항

- [Claude Code](https://claude.com/claude-code) 또는 [Cursor](https://cursor.com)
- Notion 연동 (session-log 사용 시)
  - Claude Code: Notion MCP 서버 연결
  - Cursor: Notion API 키 설정

## 라이선스

MIT
