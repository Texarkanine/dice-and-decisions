# System Patterns

> **Status note:** this file records the *designed* architecture (absorbed from the founding vision document, since deleted); reconcile each pattern against reality as engine code lands, and drop this note when the system exists. Real today: the repo layout; the GAME.md format (proven by its first game `skills/cannonball-rally/` — wrapper `SKILL.md` + `references/GAME.md`, the first game-directory-as-skill); the **dice roller** (`skills/gm/scripts/roll.sh` — see *Script-rolled dice*); and the **`gm` referee skill** (`skills/gm/` — `SKILL.md` + `references/session-procedure.md` + `references/journal-format.md`), validated against a golden transcript at `tests/fixtures/transcripts/cannonball-rally-golden.md`. With `gm` real, the *Restated state table* and *Turn brief* patterns below are implemented; the transcript **format** is specified (`journal-format.md`), but the *Disk is the journal* **behavior** is not yet reliably exercised — GMs keep the journal in chat, not on disk (deferred to a later milestone). Still pre-implementation: `player`, `table`, `playtest`, `author`.

## How This System Works

The system is a family of **agent skills** (agentskills.io format: `SKILL.md` + `references/`, `scripts/`, `assets/`) split into a generic **engine** and per-game **content**:

- **Engine skills**, each independently activatable:
  - `gm` — the referee. Reads a `GAME.md`, owns session state, announces conditions, presents choices, applies mechanics, narrates *briefly* (flavor in one sentence, math in full). Resolves external data hooks (e.g. weather lookup) when the harness has network; falls back to the game's declared offline table otherwise.
  - `player` — an AI player. Given rules, character, visible state, and a persona, returns one structured decision plus a line of table talk. Personas come from a small shipped roster (assigned, randomized, or custom); their purpose is coverage of the strategy space during playtests and color at human tables.
  - `table` — the orchestrator and the skill users actually invoke ("run Cannonball Rally with me and four AI players"). Sets up the session (game, seats, which are human, who GMs) and routes each decision to the right seat.
  - `playtest` — the batch harness. N unattended AI-only games with varied seeds, personas, and rule parameters; emits a balance report. The only skill allowed to *require* a filesystem.
  - `author` — the game writer's assistant: drafts `GAME.md` from notes, validates against the format, interrogates for unwritten rules.
- **Game content**: each game is a directory whose `references/GAME.md` the engine consumes. Build order is dependency-driven: format + Cannonball Rally first, then `gm`, then `player`+`table` (solo), then `playtest`, then mixed tables (deliberately last among the modes: their round-summary needs are best learned from dozens of solo sessions), then more games + plugin packaging.

The load-bearing assumption underneath everything: **the conversation, not the filesystem, is the working memory.** Violating that breaks portability to disk-free harnesses (Claude.ai web sandboxes can be recycled mid-conversation). The patterns below exist to protect it.

## GAME.md: one document, two audiences

`SKILL.md` is to agents what `GAME.md` is to tables. Each game's `GAME.md` is simultaneously the printable rulebook and the machine-readable spec — pure structured Markdown (no frontmatter, no hidden annotations) with an exact H2 section vocabulary defined by `skills/author/references/game-format.md`: title block (bold-label identity fields + pitch); core procedure (the turn loop as an explicit algorithm); resolution (randomizer, modifier stacking, ties, simultaneity); scoring & end state; parameters (named tunable scalars — the contract that makes `playtest` sweeps mechanical); content tables (GFM pipe tables that print cleanly *and* parse unambiguously) and card collections (one H4 card per structured instance — vehicles, stages — under a declared `**Card schema:**` line, the in-document "character sheet" mechanism; one file is the game, by design); optional external data hooks (declared real-world inputs, each with a roll-on-table offline fallback); turn report (per-game one-line declaration grammar); GM guidance. The spec carries its own validation checklist (the seed of `author`'s mechanical validation) and an assembled toy-game example that passes it. If an AI needs something the paper doesn't say, the paper is incomplete — fix the paper, never the engine.

## Repo layout: one `skills/`, repo root = plugin root

All deliverables — engine skills and game directories alike — live in a single top-level `skills/` directory, because games *are* skills (next pattern) and both target plugin ecosystems (Cursor, Claude Code) auto-discover a plugin's root-level `skills/`. The repo root therefore doubles as the future plugin root: packaging (M13) is a thin manifest wrapper with zero file moves. Naming: kebab-case skill directories (`cannonball-rally`); uppercase well-known files (`GAME.md`, `SKILL.md`); lowercase ordinary references (`game-format.md`). The format spec lives at `skills/author/references/game-format.md` — `author` is its runtime consumer; the directory is reference-only until `author`'s `SKILL.md` lands. (Decision record: `memory-bank/active/creative/creative-repo-layout.md`, archived with M1.)

## Game-directory-as-skill (the portability trick)

Each game directory is itself a valid skill: its `SKILL.md` frontmatter pitches the game; its body says "activate the engine skills against `references/GAME.md`"; `assets/` holds printables (character sheets, turn-report cards, score tracks). Installing the plugin therefore delivers engine and games through one mechanism, and game content arrives intact on harnesses with no repo checkout.

## Restated state table = canonical working memory

After every recomputation the GM re-emits the complete game state as one compact table **in the conversation itself**. This is not display sugar: it is the canonical state the next decision reads. Latest copy near the context tail → survives compaction; lives in chat → needs no filesystem. The same table doubles as what human players see (and, at mixed tables, the error-check the scribe reads aloud — disputes get corrected now, not three rounds later).

## Turn brief: every decision gets a fresh context tail

At setup the GM distills the game into a per-seat **turn brief** (decision procedure + relevant modifier tables). Each turn the orchestrator re-emits the acting seat's brief, so the context tail is always `turn brief + state table → one decision`. Rules don't dilute over long games; each turn is effectively stateless, which is exactly the shape needed to hand a turn to an isolated subagent where harnesses offer them. Full `GAME.md` is re-consulted only when a turn raises a question the brief can't answer (the brief is the token-budget version).

## Disk is the journal, not the memory

Where a filesystem exists, sessions append a transcript (every announcement, decision, roll, applied modifier) and snapshot state — enabling crash/resume, dispute audits, and the playtest dataset. But single games **must** run disk-free; only `playtest` declares a filesystem requirement (via skill `compatibility`), because a parameter sweep without recorded data is meaningless.

## Script-rolled dice

The engine bundles a tiny roller — real, implemented at `skills/gm/scripts/roll.sh` (owned by `gm`, its first consumer). Models never improvise randomness; humans at physical tables may roll and report instead, declared at setup and transcribed either way.

The roller's load-bearing design choice: **a roll is a pure deterministic function of `(seed, label, sides)`** — `face = (cksum("<seed>:<label>:<sides>") % sides) + 1`. The per-roll *label* is simultaneously the logged context **and** the reproducibility nonce, so an entire session replays from a single seed with **no on-disk state** (this is what lets reproducibility coexist with the disk-free baseline and the conversation-as-working-memory rule — labels must be unique per roll, by the GM's `<stage>-<actor>-<purpose>` naming). Unseeded runs draw a seed from `/dev/urandom` and report it for replay. The roller has *two* interfaces: stdout (the face value) and a stable stderr log line — `roll seed=<s> label=<l> die=d<n> => <r>` — which is a deliberate contract, the seed of `gm`'s transcript-journal record (M4). POSIX `sh`, shunit2-tested.

## Turn report: the human-sync protocol

Mixed tables sync humans to the AI GM via terse, structured one-liners per human action (`Dana: speed yes, Lights&Sirens, rolled 4`), defined per-game in `GAME.md` and printed on a reference card in `assets/`. Budget: under ~a dozen typed words per player per round; exceeding it is a defect in the game's turn report format, not in the scribe.

## Shared agent rules are synced, not hand-edited

`.cursor/rules/shared/`, `.cursor/skills/shared/`, and `.cursor/commands/shared/` are managed by `ai-rizz` from an external rules repo (see `ai-rizz.skbd`). Treat them as vendored: changes belong upstream, not here.
