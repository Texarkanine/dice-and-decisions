# Tech Context

A Markdown-first repository: deliverables are [agentskills.io](https://agentskills.io/specification)-compatible skill directories (`SKILL.md` + `references/`, `scripts/`, `assets/`) and game documents, not application code. The only executable code anticipated is small shell scripts inside skills (e.g. the dice roller). Development happens in Cursor; portability is validated in Claude Code, with eventual plugin packaging for both.

## Environment Setup

No build or runtime environment is required to work on the repo — it is plain Markdown plus shell scripts. Skills are exercised by installing/activating them in an agent harness (Cursor or Claude Code).

## Build Tools

None. There is no package manager, compiler, or bundler. Plugin packaging manifests are deliberately deferred until the engine is right.

## Testing Process

Shell scripts are written and tested per the workspace shell rules (`.cursor/rules/shared/shell-tdd.mdc`, `bash-style.mdc` / `shell-posix-style.mdc`). The chosen framework is **shunit2**, vendored in a **repo-level harness** (e.g. `tests/sh/vendor/shunit2`, pinned to v2.1.8) so skills ship only runtime actionables. Shell suites live under `tests/sh/skills/<skill>/...` with shared helpers in `tests/sh/common.sh` and an aggregate runner at `tests/sh/run.sh` — run all shell tests with `sh tests/sh/run.sh`. Scripts target POSIX `sh` for harness portability and are validated under both `sh` and `dash`; static analysis is `shellcheck -s sh`. (Note: the repo is checked out on a Windows-mounted drive, so file execute bits are not reliably tracked — invoke scripts via `sh <script>` or their shebang, not by relying on the `+x` bit.)

## Repo Conventions

- All deliverables (engine skills and game directories alike) live in the single top-level `skills/` directory; the repo root doubles as the future plugin root for both Cursor and Claude Code. Naming: kebab-case skill directories, uppercase well-known files (`GAME.md`, `SKILL.md`), lowercase ordinary references. The GAME.md format spec is at `skills/author/references/game-format.md`.
- `.cursor/{rules,skills,commands}/shared/` are vendored by [`ai-rizz`](https://github.com/Texarkanine/.cursor-rules) as configured in `ai-rizz.skbd` — do not hand-edit; change upstream instead.
- `TTRPG - Cannonball Rally.odt` (LibreOffice) is the original human-written source for the first game's rules; it is input material, not a maintained artifact.
