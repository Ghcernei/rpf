---
atom: ROLE-006
product: roles/token-economist.md
parent: Pilot Prerequisites v1 (ATOM-007; plan: 007-pilot-prerequisites/PLAN.md)
formulated_by: formulating agent (launch session), 2026-07-07
verification: self
maturity_target: draft
instantiation: subagent
model_tier: S
budget: ~12k tokens
recursion_allowance: 0
---

# ROLE-006 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `roles/token-economist.md` — role spec, ~40 lines |
| Atom ID | ROLE-006 |
| Executor role | framework-architect (`roles/framework-architect.md`) |
| Input product(s) | This INPUT; `roles/venture-strategist.md` (structure template — follow its section set exactly: frontmatter name+description, Identity, Capabilities, Method Defaults, Escalation Posture, Provenance) |
| Consumer(s) | ATOM-074 (lens: token economics) |
| Verification mode | self (ROLE-001 precedent: hard-criteria self-check is acceptance at draft) |
| Budget envelope | ~12k tokens |

## 2. Job To Be Done
Create the role **Token Economist** so its consuming atoms can run under a professional
optic that is specific, not generic. The role computes real money from repo records: token counters in run.logs and RESULT cost blocks, tier assignments vs work class, envelope calibration precedents (knowledge/precedent/). It projects founder-month cost from measured atoms, flags flattering rounding as a defect (governance overhead must stay visible per the D7 breakdown), and answers the shared fan question with arithmetic, units and dates — never narrative.

## 3. Definition of Done
**Hard criteria:**
- H1. `roles/token-economist.md` exists, 30–50 lines, follows the venture-strategist section set; frontmatter `description` states in one line which atoms need this role. Check: file + wc -l.
- H2. Capabilities are specific to §2 (≥5 bullets), no generic filler («writes well», «is thorough»). Check: read.
- H3. Escalation Posture names triggers E1–E8 posture + what this role decides alone. Check: grep.
- H4. Provenance table: Created / ROLE-006 / 2026-07-07. Check: grep.
**Soft:** S1. A stranger could role-play it from the file alone — judge: self.

## 4. Obligations
Write `STATUS.md` (formulated→running→delivered lines, UTC), `RESULT.md` (product path, DoD check table, cost block with your real token estimate), `workspace/run.log` (key decisions) in your atom folder. Do NOT touch status.yaml (orchestrator syncs). Do NOT read framework docs — this INPUT + the template file are sufficient. Escalate (write ESCALATION.md + stop) only if the INPUT contradicts itself; otherwise execute.
