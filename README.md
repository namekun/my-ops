# my-ops

나만의 개발 워크플로 자동화 도구. Claude Code, Cursor, GitHub Copilot을 지원합니다.

## 기능

| 기능 | 설명 |
|------|------|
| setup | 초기 설정 (커밋 컨벤션, Notion 페이지 등) |
| commit-msg | 변경 사항 분석 후 커밋 메시지 3개 추천 |
| commit | 파일 스테이징 + 추천 메시지로 커밋 |
| push | 현재 브랜치를 원격에 push |
| session-log | 세션 대화 요약 및 작업 내역을 Notion에 기록 |
| **recap** | 어제 작업 내역 리스트업 (커밋, 변경 파일, 브랜치 등) |
| **pr** | GitHub PR 자동 생성 (제목/본문/라벨 추천) |
| **review** | 코드 변경사항 리뷰 및 구조화된 피드백 |
| **changelog** | 커밋 히스토리 기반 CHANGELOG 자동 생성 |
| **branch** | 컨벤션에 맞는 브랜치명 자동 생성 + 체크아웃 |
| **issue** | 자연어로 Issue 생성 — GitHub, GitLab, Bitbucket 지원 |
| **pre-commit** | 커밋 전 lint/format/test 자동 실행 및 결과 요약 |
| **diff-summary** | 변경사항 요약 및 영향도 분석 |

## 지원 도구

| 도구 | 방식 | 호출 |
|------|------|------|
| Claude Code | 플러그인 (Skills) | `/my-ops:commit` |
| Cursor | Rules (`.mdc`) | 자연어 (`"커밋해줘"`) |
| GitHub Copilot | Instructions (`.md`) | 자연어 (`"커밋해줘"`) |

## 설치

### Claude Code

```bash
# Claude Code 세션에서
/plugin marketplace add namekun/my-ops
/plugin install my-ops
```

설치 후 바로 사용 가능합니다. 업데이트는 `/plugin update my-ops`로 할 수 있습니다.

### Cursor

`.cursor/rules/` 디렉토리를 프로젝트에 복사하세요:

```bash
git clone https://github.com/namekun/my-ops.git
cp -r my-ops/.cursor/rules/ your-project/.cursor/rules/
```

또는 서브모듈로 추가:

```bash
cd your-project
git submodule add https://github.com/namekun/my-ops.git .my-ops
cp -r .my-ops/.cursor/rules/ .cursor/rules/
```

### GitHub Copilot

`.github/copilot/` 디렉토리를 프로젝트에 복사하세요:

```bash
git clone https://github.com/namekun/my-ops.git
cp -r my-ops/.github/copilot/ your-project/.github/copilot/
```

또는 서브모듈로 추가:

```bash
cd your-project
git submodule add https://github.com/namekun/my-ops.git .my-ops
cp -r .my-ops/.github/copilot/ .github/copilot/
```

> **참고**: GitHub Copilot에서 커스텀 지침을 사용하려면 VS Code 설정에서 `github.copilot.chat.codeGeneration.useInstructionFiles`를 `true`로 설정해야 합니다.

## 사용법

### Claude Code

```
/my-ops:setup          # 초기 설정
/my-ops:commit-msg     # 커밋 메시지 추천
/my-ops:commit         # 스테이징 + 커밋
/my-ops:push           # push
/my-ops:session-log    # 세션 → Notion 기록
/my-ops:recap          # 어제 작업 내역 요약
/my-ops:pr             # PR 생성
/my-ops:review         # 코드 리뷰
/my-ops:changelog      # CHANGELOG 생성
/my-ops:branch         # 브랜치 생성
/my-ops:issue          # Issue 생성
/my-ops:pre-commit     # 커밋 전 검사
/my-ops:diff-summary   # 변경사항 요약
```

Claude Code에서는 `PreCompact` hook이 설정되어 있어, 컨텍스트 압축 시 자동으로 Notion에 세션을 기록합니다.

### Cursor

Cursor에서는 자연어로 호출합니다:

```
"my-ops setup"         # 초기 설정
"커밋 메시지 추천"       # 커밋 메시지 추천
"커밋해줘"              # 스테이징 + 커밋
"푸시해줘"              # push
"세션 기록"             # 세션 → Notion 기록
"어제 뭐했지"           # 작업 내역 요약
"PR 만들어"            # PR 생성
"코드 리뷰"            # 코드 리뷰
"changelog"            # CHANGELOG 생성
"브랜치 만들어"         # 브랜치 생성
"이슈 만들어"           # Issue 생성
"커밋 전 검사"          # 커밋 전 검사
"변경 요약"             # 변경사항 요약
```

### GitHub Copilot

Copilot Chat에서 자연어로 호출합니다:

```
"my-ops setup"         # 초기 설정
"커밋 메시지 추천"       # 커밋 메시지 추천
"커밋해줘"              # 스테이징 + 커밋
"푸시해줘"              # push
"세션 기록"             # 세션 → Notion 기록
"어제 뭐했지"           # 작업 내역 요약
"PR 만들어"            # PR 생성
"코드 리뷰"            # 코드 리뷰
"changelog"            # CHANGELOG 생성
"브랜치 만들어"         # 브랜치 생성
"이슈 만들어"           # Issue 생성
"커밋 전 검사"          # 커밋 전 검사
"변경 요약"             # 변경사항 요약
```

## 시작하기

### 1. 초기 설정 (최초 1회)

다음 항목들을 설정합니다:
- Git 커밋 메시지 컨벤션 (Conventional Commits, Gitmoji, Plain, Custom)
- 커밋 메시지 언어 (한국어/영어/혼합)
- Notion 세션 기록 위치
- 세션 기록 포함 항목

설정은 프로젝트 루트의 `.my-ops-config.json`에 저장됩니다.

> **Git 플랫폼 자동 감지**: setup 시 `git remote` URL을 분석하여 GitHub/GitLab/Bitbucket을 자동으로 감지합니다. pr, issue, review 스킬이 플랫폼에 맞는 CLI를 자동으로 사용합니다.

### 2. 일상 워크플로

```
브랜치 생성 (branch)
    ↓
코딩 작업...
    ↓
변경 확인 (diff-summary)
    ↓
커밋 전 검사 (pre-commit)
    ↓
커밋 (commit)
    ↓
푸시 (push)
    ↓
PR 생성 (pr)
    ↓
코드 리뷰 (review)
    ↓
다음 날 → 작업 회고 (recap)
```

## 설정 파일

`.my-ops-config.json` 예시:

```json
{
  "commitConvention": "conventional",
  "commitLanguage": "en",
  "gitPlatform": "github",
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
├── .claude-plugin/              # Claude Code 플러그인 메타데이터
│   ├── plugin.json
│   └── marketplace.json
├── skills/                      # Claude Code 스킬
│   ├── setup/SKILL.md
│   ├── commit-msg/SKILL.md
│   ├── commit/SKILL.md
│   ├── push/SKILL.md
│   ├── session-log/SKILL.md
│   ├── recap/SKILL.md
│   ├── pr/SKILL.md
│   ├── review/SKILL.md
│   ├── changelog/SKILL.md
│   ├── branch/SKILL.md
│   ├── issue/SKILL.md
│   ├── pre-commit/SKILL.md
│   └── diff-summary/SKILL.md
├── hooks/                       # Claude Code 훅
│   └── hooks.json               # PreCompact → 자동 세션 기록
├── .cursor/rules/               # Cursor 룰
│   ├── setup.mdc
│   ├── commit-msg.mdc
│   ├── commit.mdc
│   ├── push.mdc
│   ├── session-log.mdc
│   ├── recap.mdc
│   ├── pr.mdc
│   ├── review.mdc
│   ├── changelog.mdc
│   ├── branch.mdc
│   ├── issue.mdc
│   ├── pre-commit.mdc
│   └── diff-summary.mdc
├── .github/copilot/             # GitHub Copilot 지침
│   ├── setup.md
│   ├── commit-msg.md
│   ├── commit.md
│   ├── push.md
│   ├── session-log.md
│   ├── recap.md
│   ├── pr.md
│   ├── review.md
│   ├── changelog.md
│   ├── branch.md
│   ├── issue.md
│   ├── pre-commit.md
│   └── diff-summary.md
└── README.md
```

## 요구 사항

- [Claude Code](https://claude.com/claude-code), [Cursor](https://cursor.com), 또는 [GitHub Copilot](https://github.com/features/copilot) 중 하나
- Git 호스팅 플랫폼 CLI (pr, issue, review 기능 사용 시):
  - GitHub: [`gh`](https://cli.github.com/)
  - GitLab: [`glab`](https://gitlab.com/gitlab-org/cli)
  - Bitbucket: API 사용 (`BITBUCKET_USER`, `BITBUCKET_APP_PASSWORD` 환경변수 필요)
- Notion 연동 (session-log 사용 시)
  - Claude Code: Notion MCP 서버 연결
  - Cursor / Copilot: Notion API 키 설정

## 라이선스

MIT
