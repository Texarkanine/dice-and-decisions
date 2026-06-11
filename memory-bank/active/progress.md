# Progress

L4 sub-run for milestone M1 of `lite-rpg-toolkit`: author the GAME.md format specification as an engine reference — required sections, content-table conventions, external data hooks with offline fallbacks, and turn-report format rules — decide the repo layout for engine skills and game directories (deferred from L4 preflight), and retire `VISION.md`.

**Complexity:** Level 3

## 2026-06-11 - COMPLEXITY-ANALYSIS - COMPLETE

* Work completed
    - Classified milestone M1 as Level 3 (Intermediate Feature)
* Decisions made
    - L3 rationale: foundational spec with multiple interlocking design decisions (section schema, content-table conventions, external-data hooks, turn-report format) plus the repo-layout decision deferred from L4 preflight; milestone-scoped, not system-wide
* Insights
    - The spec is consumed by every later milestone (M2, M4, M5, M10 directly); design decisions here set the contract for the whole engine/content boundary

## 2026-06-11 - CREATIVE (Q1: repo layout) - COMPLETE (RESOLVED)

* Work completed
    - Architecture exploration of repo layout: 3 options evaluated against portability, simplicity, extensibility, discoverability
    - Verified plugin facts: Claude Code plugins auto-discover root `skills/<name>/SKILL.md` (official docs); Cursor plugin cache shows identical shape
    - Decision documented in `memory-bank/active/creative/creative-repo-layout.md`
* Decisions made
    - Single top-level `skills/` for engine skills and games; repo root = future plugin root (zero-move M13 packaging)
    - Format spec home: `skills/author/references/game-format.md` — author is the spec's runtime consumer; reference-only directory until M10
    - Naming: kebab-case skill dirs; uppercase well-known files (`GAME.md`); lowercase ordinary references
* Insights
    - Games-are-skills is load-bearing: a `games/` split would fight the one-install-mechanism portability trick and surface packaging pain only at M13

## 2026-06-11 - CREATIVE (Q2: GAME.md machine-anchoring) - COMPLETE (RESOLVED)

* Work completed
    - Architecture exploration of GAME.md anchoring strategy: pure Markdown vs YAML frontmatter vs hidden HTML-comment anchors, evaluated against single-source-of-truth, print parity, machine consumption, authorability
    - Decision documented in `memory-bank/active/creative/creative-game-md-anchoring.md`
* Decisions made
    - Pure structured Markdown: strict H2 section vocabulary, bold-label identity fields, GFM pipe tables, structured hook subsections, turn-report grammar as template + normative examples
    - New spec requirement discovered: a named **Parameters table** for tunable rule values — makes M7 sweeps mechanical and forces explicit values
* Insights
    - The machine reader is an LLM: explicit, named, tabulated values anchor the format better than serialization formats; the same discipline makes a better paper rulebook (the audiences converge — this is why invariant 6 works)
