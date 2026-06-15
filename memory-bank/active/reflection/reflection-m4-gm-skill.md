---
task_id: m4-gm-skill
date: 2026-06-15
complexity_level: 3
---

# Reflection: m4-gm-skill

## Summary

Built the `gm` engine skill — a lean `SKILL.md` router plus `references/session-procedure.md` and `references/journal-format.md` — that referees any conforming `GAME.md`. It succeeded: the documents are complete and generic, the regression gate stays green, and a 6-vehicle Cannonball Rally session was played end-to-end and accepted as the golden transcript.

## Requirements vs Outcome

Every in-scope requirement was delivered: the three gm documents, the journal contract (with a self-testing worked example), the genericity guarantee (B11), the documentation reconciliation (README, systemPatterns, cannonball-rally SKILL.md), and a golden fixture seating all six vehicles with a jail/DNF and a tied finish.

One behavior was descoped during build, by operator decision: **B9** (the journal is written to disk in journal-format skeleton form). No GM run actually journaled rounds to disk — every run kept the journal in chat and one even falsely signed off "Session log saved." Rather than force the behavior, the operator deferred it to a later milestone and accepted the golden as a chat conversion. The *format* is proven (the worked example replays exactly); the *disk-writing behavior* is not.

## Plan Accuracy

The 7-step plan held up structurally — authoring order (journal contract first, then procedure, then the lean SKILL.md) was correct, and sequencing the operator session as the final build step was right. The plan's one real miss was scale: step 6 was written as a single validation session but became **eight runs** (haiku1–7, then sonnet1), each Haiku run surfacing and fixing a distinct defect. That wasn't a planning error so much as the expected shape of prose-validation — the "test" is a played session, and like any test suite it found bugs one at a time. The challenge "session surfaces paper gaps" was anticipated; what wasn't fully anticipated was how many gm-*procedure* gaps (not just paper gaps) the runs would expose.

## Creative Phase Review

The single creative decision — Option C, structured Markdown transcript reusing the three already-pinned grammars (Turn Report line, `roll.sh` stderr line, GFM table) — held up cleanly. It translated directly into the journal-format skeleton with no friction, and the "one document, two audiences" rationale proved sound: the worked example is mechanically replayable because it reuses the roller's real output. No mega-unknown was mis-flagged.

## Build & QA Observations

Authoring went smoothly; the iteration cost was concentrated entirely in the validation runs. The recurring defect class was **the GM dropping effects that live outside the acting seat** — field-keyed modifiers (per-rider rolls, "Somethin's Up") and consequence-revoked benefits (a Suspect ability negated on pull-over). The fix was a procedural one: an explicit "Apply mechanics" cross-check beat that forces scanning the whole field and re-reading Resolution for revoked benefits before totaling. A second class was **the GM inventing scarcity the paper never wrote** (a fabricated "Gun It cooldown"), fixed upstream in the format spec with a "Usage cadence" default (silence = no limit).

QA was clean — no substantive findings. It confirmed completeness, genericity, integrity (replayed the seed-1209 example), and documentation reconciliation, and recorded B9 as the known, operator-accepted, non-blocking deferral.

## Cross-Phase Analysis

The causal chain worth recording: **planning correctly predicted that the build couldn't finish autonomously** (operator-in-the-loop validation), and that prediction shaped the build sequence so the human session came last — which is exactly why the eight-run iteration was absorbable instead of catastrophic. The creative decision to reuse pinned grammars is what let QA verify integrity mechanically (replay the example) rather than by inspection — a planning/creative choice that paid off two phases later.

The one unresolved tension traces back to the plan: prose-validation (a played session) is excellent at catching *mechanics-application* defects but structurally weak at enforcing *side-effect behaviors* like "write the journal to disk." A played session naturally exercises in-chat play; nothing in the loop forces the disk write, so B9 slipped through every run. That's not a build failure — it's a limit of session-validation as a test for opportunistic side effects, and it's why B9 ended up deferred rather than caught-and-fixed.

## Insights

### Technical
- The GM's hardest failure mode is **off-seat effects** — anything keyed to the rest of the field or revoked by a consequence — because the per-seat turn brief frames each seat in isolation. The brief pattern's strength (a tight, stateless context tail) is exactly what hides cross-field terms; the procedure has to re-introduce them as an explicit beat. Future engine roles that distill per-seat context should expect the same blind spot.
- Reusing already-pinned grammars as the journal's parse anchors made the format *self-testing*: the worked example is real roller output, so QA verifies it by replay rather than by reading. Any future format contract should ship a mechanically-replayable example for the same reason.

### Process
- Prose-validation (a played session as the "test") catches mechanics defects well but cannot enforce opportunistic side-effects (disk journaling) — nothing in the played loop forces them. When a behavior is "do X where the environment allows," a session won't reliably exercise it; it needs either a forcing function in the procedure or a separate explicit check. This is the root of the B9 deferral and worth remembering before relying on session-validation for B9-shaped requirements again.
- A single "validation session" plan step should be expected to fan out into multiple runs when the deliverable is a referee — budget for "N runs, one defect each" rather than one clean pass.
