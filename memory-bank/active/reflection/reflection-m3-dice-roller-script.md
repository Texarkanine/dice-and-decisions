---
task_id: m3-dice-roller-script
date: 2026-06-12
complexity_level: 2
---

# Reflection: Seedable dice-roller script

## Summary

Built `skills/gm/scripts/roll.sh`, the engine's randomness primitive — a POSIX-sh
roller where each roll is a pure deterministic function of `(seed, label, sides)` —
with a 15-test shunit2 suite, fully TDD. Succeeded cleanly: green under `sh` and
`dash`, shellcheck-clean, QA found no defects.

## Requirements vs Outcome

All four milestone requirements delivered with no gaps: seedable (`--seed`, or a
reported `/dev/urandom` draw), real RNG, per-roll context logging (the stderr
grammar), and reproducibility (pure function of the seed). One unplanned addition:
`--help` — a trivial usage affordance, accepted at QA as a deliberate, minimal
feature rather than scope creep.

## Plan Accuracy

The plan was accurate end to end — file list, the 7-step TDD sequence, and the
named challenges all matched reality. The two consequential design calls (label =
nonce; `cksum` PRNG) were made at plan time and held without revision. Preflight
earned its keep: it caught the `roll.bash`→`roll.sh` naming mismatch (POSIX script
with a bash extension) and the README-update gap before any code was written, and
its advisory upgraded the log line from a loose "contains" check to a pinned
grammar — turning the journal format into a real M4 contract.

## Build & QA Observations

Build was smooth: red-against-stubs → green-after-implementation with no backtracking.
The only iteration was lint polish (an `expr`→`$(())` and dropping a `CDPATH=`
prefix). Validating under `dash` surfaced why the `shift 2 || shift` guard matters
(plain `shift 2` on a lone trailing flag aborts in dash). QA was clean — the build's
own discipline (function headers, single-sourced values, no debug artifacts) left
nothing to fix.

## Insights

### Technical
- Folding "context log" and "reproducibility nonce" into one field (the label) is
  what makes seedless-state replay possible — reproducibility without a filesystem.
  This is a reusable kernel: any future engine script that needs replayable RNG
  should take a caller-supplied context string as its nonce, not an internal counter.
- A pinned-hash test fixture is the right place for a hardcoded constant: it locks an
  external tool (`cksum`) against silent drift. Validate under `dash`, not just bash,
  for anything claiming POSIX.

### Process
- For a script that is a *contract* for a later milestone, preflight's "what's the
  smartest accretive change" prompt paid off concretely — pinning the log grammar now
  is cheaper than reverse-engineering it in M4.

### Million-Dollar Question
- The built solution is essentially the elegant one: had "models never roll, and
  every roll must replay without disk" been the founding axiom, you'd arrive at
  exactly `face = f(seed, context, sides)` with the context doubling as the log key.
  Nothing about the design would change if rebuilt from scratch.
