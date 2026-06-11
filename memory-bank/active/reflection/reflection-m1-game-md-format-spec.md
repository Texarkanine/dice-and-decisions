---
task_id: m1-game-md-format-spec
date: 2026-06-11
complexity_level: 3
---

# Reflection: GAME.md Format Specification (M1)

## Summary

Authored the GAME.md format specification (`skills/author/references/game-format.md`) — canonical section vocabulary, content-table conventions, external-data hooks with paper-table fallbacks, turn-report grammar rules, a validation checklist, and a self-testing worked example — established the `skills/` repo layout, and retired `VISION.md`. Single-pass build, clean QA; the milestone succeeded.

## Requirements vs Outcome

Every milestone deliverable landed: the spec with all planned section rules, the repo layout (first use of the `skills/` convention), VISION.md absorbed and deleted, README and persistent memory bank updated. Two additions relative to the original milestone wording were both sanctioned plan evolutions, not creep: the Parameters table (creative Q2 discovery) and the Lemonade Stand worked example with self-test appendix (preflight innovation amendment). Nothing was dropped or reinterpreted.

## Plan Accuracy

The 4-step plan executed in order with no resequencing and an exact file list. None of the planned risks materialized as problems: over-specification was managed by keeping every rule traceable to a named consumer (`gm`, `playtest`, `author`); under-specification is deliberately deferred to the proving milestones (M2 authoring-side, M4 parsing-side). One mild surprise: the VISION absorption diff surfaced two unique facts beyond the plan's three named candidates (the +2hr weather-offset detail; persona purpose / mixed-tables-last rationale) — the candidate list was incomplete, but the diff procedure itself caught them, which is exactly why the step prescribed a diff rather than a checklist.

## Creative Phase Review

- **Q1 (repo layout)**: zero friction. The spec landed at the planned path; nothing else entered `skills/`; both naming conventions held. The verified plugin-discovery facts gave the decision the confidence it needed — no second-guessing during build.
- **Q2 (pure-Markdown anchoring)**: held up fully; the creative doc's implementation notes mapped 1:1 onto spec rules. The Parameters-table discovery became the spec's load-bearing anchoring rule (single source of truth: values live in exactly one place, prose references by name).
- One micro-decision was left to build that creative had only sketched: the identity block landed as a *title block* (between H1 and first H2, outside the H2 vocabulary) and its field became `**Randomizer:**` rather than creative's sketched `**Dice:**`. Both refinements follow directly from constraints already on record (print parity, randomizer neutrality) — this is the right granularity to leave to build.

## Build & QA Observations

Build was clean and single-pass. The most valuable build event: the toy game immediately vindicated the preflight amendment — Lemonade Stand's reroll perk (a *reactive* action) forced the turn-report grammar to grow `[ then <m>]`, a cross-section gap (Perks table ↔ Turn Report) that scattered snippets would never have surfaced. QA found nothing substantive; its mechanical spot-checks (all 9 section examples verbatim substrings of Appendix A; appendix H2s exactly canonical) are worth re-running after any future spec edit.

## Cross-Phase Analysis

- Preflight's toy-game amendment → directly caused the build's most valuable discovery (the reactive-action grammar gap), pre-paying a lesson M2 would otherwise have learned mid-stride.
- Creative Q2's Parameters discovery → anchored the single-source rule that the whole spec leans on.
- Plan's absorption-diff design → compensated for its own incomplete candidate list; procedure beat enumeration.
- No negative chains: no planning gap caused build problems, no creative decision created QA findings, no QA rework occurred.

## Insights

### Technical

- **Self-testing spec pattern**: requiring the spec's own appendix example to pass the spec's validation checklist catches cross-section contradictions at authoring time. The cost is a maintenance coupling — section excerpts must stay verbatim-identical to the appendix — so any future spec edit should re-run the excerpt-substring check QA used.
- **Reactive actions are where declaration grammars break**: the turn-report budget is easy to meet for declarations, hard for reactions (rerolls, interrupts). The spec now requires the grammar to express every legal action; M2 should deliberately stress this against Cannonball Rally's abilities.

### Process

- **Documentary acceptance checks are TDD for prose**: writing the 13 checks at plan time made build verification and QA nearly mechanical. Reuse this shape for M2 (game authoring is also a prose deliverable with a checkable contract — the spec's own validation checklist).
- **Absorption-diff before deletion works; candidate lists don't**: trust the diff procedure, not the plan's enumeration of what the diff will find.
