---
id: GATE-016
date: 2026-07-07
kind: gate
status: answered
atom: ATOM-007
trigger: E4 (envelope exceeded by projection — raised BEFORE spend, after Wave 0 calibration)
answered_by: Ghenadie (human)
recorded_by: formulating agent (launch session)
---

# GATE-016 — E4 of ATOM-007: envelope raise after subagent-overhead calibration

## Question / Brief

Wave 0 (ROLE-004..008) delivered all-pass but real counters totaled 267,420
tokens vs 60k planned: each spawned subagent carries a **~50k fixed overhead**
(system prompt + per-tool-call context re-billing) regardless of task size —
recorded as `knowledge/precedent/subagent-fixed-overhead.md`. Honest re-projection
of the full tree: **~1.3M tokens vs the ~800k hard stop of GATE-015**. Spend so
far ~330k. Options: raise to ~1.4M / hold 800k with economy trim (~950k
projection — still breach-risky) / pause and replan (OD7).

## Answer (verbatim)

> Поднять до ~1.4M (Recommended)

English summary (HP3): The human raised the ATOM-007 tree envelope to **~1.4M
tokens hard stop (O6.2)** — full rigor as chosen at G1, at its true measured
price. ~100k margin above the 1.3M projection.

## Consequences

- Tree envelope: ~800k → **~1.4M hard stop**. PLAN.md OD4 arithmetic superseded
  by the calibrated projection (logged; plan not silently edited — this record
  + run.log are the correction trail).
- Child envelopes re-sized with the +50k fixed term: ATOM-071 ~110k, ATOM-072
  ~120k, build verifies ~70k each, lenses ~60–70k each, SYNTH ~85k, ATOM-077
  ~100k + verify ~70k, parent verify ~100k.
- The overhead measurement itself is pilot product: feeds the token-economics
  lens (ATOM-074), the cost-line honesty rule (S3), and pricing re-anchor.
- Candidate for next ORCHESTRATION touch: per-subagent fixed term in EC1's
  floor definition (queued in the precedent file).

## Fed back to

`knowledge/precedent/subagent-fixed-overhead.md` (written); ATOM-007 run.log;
`TASKS.md` touch-queue (EC1 fixed-term candidate); PLAN.md correction trail.
