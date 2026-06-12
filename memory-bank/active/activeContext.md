# Active Context

## Current Task: m3-dice-roller-script
**Phase:** BUILD - COMPLETE (PASS)

## What Was Done

- Built the seedable dice roller via shell TDD (all 7 plan steps), tests-first
- 15-test shunit2 suite: red against stubs → green after implementation
- Green under both `sh` and `dash`; `shellcheck -s sh` clean on all four files
- Documentation updated alongside code (techContext, systemPatterns, README)

## Files Created / Modified

- `skills/gm/scripts/roll.sh` (new) — the roller
- `skills/gm/scripts/tests/common.sh` (new) — `source_script` helper
- `skills/gm/scripts/tests/run.sh` (new) — aggregate runner
- `skills/gm/scripts/tests/unit/roll_test.sh` (new) — 15-test suite
- `skills/gm/scripts/tests/vendor/shunit2` (new) — vendored framework (v2.1.8)
- `memory-bank/techContext.md` — Testing Process: shunit2 vendored, run instructions
- `memory-bank/systemPatterns.md` — Script-rolled dice pattern + status note updated
- `README.md` — layout tree (`gm/scripts/roll.sh`) + Status line

## Key Implementation Decisions

- `face = (cksum("<seed>:<label>:<sides>") % sides) + 1`; double-mod keeps the
  result in [1,sides] even under hypothetical narrow/signed integer shells
- Pinned values locked by tests: `hash_to_int("lock-test") = 1159130431`;
  `(42,unit,6) → 5`. Distribution test asserts all faces over labels 1..60 (cover
  is reached by label 9 — wide margin, fully deterministic, never flaky)
- `set -eu` deliberately NOT global (sourcing-safe per shell-tdd); errors handled
  explicitly so malformed CLI yields friendly messages, not unbound-var aborts
- Unseeded mode: `/dev/urandom` (4 bytes via `od`) with a clock/PID fallback that
  still reports a replayable seed

## Deviations from Plan

- None functionally. Lint cleanup during step 6: dropped the `CDPATH=` cd-prefix
  (SC1007) and replaced one `expr` with `$(( ))` (SC2003) in test scaffolding.
- Observation (not a deviation): file execute bits aren't tracked (Windows-mounted
  drive); scripts run via `sh`/shebang. Noted in techContext.

## Next Step

- QA review (runs automatically next per the L2 workflow)
