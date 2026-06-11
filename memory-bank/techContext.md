# Tech Context

A Markdown-first repository: deliverables are [agentskills.io](https://agentskills.io/specification)-compatible skill directories (`SKILL.md` + `references/`, `scripts/`, `assets/`) and game documents, not application code. The only executable code anticipated is small shell scripts inside skills (e.g. the dice roller). Development happens in Cursor; portability is validated in Claude Code, with eventual plugin packaging for both.

## Environment Setup

No build or runtime environment is required to work on the repo — it is plain Markdown plus shell scripts. Skills are exercised by installing/activating them in an agent harness (Cursor or Claude Code).

## Build Tools

None. There is no package manager, compiler, or bundler. Plugin packaging manifests are deliberately deferred until the engine is right.

## Testing Process

No test infrastructure exists yet. When shell scripts land, they are written and tested per the workspace shell rules (`.cursor/rules/shared/shell-tdd.mdc`, `bash-style.mdc` / `shell-posix-style.mdc`); expect `bats` or equivalent to be introduced alongside the first script.

## Repo Conventions

- All deliverables (engine skills and game directories alike) live in the single top-level `skills/` directory; the repo root doubles as the future plugin root for both Cursor and Claude Code. Naming: kebab-case skill directories, uppercase well-known files (`GAME.md`, `SKILL.md`), lowercase ordinary references. The GAME.md format spec is at `skills/author/references/game-format.md`.
- `.cursor/{rules,skills,commands}/shared/` are vendored by [`ai-rizz`](https://github.com/Texarkanine/.cursor-rules) as configured in `ai-rizz.skbd` — do not hand-edit; change upstream instead.
- `TTRPG - Cannonball Rally.odt` (LibreOffice) is the original human-written source for the first game's rules; it is input material, not a maintained artifact.
