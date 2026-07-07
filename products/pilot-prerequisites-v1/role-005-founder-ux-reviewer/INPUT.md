---
atom: ROLE-005
product: roles/founder-ux-reviewer.md
parent: Pilot Prerequisites v1 (ATOM-007; plan: 007-pilot-prerequisites/PLAN.md)
formulated_by: formulating agent (launch session), 2026-07-07
verification: self
maturity_target: draft
instantiation: subagent
model_tier: S
budget: ~12k tokens
recursion_allowance: 0
---

# ROLE-005 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `roles/founder-ux-reviewer.md` — role spec, ~40 lines |
| Atom ID | ROLE-005 |
| Executor role | framework-architect (`roles/framework-architect.md`) |
| Input product(s) | This INPUT; `roles/venture-strategist.md` (structure template — follow its section set exactly: frontmatter name+description, Identity, Capabilities, Method Defaults, Escalation Posture, Provenance) |
| Consumer(s) | ATOM-073 (lens: non-technical founder UX) |
| Verification mode | self (ROLE-001 precedent: hard-criteria self-check is acceptance at draft) |
| Budget envelope | ~12k tokens |

## 2. Job To Be Done
Create the role **Founder UX Reviewer** so its consuming atoms can run under a professional
optic that is specific, not generic. The role judges founder-facing artifacts as product UX for a non-technical founder: hunts jargon leaks (any method word reaching the founder is a defect), counts steps and questions, measures cognitive load of every instruction, checks that expectations set match what actually happens. Verdicts name concrete failures with the exact offending line, never vibes. It answers the shared fan question strictly from the founder's chair.

## 3. Definition of Done
**Hard criteria:**
- H1. `roles/founder-ux-reviewer.md` exists, 30–50 lines, follows the venture-strategist section set; frontmatter `description` states in one line which atoms need this role. Check: file + wc -l.
- H2. Capabilities are specific to §2 (≥5 bullets), no generic filler («writes well», «is thorough»). Check: read.
- H3. Escalation Posture names triggers E1–E8 posture + what this role decides alone. Check: grep.
- H4. Provenance table: Created / ROLE-005 / 2026-07-07. Check: grep.
**Soft:** S1. A stranger could role-play it from the file alone — judge: self.

## 4. Obligations
Write `STATUS.md` (formulated→running→delivered lines, UTC), `RESULT.md` (product path, DoD check table, cost block with your real token estimate), `workspace/run.log` (key decisions) in your atom folder. Do NOT touch status.yaml (orchestrator syncs). Do NOT read framework docs — this INPUT + the template file are sufficient. Escalate (write ESCALATION.md + stop) only if the INPUT contradicts itself; otherwise execute.
