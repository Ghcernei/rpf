---
atom: ATOM-007-SYNTH
product: products/pilot-prerequisites-v1/007-synth/SYNTHESIS.md
state: delivered — blocked on E8 ×2 (value gates E8-1, E8-2)
maturity: draft (per INPUT; consumed by ATOM-007 closure/FB4, ATOM-077, G2 brief)
cost:
  tokens_estimated: 75000
  envelope: 110000
  model_tier: L (claude-fable-5, LF4)
  elapsed: single session, 2026-07-07
  who_ran_it: synthesis subagent, chair role venture-strategist (SY3)
---

# RESULT — ATOM-007-SYNTH

## Summary

Synthesized the framework's first real lens fan (ATOM-073..076) over the shared
question «Дают ли эти пререквизиты пилоту стартовать и быть измеренным
безопасно?». Consolidated answer: **yes-with-conditions — 7 conditions, pilot
must not start before all hold**; until E8-2 is answered, the owner-capacity
lens's NO governs. Six contradictions named (X1–X6): 6 fact-class handled per
SY7 (3 reconciled with settling evidence, 3 dissolved — anticipated opposing
positions absent from the delivered verdicts); 2 value conflicts survived the
SY6 test and are carried unresolved to the human per SY8 (E8-1: TEAM-summary
legibility vs content silence across the perimeter; E8-2: 2-founder pilot on an
owner primary-duty commitment vs SLA/cohort de-risking). Zero fact-adjudication
looks into underlying artifacts were needed (no two lenses disagreed on a
checkable artifact fact — logged, run.log [5]). Fix-priority register in
Russian: 22 deduplicated items (8 blocking, 9 significant, 5 verify-minor
lines), each with source id, artifact, one-line fix direction, and decider.

## Deliverables

| Path | What |
| :---- | :---- |
| `SYNTHESIS.md` | The product — per SYNTHESIS-PROTOCOL §6.2 + INPUT §3 additions (consolidated answer with traceable conditions, RU fix-priority register, E8 block, per-lens coverage paragraphs) |
| `STATUS.md` | Atom status log (appended) |
| `workspace/run.log` | Full cycle log: read set, position pass, contradiction pass, R1–R6 reconciliation lines, zero-looks rationale, E8 raising, SY6–SY10 self-check |

## Decisions

- X1, X5, X6 dissolved as fact — each lens's SY9 "anticipated opponent" position
  does not exist in the delivered verdicts; settling evidence: the verdict texts
  themselves. No smoothing: the dissolutions are recorded per-contradiction with
  evidence, not as generic agreement.
- X2 and X3 split per FP4 into fact + value halves; the value halves (X2b, X3b)
  are NOT resolved here at any threshold (P0.3) — carried to E8 with exactly one
  recommendation + cost each (EP2).
- 073-S4 (consequence of declining telemetry) classified as a missing policy
  branch, not a cross-lens value conflict → CEO question at G2 (register №9).
- Register dedup: 071V-M1→№6; 076-F3→№4; 073-B3+076-F4→№1; 074-F5 noted at №20.

## Handoff

- **Formulating agent:** author E8-1/E8-2 gate briefs per O8.2/GB3 from
  SYNTHESIS.md's E8 block; record answers as gate decision records; update this
  atom's frontmatter `value_gates` and unblock.
- **ATOM-007 (parent):** FB4 item 1 — fold SYNTHESIS.md into the parent product;
  reference in the closure acceptance entry. Note register №20: render.sh's
  descendant branch must be implemented before the parent's own first live
  TEAM-summary render at closure.
- **ATOM-077 (intake):** consume the register (items №9–11, 17 land in intake
  content) and the E8-1 answer (consent clause shape).
- **G2 brief:** consume the consolidated answer + register; items marked «CEO»
  (№3, 7, 8, 9) are the human's decision surface.
