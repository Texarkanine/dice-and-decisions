# Progress

L4 sub-run for milestone M4 of `lite-rpg-toolkit`: build the `gm` skill — the engine's game-master role. Components: mechanics applier (applies GAME.md rules to declared actions), restated state table, turn-brief distillation, external-data hook resolution with offline fallback, and a transcript journal where disk exists (declared via skill `compatibility`). Validated by a human playing all seats of Cannonball Rally, with that session recorded as a golden transcript fixture for later milestones. Depends on M1 (GAME.md format spec), M2 (Cannonball Rally GAME.md), and M3 (`roll.sh`), all complete; M4 is itself a dependency of M6 (table skill).

**Complexity:** Level 3

## 2026-06-12 - COMPLEXITY-ANALYSIS - COMPLETE

* Work completed
    - Advanced L4 milestone list: M3 checked off, sub-run ephemeral state cleared and committed
    - Classified milestone M4 as Level 3 (Intermediate Feature)
* Decisions made
    - L3 rationale: complete feature with several coupled components (mechanics applier, state table, turn-brief distillation, hook resolution, transcript journal) plus a human-validated golden transcript; works within the established engine architecture, so no architectural implications warranting L4
* Insights
    - M4 is the first consumer of all three prior milestones: it reads GAME.md per the M1 spec, runs Cannonball Rally from M2, and rolls via M3's `roll.sh` — its build doubles as integration validation of those contracts
    - The golden transcript fixture produced here is itself a contract: later milestones (playtest harness, table modes) will consume it, so its format deserves deliberate design during planning
    - The roller's stderr log grammar was pinned in M3 explicitly as "the seed of M4's transcript-journal record" — the journal design should start from that grammar

## 2026-06-12 - CREATIVE (transcript journal format) - COMPLETE

* Work completed
    - Architecture exploration of the transcript journal / golden transcript format (the gm→M7 contract); decision documented in `memory-bank/active/creative/creative-transcript-journal-format.md`
* Decisions made
    - **Structured Markdown transcript** (one file per session, append-only): H1 session header (game, date, seed, dice mode, seats); one H2 per round containing announcement, declarations (game's Turn Report grammar), rolls (verbatim `roll.sh` log lines; `seed=physical` for human-reported dice), per-seat resolution arithmetic, and the restated GFM state table; final `## Standings`
    - Resume rule: last complete round's state table is the resume point; incomplete trailing round replays from its announcement (rolls reproduce from the seed)
    - Journal location at runtime: `transcripts/` under the working directory, only where disk exists; golden fixture in-repo at `tests/fixtures/transcripts/cannonball-rally-golden.md`
* Insights
    - The journal needs no new machine format: declarations, rolls, and state already have pinned grammars (Turn Report template, roll.sh stderr line, GFM tables) — the skeleton just anchors them in a file. "One transcript, two audiences" is the same move GAME.md proved
    - A structured event log was rejected on principle: two formats for one fact is the drift disease the GAME.md pattern exists to cure
