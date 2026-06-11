# Task: Formalize Cannonball Rally as a complete game directory

* Task ID: m2-cannonball-rally-game
* Complexity: Level 2
* Type: Simple enhancement (content authoring against an existing spec)

Create `skills/cannonball-rally/` — a valid game-directory-as-skill containing a `SKILL.md` wrapper and a `references/GAME.md` authored against `skills/author/references/game-format.md`. This is the format's designated proving milestone: any spec gaps the rally surfaces are fixed in the spec as part of this task.

## Source Material Inventory

- `TTRPG - Cannonball Rally.odt` (repo root) — stages and vehicle cards. Extraction so far (lossy; tables flattened):
  - **Stages** (coast-to-coast order): Escape from New York (NYC), Appalachia (Pittsburgh), Route 66 (Springfield), Midwest (Tulsa), Detour!, Rocky Mountains (Denver), Southwest Desert (Flagstaff), California Dreamin' (Redondo Beach). Each stage has: Weather reference city, Traffic (Light/Medium/Heavy), Police (Light/Medium/Heavy), Roads (Urban/Rural/Highway + grade/bank tiers).
  - **Vehicles** (6): Ambulance, Motorcycle, 4x4, SUV, 2-door Supercar, 4-door Sedan. Each has a bonus/penalty card across Weather/Traffic/Police/Roads(Type/Grade/Bank) plus named Abilities and Passives (e.g. Lights & Sirens!, Split the Lanes, Biker Gang, Double Down, Built for This, Cut Corners, Gun It, Need for Speed, Blend In, Somethin's Up, Loud Pipes).
- `memory-bank/productContext.md` Known Games row — oral-tradition facts already on record: 2–6 players, d6, win = lowest total hours once every racer has finished or been jailed; real-weather hook (stage weather = real forecast for the stage's reference city, offset +2hr per stage) with offline fallback table.
- Known-surfaced but **not yet written** rules (the six from the author's head, per the spec preamble): base stage time (2hr default — the founding balance question), the speeding option, how weather resolves into penalties, what counts as an obstacle, which die, win condition. Die and win condition are now on record; the others need the author.

## Test Plan (TDD)

Prose deliverable — validation is documentary acceptance checks (M1's proven TDD-for-prose shape), executed at build step completion and re-verified at QA. No code is anticipated; if any script becomes necessary, STOP and re-plan (guard rail per L4 invariant 8).

### Behaviors to Verify (acceptance checks)

1. **Spec conformance**: `references/GAME.md` passes every item of the spec's Validation Checklist (all 9 section groups) → checked item-by-item, not by vibes.
2. **Turn-report stress test**: every legal player action — including every reactive ability (Double Down, Gun It, Loyal-Customers-style rerolls, ability-triggered police rolls) — is expressible in the turn-report grammar within the ~dozen-word budget → enumerate actions × grammar, show each maps.
3. **Weather hook fidelity**: the External Data Hook encodes the per-stage reference city and the +2hr-per-stage offset, and its fallback resolves by d6 roll on a content table → fields present, fallback table covers 1–6.
4. **Parameters completeness**: *Base Stage Time* (2 hr) and every other tunable scalar (speeding bonus, penalty magnitudes, etc.) appear in the Parameters table and nowhere else → grep prose for buried constants.
5. **Source absorption**: every stage, vehicle modifier, ability, and passive in the ODT appears in `GAME.md` (re-themed/re-balanced is fine; silently dropped is not) → diff inventory against document.
6. **Valid skill wrapper**: `skills/cannonball-rally/SKILL.md` has agentskills.io-conformant frontmatter (name, description pitching the game) and a body directing engines to `references/GAME.md` → matches the game-directory-as-skill pattern in `systemPatterns.md`.
7. **No unwritten rules**: every Resolution-section interrogation question (randomizer operation, modifiers/stacking, bounds, ties, simultaneity) has an explicit answer; "GM's call" appears nowhere a mechanic belongs.
8. **Spec feedback loop**: any spec amendment made during this task keeps `game-format.md` self-consistent — section excerpts remain verbatim substrings of Appendix A (M1's sync check).

### Test Infrastructure

- Framework: none (prose deliverable) — documentary acceptance checks per L4 invariant 8 and the M1 precedent.
- Test location: checks recorded here; results recorded in `progress.md` at build completion and re-run at QA.
- New test files: none.

## Implementation Plan

1. **Faithful source extraction + open-rules interrogation list**
   - Files: working notes only (no repo changes yet)
   - Changes: re-extract the ODT preserving table structure (parse `content.xml` table elements, not flattened paragraphs) so each vehicle's bonus/penalty cells land in the right Weather/Traffic/Police/Type/Grade/Bank slot. Build the stage-conditions inventory. Compile the open-rules question list — everything the paper and memory bank don't answer: core round procedure, the speeding option's mechanics, obstacle definition and how obstacles are generated/encountered, police-evasion roll mechanics (base roll, "roll >2" semantics, tier modifiers), weather→penalty mapping table, Detour! stage mechanics, grade/bank tier meanings, starting conditions, ties during play. **Interrogate the operator (the game's author) with this list in one batched Q&A** — inventing rules for someone else's game is not an option. *(Preflight amendment)* Preserve the full interrogation transcript — questions as asked, answers as given — in the build's `progress.md` entry: it is the founding field data for the `author` skill's interrogation mode (M10), worth more verbatim than summarized.
2. **Draft `skills/cannonball-rally/references/GAME.md`**
   - Files: `skills/cannonball-rally/references/GAME.md` (new)
   - Changes: author the full document against the spec, section by canonical section: title block (2–6 players, time, one d6); Core Procedure (Setup + Round = one stage); Resolution (the interrogation answers from step 1); Scoring & End State (lowest total hours; jailed racers; tie-breakers); Parameters (*Base Stage Time* 2 hr + all other scalars); Content Tables (Stages, Weather fallback, Vehicles' modifiers, Abilities, Obstacles as applicable); External Data Hooks (*Stage Weather*: reference city, +2hr/stage offset, d6 fallback); Turn Report (grammar covering declarations + all reactive abilities); GM Guidance. Run acceptance checks 1–5 and 7 as each section lands.
3. **Author `skills/cannonball-rally/SKILL.md`**
   - Files: `skills/cannonball-rally/SKILL.md` (new)
   - Changes: frontmatter pitching the game; body = "activate the engine skills against `references/GAME.md`" per the game-directory-as-skill pattern. Run acceptance check 6.
4. **Spec gap foldback (conditional)**
   - Files: `skills/author/references/game-format.md` (edit only if gaps surfaced)
   - Changes: fold any format amendments the rally forced back into the spec; re-run the excerpt/appendix sync check (acceptance check 8). If no gaps: record that explicitly.
5. **Documentation updates**
   - Files: `README.md`, `memory-bank/productContext.md`, `memory-bank/systemPatterns.md` (status note)
   - Changes: README repo-layout/status section gains the first game; productContext Known Games row for Cannonball Rally flips from "rules exist in .odt + oral tradition" to formalized-at-path; systemPatterns status note updated (GAME.md format now proven by a real game). The ODT remains in place as historical input material (per techContext).

## Technology Validation

No new technology - validation not required.

## Dependencies

- `skills/author/references/game-format.md` (M1, complete) — the contract being proven
- `TTRPG - Cannonball Rally.odt` — source content (requires structured re-extraction)
- **The operator**, as the game's author — sole source for the oral rules (step 1 Q&A)

## Challenges & Mitigations

- **Lossy ODT extraction**: flattened paragraphs scrambled the bonus/penalty table cells. → Parse `content.xml` table markup directly in step 1; verify each vehicle card cell-by-cell against the inventory.
- **Oral rules live only in the author's head**: the core loop, speeding, obstacles, and police mechanics are not on paper. → Batched operator interrogation in step 1; do not invent. This is also a live rehearsal of the `author` skill's interrogation mode — note what works for M10.
- **Reactive abilities vs turn-report budget** (M1 reflection flagged this as the grammar's stress point): Double Down and Gun It are mid-resolution reactions. → Acceptance check 2 enumerates every action explicitly; if the budget can't hold, the fix is the game's report format (per spec), and if the *spec's* grammar rules are insufficient, step 4 amends them.
- **Scope creep into engine concerns**: the temptation to specify GM behavior (turn briefs, state tables) in the game doc. → The game owns only what the spec's sections own; engine behavior stays out (spec's Turn Report conventions already draw this line).

## Implementation Step Tracking

- [x] Step 1: Source extraction + operator interrogation (4 rounds, transcripts in `progress.md`)
- [x] Step 2: `skills/cannonball-rally/references/GAME.md` drafted, acceptance checks 1–5, 7 run
- [x] Step 3: `skills/cannonball-rally/SKILL.md` authored, acceptance check 6 run
- [x] Step 4: Spec foldback — **no amendments needed**; format held against the rally (check 8: spec untouched, excerpt/appendix sync n/a)
- [x] Step 5: Docs — `README.md`, `productContext.md`, `systemPatterns.md` updated

## Status

- [x] Initialization complete
- [x] Test planning complete (TDD)
- [x] Implementation plan complete
- [x] Technology validation complete
- [x] Preflight
- [x] Build
- [x] QA — PASS (2 trivial fixes: LibreOffice lock-file debris untracked + gitignored; Vehicle Modifiers column relabeled `Modifier` → `Effect` to honor the spec's sign rule for its mixed numeric/textual cells). The 8 drafted-content flags in `activeContext.md` are design content awaiting author sign-off, not QA defects — carried forward to operator review.
