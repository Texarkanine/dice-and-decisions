# Session Procedure

The full GM procedure for refereeing one session of any conforming game. The game's `references/GAME.md` is the law; this document is how the referee applies it: setup, turn briefs, the round loop, hook resolution, dice discipline, and conduct. The transcript journal it feeds is specified in `journal-format.md`.

Two rules frame everything below:

- **The conversation is the working memory.** Canonical state is the latest restated state table in chat — not a file, not the GM's recollection. Everything here works with no filesystem at all.
- **The paper is the law.** A conforming `GAME.md` (per the format spec at `skills/author/references/game-format.md`) answers every mechanics question. If it doesn't, the paper is incomplete — flag it, don't patch it from the GM's chair.

## Session Setup

1. **Load the game.** Read the named game's `references/GAME.md` in full. Confirm it has every required section of the format's canonical vocabulary (Core Procedure with Setup and Round, Resolution, Scoring & End State, Parameters, Content Tables, Turn Report, GM Guidance). If a required section is missing, or a mechanic the session will need is ambiguous or absent, **stop and say exactly what the paper fails to answer** — do not run the game on improvised rules. Fix the paper, never the engine.
2. **Establish seats.** Name each seat and who occupies it (one human may occupy any number of seats). Record any per-seat identity the game defines (vehicle, character, persona).
3. **Declare dice mode** for the session: `script` (every roll via `scripts/roll.sh`) or `physical` (humans roll real dice and report faces — see [Dice](#dice)).
4. **Declare the session seed** (script mode). Use the seed the table provides; if none, draw one by invoking the roller unseeded — `sh scripts/roll.sh --label session-seed` — and adopt the seed its log line reports (discard the face). Announce the seed: it is what makes the whole session replayable.
5. **Run the game's Setup.** Execute the numbered `### Setup` steps of the game's Core Procedure, then emit the initial state table (GFM) — the columns the game's setup and round steps require.
6. **Open the journal, where disk exists.** Create `transcripts/<game>-<YYYYMMDD-HHmmss>.md` and write the session header per `journal-format.md`. Where no disk exists, skip this — nothing else changes.
7. **Distill the turn briefs** (next section), one per seat.

## Turn Briefs

At setup the GM distills the game into one **turn brief** per seat — the token-budget version of the rules that seat needs to take a turn. A brief contains, and contains only:

1. **That seat's decision procedure**: the round steps that name the seat as actor, in order, as imperatives.
2. **That seat's applicable modifiers and abilities**: its own card or sheet, plus whatever shared values its decisions turn on (relevant parameters and content-table rows), referenced by name with current values.
3. **The declaration grammar**: the game's Turn Report template line plus one example that fits this seat.

Re-emission rule: **before every decision, re-emit the acting seat's brief followed by the current state table.** The context tail at any decision point is always `brief + state table → one decision`. Rules must never be assumed to survive in context from earlier rounds.

Re-consult rule: when a turn raises a question the brief can't answer, re-open the full `GAME.md` and answer from the paper. If a ruling reveals the brief was missing something it should carry, regenerate that brief before its next use. If the *paper* can't answer, apply the game's GM Guidance default ruling principle — out loud — and note the gap for the game's author.

## The Round Loop

Run the game's `### Round` steps exactly as written; they are the authority on order and actors. Honor the game's phase boundaries: when the round separates declaration from resolution into distinct steps, complete the earlier step for the whole field before starting the next — never pipeline one seat through declare-and-resolve while other seats are still deciding. The engine discipline laid over them:

1. **Announce.** Open the round with every value the game's announcement step requires — conditions, thresholds, the round's identity — numbers read in full, flavor within budget (see [Conduct](#conduct)). Resolve any hook the step invokes per [External Data Hooks](#external-data-hooks). Journal the announcement.
2. **Collect declarations.** For each seat, **in the order the game's round steps prescribe**: re-emit that seat's brief and the current state table, then take its declaration, echoed in the game's Turn Report grammar. If a declaration is illegal or doesn't parse, say why and re-ask. If a seat stalls, offer the game's safe default (its GM Guidance names one). Journal each line.
3. **Resolve rolls.** Make every roll the declarations and the game's round steps require, per [Dice](#dice) — declared ability rolls and mandatory checks. Journal each log line verbatim.
4. **Offer result-triggered choices.** Before applying mechanics, scan the results: does any seat's outcome trigger an *optional* choice the game defines — a reaction to a failed check, a reroll, a gamble to dodge a consequence? For each one, **stop**: name the option and its stakes to that seat, ask, and wait for the answer. Resolve only what the seat opts into, rolling any dice it needs. A result that can trigger an option is **not final until that seat has been asked** — never make the choice for a seat, least of all when the downside is severe. Treat this as its own beat every round; when nothing triggers, say so and move on. (Most seat decisions are made up front at declaration; this is the one that fires *after* a roll, so it is easy to skip — the explicit beat is what keeps it from being skipped.)
5. **Apply mechanics.** Compute each seat's outcome **in the exact order the game's Resolution section states**, reading the arithmetic in full — every term named and signed, then the total. No silent math: a number the table didn't hear doesn't exist.
6. **Restate state.** Re-emit the complete state table (GFM) — full table, every seat, every column, after **every** recomputation, not just at round end. This table is the canonical state the next decision reads. Journal it.
7. **End check.** Apply the game's end-of-game check. If the game is over, produce the final standings per its Scoring & End State and journal `## Standings`. Otherwise begin the next round.

Corrections: when an error is found, announce the correction, recompute, and restate the full table — the latest table wins. Never quietly rewrite history.

## External Data Hooks

When a round step invokes a hook by name (the game's `## External Data Hooks` section defines it):

1. **Attempt the Source** if the harness has network (or the data is otherwise at hand). Read the real-world data the hook names.
2. **Apply the Interpretation deterministically.** Map the data to game terms exactly as the hook's Interpretation rule says, including its tiebreak when more than one row fits. Two GMs reading the same data must reach the same row.
3. **No source? Roll the Fallback.** Use the hook's fallback table via the roller (a GM roll — see label grammar below).
4. **Say the ruling out loud** either way: what was seen (or rolled), which row it mapped to, and the resulting game values. The interpretation is a ruling, not a secret; disputes are settled by the hook's own rule, not relitigated.

## Dice

**Models never roll.** Every random number in the session traces to a `roll.sh` invocation or to a declared physical roll transcribed in the same line shape. A number with no log line behind it does not exist.

**Script mode.** Each roll is one invocation of the bundled roller:

```sh
sh scripts/roll.sh --seed <session-seed> --label <label> [--sides N] [--count N]
```

- stdout is the face value(s); stderr is the log line — `roll seed=<s> label=<l> die=d<n> => <r>` — which goes in the journal verbatim.
- **Label grammar:** `<stage>-<actor>-<purpose>`, all lowercase-kebab — `<stage>` is the round's in-fiction identity (the stage, the day), `<actor>` the seat (or `gm` for GM rolls such as hook fallbacks), `<purpose>` what the roll decides. Example: `day1-ana-customers`.
- **Labels are unique per roll within the session.** A roll is a pure function of `(seed, label, sides)`, so a reused label silently repeats a face. When the same seat rolls for the same purpose again in one round, disambiguate in the purpose (`…-reroll`, `…-2`).
- **Multiple dice at once:** use `--count N` — the roller suffixes `#1…#N` to the label itself; never hand-craft `#i` suffixes.
- **What to roll** comes from the game: its title block declares the randomizer (which sets `--sides`; the roller defaults to d6, the toolkit's house die) and its Resolution section says what is rolled, when, and by whom.
- Roll only what the game calls for: an action with no roll gets no roll.

**Physical mode.** Humans roll their own dice and report faces (at the table or via Turn Report lines). The GM transcribes each reported face in the standard line shape with `seed=physical`:

```
roll seed=physical label=day1-ana-customers die=d6 => 4
```

Physical sessions are not seed-replayable; everything else is identical.

## Conduct

- **Narration budget:** at most one sentence of flavor per announcement or resolution; every number read in full. The game's GM Guidance may tighten this, never loosen it.
- **Remind before deciding:** the brief re-emission is the reminder — a seat must see its own applicable effects before it declares, not after.
- **Default rulings:** when the rules run out mid-round, apply the game's GM Guidance default ruling principle, say the ruling out loud, and note it for the game's author.
- **Fix the paper:** any rule the session needed that `GAME.md` didn't supply is a defect in the game document. Record it (journal and end-of-session note); do not let it harden into an unwritten engine rule.
- **Neutral referee:** the GM applies mechanics and presents choices; it does not advise seats on strategy, favor outcomes, or make a seat's optional choices for it — including whether to use a result-triggered ability.
- **One seat at a time:** even when one human plays every seat, address each seat's turn separately, in order, with its own brief — the loop's shape is the product.
