---
task_id: m5-player-skill
date: 2026-06-15
complexity_level: 2
---

# Reflection: M5 — player seat skill

## Summary

Built the `player` skill (`SKILL.md` + `decision-procedure.md` + `personas.md`): a stateless seat
that turns the gm's turn brief + visible state table + an assigned persona into one Turn Report
declaration plus one line of table talk, never refereeing and never rolling. It succeeded — QA PASS,
and three operator-run validation sessions showed persona-true, persona-divergent play.

## Requirements vs Outcome

Delivered every planned behavior (single declaration + table talk, brief/state consumption, a
five-posture persona roster, the post-roll reaction beat, never-roll, attribution, edge cases,
game-agnostic phrasing). One thing was *added* mid-task by operator decision: an explicit
**stateless / "fresh every turn"** contract, codified in `decision-procedure.md`. One thing could
not be *fully* delivered and was knowingly descoped: **B9 (no GM ventriloquism) as a structurally
enforced property** — it ships as a written, behaviorally-honored contract, but enforcement needs
the `table` skill (M6).

## Plan Accuracy

The plan's file list and step sequence held up exactly; no reordering or splitting was needed. The
plan's self-flagged risk — that a decision-making skill can't be meaningfully validated by
desk-checking its own prose — was precisely the one that materialized. The surprise was not
technical but conceptual: how much of "is the player good?" actually depends on the *unbuilt* `table`
(isolation, fresh invocation), which sharpened M6's job rather than revealing a plan defect.

## Build & QA Observations

Build was smooth; authoring mirrored the proven `gm` structure. The self-validation pass caught two
genericity leaks (`Cruiser` echoing the rally's "cruise"; "jail" as a downside example) and fixed
them — exactly the kind of engine/content coupling the genericity rule exists to catch. QA was clean:
one trivial line re-wrap, no substantive findings. The real friction was interpretive: a stripped
*journal* made a good persona run look like a collapse until the full *chat transcript* corrected it.

## Insights

### Technical
- The unit of exchange across gm/player/table is the game's **Turn Report line**, and the gm's
  **turn brief** is exactly the player's input — so the player needed *no new interface*, only
  discipline about staying inside what the brief offers. Interfaces that fall out of an existing
  protocol are the cheap ones.
- **Soft isolation has a hard ceiling for attribution.** With one model running gm + seats inline,
  output can be persona-true yet not independently sourced; B9 is unprovable without structural
  isolation. This is now M6's headline requirement, not a vague nicety.

### Process
- **Read the chat to judge voice/persona; read the journal to judge mechanics.** The journal strips
  table talk, so judging player behavior from it produces false negatives. Pick the artifact that
  actually contains the signal you're testing.
- A decision-making skill's correctness lives in *sessions*, not in the prose. For these, treat
  operator-run play sessions as the real test bed and desk-checking as a lint pass, not a proof.

### Million-Dollar Question
- If "the player is a stateless function of (brief, state, persona), invoked fresh each turn in
  isolation" had been a *founding* assumption, the most elegant shape is the one we converged on:
  a thin seat skill plus a `table` composition root that owns casting, persona assignment, and
  per-turn isolated invocation — with the gm only ever *called*. We built the seat correctly; the
  elegance that's still latent is the `table` enforcing the isolation the seat already assumes.
  M5 is the right half of that shape; M6 is the other half.
