# VISION

A toolkit for playing, playtesting, and publishing **lite RPGs** — tabletop games that *feel* like RPGs but run entirely on decisions and dice. No improv, no voices, no rules-lawyering: players are presented with choices, they choose, the GM applies the mechanics. Cannonball Rally is the first of these; a carnival ticket-hustling game and a Caribbean sea-survival game are waiting in notebooks.

The toolkit lets AI agents fill any seat at the table — player, GM, or the whole table at once — without ever making the games *require* a computer. Every game remains printable and playable with paper, pencils, and a d6.

## Design pillars

1. **Paper-first parity.** A game is a document a human can print and run with zero computers. The same document, unmodified, is what AI players and GMs read. If the AI needs something the paper doesn't say, the paper is incomplete — fix the paper. (This was proven immediately: formalizing Cannonball Rally surfaced six unwritten rules — base stage time, the speeding option, weather resolution, what counts as an obstacle, the die, and the win condition — that lived only in the author's head.)

2. **Skills-only portability.** Everything is built as [agentskills.io](https://agentskills.io/specification)-compatible skills: a directory with a `SKILL.md`, plus `references/`, `scripts/`, and `assets/` loaded on demand. No servers, no custom tools, no harness-specific features in the core. Developed in Cursor, tested in Claude Code, and in principle runnable anywhere skills install — including Claude.ai on the web. This repo eventually ships as a plugin (for Cursor and for Claude) that packages the engine skills *plus* a library of games.

3. **Games are content, the engine is generic.** The engine skills know how to run *a* lite RPG; each game is data they consume. Adding a game means writing a document, not writing code.

4. **Playtesting is a first-class purpose, not a byproduct.** The original motivation is balance: e.g., does Cannonball Rally's 2hr base stage time sit in the sweet spot where risk-taking can beat "beige plays it safe" but doesn't dominate it? The engine must be able to answer that by allowing game authors to playtest their own games and feel the UX.

## The GAME.md format

`SKILL.md` is to agents what `GAME.md` is to tables.

Each game is a directory containing a `GAME.md`: a structured Markdown document that is simultaneously the printable rulebook and the machine-readable spec. One source of truth, two audiences. The format documentation (a reference in the engine) defines required sections:

- **Identity & flavor** — name, pitch, player count, table time.
- **Core procedure** — the turn/round loop, written as an explicit algorithm. ("Each stage: 1. GM announces conditions. 2. Each player declares speeding yes/no and any ability. 3. Resolve rolls. 4. Apply hours. 5. Advance.")
- **Resolution** — dice used, how modifiers stack, tie-breaking.
- **Scoring & end state** — how the game ends, who wins.
- **Content tables** — stages/locations/events, character options (vehicles, carnival games, survival gear...), abilities, in a tabular format that prints cleanly and parses unambiguously.
- **External data hooks** *(optional)* — declared inputs from the real world, with an offline fallback. Cannonball Rally's signature example: stage weather is the *real forecast* for the stage's reference city (each stage offset +2hr into the future, for a fancy GM), so the rally plays differently in January than July. The fallback is a roll-on-this-table weather chart for paper tables and offline agents.
- **GM guidance** — judgment calls, pacing, what to do when rules collide.

Each game directory is *itself a valid skill*: its `SKILL.md` frontmatter describes the game ("a coast-to-coast outlaw racing game for 2–6 players...") and its body says, essentially, "to run this game, activate the engine skills against `references/GAME.md`." This is the portability trick: installing the plugin delivers games and engine through one mechanism, and on harnesses with no repo checkout (Claude.ai), the game content still arrives intact. The `assets/` directory holds printables — character sheets, turn-report cards, score tracks.

## The engine skills

A small family of skills, each independently activatable:

- **`gm`** — the referee. Reads a `GAME.md`, owns the session state, announces conditions, presents choices, applies mechanics, narrates outcomes *briefly* (this is a dice game wearing an RPG's jacket — flavor in one sentence, math in full). Resolves external data hooks (weather lookup) when the harness has network access; falls back to the declared offline table otherwise.

- **`player`** — an AI player. Given the game rules, its character, the visible state, and a persona, it makes one decision at a time and returns it in a structured form plus a line of table talk. Personas (the cautious one, the gambler, the spiteful one who plays to make *you* lose) come from a small shipped roster and can be assigned, randomized, or custom-written; their purpose is coverage of the strategy space during playtests and color at human tables. The details of persona authorship are deliberately unspecified here.

- **`table`** — the orchestrator. Sets up a session (which game, how many seats, which seats are human, who GMs), then runs the loop, routing each decision to the right seat. This is the skill a user actually invokes: "run Cannonball Rally with me and four AI players."

- **`playtest`** — the batch harness. Runs N complete games unattended with AI-only tables, varying seeds, personas, and (crucially) *rule parameters* ("rerun the rally 50 times with base stage time at 1.5/2/2.5hr"), then reports: win rates by character option, score distributions, how often each ability fired and whether it paid off, whether "do nothing" beats risk-taking. Output is a human-readable balance report per batch.

- **`author`** — the game writer's assistant. Helps draft a new `GAME.md` from notes (the carnival game exists only on paper; the sea-survival game only in drawings), validates an existing one against the format, and — most valuably — interrogates it for unwritten rules the way Cannonball Rally had to be interrogated.

### State, dice, and trust

- **The restated state table is the working memory.** After every recomputation, the GM re-emits the complete current game state as one compact table *in the conversation itself*. This is not display sugar — it is the canonical state the next decision reads. Because the latest copy always sits near the context tail, it survives context compaction; because it's in the chat, it needs no filesystem, so the engine runs on harnesses where disk is absent or flaky (Claude.ai web sandboxes can be recycled mid-conversation — and a physical table's long pauses between turns invite exactly that). The same table is what humans at the table are shown: one artifact serves model and players alike.
- **Disk is the journal, not the memory.** Where a filesystem exists, sessions also append to a transcript (every announcement, decision, roll, and applied modifier) and snapshot the state file — enabling crash/resume, dispute audits, and the playtest dataset. Single games must run disk-free; only `playtest` *requires* a filesystem (declared via its `compatibility` field), because a parameter sweep without recorded data is meaningless — and batch sweeps only ever run in harnesses with real disks anyway.
- **Every decision gets a fresh context tail.** At setup, the GM distills the game into a compact **turn brief**: the decision procedure plus the modifier tables relevant to each seat. On every turn the orchestrator re-emits the acting seat's turn brief, so the tail of context is always `turn brief + state table → one decision`. Rules don't dilute over a long game, and each turn becomes effectively stateless — needing only those two inputs — which is exactly the shape required to hand a turn to an isolated subagent where harnesses offer them. (Re-loading the *full* skill and `GAME.md` each turn would buy the same freshness at several times the token cost; the brief is the budget version, with the full rules re-consulted only when a turn raises a question the brief can't answer.)
- **Dice are rolled by script, never by the model.** The engine bundles a tiny roller (`scripts/`) that uses real RNG, supports seeding (reproducible playtest batches), and logs every roll with its context to the transcript. LLMs are biased dice; we don't let them improvise randomness. At human tables, humans may roll physical dice and report results instead — declared at setup, recorded in the transcript either way.
- **Hidden information is handled honestly.** The baseline implementation runs all seats in one agent context with information hygiene by instruction — which is *soft* isolation. The lite RPGs this toolkit targets are nearly full-information games (the dice are the hidden information), so this is acceptable. Where a harness offers subagents, the orchestrator may give each player a genuinely isolated context; that is an enhancement, not a requirement.

## Orchestration modes

### Solo / playtest mode — one (or zero) humans, N AI players, AI GM

The author's mode, and the solo player's. The human (if present) occupies one seat; the `table` skill runs everything else. Turns proceed round-robin; the human sees exactly what a player at a table would: announced conditions, their options, others' declared moves, the rolls. With zero humans this degenerates into a single playtest run, which `playtest` then does in bulk.

### Mixed table, AI GM — humans and AI players at a real table

The interesting one. Physical players sit at a table; one device runs the session. The crucial mechanism is keeping the AI GM synced with what the humans did, and the answer is the **turn report**: a terse, structured line per human action, defined by the game's `GAME.md` and printed on a reference card in `assets/`. One human is the **scribe** (often whoever holds the device). A round looks like:

1. AI GM announces the round's conditions aloud (scribe reads it out) and states each AI seat's declared action.
2. Humans declare and roll physically; the scribe types one line per human: `Dana: speed yes, Lights&Sirens, rolled 4`.
3. The GM applies all mechanics and echoes back the restated state table — current standings, hours, who's in jail — which the scribe reads aloud. This echo is the *same* canonical state table described above doing double duty: it is simultaneously the GM's working memory and the table's error check. If the table disagrees with the summary, the correction happens now, not three rounds later.

The protocol is designed so the scribe types fewer than a dozen words per player per round. If that budget is exceeded, the game's turn report format is wrong — that's feedback for `author`.

### Mixed table, human GM — AI players as extra seats

The mirror image: a human runs the game with paper and wants more chairs filled. The `table` skill runs in players-only mode. Each round, the human GM types the announced conditions (same terse format), each AI seat returns its declaration and (script-rolled) dice, and the human applies the mechanics themselves on paper. The AI players trust the GM's reported outcomes — exactly like human players do.

## Build order

Dependency-driven, and front-loaded toward the author's burning need (balancing Cannonball Rally):

1. **GAME.md format + Cannonball Rally formalized.** Everything consumes the spec format, so it comes first — and writing it forces Cannonball Rally's oral rules onto paper (base 2hr stages, universal speeding option, d6, real-weather hook with fallback table, win = lowest total hours once every racer has finished or been jailed). The rally is the format's proving ground.
2. **`gm` skill.** The mechanics applier, dice roller, restated state table, turn briefs, and (where disk exists) the transcript journal. Testable immediately by a human playing all seats.
3. **`player` + `table` (solo mode).** First full loop: author + N AI players. This is deliverable #1 and #2-solo from the original vision, and the first moment the toolkit is *fun*.
4. **`playtest` batch harness.** AI-only tables at volume, parameter sweeps, balance reports. The reason this project exists; it answers "is 2hr right?"
5. **Mixed tables (`table` full mode).** Turn-report protocol, scribe flow, human-GM mode, printable reference cards. The most novel UX work, done last because it builds on everything prior and is best designed after dozens of solo sessions reveal what round summaries need to contain.
6. **More games + plugin packaging.** `author` skill matures while drafting the carnival and sea-survival games from notes; the repo grows its plugin manifests (a thin wrapper — deliberately punted until the engine is right).

## Glossed over, on purpose

Persona depth and provenance; spectator/log-viewer niceties; networked multi-device tables; non-d6 dice and cards as randomizers (the format should not preclude them, but nothing is built for them yet); localization; marketplace/distribution details beyond "it will be a plugin."
