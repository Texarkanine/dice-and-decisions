# Active Context

## Current Task: m1-game-md-format-spec
**Phase:** BUILD - COMPLETE

## What Was Done

- **Created `skills/author/references/game-format.md`** (the milestone deliverable): preamble (two audiences, paper-first parity, LLM-reader rationale, six-unwritten-rules anecdote), document conventions (pure GFM, canonical H2 vocabulary + order, extension rule, single-source rule, randomizer neutrality), per-section rules for all 9 sections (each with purpose / required content / conventions / example), validation checklist (one item per normative rule), and Appendix A: the assembled toy game
- **Updated `README.md`**: repo layout section (`skills/` convention, repo root = plugin root), format spec links, status reflecting the spec's existence
- **Deleted `VISION.md`** after absorption diff: six-unwritten-rules enumeration → spec preamble; +2hr weather-offset detail → `productContext.md` Known Games; persona purpose + mixed-tables-last rationale → `systemPatterns.md`; all other content verified already present in memory bank
- **Updated persistent memory bank**: `systemPatterns.md` (status note now reflects realized format + layout; new "Repo layout" pattern; GAME.md pattern updated to the realized section vocabulary), `techContext.md` (skills/ layout convention under Repo Conventions)

## Key Build Decisions (not in creative docs)

- Toy game is **Lemonade Stand**: rival lemonade stands, weather hook with roll-table fallback, perks, premium pricing — small enough to be trivial, rich enough to exercise every section including a reactive action (reroll perk) in the turn-report grammar
- Identity & flavor realized as the **title block**: bold-label fields + pitch between the H1 and first H2 (rulebook front-matter position), not an H2 section
- Identity field is `**Randomizer:**` (not `**Dice:**`) to keep the format randomizer-neutral by construction
- Canonical section order fixed and normative: Core Procedure → Resolution → Scoring & End State → Parameters → Content Tables → [External Data Hooks] → Turn Report → GM Guidance (rules prose first, reference material after)
- `### Setup` and `### Round` are canonical H3s inside Core Procedure; the round opens with "**A round is** ..." stating its fiction
- Hooks own *what/how*; Core Procedure steps own *when* (hooks invoked by name from steps) — no timing duplication
- Single-source rule made normative inside the document: rule values live only in Parameters/content tables; prose references them by name
- Extension H2s allowed only after GM Guidance, advisory only (nothing required for play)

## Deviations from Plan

None — built to plan, including the preflight toy-game amendment.

## Verification Results

- All 13 documentary acceptance checks in `tasks.md` pass by inspection
- Appendix A walked through the spec's own validation checklist: passes every item (self-test)
- `skills/` contains exactly the spec; no dangling VISION.md references outside memory-bank history files
- No linter errors; no test suite/build exists for this prose-only milestone (per plan)

## Next Step

- QA phase (`niko-qa` skill) — runs autonomously per L3 workflow
