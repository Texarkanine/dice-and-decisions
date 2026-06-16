# lite-rpg

> **Heads up: this README is aspirational and the project is under construction.** It describes where the toolkit is headed, not what works today. Expect missing pieces, renamed things, and wet paint.

A toolkit for playing, playtesting, and publishing **lite RPGs** — tabletop games that *feel* like RPGs but run entirely on decisions and dice. No improv, no funny voices, no rules-lawyering: the GM presents choices, players choose, the dice decide, the mechanics apply. Think "RPG night" with the overhead of a card game.

The twist: AI agents can fill **any seat at the table** — a player, the GM, or the whole table at once — and the games never *require* a computer. Every game stays printable and playable with paper, pencils, and a d6.

## Why?

Because balancing a tabletop game by hand is guesswork. The founding question of this project: in [Cannonball Rally](#the-games), is a 2-hour base stage time the sweet spot where bold play can beat "beige plays it safe" — but doesn't dominate it? Answering that honestly takes *hundreds* of plays. AI tables can play hundreds of games overnight and hand you a balance report in the morning.

And once AI can playtest a game, it can also *play* one with you: solo sessions with a full AI table, an AI GM running game night for your friends, or AI players filling the empty chairs at a human-run table.

## How it works

- **One document, two audiences.** Each game is a `GAME.md`: simultaneously the printable rulebook humans run at the table and the machine-readable spec AI reads. Same file, unmodified. If the AI needs something the paper doesn't say, the paper is incomplete — fix the paper. The format is defined in the [GAME.md format specification](skills/author/references/game-format.md).
- **Skills, not servers.** Everything ships as [agentskills.io](https://agentskills.io/specification)-compatible skills. No backend, no custom tooling — runnable anywhere skills install (Cursor, Claude Code, and in principle Claude.ai on the web).
- **The engine is generic; games are content.** Adding a game means writing a document, not writing code.
- **Dice are rolled by script, never by the model.** LLMs are biased dice. A tiny bundled roller uses real RNG, supports seeding, and logs every roll.

## The engine

| Skill | What it does |
| --- | --- |
| `gm` | The referee: announces conditions, presents choices, applies mechanics, keeps canonical state |
| `player` | An AI player with a persona — the cautious one, the gambler, the spiteful one playing to make *you* lose |
| `table` | The orchestrator: "run Cannonball Rally with me and four AI players" |
| `playtest` | The batch harness: N unattended games, parameter sweeps, balance reports |
| `author` | The game writer's assistant: drafts, validates, and interrogates `GAME.md`s for unwritten rules |

## The games

| Game | Pitch | Status |
| --- | --- | --- |
| **Cannonball Rally** | Coast-to-coast outlaw racing for 2–6 players. Speed and risk jail time, or play it safe and watch the leaderboard pull away. Stage weather comes from the *real forecast* — the rally plays differently in January than July. | [Playable on paper](skills/cannonball-rally/references/GAME.md) |
| Carnival ticket hustle | Work the midway, run the games, fleece the rubes | Notebook |
| Caribbean sea survival | Stay alive, stay afloat | Sketches |

## Repo layout

Everything installable lives in one place: `skills/`. Engine skills and games are the same kind of artifact — every game directory is itself a valid [agent skill](https://agentskills.io/specification) — so they share a single home, and the repo root doubles as the future plugin root (both Cursor and Claude Code auto-discover a plugin's root-level `skills/`).

```text
skills/
├── author/
│   └── references/
│       └── game-format.md    # the GAME.md format specification (skill itself: planned)
├── cannonball-rally/         # the first game: SKILL.md + references/GAME.md
├── gm/                       # the referee engine skill (built)
│   ├── SKILL.md
│   ├── references/           # session-procedure.md, journal-format.md
│   └── scripts/
│       └── roll.sh           # the dice roller (real RNG, seedable, logged)
├── player/                   # the player-seat engine skill (built)
│   ├── SKILL.md
│   └── references/           # decision-procedure.md, personas.md
├── table/                    # engine skills (planned)
└── playtest/
```

Each game directory ships as `skills/<game>/` with a `SKILL.md` pitch, its rulebook at `references/GAME.md`, and printables in `assets/`.

## Tests

If you just want to verify the repo's current automated checks locally, run:

```sh
make test
```

That's the single test entrypoint for this repo and is the same command CI uses.

## Status

Pre-alpha. The [`GAME.md` format specification](skills/author/references/game-format.md) is written, [Cannonball Rally](skills/cannonball-rally/references/GAME.md) is formalized against it — the format's first real proof — the [dice roller](skills/gm/scripts/roll.sh) is built (real RNG, seedable, every roll logged; reproducible from a single seed with no on-disk state), the [`gm` referee skill](skills/gm/SKILL.md) now runs a full session against the spec, validated by a golden transcript, and the [`player` skill](skills/player/SKILL.md) fills a seat with a persona (one declaration + a line of table talk, no dice — the referee's strategic opposite). Next: the remaining engine skills in dependency order (`table` → `playtest` → mixed-table play → plugin packaging).
