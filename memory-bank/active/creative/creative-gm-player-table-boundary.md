# Architecture Decision: The gm / player / table Role Boundary

## The Question

M4 shipped the `gm` skill and it ran an entire 6-seat Cannonball Rally end-to-end — on **Haiku 4.5**, a weak model. If a weak model can referee a whole game autonomously, what do the still-unbuilt `player` (M5) and `table` (M6) skills actually add that "the `gm` skill + a moderately smart model" doesn't already provide? And since the GM has demonstrably shown it *can* do it all in one context when pressed, what stops it from absorbing those roles rather than calling out to them?

## What the Haiku Runs Actually Proved

The premise needs sharpening, because it quietly overstates what was observed. Across all eight validation runs (`haiku1`–`haiku7`, `sonnet1`), the GM ran the **referee** role autonomously: load + conformance-check the game, distill per-seat turn briefs, order the seats, resolve the weather hook, roll by script, apply mechanics in Resolution order, restate the state table, score, end-check. What the GM did **not** do is **make the seat decisions** — in every run a *human* typed each declaration (`doc: lights & sirens, speed`). The GM supplied all the scaffolding; the human supplied the decision tokens.

So the real finding is narrower and more useful than "the GM can do everything":

1. **The hard part of the engine is robust enough to run on a weak model.** After M4's hardening (the off-seat cross-check beat, save/bar/beat vocabulary, the usage-cadence default), mechanics application survives Haiku. Good — that means the referee can be a clean, almost-dumb substrate.
2. **The GM's procedure is already shaped like a single-context game loop.** It distills per-seat briefs and walks the seats in order collecting declarations. That is *table-shaped scaffolding and player-facing presentation already baked into the referee.* The autonomous run was exactly **one thing** short of running the whole game solo: an independent decision-source for each seat. The human filled that slot.

That last point is the crux. The GM isn't missing *capability* — it's missing (and must keep missing) a *decision-maker per seat*. `player` and `table` are not "a smarter GM"; they are the two pieces that occupy the slot the human occupied, plus the casting that decides who occupies it.

## Components

```mermaid
flowchart TD
    User([operator: "run the rally with me + 4 AI"]) --> Table
    Table["table — composition root / casting + routing"]
    Table -->|sets up seats, dice mode, who GMs| GM
    Table -->|"for each decision: route to the right source"| H[human seat]
    Table -->|"seat-scoped brief + persona, isolated"| P1["player — persona A"]
    Table -->|"seat-scoped brief + persona, isolated"| P2["player — persona B"]
    H -->|declaration line| Table
    P1 -->|declaration line| Table
    P2 -->|declaration line| Table
    Table -->|declarations| GM
    GM["gm — neutral referee (mechanics, dice, state)"]
    GM -->|announce / brief / state table / resolution| Table
```

Three single responsibilities:

- **`gm` — the neutral referee.** Owns mechanics, dice discipline, state. Constitutionally forbidden (Conduct: *"does not advise seats on strategy, favor outcomes, or make a seat's optional choices for it"*) from taking a position. Its job is to be *correct and impartial*.
- **`player` — the strategic seat.** Its entire job is to **take a position** — the precise thing the referee may not do. Personas exist to *cover the strategy space* ("beige plays it safe" vs. a risk-taker) so playtests measure something. `player` is not a junior GM; it is the referee's **complementary opposite**.
- **`table` — the composition root.** The only component that knows the table is *heterogeneous* (which seats are human, which are AI and with which persona, script vs. physical dice, who GMs), the only one the user actually invokes, and the thing that routes each decision to its source and hands the result to the GM. The GM is **called**; it never calls.

## Why The Autonomous Run Is Evidence *For* The Split, Not Against It

The instinct "Haiku did it all, so the split is overhead" inverts the lesson. A GM that *also plays every seat* fails the founding requirement in the most dangerous way possible — silently:

- **Strategy coverage collapses to zero.** The founding question is *"does risk-taking beat beige-plays-it-safe at 2hr base stage time?"* Answering it requires seats that **embody distinct strategies**. A single GM playing all six seats either plays them in one undifferentiated house style (no coverage) or adopts strategies (abandoning the neutrality that makes its rulings trustworthy). Either way the balance report is fiction that *looks like data*.
- **Statistical independence collapses to N=1.** Six seats driven by one strategic context are one mind wearing six hats, not six independent agents. A playtest of "six players" that is really one brain is a sample size of one. The whole point of `playtest` (M7) evaporates.
- **The detectable boundary already exists.** The golden was accepted for *"48 real player turns (no GM ventriloquism)."* That phrase **is** the boundary's acceptance test: every declaration in a transcript must trace to a distinct decision-source. A run where the GM authored the declarations is a *failed* run, not a passed one — and it's mechanically checkable.

So the robust-on-Haiku result is the *good* news: the referee is a clean substrate that a separate strategic layer plugs into. The split is what converts that substrate into something that can actually answer the design question.

## Options Evaluated

- **Option A — Documentation boundary only (status quo).** Keep the skills separate; rely on the GM's Non-Goals + neutral-referee Conduct + "table calls gm, not vice versa." Already in place.
- **Option B — Structural isolation.** `table` invokes `player` as a **seat-isolated call** (a subagent where the harness offers one; at minimum a separate seat-scoped prompt) seeded with only that seat's brief + visible state + persona; the decision returns as a turn-report line — the same grammar a human types. The GM receives declarations it did not author and cannot see the player's reasoning; the player cannot see the GM's chair or other seats' hidden state.
- **Option C — Merge the roles.** Drop `player`/`table`; make `gm` a parameterizable "run the whole table" skill that takes a persona roster and loops the seats itself. The honest null hypothesis: "it can already do it, so let it."

## Analysis

| Criterion | A: docs-only | B: structural isolation | C: merge into gm |
|-----------|--------------|-------------------------|------------------|
| Strategy coverage (playtest) | leaky — collapse looks like success | **independent seats by construction** | **fails — one mind, N=1** |
| Referee neutrality | asserted, not enforced | **enforced (GM never holds strategy)** | **destroyed (GM holds strategy)** |
| Simplicity (skill count) | high (3 skills, thin glue) | medium (3 skills + isolation plumbing) | **highest (1 skill)** |
| Harness portability | full (pure instruction) | subagent path is harness-dependent; soft-isolation fallback | full |
| Sweepability (swap a strategy) | per-instruction | **swap the player call's persona; referee untouched** | poor — strategy tangled into referee |
| Collapse resistance | **weak — gravity pulls roles together** | **strong — capability removed, not just forbidden** | n/a (collapse is the design) |

Key insights:

- **A prose rule does not prevent collapse.** The GM already carries Non-Goals and a neutral-referee clause, yet its procedure is *shaped* like the table loop and the Haiku runs show it drifting toward editorializing briefs. The same helpfulness gravity that makes a GM want to narrate a seat's move is what would make it play the seat. Under a "just run it yourself" prompt, documentation yields. What removes the temptation is removing the **capability**: don't hand the GM the player's reasoning at all.
- **The requirement is itself a forcing function.** Independent of any harness feature, `playtest`'s value *requires* attributable, independent declarations. That makes the boundary testable everywhere: *every declaration traces to a distinct source.* Even on a soft-isolation web harness with no subagents, `table` still invokes `player` as a distinct step producing a distinct, attributable line — the isolation is weaker but the **attribution boundary survives**.
- **The turn-brief pattern was built for exactly this.** systemPatterns already says the per-seat brief makes each turn "effectively stateless, which is exactly the shape needed to hand a turn to an isolated subagent." Option B is the cash-in of a decision M4 already made; it is not new architecture.
- **Option C optimizes the one attribute that doesn't matter.** Fewest-skills is the only column C wins, and it wins it by sacrificing strategy coverage, neutrality, sweepability, and the entire reason `playtest` exists.

## Decision

**Selected: Option B — separate skills with structurally-isolated player decisions and `table` as the composition root**, retaining Option A's documentation boundary as the soft-isolation fallback for harnesses without subagents. Option C is **rejected**.

**Rationale.** The split is justified not by "the GM can't" but by *what the GM must not become*. `player` is the referee's strategic opposite; `table` is the casting director the user actually invokes and the only component aware the table is heterogeneous. The founding `playtest` need — strategy-diverse, independent, attributable seats — is unmeetable by a role-collapsed GM, and a collapsed GM fails *silently* (a plausible transcript with no real strategy diversity), which is the worst failure mode for a balance tool. Collapse is prevented structurally (the GM is handed declarations, never reasoning; it is called, never caller) and is made detectable by a transcript-level acceptance test that holds on every harness.

**Tradeoff accepted.** Structural isolation via subagents is harness-dependent; on the disk-free / web baseline it degrades to soft isolation (one context, instructed hygiene + distinct attributable player calls). This is consistent with the already-accepted product stance that hidden information is soft-isolated because the target games are near-full-information. The residual risk: on a soft-isolation harness, a sufficiently determined model could still ventriloquize. Mitigation: the **attribution acceptance test** ("every declaration traces to a distinct source; GM-authored declarations fail the run") is harness-independent and should be baked into M5/M6/M7 validation, exactly as `sonnet1`'s "no GM ventriloquism" criterion already foreshadowed.

## Implementation Notes

- **Boundary contracts (reuse what exists).** The unit of exchange across all three roles is the game's **Turn Report line** — a human types it, a `player` returns it, the GM consumes it identically. No seat-type-specific channel. The GM's existing per-seat **turn brief** is the input `table` feeds to a `player` (or shows a human). These two already-pinned grammars *are* the gm↔player↔table interface; nothing new needs inventing.
- **`player` (M5) input/output.** In: seat brief + current visible state table + persona. Out: exactly one Turn Report line plus a line of table talk. It must decide from seat-visible information only — never the full field the GM sees.
- **`table` (M6) responsibilities.** Session casting (seats → human | player(persona) | physical-dice flags | who GMs); per-decision routing to the right source; feeding declarations to the GM; surfacing the GM's announcements/state back out. It is the composition root: in solo, playtest, and mixed modes the GM is invoked by `table`, never the reverse.
- **Keep the GM's loop, re-read its scope.** Do **not** delete the GM's seat-by-seat presentation — it is correct and necessary when one human plays all seats (the M4 degenerate case) and when a human seat sits at a `table`-run session. The fix is conceptual: that loop presents and collects; it must never *generate* a declaration. Tighten the Conduct/Non-Goals wording from "does not advise" to also "does not author a seat's declaration" so the ventriloquism prohibition is explicit, not implied.
- **Enforcement = capability removal + a test, not exhortation.** Where subagents exist, `table` runs each `player` decision in an isolated context so the GM never receives reasoning. Everywhere, the validation harness asserts every declaration is attributable to a distinct source; a transcript of GM-authored declarations is a failed run.
