# Product Context

A toolkit for playing, playtesting, and publishing **lite RPGs** — tabletop games that *feel* like RPGs but run entirely on decisions and dice. No improv, no voices, no rules-lawyering: players are presented with choices, they choose, the GM applies the mechanics. The toolkit lets AI agents fill any seat at the table — player, GM, or the whole table at once — without ever making the games *require* a computer. Every game remains printable and playable with paper, pencils, and a d6.

## Target Audience

1. **Lite RPG authors** (primary; the project owner is the first user). They need to formalize games that live in notebooks and heads, and to *balance* them with data instead of vibes. The founding question: does Cannonball Rally's 2hr base stage time sit in the sweet spot where risk-taking can beat "beige plays it safe" but doesn't dominate it?
2. **Solo players** who want a full table experience: one human seat, AI GM, AI co-players.
3. **Physical tables** that want AI to fill gaps: an AI GM for a table of humans, or AI players as extra seats under a human GM.
4. **Eventually: plugin consumers** — the repo ships as a plugin (Cursor and Claude) packaging the engine skills plus a library of games.

## Use Cases

- **Batch playtesting** (`playtest`): run N complete AI-only games unattended, varying seeds, personas, and *rule parameters* ("rerun the rally 50 times with base stage time at 1.5/2/2.5hr"); report win rates by character option, score distributions, ability fire rates and payoff, and whether "do nothing" beats risk-taking. Output is a human-readable balance report per batch.
- **Solo / playtest mode** (`table`): one (or zero) humans, N AI players, AI GM, round-robin turns. With zero humans this degenerates into a single playtest run.
- **Mixed table, AI GM**: humans at a physical table, one device, one human acting as **scribe**. AI GM announces conditions; humans declare and roll physically; the scribe types one terse **turn report** line per human (`Dana: speed yes, Lights&Sirens, rolled 4`); the GM applies mechanics and echoes the restated state table back for the table to error-check.
- **Mixed table, human GM**: the `table` skill runs players-only; the human GM types announced conditions, AI seats return declarations and script-rolled dice, and the human applies mechanics on paper.
- **Game authoring** (`author`): draft a new `GAME.md` from notes, validate one against the format, and interrogate it for unwritten rules (formalizing Cannonball Rally surfaced six rules that lived only in the author's head).

## Key Benefits

- **Paper-first parity.** A game is a document a human can print and run with zero computers. The same document, unmodified, is what AI players and GMs read. If the AI needs something the paper doesn't say, the paper is incomplete — fix the paper.
- **One source of truth, two audiences.** `GAME.md` is simultaneously the printable rulebook and the machine-readable spec.
- **Harness portability.** Skills-only construction means no servers, no custom tools — runnable anywhere skills install, including web harnesses with no repo checkout.
- **Balance from data.** Parameter sweeps and balance reports answer design questions that table-feel alone cannot.

## Success Criteria

- The `playtest` harness can answer "is 2hr base stage time right?" for Cannonball Rally with a defensible balance report.
- Every shipped game is playable with paper, pencil, and a d6 — no computer.
- The same unmodified `GAME.md` drives both the printed table and the AI session.
- Mixed-table scribe protocol stays under ~a dozen typed words per player per round; exceeding the budget means the game's turn report format is wrong (feedback for `author`).
- Single games run disk-free; sessions survive context compaction and sandbox recycling.

## Key Constraints

- **Skills-only portability.** Everything is an [agentskills.io](https://agentskills.io/specification)-compatible skill (directory with `SKILL.md` plus `references/`, `scripts/`, `assets/` loaded on demand). No servers, no custom tools, no harness-specific features in the core. Developed in Cursor, tested in Claude Code, runnable in principle anywhere skills install (including Claude.ai web).
- **Games are content, the engine is generic.** Engine skills know how to run *a* lite RPG; each game is data they consume. Adding a game means writing a document, not writing code.
- **Dice are rolled by script, never by the model.** LLMs are biased dice. Real RNG, seedable, every roll logged with context. Humans may roll physical dice and report results (declared at setup).
- **Disk-free baseline.** Only `playtest` may *require* a filesystem (declared via its skill `compatibility` field); everything else must run where disk is absent or flaky.
- **Hidden information is soft-isolated.** Baseline runs all seats in one agent context with information hygiene by instruction; acceptable because target games are nearly full-information (dice are the hidden information). Genuine subagent isolation is an enhancement, not a requirement.

## Known Games

| Game | Status | Notes |
| --- | --- | --- |
| Cannonball Rally | Formalized at `skills/cannonball-rally/references/GAME.md` (the format's first proof); `TTRPG - Cannonball Rally.odt` remains as historical input | Coast-to-coast outlaw racing, 2–6 players, d6; signature real-weather external data hook (stage weather = real forecast for the stage's reference city, each stage offset +2hr into the future for a fancy GM) with offline fallback table; win = lowest total hours once every racer has finished or been jailed. Formalization redesigned obstacles: the map is deterministic thresholds (no GM rolls); RNG comes only from player actions, the per-racer police check, and real weather |
| Carnival ticket-hustling game | Notebook only | Future `author` target |
| Caribbean sea-survival game | Drawings only | Future `author` target |

## Deliberately Out of Scope (for now)

Persona depth and provenance; spectator/log-viewer niceties; networked multi-device tables; non-d6 dice and cards as randomizers (the format should not preclude them, but nothing is built for them); localization; marketplace/distribution details beyond "it will be a plugin."
