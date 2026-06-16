# Task: Build the `player` skill

* Task ID: m5-player-skill
* Complexity: Level 2
* Type: Simple enhancement (new engine skill — prose deliverable)

Build the engine's **player-seat** skill: the strategic seat that, given a per-seat turn
brief + the current restated state table + an assigned persona, returns **exactly one
declaration** in the game's Turn Report grammar plus **one line of in-character table talk**.
It ships with a small, shallow **persona roster** (strategy-coverage archetypes, not deep
characters — "persona depth" is deliberately out of scope per `productContext.md`).

The `player` is the neutral GM's **strategic opposite**: its entire job is to *take a
position* — the one thing the referee constitutionally must not do. Its interface is already
pinned by upstream contracts (the M1 Turn Report grammar; the M4 gm-emitted turn brief +
state table), and the gm/player/table boundary architecture is already decided (Option B:
separate skills, structurally-isolated player decisions, `table` as composition root — see
the M4 creative record recovered from git `HEAD~1:memory-bank/active/creative/creative-gm-player-table-boundary.md`;
its durable contract is recorded into `systemPatterns.md` by this task's documentation step).
M5 builds only `player`; structural isolation plumbing and routing are M6's `table` job.

## Test Plan (TDD)

Per L4 cross-milestone invariant #8 and the M4 precedent: this deliverable is **prose**, so
there is no new executable code and therefore no new shunit2 tests. The "tests-first" analog
is the behavior checklist below, written before any document exists (the prose equivalent of
red tests); it is what the self-validation walkthrough and the recorded play session are both
audited against. `make test` (the existing shell suite) is the regression gate.

### Behaviors to Verify

- **B1 — Declaration shape**: seat brief + state table → exactly one line conforming to the
  brief's Turn Report template (no extra lines, no prose mixed into the line). The line parses
  against the game's Turn Report grammar.
- **B2 — Output budget**: the player's full output is the one declaration line **plus** exactly
  one line of in-character table talk — nothing else (no rules quoting, no math, no narration of
  other seats).
- **B3 — Seat-visible information only**: the decision is made from the brief + the shared state
  table only; the player never reads or references hidden information or another seat's
  undisclosed plan. Disclosed declarations earlier in the round (leader-declares-first) are fair
  input; the GM's chair and the hidden field are not.
- **B4 — Never rolls**: the player emits no die face. It declares intent/ability; the roll value
  is left to the GM (e.g. `police [pending]`). All randomness is the script's, never the model's.
- **B5 — Persona drives strategy (coverage)**: two different personas given the **same** brief +
  state produce declarations consistent with their postures (e.g. a risk-taker speeds / uses a
  suspect ability where the cautious "plays it safe" persona cruises). Distinct, attributable,
  strategy-diverse seats — the property `playtest` (M7) depends on.
- **B6 — Result-triggered reaction**: when the GM offers an *optional* reaction after a roll
  (e.g. "pulled over — use Double Down?"), the player answers (yes/no/which) per persona, does
  **not** preempt the offer at declaration time, does not roll, and treats a severe downside
  (jail) as still the seat's call — never automatic.
- **B7 — Legality / conform to brief**: the player's declaration only uses options the brief
  actually presents (cruise/speed, legal abilities, `via <stage>` only when the slot offers a
  choice). An out-of-option declaration is the failure mode the GM re-asks; the player conforms
  to the template and the brief's option set.
- **B8 — Defer to the paper**: if a decision needs something the brief doesn't carry, the player
  asks the GM rather than fabricating a rule or a number (the player-side mirror of the gm's
  "the paper is the law").
- **B9 — Attribution / no ventriloquism**: every declaration is attributable to its player seat
  as a distinct source; the player never authors another seat's declaration and never speaks in
  the GM's voice. (Harness-independent acceptance test foreshadowed by the golden's "no GM
  ventriloquism"; the central boundary the player+table split exists to protect.)
- **B10 — Genericity**: the `player` skill embeds **no** Cannonball-Rally-specific mechanics; it
  operates purely off the brief + Turn Report grammar any conforming `GAME.md` supplies (grep
  check, mirroring the gm's B11).

### Edge Cases

- **E1 — Indifferent / stalled persona**: when the persona expresses no preference for a
  decision, the player takes the game's safe default (the brief names one — cruise, no abilities).
- **E2 — Slot offers a stage choice**: when the brief presents a multi-stage slot, the
  declaration includes `via <stage>` naming the chosen stage.
- **E3 — Reaction with catastrophic downside**: a reaction whose failure is jail/DNF is still
  offered to the persona and decided by it; the skill must not auto-decline *or* auto-accept.

### Test Infrastructure

- Framework: **shunit2**, repo-level harness under `tests/sh/` (aggregate runner `tests/sh/run.sh`,
  invoked via `make test`). Golden/play transcripts live under `tests/fixtures/transcripts/`.
- Conventions: prose engine skills are validated by recorded play sessions audited against a
  behavior checklist (established by M4's gm skill), not by unit tests.
- New test files: **none** (no new executable code). The behavior checklist above is the spec;
  the build's validation session produces a transcript that may later seed M6/M7 fixtures.

## Implementation Plan

1. **Stub the deliverables (red).**
   - Files: `skills/player/SKILL.md`, `skills/player/references/decision-procedure.md`,
     `skills/player/references/personas.md`.
   - Changes: create each with its section headers and empty bodies; confirm the behavior
     checklist (above) is committed in `tasks.md` first. No content yet.
2. **Author the persona roster.**
   - Files: `skills/player/references/personas.md`.
   - Changes: a small roster (≈3–5) of **game-agnostic** strategy-coverage archetypes spanning
     the risk axis (cautious "plays it safe" ↔ all-gas risk-taker, plus a balanced middle and
     one or two flavored variants). Each persona = one-line strategic posture (expressed against
     choices any `GAME.md` exposes: aggressive vs. safe option, use risky/suspect abilities or
     not, when to gamble a reaction) + a one-line voice cue for table talk. Note assignment modes
     (assigned / randomized / custom). Keep it shallow by mandate. Satisfies B5, B10, E1.
3. **Author the decision procedure.**
   - Files: `skills/player/references/decision-procedure.md`.
   - Changes: how to turn brief + state + persona into output. Cover: read the brief's decision
     question, applicable effects, and Turn Report template; consult the state table for standing/
     relative position; apply the persona posture; emit exactly one conforming Turn Report line +
     one line of table talk (B1, B2). The **two decision moments** — (a) up-front declaration,
     (b) the GM's post-roll result-triggered reaction offer (B6). Information hygiene (B3),
     never-roll (B4), conform-to-brief/legality (B7), defer-to-paper (B8), no-ventriloquism/
     attribution (B9), and the edge-case rules (E1–E3).
4. **Author the SKILL.md router.**
   - Files: `skills/player/SKILL.md`.
   - Changes: agentskills frontmatter (`name: player`, activation `description`); lean body —
     role (the strategic seat), What It Needs (seat brief + visible state table + persona),
     output contract (one Turn Report line + one line of table talk), Hard Rules (never roll;
     decide from seat-visible info only; never author another seat's declaration or play GM;
     the paper/brief is the law), Non-Goals (refereeing, dice, routing/casting — those are gm
     and table), and Files pointers. **No `compatibility` field** (disk-free).
5. **Self-validation walkthrough (the prose red→green check).**
   - Spec cross-check: every element the gm's turn brief presents has a consuming player behavior;
     every Turn Report grammar slot is reachable from the procedure.
   - Genericity grep (B10): no rally mechanics/proper nouns in `skills/player/` beyond illustrative,
     clearly-marked pointers.
   - Desk-check B1–B10 + E1–E3 against the authored docs; dry-run one real golden-transcript brief
     (e.g. a Stage with a reaction trigger) through **two** personas to confirm divergent,
     conforming declarations (B5) and a correct reaction answer (B6) — using the brief's stated
     options only, no rolling.
6. **Documentation reconciliation.**
   - Files: `memory-bank/systemPatterns.md`, `README.md`, `skills/cannonball-rally/SKILL.md`,
     and a minimal wording fix in `skills/gm/SKILL.md` / `skills/gm/references/session-procedure.md`.
   - Changes: (a) record the durable gm/player/table boundary contract in `systemPatterns.md`
     (player I/O contract; "player takes a position, the referee may not"; the attribution
     acceptance test) — closing the gap left when the M4 creative doc was deleted on milestone
     advance; flip the systemPatterns status note to mark `player` real. (b) README layout tree +
     status line: `player` built. (c) `cannonball-rally/SKILL.md`: mark `player` available if it
     lists it as planned. (d) tighten the gm's neutral-referee Conduct/Non-Goals from "does not
     advise" to also **"does not author a seat's declaration"** (the creative doc's
     implementation note — a one-line boundary-wording fix, enforcing the no-ventriloquism rule
     from the gm side now that a real `player` exists). *Flagged as the only edit reaching into
     the gm skill; minimal and boundary-justified.*
7. **Validation session (operator-led, final build step).**
   - Run `player` filling seats of Cannonball Rally (alongside the gm), producing attributable
     declarations + table talk across distinct personas; audit the session against B1–B10 / E1–E3.
     Per M4 precedent this is the proving step for a prose engine skill; the resulting transcript
     may seed an M6/M7 fixture. Confirm `make test` green as the regression gate.

## Technology Validation

No new technology — validation not required. (Prose skill; no new dependencies, build tools, or
scripts; `roll.sh` belongs to the gm, and the player never rolls.)

## Dependencies

- **M1** (GAME.md format spec) — supplies the Turn Report grammar the player's declaration must
  conform to. Complete.
- **M4** (`gm` skill) — emits the per-seat turn brief + restated state table the player consumes,
  and the result-triggered reaction offer the player answers. Complete.
- The deleted M4 creative record (gm/player/table boundary) — recoverable at
  `git show HEAD~1:memory-bank/active/creative/creative-gm-player-table-boundary.md`; its
  decision is implemented here and its durable contract recorded into `systemPatterns.md`.

## Challenges & Mitigations

- **Boundary collapse / ventriloquism** (the central design risk): a model may drift toward the
  GM authoring seat declarations, silently destroying strategy coverage. Mitigation: explicit
  Hard Rule + the B9 attribution acceptance test in the checklist + the minimal gm-side wording
  fix (step 6d). Structural (subagent) isolation is M6's `table` responsibility — out of M5 scope.
- **Persona shallowness vs. coverage**: too-deep personas violate the out-of-scope mandate;
  too-flat ones give no strategy coverage. Mitigation: posture-on-the-risk-axis design, validated
  by B5 (two personas, same brief, divergent declarations).
- **Genericity leak**: rally specifics creeping into an engine skill. Mitigation: B10 grep check;
  postures authored in format-generic terms.
- **Re-level check**: this stays Level 2 — a single skill with a contained decision interface,
  decisions pre-made by the M4 creative doc, no architectural choices left open. If authoring
  surfaces an open architectural question, FAIL and re-level to L3.

## Status

- [x] Initialization complete
- [x] Test planning complete (TDD)
- [x] Implementation plan complete
- [x] Technology validation complete
- [x] Preflight (PASS, 1 advisory)
- [x] Build — all 7 steps complete; validation sessions (1v1 + 2v1) confirmed B1–B8, B10 and B5 (persona divergence); B9 (attribution) structurally deferred to M6 by design; stateless decision codified in the skill
- [x] QA — PASS; one trivial re-wrap applied; no substantive findings; B9 structural enforcement carried forward to M6
