# Progress

L4 sub-run for milestone M3 of `lite-rpg-toolkit`: build the seedable dice-roller script — real RNG, per-roll context logging, reproducible seeds — developed with full shell TDD. This is the engine's randomness primitive (L4 invariant 4: models never roll dice; all randomness comes from this roller or physically-rolled, human-reported dice), and a dependency of the `gm` skill (M4).

**Complexity:** Level 2

## 2026-06-12 - COMPLEXITY-ANALYSIS - COMPLETE

* Work completed
    - Advanced L4 milestone list: M2 checked off, sub-run ephemeral state cleared and committed
    - Classified milestone M3 as Level 2 (Simple Enhancement)
* Decisions made
    - L2 rationale: a single self-contained shell script plus its test suite; no architecture decisions, no cross-component coupling. The design surface (seedable RNG, per-roll context logging, reproducible seeds) is contained and the milestone is explicitly self-contained.
* Insights
    - M3 is governed by the always-tdd + shell-tdd workspace rules — this is the toolkit's first executable deliverable, so it sets the shell-TDD precedent for every later script (playtest harness, etc.)
    - The roller is a contract consumed by M4 (`gm`): its output format (per-roll context log, reproducible-by-seed) is an interface other milestones will depend on, so the logging/seed format deserves deliberate design in the plan phase

## 2026-06-12 - PLAN (L2) - COMPLETE

* Work completed
    - Full L2 plan in `tasks.md`: interface, 12 testable behaviors, shunit2 test layout, 7-step TDD implementation plan, technology validation, dependencies, challenges
    - Technology validation: shunit2 v2.1.8 (not installed) fetched + smoke-tested (`Ran 1 test. OK`); `cksum` confirmed deterministic; `/dev/urandom`/`od`/`shellcheck` present
* Decisions made
    - Location `skills/gm/scripts/roll.bash` (engine primitive owned by gm/M4); creates `skills/gm/` without a SKILL.md until M4 (flagged, harmless)
    - POSIX `sh` for harness portability (`shell-posix-style.mdc`)
    - **Central contract:** roll = pure function of `(seed, label, sides)` via `cksum`; the per-roll label is BOTH the logged context AND the reproducibility nonce — reproducible with no disk/counter state (honors disk-free baseline + conversation-as-memory)
    - `--seed` optional; unseeded draws from `/dev/urandom` and reports the seed for replay
    - shunit2 vendored at `skills/gm/scripts/tests/vendor/shunit2`
* Insights
    - Folding "per-roll context logging" and "reproducible seeds" into one mechanism (the label = nonce) is the design's keystone — it's what lets reproducibility survive without a filesystem
    - This script sets the shell-TDD + vendored-shunit2 precedent for every later script (playtest, etc.)

## 2026-06-12 - PREFLIGHT (L2) - COMPLETE (PASS)

* Work completed
    - Validated plan vs. codebase: TDD encoding (tests stubbed + written red before any production code, per-unit ordering explicit — PASS), convention compliance, dependency impact, conflict detection (no existing roller; `skills/` holds only author + cannonball-rally), completeness (all 4 milestone requirements map to steps + tests)
    - Confirmed README already advertises the bundled roller and tracks per-skill layout/status — folded concrete README edits into build step 7
    - Wrote `.preflight-status`: PASS
* Decisions made
    - Amendment (convention): `roll.bash` → `roll.sh` — the script is POSIX `sh`, so a `.bash` extension + bash entry-point guard were inconsistent; `roll.sh` matches the POSIX idiom and shell-tdd examples
    - Amendment (advisory, applied within scope): pin the stderr log line to an exact `key=value` grammar with a format test, documented as the seed of M4's transcript-journal record — the log is the roller's second interface and deserves contract status
* Insights
    - The roller has two interfaces, not one: stdout (the face) and the stderr log (the journal record). Treating the log as a contract now is what makes M4's scribe/journal a parse, not a guess
    - `skills/gm/` will be a half-skill (no SKILL.md) until M4 — acceptable; flagged

