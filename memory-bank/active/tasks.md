# Task: m4-gm-skill

* Task ID: m4-gm-skill
* Complexity: Level 3
* Type: feature (engine skill, primarily prose deliverable)

Build the `gm` skill — the engine's referee. Reads any conforming `GAME.md`, owns session
state, announces conditions, applies mechanics, restates the state table after every
recomputation, distills per-seat turn briefs, resolves external data hooks (with offline
fallback), rolls via `scripts/roll.sh`, and journals the session transcript where disk
exists. Validated by a human playing all seats of Cannonball Rally; that session is
recorded as a golden transcript fixture for later milestones.

## Component Analysis (draft — plan in progress)

### Affected Components

- `skills/gm/SKILL.md` (new): the skill itself — activation pitch + lean session workflow, pointing into references
- `skills/gm/references/` (new): detailed GM procedure (setup, turn loop, mechanics application, state table, turn briefs, hook resolution) and the transcript journal format
- `skills/gm/scripts/roll.sh` (exists): consumed as-is; its stderr log grammar is the seed of the journal record
- Golden transcript fixture (new, location TBD by open question): recorded human-played Cannonball Rally session
- `README.md`: gm status updates (engine table, repo layout, Status)
- `memory-bank/systemPatterns.md`: status-note reconciliation once gm is real

### Cross-Module Dependencies

- gm consumes the GAME.md format spec (M1) — every required section maps to a GM behavior
- gm runs Cannonball Rally (M2) — the validation game
- gm invokes `roll.sh` (M3) — dice + pinned log grammar
- M6 (`table`) and M7 (`playtest`) will consume gm's outputs; the journal/transcript format is their contract

### Boundary Changes

- New public contract: the transcript journal record format (extends the roll log grammar)
- New skill directory completing the half-skill `skills/gm/`

## Open Questions

- [x] **Transcript journal & golden transcript format** → Resolved: structured Markdown
  transcript — normative skeleton (H1 session header; one H2 per round with announcement,
  declarations in the game's Turn Report grammar, verbatim `roll.sh` log lines, per-seat
  resolution arithmetic, restated GFM state table; final `## Standings`), reusing the three
  already-pinned grammars as parse anchors; golden fixture at
  `tests/fixtures/transcripts/cannonball-rally-golden.md`
  (see `memory-bank/active/creative/creative-transcript-journal-format.md`)

## Status

- [ ] Component analysis complete
- [ ] Open questions resolved
- [ ] Test planning complete (TDD)
- [ ] Implementation plan complete
- [ ] Technology validation complete
- [ ] Preflight
- [ ] Build
- [ ] QA
