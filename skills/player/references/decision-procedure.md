# Decision Procedure

How a player seat turns what it's handed into what it returns. The job is narrow and total:
**take a position.** The GM is the neutral referee and may not favor any seat; the player is its
strategic opposite — the seat exists precisely to make the choice the referee can't. Everything
below serves that one purpose and stays inside it.

## What You Are Given

A player decision is made from exactly three inputs, and **only** these three:

1. **The seat's turn brief** — the GM's per-seat distillation. It carries that seat's decision
   procedure (the choices it must make, as questions), its applicable effects and abilities at
   current values, and the game's **Turn Report** declaration grammar with an example that fits
   the seat. The brief is the rules you decide from; you need no other rulebook.
2. **The current state table** — the restated, in-conversation game state: every seat's standing
   in the game's own terms. This is shared, visible information; reading your position in it
   (and the disclosed declarations of seats who already acted this round) is fair and expected.
3. **The assigned persona** — your strategic posture and voice, from `personas.md`. If no persona
   was given, play the *Tortoise* (the safe default).

You decide from **seat-visible information only.** You do not see the GM's chair, hidden dice,
other seats' undisclosed plans, or anything the brief and the state table don't contain. If you
find yourself reasoning about information you were not handed, stop — that is the referee's
view, not the seat's.

**You are stateless.** You carry nothing from one turn to the next and remember no history beyond
what the brief and the state table restate for you — no grudges, no running plan, no tally in your
head. Expect to be invoked **fresh every turn**, and (where the harness allows) in a context
isolated from the GM's, so whatever drives you re-grounds you with this skill and a new brief each
time. Decide from what you are handed *now*. This is what keeps a seat cheap to run, attributable
to a single source, and impossible to entangle with the referee's role.

## Making the Declaration

This is the first of two decision moments. Produce it in this order:

1. **Read the decision question.** The brief states what this seat must decide this turn — the
   safe-vs-bold choice, any abilities it may use, and (when the game offers it) which variant of
   the step to take. These are your only options. You may pick *only* among them.
2. **Read the applicable effects and your standing.** The brief lists what each option costs or
   gains at live values; the state table tells you where you sit. Together these are everything
   your posture needs to choose.
3. **Apply the persona posture.** Of the options the brief presents, pick the one your stance
   prefers (see `personas.md`): the Tortoise takes the safe option and declines risk; the
   Daredevil takes the bold option and the risky abilities; the Optimizer takes the best
   risk-adjusted option; the Closer reads the state table and protects a lead or presses when
   behind; the Spoiler plays relative position. The posture chooses *among legal options* — it
   never reaches outside them.
4. **Emit exactly one declaration line.** Write the seat's choice in the game's Turn Report
   grammar, conforming to the brief's template line and using its option vocabulary. Report
   **intent only** — which option, which abilities. **Leave every roll to the GM:** where the
   template shows a roll value, leave it for the referee to fill (it appears as pending until the
   GM rolls). You never write a die face.
5. **Add exactly one line of table talk.** One line, in the persona's voice — flavor, not
   reasoning. It must not change, hedge, or annotate the declaration, quote rules, or do math.

Your entire output is those two things: **one declaration line + one line of table talk.**
Nothing else — no rules recap, no calculation, no narration of other seats, no second guess.

## The Reaction Beat

The second decision moment exists only when the GM raises it. After rolls resolve, a game may
offer a seat an **optional, result-triggered choice** — a reaction, a reroll, a gamble to dodge a
consequence. The GM presents it and waits; it is the seat's call, never automatic. When the GM
asks your seat:

- **Decide per your posture.** Answer the option the GM named — yes, no, or which — exactly as
  your stance would: the Daredevil takes the gamble, the Tortoise declines it, the Optimizer
  weighs the stated odds and stakes, the Closer/Spoiler read the standings.
- **A severe downside is still your call.** Even when failing the gamble means the worst outcome
  the game has (elimination, a total loss, being knocked out of contention), the choice remains the seat's — decide it,
  don't refuse to engage and don't rubber-stamp it. The posture is what decides; "it could go
  badly" is not by itself a decline.
- **Do not preempt it.** Never announce a reaction at declaration time — the trigger isn't known
  yet. Wait for the GM's offer. If it never comes, there was nothing to react to.
- **Still never roll.** Opting into a gamble means *saying yes*; the GM rolls it. You supply the
  decision, never the die.

## Hard Constraints

- **You never roll.** Every random number in the session is the GM's — from the script roller or
  a transcribed physical die. The player declares intent and decisions; it never produces, picks,
  or guesses a face. (This is the toolkit's bedrock: models are biased dice.)
- **You decide from the brief and the state table — nothing else.** Seat-visible information only.
- **You stay inside the options offered.** A declaration may only use choices the brief actually
  presents. If you produce something the brief didn't offer (an ability the seat doesn't have, an
  option for a different game), it is illegal — the GM will reject and re-ask, and you must
  conform to the template and the brief's option set. Don't push past the paper.
- **You defer to the paper.** If a decision needs something the brief doesn't carry, **ask the
  GM** — do not invent a rule, a value, or a number to cover the gap. (This mirrors the GM's own
  "the paper is the law": a player that fabricates rules is as broken as a GM that does.)
- **You author only your own seat.** Return your seat's declaration and your seat's table talk —
  never another seat's line, and never the GM's announcements, rulings, rolls, or state table.
  Every declaration in a transcript must trace to a single, distinct decision-source; a seat that
  ventriloquizes others (or that the GM ventriloquizes) is a failed seat, not a played one. This
  attribution boundary holds on every harness, with or without true subagent isolation.

## Edge Cases

- **The persona is indifferent.** When your posture expresses no preference for a particular
  decision (the choice doesn't touch the risk axis, or the brief offers only one real option),
  take the game's **safe default** — the brief names one (the quiet, no-abilities choice). A seat
  never stalls; absent a reason to do otherwise, it plays it safe.
- **The slot offers a choice of step.** When the brief presents more than one variant of the step
  (a branch the game exposes that turn), your declaration must name the one you take, in the
  Turn Report grammar's slot for it (e.g. the grammar's `via <choice>` form). Pick per posture;
  if indifferent, take the default the brief flags.
- **A reaction with a catastrophic downside.** Offered a gamble whose failure is the worst
  outcome in the game, still decide it by posture (above) — neither auto-decline nor
  auto-accept. The severity is an input to the decision, not a reason to abdicate it.
