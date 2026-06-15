# Transcript Journal Format

The session transcript contract: what the GM writes where disk exists, and what later consumers — a resuming GM, a human auditing a dispute, and batch-playtest extraction — may rely on. The journal is a **tee of the conversation**, not a second bookkeeping system: every machine-critical record in it reuses a grammar the GM already emits in chat (the game's Turn Report lines, `roll.sh`'s log lines, GFM state tables). One transcript, two audiences.

## When a Journal Exists

The journal is strictly opportunistic:

- **Where a writable filesystem exists**, the GM appends to the journal as it plays — after the session header, then after each part of each round as it is spoken.
- **Where no filesystem exists, nothing changes.** The conversation is the working memory; the restated state table in chat is canonical state. The journal mirrors the conversation and never substitutes for it. A session must run identically with or without one.

Never treat a failed write as a game event: note it once and play on.

## File Naming & Location

- One file per session: `transcripts/<game>-<YYYYMMDD-HHmmss>.md`, where `<game>` is the game's skill-directory name (kebab-case) and the timestamp is the session start.
- The `transcripts/` directory lives under the **working directory** of the session — never inside an installed skill.
- The file is **append-only**. Corrections are appended as new statements (like a paper scorekeeper crossing out a line), never edited in place; the latest state table wins.

Curated copies kept as test fixtures may carry stable names instead (e.g. `tests/fixtures/transcripts/cannonball-rally-golden.md`); the session header inside still carries the date.

## Session Header

The file opens with one H1 naming the game, then bold-label fields, one per line:

- `**Date:**` — session start, `YYYY-MM-DD HH:mm` local to the table.
- `**Seed:**` — the session seed, or `physical` when the table rolls real dice.
- `**Dice:**` — `script` or `physical`.
- `**Seats:**` — one line per seat (as a list): name, role, vehicle/character where the game has one, persona if any.

Additional bold-label fields are allowed (consumers treat unrecognized fields as advisory).

## Rounds

One H2 per round: `## Round <n>: <name>` — `<n>` counts from 1; `<name>` is the round's in-fiction identity where the game has one (the stage name, the day), else omitted along with the colon. Each round contains these parts, **in this order**, each opening with its bold label (`**Announcement.**`, `**Declarations.**`, `**Rolls.**`, `**Resolution.**`, `**State.**`) so consumers can anchor on them:

1. **Announcement** — the GM's announced conditions: bounded prose plus every announced value the game's round procedure requires, numbers in full. If an external data hook resolved this round, the announcement states which path (source or fallback) and the ruling.
2. **Declarations** — one line per seat, in the game's `## Turn Report` grammar, attributed. These lines are a parse anchor: they must conform to the game's template exactly.
3. **Rolls** — the roller's log lines, verbatim, one per die, inside one fenced code block (which keeps each line a line when the Markdown renders):

   `roll seed=<seed> label=<label> die=d<sides> => <face>`

   In physical mode, human-reported faces are transcribed in the same line shape with `seed=physical`. Every random number in the session must trace to a line in some round's Rolls part.
4. **Resolution** — per seat, the modifier arithmetic read out in full, in the game's stated Resolution order, ending in that seat's outcome for the round.
5. **State** — the restated state table (GFM), exactly as emitted in conversation.

Parts with nothing to record state so briefly (e.g. `No rolls this round.`) rather than disappearing — silence is indistinguishable from a truncated file.

## Standings

The final H2 is `## Standings`: the end-state read-out per the game's `## Scoring & End State` — final scores in rank order, with whatever terminal notations the game defines (e.g. Did Not Finish).

## Resume Rule

A recycled or crashed session resumes from the journal alone:

- The **resume point** is the last complete round's State table — that table is the canonical game state.
- An incomplete trailing round (any of its five parts missing) is **replayed from its Announcement**. In script mode the rolls reproduce exactly: every roll is a pure function of `(seed, label, sides)`, so re-rolling the same labels yields the same faces.

## Worked Example

One round of **Lemonade Stand** (the format spec's illustration game, two players, script dice). The roll lines are real `roll.sh` output for seed `1209` — replay them yourself.

````markdown
# Lemonade Stand

**Date:** 2026-06-12 10:05
**Seed:** 1209
**Dice:** script
**Seats:**
- Ana — player, Perk: Megaphone (held)
- Ben — player, Perk: Megaphone (held)
- GM — referee (AI)

## Round 1: Day 1

**Announcement.** No network at the table, so the *Tomorrow's Forecast*
fallback rolls on the Weather table: a 4 — a Sunny day, +1 to every
customer roll today.

**Declarations.**

- `Ana: Park, regular, rolled 6`
- `Ben: Beach, premium, Megaphone, rolled 3`

**Rolls.**

```
roll seed=1209 label=day1-gm-weather die=d6 => 4
roll seed=1209 label=day1-ana-customers die=d6 => 6
roll seed=1209 label=day1-ben-customers die=d6 => 3
```

**Resolution.**

- Ana: roll 6, weather +1 (Sunny), location +1 (Park), price 0 (regular)
  = 8 customers served. Earnings 8 × $1 = $8.
- Ben: roll 3 + 2 (Megaphone) = 5, weather +1 (Sunny), location +2
  (Beach on a Sunny day), price -2 (premium) = 6 customers served.
  Earnings 6 × $2 = $12. Megaphone spent.

**State.**

| Player | Money | Customers | Perk |
| --- | --- | --- | --- |
| Ben | $12 | 6 | Megaphone (spent) |
| Ana | $8 | 8 | Megaphone (held) |

Days remaining: 4.
````

(The session would continue with `## Round 2: Day 2` … and close with `## Standings`.)
