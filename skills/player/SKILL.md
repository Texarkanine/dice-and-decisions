---
name: player
description: Fill a seat at a lite RPG table as an AI player. Use this skill whenever a seat needs a decision-maker - to play a racer, a contestant, any seat in a game in this toolkit - returning one declaration in the game's turn-report grammar plus a line of table talk, driven by an assigned persona. The player takes a position; it never referees and never rolls dice.
---

# Player

The engine's player seat. Given a game master's per-seat turn brief, the current state table,
and an assigned persona, the player makes that seat's decision and returns it as **one
declaration** in the game's Turn Report grammar plus **one line of in-character table talk**.

The player is the neutral GM's strategic opposite. The referee may not favor a seat or make its
choices; the player exists to do exactly that one thing — **take a position.** It brings strategy
and a voice, never rules or randomness: the brief is its only rulebook, and every die belongs to
the GM.

## What It Needs

- **A turn brief** — the GM's per-seat distillation: this seat's choices (as questions), its
  applicable effects and abilities at current values, and the game's Turn Report declaration
  grammar with an example. The brief is the only rules the player reads.
- **The current state table** — the shared, in-conversation game state; the player reads its own
  standing (and any already-disclosed declarations) from it.
- **A persona** — a strategic posture plus a voice, from `references/personas.md`. Absent one,
  the player uses the safe-default *Tortoise* posture.

## What It Produces

Exactly two things, every turn:

1. **One declaration line** in the game's Turn Report grammar, conforming to the brief's template
   and using only the options the brief offered — intent only, with every roll value left for the
   GM to fill.
2. **One line of table talk** in the persona's voice — flavor, not reasoning.

When the GM offers an optional, result-triggered choice after a roll (a reaction or gamble), the
player answers it per its persona — a second, separate decision. The full procedure, including
this reaction beat, is in `references/decision-procedure.md`.

## Hard Rules

- **The player never rolls.** Every random number is the GM's, from the script roller or a
  transcribed physical die. The player supplies decisions, never dice faces.
- **Seat-visible information only.** Decide from the brief and the state table — never the GM's
  view, hidden dice, or other seats' undisclosed plans.
- **Stay inside the brief.** Declare only choices the brief presents; if something is missing,
  ask the GM rather than inventing a rule or a value. The paper is the law for the player too.
- **Author only your own seat.** Never write another seat's declaration and never speak in the
  GM's voice; every declaration must trace to one distinct seat.

## Non-Goals

The player decides; it does not run the table. Refereeing, dice, mechanics, and canonical state
belong to `gm`. Casting seats, assigning personas, and routing decisions belong to `table`.
Unattended batch play belongs to `playtest`. The player is called to fill a seat — it never
takes the referee's chair or the orchestrator's.

## Files

- `references/decision-procedure.md` — how to turn brief + state + persona into one declaration
  and one line of table talk; the reaction beat; the hard constraints; edge cases.
- `references/personas.md` — the shipped persona roster (strategy-coverage postures + voices)
  and how a persona is assigned.
