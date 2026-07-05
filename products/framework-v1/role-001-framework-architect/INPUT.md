---
atom: ROLE-001
product: Framework Architect role spec (/roles/framework-architect.md)
parent: Recursive Product Framework v1
formulated_by: Human (Ghenadie) + advisor agent, 2026-07-05
verification: self
maturity_target: draft
instantiation: subagent
budget: ~5k tokens
recursion_allowance: 0
---

# ROLE-001 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `/roles/framework-architect.md` per ATOM-SPEC §6.3 ROLE template |
| Atom ID | ROLE-001 |
| Parent product | Recursive Product Framework v1 |
| Executor role | (bootstrap exemption — this is the atom that ends the empty-/roles/ state; log as executor decision) |
| Input product(s) | `framework/ATOM-SPEC.md`; `products/framework-v1/001-atom-spec/INPUT.md` (the role's de-facto first definition) |
| Consumer(s) | ATOM-002 (immediately); every future framework-authoring atom |
| Maturity target | draft |
| Gates | none — trigger gates only |
| Instantiation | subagent |
| Verification mode | self (low criticality, reversible, internal) |
| Budget envelope | ~5k tokens |
| Recursion-depth allowance | 0 |

## 2. Job To Be Done
Give the framework its first persistent role: the **Framework Architect** — the role that authors normative framework documents. Provenance must credit ATOM-001 (created the archetype, hardened by use).

## 3. Context — Decisions Already Made
Role packaging follows ATOM-SPEC §6.3 exactly (SKILL-style minimal frontmatter). Content source: the executor-role paragraph of ATOM-001's INPUT §1 + observed behavior (normative MUST/SHOULD writing, tables over prose, ruthless minimalism, escalation posture per E1–E7 + consolidated question sets, presents options with recommendation).

## 4. Deliverable
`/roles/framework-architect.md` — complete ROLE template, ≤60 lines.

## 5. Definition of Done
**Hard:** H1 file exists at exact path; H2 valid YAML frontmatter with `name` + one-line `description`; H3 all five template sections present; H4 ≤60 lines.
**Soft (judge: executor self-check):** S1 a stranger agent reading only this role spec would write in recognizably the same register as ATOM-SPEC.
**Maturity target:** draft. Do not gold-plate.

## 6. Method Hints (non-binding)
Second person ("You are..."). Steal phrasing from ATOM-001 INPUT rather than inventing.

## 7. Escalation
Triggers E1–E7 of ATOM-SPEC §5.7. Gates: none. Otherwise execute.
