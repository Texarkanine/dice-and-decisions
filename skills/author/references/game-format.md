# GAME.md Format Specification

Every game in this toolkit is one Markdown document named `GAME.md`. That single document is simultaneously:

- the **printable rulebook** a human table runs with paper, pencils, and a randomizer, and
- the **machine-readable spec** the engine skills (`gm`, `player`, `table`, `playtest`, `author`) consume.

This reference defines the format: the required sections, the conventions inside each, and the validation checklist a conforming document must pass. Its primary readers are game authors (and the `author` skill assisting them); the engine skills rely on it to know what any conforming game guarantees. Each game ships as a skill directory, and its rulebook lives at `references/GAME.md` inside that directory.

**Status:** the format is proven by writing real games against it, starting with Cannonball Rally, its designated proving ground. Amendments surfaced by formalizing a real game are expected and are folded back into this document.

## Why This Format

**One document, two audiences.** The printed rulebook and the machine spec are the same unmodified file. There is no parallel machine format to drift out of sync, and nothing in the document may duplicate anything else in the document — every fact appears exactly once.

**Paper-first parity.** A `GAME.md` must print as a complete, pleasant rulebook. No frontmatter, no hidden annotations, no machine scaffolding on the page. The parity rule cuts the other way too: *if the AI needs something the paper doesn't say, the paper is incomplete — fix the paper, never the engine.*

**The machine reader is an LLM.** "Parseable" here does not mean a serialization format; it means consistent structure and explicit, named, tabulated values. The failure mode this format guards against is ambiguous prose — "takes a couple hours", "roll high to win" — not missing metadata. The discipline that makes a document reliable for an LLM (exact section names, every value explicit, every edge case answered) is the same discipline that makes a good paper rulebook. The two audiences converge.

**Explicitness is the whole game.** An illustration: formalizing Cannonball Rally, this toolkit's first game, surfaced six rules that lived only in the author's head — the base stage time, the speeding option, how weather resolves, what counts as an obstacle, which die to use, and the win condition. The game had been played happily for years; the paper just didn't say. This format exists to force that interrogation up front. (Cannonball Rally appears in this spec only as illustration; no game's rules are part of the format.)

**One file is the game.** A game fits, reasonably, in one `GAME.md`. This is a creative constraint, not a storage decision: having to fit the whole game in a single printable document breeds tight design, and it keeps "print the rulebook" a one-step act. For structured content sets — vehicles, character options, stage libraries — the collection convention (see Content Tables) keeps growth organized *inside* the document; the format deliberately does not provide a way to split a game across files.

## Document Conventions

These rules govern the whole document:

1. **Pure Markdown.** GitHub-Flavored Markdown only. No YAML frontmatter, no HTML comments, no hidden annotations of any kind. What prints is what parses.
2. **The H1 is the game's name** and is the first line of the document.
3. **The title block** (identity fields and pitch — see [The Title Block](#the-title-block)) sits between the H1 and the first H2.
4. **Required sections use exact H2 names** from the canonical vocabulary below, in canonical order. The optional section, when present, occupies its slot in that order.
5. **Extension sections** — game-specific H2s outside the vocabulary — are allowed only *after* `## GM Guidance`. They may carry flavor, lore, variants, or designer notes, but nothing required to play: if a rule matters, it belongs in a required section. Engine readers ignore extension sections they don't recognize.
6. **Single source of truth, inside the document too.** Every rule value lives in exactly one place — a parameter in the Parameters table, content in a content table — and prose refers to it *by name* rather than restating it. A document where prose says "5 days" and the Parameters table says `Days = 5` has two places to edit and will eventually disagree.
7. **Randomizer neutrality.** Games declare their own randomizer (dice, cards, anything a table can operate). The d6 is this toolkit's house default, not a format requirement. Nothing in a conforming document may assume a randomizer the title block didn't declare.
8. **All tables are GFM pipe tables.** They print cleanly and parse unambiguously; no other table syntax is permitted.

### Canonical Section Vocabulary

| # | Section | Heading | Presence |
| --- | --- | --- | --- |
| 0 | Title block | *(none — between H1 and first H2)* | Required |
| 1 | Core Procedure | `## Core Procedure` | Required |
| 2 | Resolution | `## Resolution` | Required |
| 3 | Scoring & End State | `## Scoring & End State` | Required |
| 4 | Parameters | `## Parameters` | Required |
| 5 | Content Tables | `## Content Tables` | Required |
| 6 | External Data Hooks | `## External Data Hooks` | Optional |
| 7 | Turn Report | `## Turn Report` | Required |
| 8 | GM Guidance | `## GM Guidance` | Required |
| 9+ | Extension sections | *(any H2 not in this table)* | Optional |

### The Worked Example

Every example in this spec is drawn from **Lemonade Stand**, a deliberately trivial game written to exercise every section of the format. The complete assembled document appears in [Appendix A](#appendix-a-worked-example--lemonade-stand) and passes the [Validation Checklist](#validation-checklist) — it doubles as the starting template for drafting a new game. Lemonade Stand is an illustration, not part of the format.

## Sections

Each section below gives its **purpose**, its **required content**, its **conventions**, and an **example** excerpted from Lemonade Stand.

### The Title Block

*Required. Position 0 — between the H1 and the first H2.*

**Purpose:** identify the game at a glance — for a human browsing a shelf and for a machine indexing a library — without resorting to frontmatter. This is the format's identity-and-flavor section.

**Required content:**

- Bold-label identity fields, one per line, each in the form `**Label:** value`:
    - `**Players:**` — the supported player count or range.
    - `**Time:**` — typical wall-clock play time.
    - `**Randomizer:**` — what generates chance (e.g. "one d6", "a standard 52-card deck", "none"). Everything else in the document must be consistent with this declaration.
- A pitch of one to three sentences: what the game feels like and why someone would play it.

**Conventions:**

- Additional bold-label fields (e.g. `**Materials:**` for non-randomizer table needs) are allowed; readers treat unrecognized fields as advisory.
- The fields come first, then the pitch.

**Example:**

```markdown
# Lemonade Stand

**Players:** 2–6
**Time:** about 20 minutes
**Randomizer:** one d6 (a single shared die is fine)
**Materials:** pencil and paper for the score sheet

You and your rivals run lemonade stands for one summer week. Each day, pick
your spot, set your price, and pray for sun: weather, location, and ambition
decide how many customers show up. Most money when the week ends wins.
```

### Core Procedure

*Required. Position 1. Heading: `## Core Procedure`.*

**Purpose:** the complete game loop as an explicit algorithm. This is the section the `gm` skill distills into per-seat turn briefs, and the section a first-time human GM runs the game from.

**Required content:**

- A `### Setup` subsection: a numbered list of everything done once before play.
- A `### Round` subsection: a numbered list forming the repeating loop. Its first line states what one round represents in the game's fiction (e.g. "**A round is** one day of business.").
- An explicit end-of-game check as a numbered step in the round, referencing `## Scoring & End State`.

**Conventions:**

- Every step names its actor in bold — `**GM**`, `**Each player**`, `**Table**` (all participants), or a specific role — and states what the step consumes and produces, so any step can be handed to the right seat in isolation.
- Steps are imperative sentences.
- Steps reference parameters, content tables, and hooks by name; they never restate values (convention 6).
- If the game uses External Data Hooks, each hook is invoked by name from the step where it applies — the procedure, not the hook, owns the timing.

**Example:**

```markdown
### Round

**A round is** one day of business. The game lasts *Days* rounds.

1. **GM** announces today's weather — resolved via the *Tomorrow's Forecast*
   hook, or by its fallback — and the matching modifier from the Weather table.
2. **Each player**, in seat order, declares a location from the Locations
   table, a price (regular or premium), and optionally one unused Perk.
3. **Each player** rolls 1d6 and computes customers served (see Resolution).
4. **GM** records each player's customers served and earnings — customers
   served × *Regular Price* or *Premium Price* — on the score sheet.
5. **GM** restates the full score sheet: each player's money, total customers
   served, Perk spent or held, and days remaining.
6. **GM** checks the end condition: if this was round *Days*, the game is
   over — go to Scoring & End State. Otherwise begin the next round.
```

### Resolution

*Required. Position 2. Heading: `## Resolution`.*

**Purpose:** how chance and modifiers turn declarations into outcomes. This is the section that must leave **zero unanswered mechanics questions** — it is where games hide their unwritten rules, so the format interrogates it hardest. (These same questions seed the `author` skill's interrogation mode.)

**Required content** — an explicit answer to every one of these questions. If a question doesn't apply, the section says so and why; explicit "not applicable" beats silence, because silence is indistinguishable from an unwritten rule:

1. **Randomizer operation.** What is rolled/drawn, when, and by whom?
2. **Modifiers.** What modifier sources exist, and in exactly what order do they stack or apply?
3. **Bounds.** Are results clamped to a minimum or maximum?
4. **Ties.** How are tied results between players resolved? (Final-standings ties belong to Scoring & End State; ties during play belong here.)
5. **Simultaneity.** What resolves simultaneously versus sequentially? Can one player's result affect another's?

**Conventions:**

- Language stays consistent with the declared randomizer — a card game writes "draw", not "roll".
- Effects defined in a content table (abilities, perks, gear) are applied "as the table entry states"; this section defines *when and how* such effects enter the computation, without restating them.

**Example:**

```markdown
## Resolution

- **Randomizer:** one d6, rolled once per player per round, in step 3 of the
  round. Each player rolls their own d6 (a single shared die passed in seat
  order is fine).
- **Customers served** = roll + weather modifier + location modifier + price
  modifier, with a minimum of 0. There is no upper bound.
- **Stacking:** all modifiers are additive. Apply them in this order: weather
  (Weather table), then location (Locations table), then price (0 for regular;
  *Premium Penalty* for premium). With addition the order never changes the
  result; it is fixed so totals are always read out the same way.
- **Perks:** a declared Perk applies exactly as its card's **Effect:** field
  says, at the moment its **When:** field names. If a Perk changes a roll or
  a modifier, recompute customers served with the changed value.
- **Ties:** not applicable during play — players' rolls are never compared
  against each other. Final-score ties are settled in Scoring & End State.
- **Simultaneity:** all players' sales resolve simultaneously; no player's
  declaration, roll, or earnings affects another's. Any number of players may
  share a location.
```

### Scoring & End State

*Required. Position 3. Heading: `## Scoring & End State`.*

**Purpose:** when the game ends and who wins — checkable mechanically at the end of every round.

**Required content:**

- **End condition:** when the game is over, testable at the end-of-game check in Core Procedure.
- **Score:** how each player's final score is computed.
- **Winner:** how the winner is determined from scores.
- **Ties:** an ordered list of tie-breakers ending in a deterministic terminal rule (e.g. "tied players share the win") — the list may not run out.
- **Standings:** what the final read-out looks like.

**Conventions:**

- Bold-label bullets (as in the example) keep the five answers individually findable.
- Values referenced by parameter or table name, as everywhere.

**Example:**

```markdown
## Scoring & End State

- **End:** the game ends at the end of round *Days*.
- **Score:** each player's score is their total money earned.
- **Winner:** the highest score wins.
- **Ties:** break ties in order: (1) most total customers served across the
  game; (2) if still tied, the tied players share the win.
- **Standings:** the GM reads out the final score sheet, highest score first.
```

### Parameters

*Required. Position 4. Heading: `## Parameters`.*

**Purpose:** every tunable scalar rule value, named, in one table. This is the rulebook's at-a-glance tuning panel for designers, and the contract that makes `playtest` parameter sweeps mechanical ("rerun it 50 times with *Days* at 4/5/6").

**Required content:**

- Exactly one GFM table with the exact column headers `Parameter | Default | Meaning`.
- Every scalar value a designer might tune — durations, prices, thresholds, penalties — appears here, and **only** here. A rule constant buried in prose is a defect.

**Conventions:**

- Parameter names are Title Case and unique; prose elsewhere references them by name, conventionally in italics (`*Days*`).
- Defaults carry their units (`$1`, `2 hr`) or are dimensionless counts.
- Per-row content values (a location's modifier, an event's effect) are **not** parameters — they live in content tables. Parameters are the named scalars the rules text leans on.

**Example:**

```markdown
## Parameters

| Parameter | Default | Meaning |
| --- | --- | --- |
| Days | 5 | Rounds (days) in one game |
| Regular Price | $1 | Earnings per customer served at regular price |
| Premium Price | $2 | Earnings per customer served at premium price |
| Premium Penalty | -2 | Customer-roll modifier when charging premium |
```

### Content Tables

*Required. Position 5. Heading: `## Content Tables`.*

**Purpose:** the game's bulk content — locations, stages, events, character options, abilities, gear — in a form that prints cleanly and reads unambiguously.

**Required content:**

- Every content unit — a table or a collection — sits under its own H3 inside this section, named for the one concept it holds.
- **One concept per unit.** Locations and perks never share a table or a collection.
- Each table is introduced by a sentence (or two) defining what each column means — column semantics are never left to inference. (Inside a collection, the intro defines the semantics once for every card.)

**Tables or collections.** A concept whose instances are homogeneous rows belongs in a table. A concept whose instances each carry *structure* — identity fields, their own small table, labeled prose entries like abilities — belongs in a **collection**: the H3 introduces the set and declares its card schema, then one H4 per **card**. Cards are how a player's "character sheet" lives inside the one document: each card reads, and prints, as a self-contained unit.

**Collection rules:**

- The collection's intro contains a normative `**Card schema:**` line naming each card's required parts, in order. Every card follows it exactly.
- Each card is an H4 named for its instance. H4 headings appear in the document only as cards inside collections.
- A card may contain bold-label fields, at most one table, and labeled prose entries — per its schema.
- Prose elsewhere refers to the collection by its H3 name and to cards by name ("the Perks collection", "the Megaphone Perk").
- Cards are content, like rows: they may be added, removed, or rebalanced without touching the rules text.

**Table conventions:**

- **Roll tables** (tables a randomizer selects rows from) put the selector in the first column, labeled `Roll` (or `Draw` for cards), covering the declared randomizer's full range with no gaps and no overlaps. Ranges are written `low–high` (en dash preferred, hyphen accepted).
- **Modifier columns** are labeled `Modifier` and every value carries an explicit sign (`+1`, `-2`); only `0` may be unsigned. Conditional modifiers spell out their condition in the cell.
- Prose elsewhere refers to tables by their H3 names ("the Weather table").
- Rows are content, so unlike parameters they may be added, removed, or rebalanced without touching the rules text.

**Example** (a table, then a collection):

```markdown
### Weather

Each row is one kind of day. *Roll* is used by the *Tomorrow's Forecast*
fallback; *Weather* names the day; *Modifier* applies to every player's
customer roll that day.

| Roll | Weather | Modifier |
| --- | --- | --- |
| 1 | Storm | -4 |
| 2 | Rain | -2 |
| 3 | Cloudy | 0 |
| 4–5 | Sunny | +1 |
| 6 | Hot | +2 |
```

```markdown
### Perks

Each card is one Perk. Each player picks one at setup; each Perk is usable
once per game.

**Card schema:** `**When:**` (when to declare it); `**Effect:**` (what it
does).

#### Megaphone

**When:** With your declarations
**Effect:** +2 to today's roll
```

### External Data Hooks

*Optional. Position 6. Heading: `## External Data Hooks`.*

**Purpose:** declared real-world inputs that make play vary with reality — the rally that plays differently in January than July. Every hook degrades gracefully: a paper table, or an agent without network access, uses the fallback with zero rule changes.

**Required content** — one H3 per hook, named for the hook, containing exactly these bold-label fields:

- `**Source:**` — what real-world data, and where it comes from.
- `**Interpretation:**` — how raw data maps to game terms, deterministically enough that two GMs reading the same forecast reach the same row.
- `**Fallback:**` — the offline procedure. The fallback **must** resolve via a content table operable with the game's declared randomizer (roll-on-this-table), so paper tables remain first-class.

**Conventions:**

- The hook declares *what and how*; **when** a hook fires is owned by the Core Procedure step that references it by name.
- A hook's game-term vocabulary must match the content table that backs it — the fallback table doubles as the interpretation's target categories.

**Example:**

```markdown
## External Data Hooks

### Tomorrow's Forecast

- **Source:** a real weather forecast for the table's agreed home town, looked
  up for the current calendar date plus the round number (round 1 uses
  tomorrow's forecast).
- **Interpretation:** map the forecast to the closest *Weather* row of the
  Weather table (e.g. "partly cloudy" → Cloudy; any thunderstorm or severe
  warning → Storm). When two rows fit, pick the one whose modifier is closer
  to 0.
- **Fallback:** roll 1d6 on the Weather table.
```

### Turn Report

*Required. Position 7. Heading: `## Turn Report`.*

**Purpose:** the game's one-line declaration grammar — how a human action at a physical table is transcribed for the GM in a few typed words. This is what gets printed on a per-game reference card.

**Required content:**

- **One template line** in inline code, using `<angle brackets>` for placeholders, `[square brackets]` for optional parts, and literal text as-is.
- **At least two normative examples**: one minimal (no optional parts) and enough others to exercise every optional part at least once. Every example must conform to the template exactly — a non-conforming example is a format defect.

**Conventions:**

- **Budget:** a report line must stay under roughly a dozen words per player per round. A game whose legal actions can't be expressed within the budget has a defective turn report format — the fix belongs in the game, not in the person typing.
- The grammar must be able to express **every legal player action** in a round, including reactive ones (rerolls, interrupts).
- The protocol *around* these lines — who types, when, what the GM echoes back — is engine behavior, not the game's contract, and will be refined as mixed-table play is built. The game owns only the line format.

**Example:**

```markdown
## Turn Report

One line per player, typed by the scribe:

`<name>: <location>, <regular|premium>[, <perk>], rolled <n>[ then <m>]`

(`then <m>` reports a Loyal Customers reroll: the first roll, then the kept
reroll.)

Examples:

- `Ana: Park, regular, rolled 5`
- `Ben: Beach, premium, Megaphone, rolled 2`
- `Cy: School Gate, regular, Loyal Customers, rolled 1 then 4`
```

### GM Guidance

*Required. Position 8. Heading: `## GM Guidance`.*

**Purpose:** judgment calls, pacing, and what to do when rules collide or run out. The loosest section by design — but its two anchors are required, because "GM's call" without a default ruling principle is one more unwritten rule.

**Required content:**

- A **default ruling principle** for situations the rules don't cover.
- **Pacing guidance** — at minimum, the narration budget and what to do when a player stalls.

**Conventions:**

- Bullets, short and imperative.
- Game-specific judgment calls (known ambiguities, table disputes the designer anticipates) go here.
- Guidance may point at other sections' rules but never overrides them.

**Example:**

```markdown
## GM Guidance

- One sentence of flavor per announcement at most; read every number in full.
- Weather disputes: the Interpretation rule of *Tomorrow's Forecast* decides —
  never relitigate the sky.
- If a player stalls on declarations, offer the safe default: Park, regular,
  no Perk.
- For anything these rules don't cover, make the cheapest ruling that keeps
  the day moving, say it out loud, and note it for the game's author.
```

## Validation Checklist

A conforming `GAME.md` passes every item. Each item restates exactly one normative rule from this spec; the list is the seed of the `author` skill's mechanical validation.

### Document

- [ ] Pure GFM Markdown: no YAML frontmatter, no HTML comments, no hidden annotations.
- [ ] The H1 is the game's name and the first line of the document.
- [ ] The title block sits between the H1 and the first H2.
- [ ] Every required section is present, with its heading spelled exactly as the canonical vocabulary defines.
- [ ] Sections appear in canonical order; the optional section, if present, occupies its slot.
- [ ] Extension H2 sections, if any, appear only after `## GM Guidance` and contain nothing required for play.
- [ ] No rule value appears in more than one place; prose references parameters and tables by name.
- [ ] No text assumes a randomizer the title block didn't declare.
- [ ] All tables are GFM pipe tables.

### Title Block

- [ ] `**Players:**`, `**Time:**`, and `**Randomizer:**` fields are present in bold-label form.
- [ ] A pitch of one to three sentences follows the fields.

### Core Procedure

- [ ] Contains `### Setup` and `### Round`, each a numbered list.
- [ ] `### Round` opens by stating what one round represents.
- [ ] Every step names its actor in bold.
- [ ] Each step's inputs and outputs are identifiable from its text.
- [ ] The round contains an explicit end-of-game check referencing Scoring & End State.

### Resolution

- [ ] States what is rolled/drawn, when, and by whom.
- [ ] Lists every modifier source and an explicit stacking order.
- [ ] States bounds on results, or explicitly that there are none.
- [ ] Answers tie handling during play, or explicitly marks it not applicable with a reason.
- [ ] Answers what resolves simultaneously versus sequentially, and whether one player's result can affect another's.

### Scoring & End State

- [ ] End condition is stated and checkable at the round's end-of-game check.
- [ ] Score computation is defined.
- [ ] Winner determination is defined.
- [ ] Tie-breakers are an ordered list ending in a deterministic terminal rule.
- [ ] The final standings read-out is described.

### Parameters

- [ ] Exactly one table with the exact column headers `Parameter | Default | Meaning`.
- [ ] Parameter names are Title Case and unique.
- [ ] Every scalar tunable in the rules appears in the table; no rule constant is buried in prose.
- [ ] Defaults carry units where applicable.

### Content Tables

- [ ] Every content unit (table or collection) sits under its own H3 inside `## Content Tables`.
- [ ] One concept per table or collection.
- [ ] Each table is introduced by a sentence defining its column semantics (a collection's intro covers its cards' tables).
- [ ] Roll-table selector columns cover the declared randomizer's full range with no gaps or overlaps.
- [ ] Modifier values carry explicit signs (only `0` may be unsigned).
- [ ] Every collection's intro contains a `**Card schema:**` line naming each card's required parts in order.
- [ ] Every card is an H4 inside a collection and follows its collection's schema exactly.
- [ ] H4 headings appear only as cards inside collections.

### External Data Hooks (if present)

- [ ] Each hook is its own H3 with `**Source:**`, `**Interpretation:**`, and `**Fallback:**` fields.
- [ ] Each fallback resolves via a content table operable with the declared randomizer.
- [ ] Each hook is referenced by name from at least one Core Procedure step.

### Turn Report

- [ ] Gives exactly one template line using `<placeholders>` and `[optionals]`.
- [ ] At least two examples, including one minimal; every optional part is exercised by some example.
- [ ] Every example conforms to the template.
- [ ] Every example is under roughly a dozen words.
- [ ] The grammar can express every legal player action in a round.

### GM Guidance

- [ ] Includes a default ruling principle for uncovered situations.
- [ ] Includes pacing guidance.

## Appendix A: Worked Example — Lemonade Stand

The complete assembled `GAME.md` that every example above excerpts. It passes the Validation Checklist and is the recommended starting template when drafting a new game. It is an illustration, not part of the format.

```markdown
# Lemonade Stand

**Players:** 2–6
**Time:** about 20 minutes
**Randomizer:** one d6 (a single shared die is fine)
**Materials:** pencil and paper for the score sheet

You and your rivals run lemonade stands for one summer week. Each day, pick
your spot, set your price, and pray for sun: weather, location, and ambition
decide how many customers show up. Most money when the week ends wins.

## Core Procedure

### Setup

1. **GM** draws a score sheet: one row per player, with columns for money
   (starting at $0), total customers served (starting at 0), and Perk.
2. **Each player**, in seat order, picks one Perk from the Perks collection
   and records it. More than one player may pick the same Perk.
3. **Table** agrees on a home town if using the *Tomorrow's Forecast* hook;
   otherwise skip this step.

### Round

**A round is** one day of business. The game lasts *Days* rounds.

1. **GM** announces today's weather — resolved via the *Tomorrow's Forecast*
   hook, or by its fallback — and the matching modifier from the Weather table.
2. **Each player**, in seat order, declares a location from the Locations
   table, a price (regular or premium), and optionally one unused Perk.
3. **Each player** rolls 1d6 and computes customers served (see Resolution).
4. **GM** records each player's customers served and earnings — customers
   served × *Regular Price* or *Premium Price* — on the score sheet.
5. **GM** restates the full score sheet: each player's money, total customers
   served, Perk spent or held, and days remaining.
6. **GM** checks the end condition: if this was round *Days*, the game is
   over — go to Scoring & End State. Otherwise begin the next round.

## Resolution

- **Randomizer:** one d6, rolled once per player per round, in step 3 of the
  round. Each player rolls their own d6 (a single shared die passed in seat
  order is fine).
- **Customers served** = roll + weather modifier + location modifier + price
  modifier, with a minimum of 0. There is no upper bound.
- **Stacking:** all modifiers are additive. Apply them in this order: weather
  (Weather table), then location (Locations table), then price (0 for regular;
  *Premium Penalty* for premium). With addition the order never changes the
  result; it is fixed so totals are always read out the same way.
- **Perks:** a declared Perk applies exactly as its card's **Effect:** field
  says, at the moment its **When:** field names. If a Perk changes a roll or
  a modifier, recompute customers served with the changed value.
- **Ties:** not applicable during play — players' rolls are never compared
  against each other. Final-score ties are settled in Scoring & End State.
- **Simultaneity:** all players' sales resolve simultaneously; no player's
  declaration, roll, or earnings affects another's. Any number of players may
  share a location.

## Scoring & End State

- **End:** the game ends at the end of round *Days*.
- **Score:** each player's score is their total money earned.
- **Winner:** the highest score wins.
- **Ties:** break ties in order: (1) most total customers served across the
  game; (2) if still tied, the tied players share the win.
- **Standings:** the GM reads out the final score sheet, highest score first.

## Parameters

| Parameter | Default | Meaning |
| --- | --- | --- |
| Days | 5 | Rounds (days) in one game |
| Regular Price | $1 | Earnings per customer served at regular price |
| Premium Price | $2 | Earnings per customer served at premium price |
| Premium Penalty | -2 | Customer-roll modifier when charging premium |

## Content Tables

### Locations

Each row is one location a player may declare in step 2 of a round.
*Modifier* applies to that player's customer roll; *Notes* is flavor.

| Location | Modifier | Notes |
| --- | --- | --- |
| Park | +1 | Reliable foot traffic |
| School Gate | 0 | Steady but slow |
| Beach | +2 on Sunny or Hot days, -2 otherwise | Weather-dependent crowd |

### Weather

Each row is one kind of day. *Roll* is used by the *Tomorrow's Forecast*
fallback; *Weather* names the day; *Modifier* applies to every player's
customer roll that day.

| Roll | Weather | Modifier |
| --- | --- | --- |
| 1 | Storm | -4 |
| 2 | Rain | -2 |
| 3 | Cloudy | 0 |
| 4–5 | Sunny | +1 |
| 6 | Hot | +2 |

### Perks

Each card is one Perk. Each player picks one at setup; each Perk is usable
once per game.

**Card schema:** `**When:**` (when to declare it); `**Effect:**` (what it
does).

#### Megaphone

**When:** With your declarations
**Effect:** +2 to today's roll

#### Loyal Customers

**When:** After seeing your roll
**Effect:** Reroll; keep the new result

#### Ice Machine

**When:** With your declarations
**Effect:** Today's weather modifier is 0 for you

## External Data Hooks

### Tomorrow's Forecast

- **Source:** a real weather forecast for the table's agreed home town, looked
  up for the current calendar date plus the round number (round 1 uses
  tomorrow's forecast).
- **Interpretation:** map the forecast to the closest *Weather* row of the
  Weather table (e.g. "partly cloudy" → Cloudy; any thunderstorm or severe
  warning → Storm). When two rows fit, pick the one whose modifier is closer
  to 0.
- **Fallback:** roll 1d6 on the Weather table.

## Turn Report

One line per player, typed by the scribe:

`<name>: <location>, <regular|premium>[, <perk>], rolled <n>[ then <m>]`

(`then <m>` reports a Loyal Customers reroll: the first roll, then the kept
reroll.)

Examples:

- `Ana: Park, regular, rolled 5`
- `Ben: Beach, premium, Megaphone, rolled 2`
- `Cy: School Gate, regular, Loyal Customers, rolled 1 then 4`

## GM Guidance

- One sentence of flavor per announcement at most; read every number in full.
- Weather disputes: the Interpretation rule of *Tomorrow's Forecast* decides —
  never relitigate the sky.
- If a player stalls on declarations, offer the safe default: Park, regular,
  no Perk.
- For anything these rules don't cover, make the cheapest ruling that keeps
  the day moving, say it out loud, and note it for the game's author.
```
