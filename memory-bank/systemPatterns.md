# System Patterns

> **Status note:** the codebase is pre-implementation. This file records the *designed* architecture (absorbed from the founding vision document, since deleted). As code lands, reconcile each pattern against reality and drop this note when the system exists.

## How This System Works

The system is a family of **agent skills** (agentskills.io format: `SKILL.md` + `references/`, `scripts/`, `assets/`) split into a generic **engine** and per-game **content**:

- **Engine skills**, each independently activatable:
  - `gm` — the referee. Reads a `GAME.md`, owns session state, announces conditions, presents choices, applies mechanics, narrates *briefly* (flavor in one sentence, math in full). Resolves external data hooks (e.g. weather lookup) when the harness has network; falls back to the game's declared offline table otherwise.
  - `player` — an AI player. Given rules, character, visible state, and a persona, returns one structured decision plus a line of table talk. Personas come from a small shipped roster (assigned, randomized, or custom).
  - `table` — the orchestrator and the skill users actually invoke ("run Cannonball Rally with me and four AI players"). Sets up the session (game, seats, which are human, who GMs) and routes each decision to the right seat.
  - `playtest` — the batch harness. N unattended AI-only games with varied seeds, personas, and rule parameters; emits a balance report. The only skill allowed to *require* a filesystem.
  - `author` — the game writer's assistant: drafts `GAME.md` from notes, validates against the format, interrogates for unwritten rules.
- **Game content**: each game is a directory whose `references/GAME.md` the engine consumes. Build order is dependency-driven: format + Cannonball Rally first, then `gm`, then `player`+`table` (solo), then `playtest`, then mixed tables, then more games + plugin packaging.

The load-bearing assumption underneath everything: **the conversation, not the filesystem, is the working memory.** Violating that breaks portability to disk-free harnesses (Claude.ai web sandboxes can be recycled mid-conversation). The patterns below exist to protect it.

## GAME.md: one document, two audiences

`SKILL.md` is to agents what `GAME.md` is to tables. Each game's `GAME.md` is simultaneously the printable rulebook and the machine-readable spec — a structured Markdown document with required sections defined by the format reference in the engine: identity & flavor; core procedure (the turn loop as an explicit algorithm); resolution (dice, modifier stacking, ties); scoring & end state; content tables (print cleanly *and* parse unambiguously); optional external data hooks (declared real-world inputs, each with an offline fallback); GM guidance. If an AI needs something the paper doesn't say, the paper is incomplete — fix the paper, never the engine.

## Game-directory-as-skill (the portability trick)

Each game directory is itself a valid skill: its `SKILL.md` frontmatter pitches the game; its body says "activate the engine skills against `references/GAME.md`"; `assets/` holds printables (character sheets, turn-report cards, score tracks). Installing the plugin therefore delivers engine and games through one mechanism, and game content arrives intact on harnesses with no repo checkout.

## Restated state table = canonical working memory

After every recomputation the GM re-emits the complete game state as one compact table **in the conversation itself**. This is not display sugar: it is the canonical state the next decision reads. Latest copy near the context tail → survives compaction; lives in chat → needs no filesystem. The same table doubles as what human players see (and, at mixed tables, the error-check the scribe reads aloud — disputes get corrected now, not three rounds later).

## Turn brief: every decision gets a fresh context tail

At setup the GM distills the game into a per-seat **turn brief** (decision procedure + relevant modifier tables). Each turn the orchestrator re-emits the acting seat's brief, so the context tail is always `turn brief + state table → one decision`. Rules don't dilute over long games; each turn is effectively stateless, which is exactly the shape needed to hand a turn to an isolated subagent where harnesses offer them. Full `GAME.md` is re-consulted only when a turn raises a question the brief can't answer (the brief is the token-budget version).

## Disk is the journal, not the memory

Where a filesystem exists, sessions append a transcript (every announcement, decision, roll, applied modifier) and snapshot state — enabling crash/resume, dispute audits, and the playtest dataset. But single games **must** run disk-free; only `playtest` declares a filesystem requirement (via skill `compatibility`), because a parameter sweep without recorded data is meaningless.

## Script-rolled dice

The engine bundles a tiny roller in `scripts/` using real RNG: seedable (reproducible playtest batches), every roll logged with context. Models never improvise randomness. Humans at physical tables may roll and report instead — declared at setup, transcribed either way.

## Turn report: the human-sync protocol

Mixed tables sync humans to the AI GM via terse, structured one-liners per human action (`Dana: speed yes, Lights&Sirens, rolled 4`), defined per-game in `GAME.md` and printed on a reference card in `assets/`. Budget: under ~a dozen typed words per player per round; exceeding it is a defect in the game's turn report format, not in the scribe.

## Shared agent rules are synced, not hand-edited

`.cursor/rules/shared/`, `.cursor/skills/shared/`, and `.cursor/commands/shared/` are managed by `ai-rizz` from an external rules repo (see `ai-rizz.skbd`). Treat them as vendored: changes belong upstream, not here.
