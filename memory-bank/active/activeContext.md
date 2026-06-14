# Active Context

## Current Task: m4-gm-skill
**Phase:** BUILD (L3) - IN-PROGRESS (steps 1-5 of 7 complete; awaiting operator validation session)

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

## Validation Session (build step 6) — IN PROGRESS, operator-led

- **Run 1 (seed `haiku1`, Claude Code, Haiku 4.5):** complete. Racers seated Motorcycle,
  Ambulance, Sedan, Supercar (4 of 6 vehicles; 4x4 and SUV absent). Surfaced two mechanical
  defects, both fixed and committed (`fix: clarify police-roll timing and reaction-as-choice`):
  police checks now explicitly batch after all declarations; Reactions are explicitly the
  racer's choice (Haiku had auto-jailed a racer via an unchosen Double Down).
- Raw conversion of run 1 lives at `tests/fixtures/transcripts/cannonball-rally-haiku1-raw.md`
  (via `scripts/jsonl-to-md.py`); it is NOT the golden transcript.
- **Operator is now iterating:** balance tweaks (operator-owned, M2 content — see decisions)
  + further Haiku runs until one cleanly exercises all mechanisms. Operator will point here
  when a keeper run exists.

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

- Await operator's keeper run; convert + munge it into conforming
  `tests/fixtures/transcripts/cannonball-rally-golden.md` (validate against journal-format +
  behaviors B1–B11 and the edge-case list before crowning it golden).
- Then build step 7: README + systemPatterns + cannonball-rally SKILL.md wording; `make test`.
