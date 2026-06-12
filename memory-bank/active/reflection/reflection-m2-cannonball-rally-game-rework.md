---
task_id: m2-cannonball-rally-game (rework)
date: 2026-06-11
complexity_level: 2
---

# Reflection: M2 Rework — Card Collections

## Summary

Added the card/collection convention to the GAME.md format spec and restructured Cannonball Rally's vehicles and stages as cards inside the one document. Succeeded cleanly; the rally now reads as the ODT's cards did, and route assembly became future-additive content.

## Requirements vs Outcome

All four rework requirements delivered: the convention (with the preflight-amended normative `**Card schema:**` line), the rally restructure (6 vehicle cards, 7 slot-structured stage cards), the one-file principle written into the spec's *Why This Format*, and the explicit non-goals honored (no per-object files, no assets, no scaling provisions). One unplanned win: the Detour stopped being a mechanic — slot multiplicity *is* the choice, and per-slot choices everywhere (the operator's "every stage a detour" musing) now costs zero additional rules.

## Plan Accuracy

The 4-step plan held exactly; appendix-first editing made the spec's excerpt/appendix sync a non-event. The one surprise was environmental: the operator had reflowed the rally documents (unwrapped hard-wrapped lines) and copy-edited `SKILL.md` between sessions — a failed verbatim-match edit caught it, and the build adopted their style.

## Build & QA Observations

Build was mechanical once the convention's wording settled. QA found one real thing: the Vehicles collection intro restated the Suspect rule that Resolution owns — collection intros are a new temptation surface for rule duplication, worth a dedicated check in `author`'s validator (M10).

## Insights

### Technical

- **Good structure deletes rules.** The slot field turned the Detour from a special-cased mechanic into emergent behavior. When a rule exists only to describe an arrangement of content, restructure the content instead.
- **Collection intros attract rule duplication**: schema semantics belong in the intro; game rules belong in Resolution. Add this to `author`'s validation checks.

### Process

- **Verbatim-match editing doubles as a tripwire** for out-of-band operator edits — the failed exact-match replace was the only signal the documents had changed. Re-read before editing files an operator has open.
- The design conversation that triggered this rework (operator weighing separate files vs. one document, then choosing the constraint over the convenience) produced a better outcome than either initial instinct — "the one-file constraint is the creativity-breeding one" is now load-bearing spec text.

### Million-Dollar Question

If collections had been in the format from M1, the rally's first formalization would have produced cards directly and this rework wouldn't exist — but the convention's *shape* (normative schema line, intro-vs-Resolution ownership split) was only findable by restructuring a real game that already had a unified rules core. M1's toy game couldn't have surfaced it: Perks were too small to hurt as a table. The sequence was right; the cost was one rework cycle, and it bought the convention its proof.
