# Active Context

## Current Task: m2-cannonball-rally-game
**Phase:** BUILD - COMPLETE

## What Was Done

- Full L2 plan written to `tasks.md`: source inventory (ODT stages + 6 vehicles; oral-tradition facts from productContext), 8 documentary acceptance checks (TDD-for-prose, reusing the M1 shape), 5-step implementation plan, challenges & mitigations
- Key plan decisions:
    - Step 1 ends with a **batched operator interrogation** for the oral rules (core loop, speeding, obstacles, police mechanics, Detour!, grade/bank) — the author's rules are not invented
    - ODT must be re-extracted structurally (table markup, not flattened paragraphs) — the naive extraction scrambled vehicle bonus/penalty cells
    - Spec-gap foldback is an explicit conditional step with the M1 excerpt/appendix sync check
- No new technology; no code anticipated (guard rail: STOP and re-plan if a script becomes necessary)

## Build Results

- Files created: `skills/cannonball-rally/SKILL.md`, `skills/cannonball-rally/references/GAME.md`
- Files modified: `README.md`, `memory-bank/productContext.md` (Known Games row), `memory-bank/systemPatterns.md` (status note)
- Key decisions during build:
    - 4 interrogation rounds produced a design simplification: deterministic map (no GM obstacle rolls), unified per-stage police check (bar = police tier + Suspicion Step per suspect action), strict-beat threshold semantics (ties lose)
    - Sequenced reactions (Double Down, Gun It, Blend In) stay as-written, separate from the stage police bar — per operator ruling
    - Turn-report grammar grew `[ via <detour>]` mid-build — the Detour stage choice was inexpressible (M1's "reactive/optional actions break grammars" lesson, confirmed on a real game)
    - `Forecast Offset` promoted to a parameter after the buried-constant scan caught "+2 hours per stage" in hook prose
- **Drafted-content flags requiring author sign-off (carried to QA/operator review):**
    1. Traffic penalty applies at Medium+ tiers only (Light = free) — my call; alternative was all tiers
    2. Cut Corners effect drafted as -1 hr (source never stated its benefit; sized per *Risk Magnitude*)
    3. Racers tied on total hours act in setup order (bookkeeping rule, invented)
    4. Weather fallback table rows (Clear/Heat/Rain/Storm/Snow+ice and their *Counts as* categories) are new content
    5. Need for Speed read as "subtract 1 hr instead of *Speeding Bonus*" (source: "speeding is -1hr faster")
    6. Get-around abilities (Split the Lanes, Built for This, Hooliganism) now roll vs. traffic tier per the round-3 "heavier = harder" ruling — originally some auto-succeeded with only a police roll
    7. Title block Time: "about an hour" (estimate)
    8. Forecast interpretation tie-break: "pick the row whose Counts-as list is shorter" (invented)

## Next Step

- QA (`niko-qa` skill)
