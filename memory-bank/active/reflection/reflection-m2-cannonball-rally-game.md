---
task_id: m2-cannonball-rally-game
date: 2026-06-11
complexity_level: 2
---

# Reflection: Cannonball Rally Game Directory (M2)

## Summary

Formalized Cannonball Rally as the toolkit's first complete game directory (`skills/cannonball-rally/` — `SKILL.md` wrapper + `references/GAME.md`), proving the GAME.md format on a real game. The milestone succeeded — and exceeded its brief: the interrogation didn't just record the oral rules, it improved the design (deterministic map, unified police check).

## Requirements vs Outcome

All deliverables landed: valid skill wrapper, spec-conformant rulebook, format proven, docs updated. The format itself required **zero amendments** — the proving milestone's most important data point. One scope inversion worth noting: the plan treated the operator as a source of *existing* rules, but the interrogation became a live design session — the operator abolished the GM obstacle roll and unified the police mechanics when the questions surfaced a contradiction. The GAME.md records a better game than the ODT described. Eight drafted-content items (traffic Medium+ threshold, Cut Corners effect, weather fallback rows, etc.) remain flagged for author sign-off; they are recorded in `activeContext.md` and the build report.

## Plan Accuracy

The 5-step plan held with one stretch: "one batched Q&A" became four interrogation rounds, because answers kept revealing the next question — and ultimately a design simplification. The planned challenges all materialized and were all handled by their planned mitigations: the lossy ODT extraction (structural re-parse worked), the oral-rules dependency (interrogation worked), and the reactive-ability grammar stress (it fired — but on the Detour *choice*, not a reaction).

## Build & QA Observations

Build was single-pass after the interrogation settled. Two self-caught gaps mid-build vindicated the acceptance-check approach: the turn-report grammar couldn't express the Detour choice (grew `[ via <detour>]`), and a tunable constant (+2 hr forecast offset) was buried in hook prose (promoted to *Forecast Offset*). QA found only trivia: committed LibreOffice lock-file debris and a column-label nit against the spec's sign rule.

## Insights

### Technical

- **Optionality, not just reactivity, breaks turn-report grammars.** M1 predicted reactions would stress the grammar; the actual gap was a *choice* (which detour stage). Generalized lesson for the spec's consumers: enumerate every point where a player selects among alternatives, not just every roll.
- **Formalization is a design tool, not a transcription tool.** Forcing the rules onto paper surfaced a contradiction (police-roll model vs. obstacle-roll model) that years of play never did, and the fix made the game simpler: deterministic map, one police roll, strict-beat thresholds. Expect `author`'s interrogation mode (M10) to *improve* games, not just document them.

### Process

- **Interrogation technique notes for M10**: concrete worked examples ("walk me through one Sedan turn in NYC") and forced-choice questions (AskQuestion options) extracted decisions fastest; open-ended lists worked for the first pass but stalled on mechanics. Four short rounds beat one exhaustive round — each answer changed which questions mattered. The verbatim transcripts are preserved in `progress.md` as founding field data.
- **Drafted-content flags are the right escape valve**: where the author had no rule (Cut Corners' benefit, the weather fallback table), drafting a proposal sized by the design's own heuristics (*Risk Magnitude*, *Ambient Magnitude*) and flagging it beat both inventing silently and blocking on questions.

### Million-Dollar Question

If "the map is deterministic; all RNG comes from player choices and real weather" had been a founding assumption, the obstacle-tier system would have been designed once as a single threshold vocabulary — which is exactly where four rounds of interrogation landed it (Obstacle Tiers table + strict-beat rule + suspicion stacking). What we built *is* the elegant version; the rally's history just took the scenic route to it. The reusable kernel — thresholds, suspicion, magnitude heuristic — looks like the seed of a house system future games could share.
