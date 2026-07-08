---
atom: ATOM-091-VERIFY
product: VERDICT.md on ATOM-091 (kickoff sale kit)
parent: pilot-sale-v1 (ATOM-090)
formulated_by: launch session, 2026-07-08
verification: self
maturity_target: draft
instantiation: subagent (fresh context — VP4)
model_tier: L (MT3/MT4; INFO-008 rule 3)
budget: ~100k tokens (slim package ~15k read ×3.5 + 40k, ≥25% margin per VP20)
recursion_allowance: 0
---

# ATOM-091-VERIFY — Input Specification (slim blind package, VP20)

You are a blind Verify atom. Self-contained: do NOT read framework documents,
the target's `INPUT.md` beyond §3–§4 (deliverables spec + DoD — the law you
re-run), `STATUS.md`, `workspace/` or run.log. From the target's `RESULT.md`
read ONLY the DoD self-check table. Round: **1**. Returns: **0**.

## 1. Job
The target produced a sale kit the CEO must be able to act on same-day.
Re-run every hard criterion yourself; judge soft criteria; write `VERDICT.md`
(accept / return-with-closed-fix-list) into
`products/pilot-sale-v1/091-sale-kit-verify/`.

## 2. Files you may read (complete list)
1. All four files under `products/pilot-sale-v1/091-sale-kit/kit/`
2. `products/pilot-sale-v1/091-sale-kit/INPUT.md` — §3 and §4 ONLY (the law)
3. `products/pilot-sale-v1/091-sale-kit/RESULT.md` — DoD table ONLY
4. **References (the law):** `decisions/INFO-001-pilot-terms-startup-moldova.md`; `decisions/INFO-010-signature-subject-principle.md`; `/Users/ghcernei/.claude/skills/style/style-profile.md` (voice reference for S1)
Instruments: ls, wc, grep, diff.

## 3. Criteria (verbatim from target DoD)
- H1. All 4 kit files exist, complete per §3 (outreach: 2 variants × RU/RO,
  word budgets ≤120/≤200, single ask, placeholders; agenda: timed blocks incl.
  live-show list and explicit red lines; script: say/don't-say + the two
  verbatim answers + 4 objection branches; signals: binary observable +
  follow-up prewritten).
- H2. Exchange terms and red lines are EXACT substrings of INFO-001 (diff/grep).
- H3. Jargon grep `DoD|атом|atom|verify|INPUT|гейт|gate|tier` — zero hits
  across kit files (paths/code spans excepted). Run it yourself.
- H4. No promises beyond INFO-001/STRATEGY: no cost figures (pilot free, rate
  «уточняется»), no founder-outcome guarantees, no dates promised for results.
- H5. Every signature mention names its subject (deal — сделка/înțelegere) per INFO-010.
- H6. signals.md: each signal binary and externally observable.
**Soft:**
- S1. Outreach voice vs style-profile: does it read like the founder or like
  marketing? Name specific lines that break voice, if any. Final judge = CEO.
- S2. Same-day actionability: anything the CEO would have to write/decide
  himself beyond the three placeholders? Name it.

## 4. Verdict discipline
`accept` only if every H passes your own re-run and no blocking soft failure;
otherwise `return` with a CLOSED fix list (file, line, what, why). Findings:
blocking / minor. Write `VERDICT.md`, `STATUS.md`, `RESULT.md`,
`workspace/run.log` in YOUR folder. Do NOT touch status.yaml. Chat reply is a
signal; files are the product.
