# Task: M2 rework — card/collection sections for GAME.md

* Task ID: m2-cannonball-rally-game (rework)
* Complexity: Level 2
* Type: Simple enhancement (spec amendment + content restructure)

Add a **card/collection convention** to the GAME.md format spec, then restructure Cannonball Rally's vehicles and stages as cards within `GAME.md`. One file stays the rule — the operator named it the creativity-breeding constraint — and stage cards carry a slot field so future route assembly is additive content.

## Design Decisions (settled by operator; this plan implements them)

- Everything stays in `GAME.md`; no per-object files, no `assets/` work (M8), no n=100 scaling provisions
- Cards exist for *collections*: vehicles now; stages now (slot-structured); obstacle sets are an anticipated future use
- A multi-card slot **is** the Detour — per-slot choice should fall out as the generic rule, not a special case
- Print formatting is a non-concern

## Test Plan (TDD)

Prose deliverable — documentary acceptance checks, run as each step lands and re-verified at QA. No code anticipated (same guard rail as before).

### Behaviors to Verify (acceptance checks)

1. **Spec self-test holds**: after amendment, every per-section example in `game-format.md` is a verbatim substring of Appendix A, and Appendix A passes the spec's own (updated) validation checklist → mechanical substring + checklist walk.
2. **Convention completeness**: the collection convention defines (a) how a collection declares its card schema, (b) one H4 per card, (c) reference-by-name for collections and cards, (d) guidance on table vs. collection (homogeneous rows vs. structured instances) → read the convention against this list.
3. **Spec exercises its own convention**: Lemonade Stand contains at least one collection (Perks converted to cards) so the self-test appendix proves the new rules → check appendix.
4. **One-file principle recorded**: the spec's preamble/conventions state that a game fits reasonably in one `GAME.md` → grep.
5. **Rally conformance**: restructured `GAME.md` passes the updated validation checklist → item-by-item walk.
6. **Content preservation**: every vehicle modifier, ability (with its Type and Suspect marking), and stage condition present before the rework appears after it → diff inventory against the pre-rework tables (git HEAD).
7. **No dangling references**: no prose in the rally or spec still references the removed `Vehicle Modifiers` / `Abilities` / `Route` tables → grep.
8. **Generic slot rule**: the Detour is expressed only as two stage cards sharing a slot plus one generic "multi-card slot = racer's choice" rule — no Detour-specific mechanics → read Core Procedure.
9. **Single-source intact**: no rule value duplicated between cards and prose; parameters still referenced by name → spot-check.

### Test Infrastructure

- Framework: none (prose) — documentary acceptance checks per established precedent.
- New test files: none.

## Implementation Plan

1. **Amend the format spec** (`skills/author/references/game-format.md`)
   - Add the one-file principle to *Why This Format*.
   - In the *Content Tables* section, add the **collection convention**: an H3 may be a collection — an intro defining the card schema, then one H4 per card; cards may hold bold-label fields, one small table, and short labeled prose entries; use tables for homogeneous rows, collections for structured instances.
   - *(Preflight amendment)* The schema declaration is a **normative bold-label line** (`**Card schema:** …`) in the collection's intro, naming the required fields/parts in order — making `author`'s (M10) card validation mechanical instead of inferential, the same trick the Parameters table pulled for `playtest`.
   - Convert Lemonade Stand's Perks to a 3-card collection in **both** the section example and Appendix A (self-test discipline); update the Resolution excerpt + appendix wording that referenced Perks columns (`When`/`Effect` columns → card fields).
   - Extend the validation checklist with collection items (schema declared; every card matches it; H4s only inside collections).
   - Run acceptance checks 1–4.
2. **Restructure rally vehicles** (`skills/cannonball-rally/references/GAME.md`)
   - Replace `### Vehicles` + `### Vehicle Modifiers` + `### Abilities` with one `### Vehicles` collection: per-vehicle H4 card = pitch line, effects table (`Applies to | Effect`), abilities as labeled entries (`**Split the Lanes** *(Action)* — …`, Suspect marked inline).
   - Update all prose references (Core Procedure step 2, Resolution police/traffic bullets, Weather table intro, Abilities-table mentions).
   - Run acceptance checks 6–7 (vehicle half).
3. **Restructure rally stages** (same file)
   - Replace `### Route` with a `### Stages` collection: per-stage H4 card with `**Slot:**`, `**Weather City:**`, `**Traffic:**`, `**Police:**`, `**Roads:**`, `**Grade:**`, `**Bank:**` fields.
   - Add the generic slot rule to Core Procedure (race runs slots in order; a slot holding multiple cards is a racer's choice — the classic route's slot 5 is the Detour); adjust the Round and Turn Report wording (`via <stage>`).
   - Run acceptance checks 5, 6–9 (full).
4. **Documentation alignment**
   - `memory-bank/systemPatterns.md`: the GAME.md vocabulary paragraph gains collections; `README.md`: no change expected (verify).
   - Re-run check 1 (spec sync) once everything has settled.

## Technology Validation

No new technology - validation not required.

## Dependencies

- Pre-rework `GAME.md` at git HEAD (content-preservation diff baseline)
- Operator design decisions recorded in `projectbrief.md` Rework section

## Challenges & Mitigations

- **Excerpt/appendix sync is the riskiest seam**: converting Perks touches the Content Tables example, the Resolution example, and Appendix A simultaneously. → Edit Appendix A first, then re-derive every excerpt from it verbatim; finish with the mechanical substring check.
- **Suspect marking loses its table column**: it must stay machine-findable inside card prose. → Fixed inline form `*(Action — Suspect)*` declared in the collection's schema intro; checklist item enforces it.
- **Checklist bloat**: each new checklist item must restate exactly one normative rule. → Add the minimum set (3 items) and review against the existing one-rule-per-item style.
- **Scope creep into route presets**: multiple routes/maps are future content. → Only the classic route ships; the slot rule is the entire assembly mechanism.

## Implementation Step Tracking

- [x] Step 1: Spec amended — one-file principle, collection convention (`**Card schema:**` normative line), Perks converted to cards in section example + Appendix A, 3 checklist items added, 2 items generalized
- [x] Step 2: Rally vehicles → 6-card collection (pitch + effects table + inline abilities); `Vehicles`/`Vehicle Modifiers`/`Abilities` tables retired; prose references updated
- [x] Step 3: Rally stages → 7-card collection with `**Slot:**` fields; generic multi-card-slot rule; Detour reduced to a parenthetical name for slot 5's choice; turn report `via <stage>`
- [x] Step 4: `systemPatterns.md` aligned; README verified (no change needed)
- All 9 acceptance checks pass (excerpt/appendix sync mechanically verified; ability census 5 Action / 4 Passive / 3 Reaction, 4 Suspect; slots 1–6 with 5 doubled)

## Status

- [x] Initialization complete
- [x] Test planning complete (TDD)
- [x] Implementation plan complete
- [x] Technology validation complete
- [x] Preflight
- [x] Build
- [x] QA — PASS (1 trivial fix: Vehicles-collection intro restated the Suspect→*Suspicion Step* rule already owned by Resolution; intro now defers to Resolution)
