# Project Brief

## User Story

As a lite RPG author, I want a skills-based toolkit where AI agents can fill any seat at the table (player, GM, or the whole table) so that I can playtest and balance my games at volume, play them solo, and eventually publish them — while every game remains printable and playable with paper, pencils, and a d6.

## Use-Case(s)

### Use-Case 1: Batch playtesting (the founding need)

Run N complete AI-only games unattended, sweeping seeds, personas, and rule parameters (e.g. "rerun the rally 50 times with base stage time at 1.5/2/2.5hr"), and produce a human-readable balance report — answering questions like "does 2hr base stage time let risk-taking beat 'beige plays it safe' without dominating it?"

### Use-Case 2: Solo play

One human + N AI players + AI GM, full loop, round-robin turns — the first moment the toolkit is *fun*.

### Use-Case 3: Mixed tables

Physical tables where AI fills gaps: AI GM synced via the scribe/turn-report protocol, or AI players returning declarations and script-rolled dice under a human GM.

### Use-Case 4: Game authoring

Draft a `GAME.md` from notes, validate it against the format, interrogate it for unwritten rules (the carnival and sea-survival games are waiting in notebooks).

## Requirements

Build in dependency order (per the original vision, now absorbed into the persistent memory bank):

1. **GAME.md format spec + Cannonball Rally formalized** — the format is consumed by everything else; the rally is its proving ground and forces the oral rules onto paper.
2. **`gm` skill** — mechanics applier, dice roller script, restated state table, turn briefs, transcript journal (where disk exists). Testable by a human playing all seats.
3. **`player` + `table` (solo mode)** — first full loop: author + N AI players.
4. **`playtest` batch harness** — AI-only tables at volume, parameter sweeps, balance reports.
5. **Mixed tables (`table` full mode)** — turn-report protocol, scribe flow, human-GM mode, printable reference cards.
6. **More games + plugin packaging** — `author` skill matures drafting the carnival and sea-survival games; plugin manifests (thin wrapper, deliberately last).

## Constraints

1. **Paper-first parity** — the same unmodified `GAME.md` serves print and AI; if the AI needs something the paper doesn't say, fix the paper.
2. **Skills-only portability** — agentskills.io-compatible skills; no servers, custom tools, or harness-specific core features. Developed in Cursor, validated in Claude Code.
3. **Engine is generic, games are content** — adding a game means writing a document, not code.
4. **Dice rolled by script, never by the model** — real RNG, seedable, every roll logged.
5. **Disk-free baseline** — only `playtest` may require a filesystem (declared via skill `compatibility`).
6. **VISION.md is seed material** — its content lives in the memory bank; the file is deleted once the work it seeds is underway.

## Acceptance Criteria

1. Cannonball Rally exists as a complete, valid `GAME.md` that a human can print and run with zero computers, with no rules left in the author's head.
2. A solo session ("run Cannonball Rally with me and four AI players") runs end-to-end: AI GM, AI players with personas, script-rolled dice, restated state table after every recomputation.
3. `playtest` produces a balance report across a rule-parameter sweep, sufficient to answer the 2hr base-stage-time question with data.
4. Mixed-table play works with the scribe protocol staying under ~a dozen typed words per player per round.
5. The repo packages as a plugin delivering engine skills plus the game library through one mechanism.
