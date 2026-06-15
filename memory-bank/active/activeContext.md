# Active Context

## Current Task: m4-gm-skill
**Phase:** BUILD (L3) - IN-PROGRESS (steps 1-6 of 7 complete; golden transcript accepted; step 7 next)

## What Was Done

- Steps 1-5 of the implementation plan: stubbed then authored the three gm documents —
  `skills/gm/references/journal-format.md` (transcript contract: opportunistic journal,
  `transcripts/<game>-<YYYYMMDD-HHmmss>.md`, H1 header + bold-label fields, five ordered
  bold-labeled parts per `## Round <n>` H2, final `## Standings`, resume rule, worked
  Lemonade Stand example with real seed-1209 roll.sh output), `skills/gm/references/
  session-procedure.md` (setup incl. conformance check + seed declaration, turn-brief
  distillation/re-emission/re-consult rules, round loop, hook resolution, dice discipline
  with label grammar `<stage>-<actor>-<purpose>`, conduct), `skills/gm/SKILL.md` (lean
  router: role, needs, session summary, hard rules, non-goals, file pointers; no
  `compatibility` field)
- Step 5 self-validation: spec cross-check (every required GAME.md section has a consuming
  gm behavior), Lemonade Stand genericity round (B11 — grep shows only illustrative
  pointers, no rally content), edge-case desk-check (all 8 trace to procedure rules)
- Defects found & fixed in step 5: journal example's weather label violated the label
  grammar (now `day1-gm-weather`, faces recomputed from real rolls); missing
  randomizer→`--sides` link added to the Dice section

## Key Decisions

- Journal parts open with bold labels (`**Announcement.**` … `**State.**`) as parse anchors;
  roll lines sit in a fenced code block so each line survives Markdown rendering
- Setup choices (vehicle/character/persona/perk) live in the header's `**Seats:**` field, so
  resume-from-journal can reconstruct initial state without replaying setup
- Session seed: operator-supplied, else drawn via one unseeded roller call (adopt the
  reported seed, discard the face)

## Validation Session (build step 6) — COMPLETE, operator-led

- **Iterated across 8 runs** (seeds `haiku1`–`haiku7` on Claude Haiku 4.5, then `sonnet1` on
  Sonnet 4.6). Each Haiku run surfaced a defect; every fix landed as a committed gm-doc or
  GAME.md change. The arc, in order:
  - Reaction-as-choice (Haiku auto-applied Double Down / Blend In) → procedure step "Offer
    result-triggered choices" + GAME.md reaction wording.
  - Police-modifier misrouting (applied to the DC) → `save`/`bar`/`beat` vocabulary, modifiers
    one-sided onto the player's save (`57b36a3`).
  - Field-keyed misses (Biker Gang per-rider rolls, Somethin's Up) + consequence-revoked
    benefits (Suspect ability negated on pull-over) → the "Apply mechanics" cross-check beat
    (`5f78efb`) + GAME.md fixes (`411f510`).
  - Light-traffic penalty misapplied → GAME.md "Medium or Heavy" clarity fix.
  - Output-format drift / brief decay → turn-brief shape pinned, scoreboard de-duped,
    dice-batching guidance (`2831ea1`).
  - Fabricated "Gun It cooldown" (model invented scarcity the paper didn't write) → format-spec
    **Usage cadence** default: silence means no usage limit (`9695a2c`).
- Raw playtest conversions retained at `tests/fixtures/transcripts/cannonball-rally-haiku{1-7}-raw.md`
  (+ `haiku-bs`) via `scripts/jsonl-to-md.py`. These are NOT the golden.
- **Golden accepted (`sonnet1`):** `tests/fixtures/transcripts/cannonball-rally-golden.md`.
  Seats **all 6 vehicles** (Alex/Ambulance, Blake/Motorcycle, Casey/4x4, Drew/SUV,
  Ellis/Supercar, Frankie/Sedan), 48 real player turns (no GM ventriloquism), and exercises
  every committed fix correctly — incl. the subtle Suspect-vs-non-Suspect revoke and a
  tied-finish tiebreaker. Coverage spread: a reaction-saved pull-over, a jail/DNF (Blake's
  Double Down), a top tie. Accepted **as-is, provisionally** ("for now").

## Known Defect (deferred) — disk journaling never happens

- The `sonnet1` GM wrote only the journal **header** to `transcripts/…140000.md`, then ran the
  whole session in chat and falsely signed off "Session log saved". **No GM run has ever
  journaled rounds to disk** — the chat is treated as the journal. Behavior **B9** (journal
  follows the journal-format skeleton on disk where disk exists) is therefore unverified by the
  golden. Procedure enforcement of this is weak.
- **Deferred to a later milestone** (operator decision, 2026-06-15) — out of M4 scope; create a
  new milestone if needed. The golden stands as-is; the record of play is complete in chat form.

## Golden Transcript Acceptance (operator decision, 2026-06-14)

- The golden transcript must seat **every vehicle currently in the rally** — all 6: Ambulance,
  Motorcycle, 4x4, SUV, 2-door Supercar, 4-door Sedan. That implies a **6-racer** session
  (one per vehicle) for full vehicle coverage.
- Reaction-gated mechanisms (Gun It, Blend In, Double Down) only fire on a pull-over, so full
  *mechanism* coverage is dice-dependent — may need seed selection or be spread across the run.
- **Balance is operator-owned and out of M4 scope.** The gm/journal work is validated against
  procedure correctness, not rally balance. Balance tweaks (Route 66 police tier, desert base
  time, Lights & Sirens, sedan dominance, the Detour) are deferred to a separate M2 rally pass;
  the operator's uncommitted GAME.md/ODT edits belong to that effort, not this commit stream.

## Next Step

- Build step 7: README + systemPatterns + cannonball-rally SKILL.md wording; `make test`.
