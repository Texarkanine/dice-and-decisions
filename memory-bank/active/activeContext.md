# Active Context

## Current Task: m5-player-skill
**Phase:** QA (L2) - COMPLETE (PASS) → REFLECT next

## What Was Done
- Authored the `player` skill (`SKILL.md` + `references/decision-procedure.md` +
  `references/personas.md`): consumes the gm's turn brief + state table + a persona, returns one
  Turn Report declaration + one line of table talk; two decision moments (declaration + post-roll
  reaction beat); never rolls; seat-visible info only; attribution/no-ventriloquism.
- Persona roster: five game-agnostic risk-axis postures (Tortoise, Daredevil, Optimizer, Closer,
  Spoiler) + voices + assignment modes.
- Documentation reconciliation: gm/player/table boundary + attribution test recorded in
  `systemPatterns.md`; README + cannonball-rally SKILL flipped to "player built"; gm Conduct
  tightened to "never authors a seat's declaration".
- **Codified the stateless decision** in `decision-procedure.md` ("You are stateless… invoked fresh
  every turn") — sets up M6's per-turn invocation expectation.
- **Reconciled `productContext.md`** with the operator's clarifications (below).
- `make test` green (15/15).

## Validation Sessions (build step 7) — operator-led, COMPLETE
- Three Composer-2.5 sessions: a 4-seat journal, a **1v1** (`transcripts/cannonball-1v1.md`,
  Daredevil supercar vs. human sedan), and a **2v1** (`transcripts/cannonball-2v1.md`, Daredevil
  supercar + Optimizer ambulance vs. human sedan).
- Confirmed at the behavior level: B1, B2, B4, B6 (Gun It opt-in framed as the seat's choice),
  B7, E2 (stage choice), B10 — and crucially **B5**: in the 2v1 the Daredevil (speed + hard line +
  Gun It gamble) and the Optimizer (cruise + Lights & Sirens EV play + easy route) **diverged**,
  attributable and in distinct voices.
- **B9 (attribution) is NOT provable by these runs and structurally can't be until M6**: with no
  `table` and no subagent, one model ran the GM *and* the AI seats inline (it even narrated the AI
  moves in GM parentheticals). Output was persona-true but not independently sourced. This is the
  accepted soft-isolation limitation; the real fix is M6's fresh-each-turn invocation.

## Key Decisions (operator, 2026-06-15)
- **Stay fully stateless for now; do not flesh out personality/memory.** AI players fill a seat,
  must be beatable, must not work to make play un-fun, need not be sapient — deep social play comes
  from the humans. (Memory reframe + Biker-Gang motivation + non-foreclosure recorded in
  `productContext.md` "Deliberately Out of Scope".)
- **Founding purpose is dual:** balance-testing exists *in service of play* (balance a game so it's
  worth playing; AI seats fill empty chairs for a full table). Recorded in `productContext.md`.
- Balance of the rally itself (the sedan's competitiveness) remains operator-owned, out of M5
  scope — an M7/playtest question, not a player-skill concern.

## Next Step
- Proceed to REFLECT (L2): capture lessons from M5 (stateless decision, soft- vs. structural
  isolation, journal-vs-transcript gap), confirm persistent-file reconciliation, then archive and
  advance the M5 milestone checkbox.
