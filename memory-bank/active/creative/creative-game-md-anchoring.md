# Architecture Decision: GAME.md Machine-Anchoring Strategy

How are sections, content tables, external-data hooks, and turn-report declarations made unambiguously parseable while GAME.md remains a beautiful printable rulebook?

## Requirements & Constraints

Quality attributes, ranked:

1. **Single source of truth** (invariant 6) — one document, two audiences; nothing in the file may be able to diverge from anything else in the file.
2. **Paper-first parity** (invariant 1) — printed output is a rulebook, not a config file; no visible machine scaffolding.
3. **Reliable machine consumption** — `gm` (M4) distills turn briefs from it; `author` (M10) validates against it mechanically; `playtest` (M7) sweeps named rule parameters.
4. **Authorability** — game authors write plain Markdown with ordinary tools.

Constraints:

- Content tables must print cleanly AND parse unambiguously.
- External data hooks: declared real-world inputs, each with an offline fallback usable at paper tables.
- Turn-report format is declared per-game and must fit a printed reference card.
- Must not preclude non-d6 dice or cards (nothing built for them, nothing forbidding them).

Scope: the *anchoring strategy* (how structure is encoded). The full section inventory and per-section content rules are spec implementation, not decided here.

## Components

The document has three consumers with different needs:

- **Printer/human**: rendered Markdown → rulebook. Needs: readable prose, clean tables, no scaffolding.
- **`gm` (LLM)**: reads sections to run the game and distill per-seat turn briefs. Needs: predictable section names, explicit values, complete edge-case answers.
- **`author`/`playtest` (LLM + scripts)**: validates structure; identifies tunable parameters to sweep. Needs: checkable section vocabulary, named parameters.

## Options Evaluated

- **A: Pure structured Markdown** — exact required H2 section vocabulary, spec-defined field conventions inside sections, GFM pipe tables for all content tables, named rule parameters in a Parameters table. No frontmatter, no hidden annotations.
- **B: YAML frontmatter + structured body** — SKILL.md-style frontmatter for identity/metadata (players, time, dice, hooks manifest), headings for the rules body.
- **C: Markdown + invisible HTML-comment anchors** — `<!-- machine hints -->` carrying parameters and hook declarations invisibly.

## Analysis

| Criterion | A: pure Markdown | B: frontmatter + body | C: hidden anchors |
|-----------|------------------|----------------------|-------------------|
| Single source of truth | ✅ every fact appears once, visibly | ⚠️ identity facts exist twice (frontmatter + human title block) → intra-document drift | ❌ a hidden parallel spec inside the file; prose and comments can disagree |
| Print parity | ✅ renders as a rulebook everywhere | ⚠️ YAML block prints as code on page 1 | ✅ invisible in print |
| Machine consumption | ✅ LLM-reliable via consistent structure + explicit values | ✅ mechanical metadata extraction | ✅ arbitrarily precise |
| Authorability | ✅ plain Markdown | ⚠️ YAML foot-guns for non-programmers | ❌ miserable to write and maintain |
| Risk | Low | Medium (drift) | High (invariant 6 violated in spirit) |

Key insights:

- **The machine reader is an LLM, not a strict parser.** "Parse unambiguously" is satisfied by consistent structure and *explicit, named, tabulated values* — not by serialization formats. The failure mode to guard against is ambiguous prose ("takes a couple hours"), not missing YAML.
- The discipline that makes a document LLM-reliable — exact section names, every value explicit, every edge case answered — is the same discipline that makes a *good paper rulebook*. The two audiences converge; B and C solve a problem the system doesn't have, at the cost of the one invariant that matters most.
- `playtest` (M7) sweeps "rule parameters" — so tunable values need to be *named and declared*, not buried in prose. A required Parameters table (name, default, meaning) makes sweeps mechanical and doubles as the rulebook's at-a-glance tuning knobs. This insight surfaced during this exploration and is fed back into the spec's section inventory.

## Decision

**Selected**: Option A — pure structured Markdown with a strict section vocabulary.

**Rationale**: It is the only option where print parity and machine consumption reinforce each other instead of trading off, and the only one with zero intra-document duplication (single-source-of-truth is the top-ranked attribute). LLM consumers need structure and explicitness, both of which pure Markdown delivers.

**Tradeoff**: No mechanically-extractable metadata block; scripts that want metadata (e.g. a future game-library index) must read the Identity section's structured fields. Accepted — the fields are spec-defined and trivially LLM-extractable.

## Implementation Notes

Anchoring conventions the spec must define (content rules are spec implementation):

- **Section vocabulary**: exact, canonical H2 names for required sections; optional sections from a fixed list; unknown H2s allowed only under a spec-defined extension rule.
- **Identity block**: spec-defined bold-label fields (`**Players:**`, `**Time:**`, `**Dice:**`, ...) — structured enough to extract, rendered as a normal rulebook title block.
- **Content tables**: GFM pipe tables; one concept per table; header row vocabulary defined per table kind; every column's semantics defined in the spec.
- **Parameters table**: named tunable rule values (name, default, meaning); prose references parameters by name. Serves M7 sweeps; forces explicit values.
- **External data hooks**: one structured subsection per hook with required fields — input source, how to interpret, and an offline fallback that is itself a content table (roll-on-this-table), keeping paper tables first-class.
- **Turn-report declaration**: per-game grammar given as a template line plus normative examples, sized for a printed reference card (~a dozen words per player per round).
- **Resolution completeness**: the spec enumerates the questions every Resolution section must answer (dice, modifier stacking order, ties, simultaneity) — this list is the seed of `author`'s (M10) interrogation checklist.
- **Core procedure as algorithm**: numbered steps, each step naming who acts and what they consume/produce.
