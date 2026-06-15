# Architecture Decision: Transcript Journal & Golden Transcript Format

## Requirements & Constraints

**Functional requirements:**

- Record a complete session: setup (game, seats, dice mode, seed), every announcement,
  declaration, roll, applied-modifier computation, state-table snapshot, and final standings.
- Enable crash/resume: a recycled sandbox must be able to reconstruct the session from the
  journal alone (latest state + position in the procedure).
- Support dispute audit: a human must be able to read the journal and check what happened.
- Serve as the golden-fixture format: M4's human-played Cannonball Rally session is recorded
  in this format; later milestones (M6 reference, M7 playtest dataset/report) consume it.
- Strictly optional: where no disk exists the session runs unchanged — the journal mirrors
  the conversation, never replaces it (conversation is the working memory; disk is the journal).

**Quality attributes, ranked:**

1. **Human auditability** — paper-first ethos; dispute audits; the operator verifies the
   golden transcript by reading it.
2. **Machine parseability** — M7 must extract rolls, choices, times, and outcomes at volume.
3. **Production simplicity** — the GM appends as it plays; no tooling exists to help it.
4. **Resilience** — append-only; a truncated file must still be useful for resume.

**Technical constraints:**

- Markdown-first repo; the writer *and* the primary machine reader are LLMs.
- The roll log line grammar is already pinned (M3): `roll seed=<s> label=<l> die=d<n> => <r>`.
- Each game's declaration grammar is already pinned: the GAME.md `## Turn Report` template.
- State is already canonically a GFM table (restated state table pattern).
- No parser is built in M4 (M7 builds extraction when it needs it) — the format must be
  parseable by anchoring on existing pinned grammars, not by promising future tooling.

**Scope boundaries:** the journal record format and fixture location are in scope; the
mixed-table scribe protocol (M8) and the playtest dataset/report layout (M7) are out of
scope, though M7 builds on this format.

## Components

Producer: the `gm` skill, appending after each recomputation. Consumers: a resuming `gm`
(crash/resume), humans (audit, the operator validating the golden fixture), and M7's
`playtest` extraction. The journal sits on the boundary between gm and everything later —
it is a contract, like `roll.sh`'s stderr line, not an internal convenience.

## Options Evaluated

- **A — Narrative Markdown transcript**: one `.md` per session; the GM tees what it says in
  conversation (prose announcements, declaration lines, roll lines, GFM state tables) with
  no normative structure beyond habit.
- **B — Structured event log**: one line per event in a `key=value` grammar extending the
  roll line (`announce …`, `declare …`, `state …`); maximally machine-friendly.
- **C — Structured Markdown transcript**: a Markdown document with a small normative
  skeleton (required headings and per-round parts), whose machine-critical records are the
  *already-pinned* grammars — turn-report lines for declarations, verbatim `roll …` lines
  for dice, GFM tables for state — plus bounded prose for announcements/flavor.

## Analysis

| Criterion | A: Narrative | B: Event log | C: Structured Markdown |
|-----------|--------------|--------------|------------------------|
| Fitness | Resume/audit yes; M7 extraction fuzzy | M7 yes; audit poor; state tables don't fit lines | All four consumers served |
| Simplicity | Trivial to produce | Forces translating every utterance into a second format | Tee of conversation + small skeleton |
| Maintainability | Drifts session-to-session (no contract) | Two formats for one fact = drift (the exact disease GAME.md exists to cure) | One format, two audiences (the house pattern) |
| Scalability | M7 parses prose at volume — fragile | Fine | Anchors (headings, pinned grammars) parse at volume |
| Risk | Golden fixture format would be folklore | Humans can't audit; violates paper-first ethos | Low — skeleton is small and additive over A |

Key insights:

- The toolkit *already owns* pinned grammars for exactly the events M7 needs most:
  declarations (the game's Turn Report template), rolls (`roll.sh`'s stderr line), and state
  (GFM tables). Option C is not a new format so much as a skeleton that anchors existing
  contracts in a file — the journal costs no double bookkeeping because those grammars are
  what the GM emits in conversation anyway.
- Option B reintroduces the dual-format drift problem the GAME.md "one document, two
  audiences" pattern was created to kill. Rejecting it is consistency, not taste.

## Decision

**Selected**: Option C — structured Markdown transcript.
**Rationale**: It is the only option serving all four consumers, and it wins the top two
quality attributes simultaneously by reusing pinned grammars as parse anchors — the same
"one document, two audiences" move that GAME.md proved.
**Tradeoff**: A small normative skeleton must be specified and followed (vs. A's
write-anything), and M7's extraction must anchor on headings/grammars rather than a
serialization format (vs. B's trivial parsing). Both accepted.

## Implementation Notes

The skeleton (normative, defined in the gm skill's journal reference):

- **One file per session**, named `<game>-<YYYYMMDD-HHmmss>.md`, append-only. Where disk
  exists the GM writes into a `transcripts/` directory under the working directory (never
  inside the installed skill); where it doesn't, no journal, no behavior change.
- **H1 session header**: game name + bold-label fields (`**Date:**`, `**Seed:**`,
  `**Dice:**` script or physical, `**Seats:**` one line per seat: name, role, vehicle/
  character, persona if any).
- **One H2 per round**: `## Round <n>: <name>` (e.g. the stage name), containing in order:
  1. **Announcement** — the GM's announced conditions: bounded prose plus the announced
     values (read in full, per GM Guidance).
  2. **Declarations** — one line per seat in the game's Turn Report grammar, attributed.
  3. **Rolls** — the `roll seed=… label=… die=d<n> => <r>` lines verbatim (script mode), or
     the same line shape with `seed=physical` for human-reported dice.
  4. **Resolution** — per seat, the modifier arithmetic read out (the math in full).
  5. **State** — the restated state table (GFM), exactly as emitted in conversation.
- **Final H2** `## Standings`: the end-state read-out per Scoring & End State.
- **Resume rule**: the resume point is the last complete round's state table; an incomplete
  trailing round is replayed from its announcement (rolls are reproducible from the seed).
- **Golden fixture location**: `tests/fixtures/transcripts/` in the repo (repo-level test
  data, consistent with the repo-level `tests/` harness; skills ship only runtime
  actionables). The M4 fixture: `tests/fixtures/transcripts/cannonball-rally-golden.md`.
