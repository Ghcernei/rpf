---
atom: ATOM-002-VERIFY
product: Verdict on ATOM-002 (VERDICT.md)
parent: Recursive Product Framework v1
formulated_by: formulating agent (launch session, L5), 2026-07-05
verification: self
maturity_target: draft
instantiation: session
budget: ~15k tokens
recursion_allowance: 0
---

# ATOM-002-VERIFY — Input Specification (blind package per VP2)

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `products/framework-v1/002-fev-protocol-verify/VERDICT.md` |
| Atom ID | ATOM-002-VERIFY |
| Parent product | Recursive Product Framework v1 |
| Executor role | Verify agent (operating manual: `framework/FEV-PROTOCOL.md` §2) |
| Input product(s) | exactly the blind package of §3 below — nothing else |
| Consumer(s) | Formulating agent (acceptance decision, L6); the human (sign-off) |
| Maturity target | draft |
| Gates | none — trigger gates only |
| Instantiation | session (fresh isolated context, VP4) |
| Verification mode | self |
| Budget envelope | ~15k tokens (charged to parent per VP5) |
| Recursion-depth allowance | 0 |

## 2. Job To Be Done
Blind-verify ATOM-002's product against its DoD (§4 below). Verdict: `accept` or `return` with findings, per FEV-PROTOCOL VP7–VP14. Round 1; returns used: 0.

## 3. Blind package — the ONLY files you may read
1. This INPUT.md.
2. Product under verification: `framework/FEV-PROTOCOL.md` (also your operating manual, §2 — the document must survive being used for its own verification).
3. Product (backfill): `decisions/GATE-001-standalone-harness.md`, `decisions/RISK-001-claude-first-neutral-core.md`, `decisions/GATE-002-atom-001-acceptance.md`.
4. Product metadata cited by H7: `products/framework-v1/002-fev-protocol/RESULT.md`, `products/framework-v1/002-fev-protocol/STATUS.md`. Per VP3: executor self-check claims therein are claims, not evidence — re-run everything yourself.
5. Reference standard cited by H6: `framework/ATOM-SPEC.md`.

Prohibited (VP2): the target atom's `workspace/`, its `INPUT.md` sections other than the DoD quoted below, any other atom's folder, the launch file, git history, and any executor reasoning beyond the RESULT.md admitted above.

## 4. The DoD you verify against (ATOM-002 INPUT §5, verbatim)
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

## 5. Definition of Done (for this Verify atom)
**Hard:** V-H1. `VERDICT.md` exists at this folder's root, conforming to the FEV-PROTOCOL §5.1 template (frontmatter + all sections). V-H2. Every hard criterion H1–H7 has an evidence row with the actual check run and raw output. V-H3. Every soft criterion judged by you has a finding or a criterion-specific "no findings" justification (VP10); S4 marked deferred to human (VP9).
**Soft (judge: self):** V-S1. Findings, if any, conform to VP11 (severity + citation + evidence).

## 6. Method Hints (non-binding)
Run hard checks by script. Be adversarial on S2/S3: hunt for aspirational phrasing and for any statement that relaxes an ATOM-SPEC obligation.

## 7. Escalation
Triggers E1–E7 of ATOM-SPEC §5.7. Gates: none. Otherwise: do not ask for permission. Execute, then write your own STATUS.md, workspace/run.log, and RESULT.md per ATOM-SPEC obligations (L10).
