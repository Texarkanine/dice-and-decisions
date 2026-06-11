# Current Task: m1-game-md-format-spec

**Complexity:** Level 3

*(Plan phase in progress — component analysis and open questions below; full plan populated at end of plan phase.)*

## Component Analysis (draft)

### Affected Components

- **GAME.md format spec** (new): engine reference defining required sections, content-table conventions, external data hooks with offline fallbacks, turn-report format rules. Consumed by M2, M4, M5, M10.
- **Repo layout skeleton** (new): directory structure for engine skills and game directories — design decision deferred from L4 preflight to M1.
- **`VISION.md`** (retired): seed material already absorbed into memory bank; deleted once spec lands.
- **`README.md`** (updated): point at the spec and layout.
- **`memory-bank/systemPatterns.md` / `techContext.md`** (updated): record layout decision once made.

### Cross-Module Dependencies

- Format spec → every game document (M2, M11, M12): games must satisfy it.
- Format spec → `gm` (M4): defines what the GM parses (sections, tables, hooks, turn reports).
- Format spec → `author` (M10): validation checklist must be mechanically derivable from the spec.
- Repo layout → plugin packaging (M13): layout must package cleanly for Cursor and Claude.

### Invariants & Constraints (from L4 milestone list)

1. Paper-first parity — GAME.md is printable and playable with paper, pencils, and a d6.
2. GAME.md is the single source of truth — one document, two audiences; no separate machine spec.
3. Engine/content separation — the spec is engine; no game-specific rules in it.
4. Skills-only core — layout must be agentskills.io-compatible.
5. Vendored rules untouched — nothing under `.cursor/{rules,skills,commands}/shared/`.

## Open Questions

- [x] **Q1: Repo layout** → Resolved: single top-level `skills/` directory for engine skills AND game directories; repo root doubles as plugin root (both Cursor and Claude plugins auto-discover root `skills/`); format spec lives at `skills/author/references/game-format.md` (author is its runtime owner; SKILL.md arrives in M10). (see `memory-bank/active/creative/creative-repo-layout.md`)
- [x] **Q2: Machine-anchoring strategy for GAME.md** → Resolved: pure structured Markdown — exact H2 section vocabulary, bold-label identity fields, GFM pipe tables, a named Parameters table for tunable values, structured hook subsections with table-based offline fallbacks, turn-report grammar as template + normative examples. No frontmatter, no hidden annotations: the machine reader is an LLM, so explicitness and consistency anchor the format, and print/machine needs converge. (see `memory-bank/active/creative/creative-game-md-anchoring.md`)
