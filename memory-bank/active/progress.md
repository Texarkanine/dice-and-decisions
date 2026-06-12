# Progress

L4 sub-run for milestone M2 of `lite-rpg-toolkit`: formalize Cannonball Rally as a complete game directory — a valid skill wrapper plus `references/GAME.md` authored against the M1 format spec — proving the format on a real game and fixing any spec gaps it surfaces.

**Complexity:** Level 2

## 2026-06-11 - COMPLEXITY-ANALYSIS - COMPLETE

* Work completed
    - Advanced L4 milestone list: M1 checked off, sub-run ephemeral state cleared
    - Classified milestone M2 as Level 2 (Simple Enhancement)
* Decisions made
    - L2 rationale: one self-contained game directory authored against the finished spec; no engine code, no architectural decisions (settled in M1); spec-gap fixes are contained edits
* Insights
    - M2 is the format's designated proving milestone (L4 invariant 8) — reflection from M1 flagged testing the rally's reactive abilities against the turn-report grammar, and reusing documentary acceptance checks as TDD-for-prose

## 2026-06-11 - PLAN (L2) - COMPLETE

* Work completed
    - Full L2 plan in `tasks.md`: source inventory (ODT structural extraction findings: 8 stages, 6 vehicles with abilities/passives), 8 documentary acceptance checks, 5-step implementation plan, challenges & mitigations
    - Test infrastructure survey: prose deliverable, no code anticipated — documentary acceptance checks per the M1 precedent and L4 invariant 8
* Decisions made
    - Step 1 ends with a batched operator interrogation for the oral rules (core loop, speeding option, obstacle definition, police-evasion mechanics, weather→penalty mapping, Detour!, grade/bank tiers, ties) — the author's game is not guessed at
    - ODT re-extraction must parse `content.xml` table markup; the flattened-paragraph extraction scrambled vehicle bonus/penalty cells
    - Spec-gap foldback is an explicit conditional step (4) carrying M1's excerpt/appendix sync-check obligation
* Insights
    - The step-1 interrogation doubles as a live rehearsal of the `author` skill's interrogation mode (M10) — worth noting what works
    - Acceptance check 2 (enumerate every legal action × turn-report grammar) operationalizes M1's "reactive actions are where grammars break" insight

## 2026-06-11 - PREFLIGHT (L2) - COMPLETE (PASS)

* Work completed
    - Validated plan: TDD encoding (prose-only; acceptance checks written at plan time, run per-section during build; code guard rail present), convention compliance (`skills/cannonball-rally/` matches kebab-case + game-directory-as-skill pattern; no deviations), dependency impact (grep confirms all Cannonball touchpoints — README, productContext, game-format illustration text — are either planned doc updates or no-ops), conflict detection (greenfield directory; `skills/` contains only `author/`; no overlap), completeness (every milestone deliverable maps to a step and an acceptance check)
    - Wrote `.preflight-status`: PASS
* Decisions made
    - Innovation amendment applied to plan step 1: preserve the operator interrogation transcript verbatim in the build record — founding field data for the `author` skill's interrogation mode (M10)
* Insights
    - The spec's illustrative Cannonball mentions in `game-format.md` are deliberately rule-free, so M2 cannot contradict them — the format's "no game rules in the spec" discipline pays off here

## 2026-06-11 - BUILD (L2) - IN-PROGRESS (step 1: interrogation round 1 answered)

* Work completed
    - Structured ODT re-extraction (table markup, cell-accurate): 6 vehicle cards, 8 stage condition blocks, all abilities/passives recovered
    - Interrogation round 1: 12 questions asked, operator answered. **Verbatim transcript preserved below** (field data for `author` interrogation mode, M10)
* Decisions made (operator rulings, round 1)
    - Core loop per stage: (1) GM announces stage, weather, special conditions, standard time; (2) players act in order of current LOWEST cumulative time (first stage: house rules, default clockwise) — being ahead means others see your move and react; GM reminds each player of their vehicle's buffs/detriments; (3) players declare intent and roll, getting their stage time; (4) scoreboard updated
    - Setup: free vehicle selection, duplicates allowed (duplicate-vehicle interactions are a feature)
    - Speeding: declare on your turn; flat -0.5hr off stage time; -1 to your police-avoidance roll
    - Police: everyone is passively illegal — baseline 1/6 police interest on 1d6 (roll above 1 to avoid); speeding/Hooliganism/etc. debuff that roll (GTA-star-rating model)
    - Weather: no direct penalty mechanism; only intersects vehicle cards; GM discretion for ambient flavor effects. Magnitude heuristic: ambient/RNG effects ±0.5hr, player-initiated risks ±1hr ("agency matters")
    - Obstacles: GM rolls 1d6 + obstacle tier per stage; obstacle present on total ≥ 6. Tiers: Light/Medium/Heavy (Heavy = 3, e.g. NYC traffic)
    - Road type (Urban/Rural/Highway) is a kind, not a tier — intersects vehicle cards only. Grade/bank likewise only intersect vehicle characteristics
    - Detour!: after Midwest, each player CHOOSES Rocky Mountains or Southwest Desert (car + forecast inform the choice). Future: alternate route maps planned
    - Jail (Double Down fail) = early loss, hours dropped, off leaderboard. Ordinary pull-overs = detained only (buddy bails you out)
    - Final ties stand — tied racers tie ("Drama, baybee!"); no run-off
    - Card corrections: 4x4 weather negation is a **bonus** (misfiled); Sedan inclement weather is a **+0.5hr penalty** (misfiled as -0.5hr)
* Insights
    - Magnitude heuristic (ambient ±0.5 / agency ±1) is a designer principle worth surfacing in GM Guidance, not just a value table
    - Round 2 follow-ups required: what the step-3 roll determines (time computation), baseline police-check cadence and tier interaction, obstacle penalty magnitudes and per-category scope

### Interrogation transcript — round 1 (operator verbatim)

> Core Loop 1: in order,
>
> 1. gm announces "we're entering... \<stage\>, weather is... [any special randomized conditions]. Standard time is X hours (if rainy, standard time may increase above base hours, or construction, etc)"
> 2. in order of current LOWEST time (house rools, default clockwise, or w/e, if first turn - idea is being ahead lets others see what you do first and REACT to it in their decisions, deciding if they need to speed, etc), players are asked what they want to do - even if there are no obstacles to contend with, players may choose to speed. GM should remind players of their buffs/detriments, e.g. "hey, this is open highway, so mr. SUV, you're actually gonna be 2.5hrs 'cause you'll be getting a lot of gas" or something.
> 3. players declare intent and roll, getting their time through the stage.
> 4. scoreboard updated
>
> at setup: house rules, default free selection, multiple allowed. fun interactions with multiples (multiple motorcycles, multiple ambulances) are part of the fun.
>
> speeding: on your turn, you can declare that you'll be speeding. That modifier goes onto whatever ELSE you're dealing with. speeding . The whole cannonball is illegal, so you always have a chance of police: 1d6. If you speed, you take a -1 to your roll against that (i.e. you must roll above a 1 - 2-5 - to avoid police. If you speed, you get -1 - so your 2 becomes a 1 and FAILS the check - you got cops on you!)
>
> speeding knocks 0.5h off your time, flat (playtesting may change that, but, for now, we do that).
>
> Police are like your GTA star rating: you're all passively illegal with 1/6 of police interest. Hoolagainism, speeding, etc, can all debuff your rolls to avoid police.
>
> Weather: no direct penalty; intersects with various vehicles. a clear and sunny day has no penalty... except maybe if you're in nevada, and it's a hot day (>100F), that little sedan might overheat and need a break, so +.5hr (most ambient / RNG effects are +/- .5h, most player-initiated risks are +/- 1hr - agency matters!). This isn't mechanizable - the GM will have to run with it. Cars note what kind of weather they respond to, GM can add specific flavor in - i.e. if you're playing in Lousiana during hurrcane season because you're shelting in place RIGHT NOW, then maybe super-incllement storms show up in your game - up to GM discresion. the only REAL mechanism is where a vehicle notes it intersects with a kind of weather.
>
> Obstacles: GM rolls 1d6 + obstacle tier per stage. light, medium heavy are the tiers. So, Escape from New york: traffic: heavy - that's a 3. GM rolls 1d6, if they meet or exceed 6, the obstacle is present. So, you roll 2 - +3, that's 5 - no traffic obstacle in NYC today. Playtesting may reveal that the math needs to change; this is where we'll start.
>
> road urban/rural/highway isn't a tier exactly - it's a kind, and it also intersects w/ car buffs/bonuses.
>
> You can see that picking a few different ROUTES across the US, would build totally differnet games (that's planned for the future - a couple different "maps")
>
> Stages: "detour" is where players have a CHOICE of which stage they want to go through - once completing midwest, they can go through the mountains or detour farther south and go flat. depending on their car and their expectation of the forecast, they might choose differently... grade/bank are only intersections w/ vehicle characteristics.
>
> Edge cases: Jail is a early-lose. Otherwise, you're just detained. Call it your buddy bails you out so you can finish the race (you may still end up in prison after you finish the race, but that's not part of the game ;) ). A jailed racer's hours are dropped - they're off the leaderboard. Can't win no' mo'.
>
> Ties are allowed. If you tie, you tie. Drama, baybee! I don't have a run-off design at the moment.
>
> 4x4 - yeah, that should be a bonus, I think. Sedan -0.5hr in inclement weathe ris misfiled, it's a +0.5hr penalty. You take longer because your car is smol and not built for the rough weather.

### Interrogation round 2 — rulings

* Rolls are action/reaction-only: a racer with nothing to contend with takes Base Stage Time + card modifiers with **no roll** ("I cruise") — except the police check
* **Every racer rolls the police check every stage** — chances can be low, never zero
* Ordinary pull-over = +1hr (detained)
* Passive obstacles (traffic, not player-initiated): flat +0.5hr if present — NYC with traffic obstacle = 2.5hr for a no-shenanigans racer
* GM's per-stage obstacle-presence roll (1d6 + tier, present on ≥6) is made **per tiered obstacle: traffic and police** (the only two tiered obstacles right now)
* Players never roll *against* traffic — it's just a penalty (vehicle actions/abilities may counteract it)
* Tier values confirmed: Light 1, Medium 2, Heavy 3

### Interrogation transcript — round 2 (operator verbatim)

> Players only roll if necessary for an action or reaction. If I'm in the sedan, it's sunny 74F, traffic's light, it's highway, no construction... I can just say "I cruise" and take my +2hr base stage time, no roll. Well, except...
>
> Every racer rolls for police every stage. The chances of getting pulled over can be low... but never zero!
>
> ordinary pull-over is +1hr.
>
> Passive obstacle like traffic (not direct result of player choice) just adds +.5hr, so NYC would take 2.5hr if you just sat thru the traffic and didn't pull shenanigans.
>
> the 1d6 obstacle roll per stage is per tiered obstacle - just traffic and police, right now.
>
> In NYC wi/ heavy traffic an dheavy police, you're not rolling against traffic directly - that's just a penalty. Maybe you have ana ction or ability to counteract traffic that you'd roll for, maybe not.
>
> Everyone always rolls for police. light 1, med 2, heavy 3, yes.

### Interrogation round 3 — rulings (design simplification)

* **No RNG in map obstacles** — the GM obstacle-presence roll is abolished. Stage conditions are pure thresholds; RNG comes only from players (and the actual weather)
* Police: the stage's police tier IS the threshold a racer's 1d6 must clear (Light 1 / Medium 2 / Heavy 3); player buffs/debuffs modify their roll against it. "Police presence is a passive long-arm scrutiny that you want to fly under." (Operator noted this supersedes the round-1 baseline-1/6 model)
* Traffic: also a pure threshold (magnitudes pending round 3b)

### Interrogation transcript — round 3 (operator verbatim)

> [On police-obstacle manifestation:] The GM police decision sets the baseline players must clear. Heavy police = 3 means players have to clear a 3. player buffs/debuffs may affect their 1d6 and have it clear or not clear that. Police presence is a passive long arm scrutiny that you want to fly under. this may contradict what I said earlier.
>
> Let's make traffic a pure threshold, too. No RNG in the map obstacles; the RNG is purely from the players (and the actual weather).

### Interrogation rounds 3b & 4 — rulings

* Traffic penalty is a **flat +0.5hr** — the question is sit through it vs. get around it. Tier = how hard it is to get around; success erases the penalty entirely ("doesn't matter how many cars are on the interstate if you're tearing thru a cornfield")
* Police consolidation: **unified** — ONE police roll per racer per stage; threshold = stage police tier; suspect actions stack debuffs onto it (operator selected this option explicitly)
* Threshold semantics: players must **BEAT** the threshold — ties lose (obstacle tier 1 vs. player roll of 1 = player loses; minimum risk is never zero because you can't roll a 0)
* Suspect actions raise the bar **above** the passive police level. Explicitly sequenced reactions (e.g. Double Down) are separate and as-written, ignoring the passive police level

### Interrogation transcript — rounds 3b & 4 (operator verbatim)

> [Traffic magnitude:] The traffic penalty is a flat 0.5hr - the question is whether you sit in traffic, or try to get around it. The heavier it is the HARDER it is to get around - but if you get around, you get around it -0 doesn't matter how many cars are on the interstate if you're tearing thru a cornfield!
>
> [Police consolidation: selected "Unified: ONE police roll per racer per stage — threshold = stage tier; speeding, Hooliganism, Lights & Sirens etc. just stack debuffs/buffs onto that roll (cards rewritten accordingly)"]
>
> In a tie vs an obstacle, the obstacle loses; players must BEAT a threshold. This means obstacle 1: player 1: is the player losing (because you can't roll 0).
>
> a note on rolls that cause police presence - the idea is that if you choose an action for your turn that makes you more suspect, you have to clear a higher bar than the passive police presence already was. some are obviously sequenced, like "double down" - those are separate and as-written, ignoring the passive police level.

*(Transcription note: the round-4 example "obstacle 1: player 1: is the player losing" is decisive — a tie goes to the obstacle; the opening clause "the obstacle loses" is read as a slip.)*

## 2026-06-11 - BUILD (L2) - COMPLETE (PASS)

* Work completed
    - Authored `skills/cannonball-rally/references/GAME.md`: title block, Core Procedure (Setup + stage Round with leader-first declarations), Resolution (deterministic map, strict-beat thresholds, unified police check, speeding, traffic get-arounds, additive stacking order, explicit no-bounds/ties/simultaneity), Scoring & End State (lowest hours, jail = DNF, ties stand), 8 Parameters, 6 Content Tables (Route, Obstacle Tiers, Weather, Vehicles, Vehicle Modifiers, Abilities), Stage Weather hook (*Forecast Offset* look-ahead, d6 fallback), Turn Report grammar, GM Guidance (magnitude heuristic: ambient ±0.5 / agency ±1)
    - Authored `skills/cannonball-rally/SKILL.md` (game-directory-as-skill wrapper; paper-playable today, engine activation later)
    - Updated `README.md` (status, layout, games table), `productContext.md` (Known Games row), `systemPatterns.md` (status note: format proven by first game)
    - All 8 documentary acceptance checks pass; structure mechanically verified (canonical H2 order, weather roll coverage 1–6, parameter prose references)
* Decisions made
    - Spec foldback (step 4): **no amendments required** — the format held against a real game with reactions, a stage choice, and a real-weather hook
    - Two self-caught gaps fixed mid-build: turn-report grammar grew `[ via <detour>]` (Detour choice was inexpressible); `Forecast Offset` promoted from buried hook prose to a parameter
    - 8 drafted-content flags recorded in `activeContext.md` for author sign-off (traffic Medium+ only, Cut Corners -1hr, tie order, weather fallback rows, Need for Speed reading, get-arounds roll vs. tier, time estimate, forecast tie-break)
* Insights
    - M1's "reactive actions break grammars" lesson fired exactly as predicted — but on a *choice* (the Detour), not a reaction; optionality of any kind is the grammar stressor
    - The unified police check (one roll, bar = tier + suspicion) replaced four divergent per-card police clauses — formalization didn't just record the design, it simplified it; the operator drove the simplification when the contradiction surfaced
    - Interrogation worked best with concrete worked examples ("walk me through one Sedan turn in NYC") and forced-choice questions — field notes for `author`'s interrogation mode (M10)

## 2026-06-11 - QA (L2) - COMPLETE (PASS)

* Work completed
    - Semantic review against the plan: KISS (unified police check is *simpler* than the source's four divergent clauses; no over-engineering), DRY (all rule values live once — parameters by name, tiers in one table; content-cell constants are rows, allowed), YAGNI (every parameter has a consumer; no speculative sections), Completeness (5/5 steps, all 8 acceptance checks, no stubs), Regression (kebab-case dir, uppercase well-known files, vendored dirs untouched), Integrity (one debris finding, fixed), Documentation (README + both persistent memory bank files updated alongside)
    - Spec validation checklist re-walked on the final document: all items pass
    - Wrote `.qa-validation-status`: PASS
* Decisions made
    - Trivial fix: LibreOffice lock file (`.~lock.*#`) had been committed — untracked and gitignored
    - Trivial fix: Vehicle Modifiers column relabeled `Modifier` → `Effect` — the column mixes signed numerics with textual effects ("Halved for you"), and the spec's sign rule binds columns *labeled* Modifier
    - The 8 drafted-content flags are design decisions for the author, not QA defects — explicitly carried to operator review (the build report surfaced them)
* Insights
    - The spec's sign-rule-by-column-label turned out to be a useful escape hatch: mixed modifier/effect columns are legal under a different label, no spec amendment needed

## 2026-06-11 - REFLECT (L2) - COMPLETE

* Work completed
    - Full lifecycle review written to `memory-bank/active/reflection/reflection-m2-cannonball-rally-game.md`
    - Persistent files reconciled — no updates needed beyond those already made in build step 5
* Decisions made
    - The 8 drafted-content flags remain open for author sign-off as content edits; they do not block the milestone (the document is complete and self-consistent with the drafted values)
* Insights
    - Optionality (the Detour choice), not just reactivity, is what breaks turn-report grammars — generalizes M1's lesson
    - Formalization improved the design rather than just recording it (deterministic map, unified police check) — expect the same from `author` (M10)
    - The threshold/suspicion/magnitude kernel looks like the seed of a reusable house system for future games

## 2026-06-11 - REWORK INITIATED

* Operator feedback (design review of the delivered GAME.md)
    - Amalgamated vehicle tables don't match the ODT's per-vehicle cards; a vehicle should read as a character sheet
    - Separate files per vehicle/stage considered and rejected by the operator: the one-file constraint is the creativity-breeding constraint of the format; authors maintain one document
    - Print formatting explicitly a non-concern; no assets work in this rework
    - Decision: card sections *within* GAME.md for collections (vehicles, stages, future obstacle sets); stage cards structured so route assembly is future-additive ("even 5 more stages = combinatorially many routes"); spec amendment required
* Rework scope appended to `projectbrief.md`; sub-run ephemeral state cleared for re-classification

## 2026-06-11 - COMPLEXITY-ANALYSIS (REWORK) - COMPLETE

* Work completed
    - Classified the M2 rework as Level 2 (Simple Enhancement)
* Decisions made
    - L2 rationale: spec amendment (card/collection convention) + one-document content restructure; architectural decisions already made by operator (one file wins; cards within GAME.md; stage cards carry a slot/band field; no assets work)
* Insights
    - The rework's riskiest seam is the spec's self-test discipline: a new convention needs a Lemonade Stand example, and section excerpts must stay verbatim substrings of Appendix A
