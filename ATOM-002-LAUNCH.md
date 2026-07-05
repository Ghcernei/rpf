# LAUNCH — ROLE-001 then ATOM-002

> Runtime instruction for this session. You will execute **two atoms in strict sequence**, per `framework/ATOM-SPEC.md` (read it first — it is your contract).
> Step 0 — materialize Formulate outputs: create both product folders with their `INPUT.md` (copy from below), `STATUS.md` in state `formulated`, and `workspace/`. Then execute ROLE-001; only after it is `delivered`, execute ATOM-002.
> Spawn justification (logged by formulator): ROLE-001 exists because F2 forbids instantiating ATOM-002 while `/roles/` lacks its role spec; cost trivial (~5k), value: constitutional compliance from atom #2 onward.

---
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

---
---
atom: ATOM-002
product: FEV & Escalation Protocol (framework/FEV-PROTOCOL.md)
parent: Recursive Product Framework v1
formulated_by: Human (Ghenadie) + advisor agent, 2026-07-05
verification: independent + human
maturity_target: reviewed
instantiation: session
budget: ~60k tokens (hard stop-and-escalate on projected overrun, O6.2)
recursion_allowance: 1
---

# ATOM-002 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `framework/FEV-PROTOCOL.md` |
| Atom ID | ATOM-002 |
| Parent product | Recursive Product Framework v1 |
| Executor role | framework-architect (created by ROLE-001) |
| Input product(s) | `framework/ATOM-SPEC.md` (binding, R0.3: you may tighten, never relax); this INPUT; the precedent record in §3.3 below |
| Consumer(s) | Verify atoms (their operating manual); formulating agents (DoD authoring + escalation routing); executors (what returns/escalations look like); the human (reads decision records and gate briefs) |
| Maturity target | reviewed |
| Gates | none — trigger gates only |
| Instantiation | session |
| Verification mode | independent + human (constitutional document, feeds all downstream atoms) |
| Budget envelope | ~60k tokens |
| Recursion-depth allowance | 1 |

## 2. Job To Be Done
Turn the FEV interface fixed in ATOM-SPEC (L5–L6, L10, E1–E7, §5.8) into an executable protocol: how Verify atoms are formulated and run, how findings and verdicts are written, how returns are scoped, how escalations and human answers are recorded. After this product, no participant should improvise the mechanics of checking, returning, escalating, or recording decisions.

**Consumers:** see table above; the document is the operating manual for the "govern" half of the framework.

## 3. Context — Decisions Already Made

### 3.1 Fixed by ATOM-SPEC (do not restate, reference by rule number)
Blind Verify input (DoD + product only); accept/return verdict; 2-return limit, 3rd failure = E5; hard criteria run by script/instrument, soft by named judge; anti-rubber-stamp duty (findings or explicit justified "no findings"); escalation triggers E1–E7; consolidated question sets; three human products; gate brief content and author (formulating agent, never the executor); every human answer recorded under `/decisions/` and fed back (O8.3).

### 3.2 Additional accepted decisions to formalize
- **Findings format:** numbered, each with severity (`blocking` | `substantive` | `minor`), the DoD criterion or rule it cites, and evidence. Verdict references findings by number.
- **Return instruction:** written by Verify as a minimal, closed fix list — "apply minimally and redeliver; do not change anything else." Rework outside the fix list is itself a finding on re-verify.
- **Re-verify scope:** full hard-criteria re-run (cheap) + delta inspection of the fixes + spot-check that nothing else moved. Not a full soft re-read unless a fix touches meaning broadly.
- **Verify economics:** Verify runs at high capability; its cost is charged to the parent's envelope as a separate line (schema per O4.2).
- **Decision records in `/decisions/`:** one file per decision, three kinds — `information` (E1 answer), `risk-acceptance` (E2), `gate` (E3 go/no-go/pivot). Each record: id, date, kind, question/brief summary, the answer verbatim, consequences (what it unblocks), and where it was fed back (role spec / knowledge file), per O8.3.
- **Self-waiver prohibition** (O6.2) applies to every protocol step: no participant may relax its own controls; only the human may, as a recorded risk acceptance.

### 3.3 Precedents to encode (the protocol already ran manually — twice)
- ATOM-000: executor overran budget 2× and self-waived → produced the hard-stop rule; treat as the canonical negative example for O6.2 handling.
- ATOM-001 verification: blind check (script for H*, judgment for S*), 2 findings (1 substantive — template defect that would propagate; 1 minor — wording contradiction), return with closed fix list, narrow re-verify by delta, accept, human sign-off. Treat as the canonical positive example; the protocol you write must reproduce this run without improvisation.

## 4. Deliverable
`framework/FEV-PROTOCOL.md` containing, normatively: (1) Formulate protocol — DoD authoring rules (hard/soft split, judge assignment, A7 discipline), verification-depth assignment procedure, gate placement; (2) Verify protocol — Verify-atom INPUT composition (what enters the blind package), execution steps, findings + verdict format, return instruction format, re-verify scope, anti-rubber-stamp mechanics; (3) Escalation protocol — per-trigger (E1–E7) routing, question-set format, resumption rules; (4) Decision recording — `/decisions/` file naming and the three record kinds; (5) Backfill: create real `/decisions/` records for: GATE-001 (standalone harness, vendored conventions), the platform risk acceptance (Claude-first execution / neutral core), and ATOM-001 human acceptance — sourced from this INPUT and repo history; these serve as the template's validation examples; (6) exactly three fenced templates: `VERDICT.md` (findings + verdict), decision record, `GATE-BRIEF.md`.

## 5. Definition of Done
**Hard criteria:**
- H1. `framework/FEV-PROTOCOL.md` exists; 250–800 lines including templates.
- H2. Contains the five protocol sections of §4 (detectable by headings) — Formulate / Verify / Escalation / Decision recording / Templates.
- H3. Exactly three fenced templates (`VERDICT.md`, decision record, `GATE-BRIEF.md`), each with YAML frontmatter.
- H4. Zero platform/product names in normative text (grep: "Claude Code", "MCP", "Codex", "OpenClaw", "Hermes", "BMAD").
- H5. ≥3 real files exist under `/decisions/` (the §4.5 backfill), each conforming to the decision-record template.
- H6. Zero contradictions with ATOM-SPEC rule numbers cited; every ATOM-SPEC reference resolves (no dangling rule ids).
- H7. `RESULT.md` with cost block (ROLE-001 cost aggregated per O4.2); `STATUS.md` last state `delivered`.

**Soft criteria (judge: Verify agent unless noted):**
- S1. A Verify atom instantiated with only FEV-PROTOCOL + a DoD + a product could run the ATOM-001-style verification end-to-end without improvising.
- S2. Every normative statement testable; no aspirational language.
- S3. Tightens but never relaxes ATOM-SPEC (R0.3 discipline).
- S4. The three backfilled decision records read as usable precedents — judge: human.
- S5. Core (excluding templates) readable in ≤ 12 minutes.

**Maturity target:** reviewed. Do not gold-plate.

## 6. Method Hints (non-binding)
Tables and numbered rules; continue the rule-numbering ethos (new prefixes, no collisions with ATOM-SPEC). Where a mechanic is uncovered by §3, choose the simplest reversible option and log it (O9.1).

## 7. Escalation
Triggers E1–E7 of ATOM-SPEC §5.7. Gates placed for this atom: none — trigger gates only. Budget hard stop per O6.2 — stop-and-escalate, never finish-then-report. Otherwise: do not ask for permission on the normal path. Execute.

---
*End of launch file. Two atoms, strict sequence, one session.*
