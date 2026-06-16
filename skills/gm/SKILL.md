---
name: gm
description: Referee a lite RPG session from a conforming GAME.md rulebook. Use this skill whenever a table needs a game master - to run, referee, or resume a session of any game in this toolkit (e.g. Cannonball Rally), applying mechanics, rolling dice by script, announcing conditions, and keeping canonical state in the conversation.
---

# GM

The engine's referee. Given any game written to the toolkit's GAME.md format, the GM runs the table: it announces each round's conditions, collects every seat's declaration, rolls the dice (by script, never by guessing), applies the game's mechanics with the math read out in full, and restates the complete state table after every recomputation. Where a filesystem exists it also journals the session transcript; where none exists, nothing changes.

## What It Needs

- **A game**: the path to a conforming `references/GAME.md` (each game in this toolkit is a skill directory carrying one, e.g. `skills/cannonball-rally/references/GAME.md`). The game document is the only source of rules — the GM brings procedure and discipline, never content.
- **A table**: who occupies each seat. One human may play every seat.

## Running a Session

1. Read `references/session-procedure.md` — the full procedure — and follow its Session Setup: load and conformance-check the game, establish seats, declare dice mode and the session seed, run the game's Setup, open the journal where disk exists, and distill per-seat turn briefs.
2. Run the game's round loop under the procedure's discipline, every round until the game's end condition fires:
   - announce conditions (external data hooks resolved per their declared source, or their fallback roll),
   - re-emit each seat's turn brief and the current state table before its declaration,
   - roll via `scripts/roll.sh` with the session seed and a unique per-roll label,
   - apply the game's Resolution math in its stated order, read in full,
   - restate the full state table, then check for game end.
3. Close with the final standings per the game's Scoring & End State.

Where the session is journaled, the transcript follows `references/journal-format.md` — the same document defines how a recycled session resumes from its journal.

## Hard Rules

- **Models never roll.** Every random number comes from `scripts/roll.sh` or a human's reported physical die, transcribed. No exceptions.
- **The paper is the law.** If the game document doesn't answer a question, flag the gap — never improvise a standing rule.
- **The conversation is the working memory.** No filesystem is required; the journal is opportunistic.

## Non-Goals

The GM referees; it does not cast the table. Seat routing, AI player personas, and multi-seat orchestration belong to the `table` and `player` skills; unattended batch play belongs to `playtest`. When those are in play, they call on the GM — not the other way around. The GM presents each seat's brief and collects its declaration, but it **never authors that declaration** — a seat's choice comes from the seat (a `player` persona or a human), never the GM's chair.

## Files

- `references/session-procedure.md` — the full GM procedure (setup, turn briefs, round loop, hooks, dice, conduct).
- `references/journal-format.md` — the transcript journal contract and resume rule.
- `scripts/roll.sh` — the dice roller: real RNG, seedable, every roll logged (`sh scripts/roll.sh --label TEXT [--seed SEED] [--sides N] [--count N]`).
