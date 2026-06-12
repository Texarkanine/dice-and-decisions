# Task: Seedable dice-roller script

* Task ID: m3-dice-roller-script
* Complexity: Level 2
* Type: Simple enhancement (first executable deliverable)

Build the engine's randomness primitive: a small, seedable dice-roller script with
real RNG, per-roll context logging, and reproducible-by-seed output, developed with
full shell TDD (shunit2). This is the roll source mandated by L4 invariant 4 (models
never roll dice) and the dice contract that the `gm` skill (M4) will consume.

## Key Design Decisions

- **Location:** `skills/gm/scripts/roll.sh`. The roller is the engine randomness
  primitive owned by `gm` (its first consumer, M4) per `systemPatterns.md` ("the
  engine bundles a tiny roller in `scripts/`"). M3 establishes `skills/gm/scripts/`
  with the roller + tests only; M4 adds `gm/SKILL.md` and the rest. ⚑ *Consequence:*
  `skills/gm/` exists with no `SKILL.md` during the M3→M4 window — harmless (not yet
  an activatable skill), flagged for operator awareness.
- **Language:** POSIX `sh` (`#!/bin/sh`), governed by `shell-posix-style.mdc`, for
  maximum harness portability (invariant 2: validated in Claude Code; disk-free
  sandboxes). shunit2 is POSIX-compatible.
- **Reproducibility contract — the central design:** a roll is a *pure deterministic
  function of `(seed, label, sides)`*: `face = (cksum("<seed>:<label>:<sides>") %
  sides) + 1`. The per-roll **label** is simultaneously (a) the context that gets
  logged and (b) the nonce that makes the roll reproducible. Same seed + same labels
  → same rolls, with **no counter/disk state** — honoring the disk-free baseline and
  conversation-as-working-memory pattern. This unifies "per-roll context logging" and
  "reproducible seeds" into one mechanism. Labels must be unique per roll within a
  session (the GM's naming convention: stage/actor/purpose).
- **Seed handling:** `--seed` is optional. When omitted, a seed is drawn from
  `/dev/urandom` (real entropy) and reported in the log, so any unseeded session is
  replayable by re-supplying its reported seed.
- **"Real RNG" reconciliation:** entropy for unseeded sessions comes from
  `/dev/urandom`; given a seed, the roller is a deterministic PRNG (which *is* the
  reproducibility requirement). The model never improvises — the script computes.
- **Hash choice:** `cksum` (POSIX, always present, deterministic 32-bit CRC). Modulo
  bias into small dice (d2–d100) is negligible; documented, not rejection-sampled.

## Interface

```
roll.sh --label TEXT [--seed SEED] [--sides N] [--count N]
```

- `--label TEXT` — **required**; the per-roll context (also the reproducibility nonce)
- `--seed SEED` — optional; if omitted, generated from `/dev/urandom` and logged
- `--sides N` — optional, default `6`; positive integer
- `--count N` — optional, default `1`; positive integer (for `NdS`; internal label
  is salted per die as `<label>#<i>`)
- **stdout:** face value(s), space-separated, single line (clean for capture)
- **stderr:** one structured log line per roll, in an **exact, stable `key=value`
  grammar** (a deliberate contract — the seed of M4's transcript-journal record):
  `roll seed=<seed> label=<label> die=d<sides> => <result>`

## Test Plan (TDD)

### Behaviors to Verify

- Determinism: `roll_die <seed> <label> <sides>` called twice → identical result
- Range: result ∈ [1, sides] for sides ∈ {2, 6, 20, 100}
- Label independence: two distinct labels (same seed/sides) can differ (sanity)
- Seed independence: two distinct seeds (same label/sides) can differ (sanity)
- `hash_to_int` lock: known string → known fixed integer (pins the algorithm)
- Seed reporting + replay: with `--seed` omitted, a seed is generated and appears in
  the log; re-running with that reported seed reproduces the stdout result
- Distribution sanity (deterministic, not random): with a fixed seed and labels
  `1..N`, every face `1..sides` appears at least once for a tuned N (no flakiness —
  the sequence is fully determined by the fixed seed)
- CLI happy path: `--seed S --sides 6 --label X` → single integer 1–6 on stdout; log
  line on stderr matches the **exact grammar** `roll seed=S label=X die=d6 => <result>`
  (pins the log format as an M4-facing contract, not just a "contains" check)
- Count: `--count 3` → three in-range values on stdout, deterministic per (seed,label)
- Entry-point protection: sourcing `roll.sh` produces no output / does not run main
- Validation (each → nonzero exit, stderr message, no stdout result):
  `--sides 0`, `--sides -1`, `--sides abc`, `--count 0`, missing `--label`

### Test Infrastructure

- Framework: **shunit2 v2.1.8**, vendored at `skills/gm/scripts/tests/vendor/shunit2`
  (not installed system-wide; fetch validated — fetches and runs clean)
- Test location: `skills/gm/scripts/tests/`
- Conventions (per `shell-tdd.mdc`): functions are sourced (entry-point protected),
  return codes not `exit`, parameterized I/O, `common.sh` helper sources the script
  under test, every test ends `return 0`
- Layout / new files:
  - `skills/gm/scripts/tests/common.sh` — `source_script` helper
  - `skills/gm/scripts/tests/vendor/shunit2` — vendored framework
  - `skills/gm/scripts/tests/unit/roll_test.sh` — the suite
  - `skills/gm/scripts/tests/run.sh` — runs all unit suites

## Implementation Plan

1. **Vendor shunit2 + scaffold tests.**
   - Files: `skills/gm/scripts/tests/vendor/shunit2`, `tests/common.sh`, `tests/run.sh`
   - Changes: download shunit2 v2.1.8; `common.sh` provides `source_script`; `run.sh`
     iterates `tests/unit/*_test.sh`.
2. **Stub `roll.sh` interface + stub the test suite (no impl).**
   - Files: `skills/gm/scripts/roll.sh`, `tests/unit/roll_test.sh`
   - Changes: POSIX header + documented empty function signatures (`hash_to_int`,
     `roll_die`, `generate_seed`, `validate_positive_int`, `log_roll`, `main`) with
     entry-point guard; empty test cases for every behavior above.
3. **Implement test bodies; run → all fail (red).**
   - Files: `tests/unit/roll_test.sh`
   - Changes: fill assertions; confirm they fail against the stubs.
4. **Implement `hash_to_int` + `roll_die`; make determinism/range/lock tests pass.**
   - Files: `skills/gm/scripts/roll.sh`
   - Changes: `cksum`-based hash → `(n % sides) + 1`.
5. **Implement `validate_positive_int`, `generate_seed`, `log_roll`, `main` (arg
   parse, count loop with per-die label salt, seed default-from-urandom + report);
   make CLI/validation/seed-replay/count tests pass.**
   - Files: `skills/gm/scripts/roll.sh`
6. **Refactor + lint; tune distribution-sanity N; full suite green; shellcheck clean.**
   - Files: all of the above
   - Changes: `shellcheck -s sh roll.sh`; final `tests/run.sh` green.
7. **Documentation.**
   - Files: `memory-bank/techContext.md` (Testing Process: shunit2 vendored, how to
     run `tests/run.sh`), `memory-bank/systemPatterns.md` (Script-rolled dice pattern:
     roller now real at `skills/gm/scripts/roll.sh`, (seed,label,sides) contract, and
     the stderr log line documented as the seed of M4's transcript-journal record),
     `README.md` (Repo layout tree: add `gm/scripts/roll.sh`; Status line: dice roller
     done, next is the `gm` skill)

## Technology Validation

- shunit2 v2.1.8 — not installed; **vendored**. PoC: fetched from
  `raw.githubusercontent.com/kward/shunit2/v2.1.8/shunit2` and ran a trivial test
  (`Ran 1 test. OK`, exit 0). ✅
- `cksum` deterministic int confirmed (`"7:stage3-police-Dana:6"` → `2729685472`). ✅
- `/dev/urandom` readable; `od` available for byte→int. ✅
- `shellcheck` available (`/usr/bin/shellcheck`) for static analysis. ✅

## Dependencies

- POSIX `sh`, `cksum`, `od`, `/dev/urandom` (runtime — all present)
- shunit2 (test-only, vendored), `shellcheck` (dev-only)
- Upstream: M1 (format spec) + M2 (rally) complete; M4 (gm) consumes this roller

## Challenges & Mitigations

- **shunit2 absent:** vendor v2.1.8 in-repo (validated). Mitigated.
- **cksum modulo bias:** negligible for small dice; documented, not rejection-sampled.
- **Distribution test flakiness:** none — tests are seed-deterministic; tune N so all
  faces appear and the result is permanently fixed.
- **POSIX vs bash conveniences:** write strict POSIX `sh`; lint `shellcheck -s sh`.
- **`/dev/urandom` missing in some sandbox:** affects only unseeded mode; fall back to
  a `date`/`$$`-derived seed with a stderr warning, still reported for replay.
- **`skills/gm/` half-skill window:** documented decision; M4 completes the skill.

## Preflight Amendments (2026-06-12)

- **[convention, low — applied]** Renamed `roll.bash` → `roll.sh`: the script is POSIX
  `sh` (`#!/bin/sh`), so the `.bash` extension and a bash entry-point guard were
  inconsistent. `roll.sh` matches the POSIX choice, the shell-tdd examples, and the
  POSIX entry-point idiom `[ "${0##*/}" = "roll.sh" ]`.
- **[completeness, low — applied]** Made the `README.md` update concrete: add
  `gm/scripts/roll.sh` to the Repo layout tree and advance the Status line (the README
  already advertises the bundled roller and tracks per-skill status).
- **[advisory — applied, within L2/scope]** Elevated the stderr log line to an exact,
  pinned `key=value` grammar and a format-matching test, and documented it as the seed
  of M4's transcript-journal record. The log is the roller's second interface (after
  stdout); pinning it now makes M4's parser a contract, not a guess.
- **[dependency, informational — carried]** `skills/gm/` exists without a `SKILL.md`
  during the M3→M4 window; harmless, completed by M4. No action.

## Status

- [x] Initialization complete
- [x] Test planning complete (TDD)
- [x] Implementation plan complete
- [x] Technology validation complete
- [x] Preflight
- [x] Build
- [x] QA
