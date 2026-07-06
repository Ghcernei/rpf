---
atom: ATOM-016-VERIFY
product: VERDICT.md on ATOM-016 (Synthesis & Perspective Protocol)
parent: Recursive Product Framework v1
formulated_by: formulating agent (launch session), 2026-07-06
verification: self
maturity_target: draft
instantiation: session
model_tier: L (judgment-heavy verification of a constitutional document — MT3/MT4)
budget: ~180k tokens (blind-package read estimate ~40k ×3.5 + 40k runtime constant, per EC2 and knowledge/precedent/verify-envelope-calibration.md)
recursion_allowance: 0
---

# ATOM-016-VERIFY — Input Specification (blind package per VP2)

You are a blind Verify atom under `framework/FEV-PROTOCOL.md` §2. You receive ONLY this package. You MUST NOT read the target atom's `workspace/`, run log, `RESULT.md`, `STATUS.md`, launch files, decision records, or any executor reasoning. Round: **1**. Returns used so far: **0**.

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `VERDICT.md` at `products/framework-v1/016-synthesis-protocol-verify/` |
| Atom ID | ATOM-016-VERIFY |
| Parent product | Recursive Product Framework v1 |
| Executor role | framework-architect (`roles/framework-architect.md`) |
| Input product(s) | the blind package listed in §3 |
| Consumer(s) | The formulating agent (accept/return routing per L6); the human risk-taker (sign-off per VP18) |
| Maturity target | draft |
| Gates | none — trigger gates only |
| Instantiation | session (fresh isolated context, VP4) |
| Verification mode | self (a Verify atom's own product is not re-verified) |
| Budget envelope | ~180k tokens |
| Recursion-depth allowance | 0 |

## 2. Job To Be Done
Deliver an accept/return verdict on ATOM-016's product per FEV-PROTOCOL §2: re-run every hard criterion yourself (VP3 — the executor's self-check is a claim, not evidence), judge every soft criterion assigned to the Verify agent with per-criterion findings or specific justifications (VP10), defer human-judged criteria (VP9), and write `VERDICT.md` per the FEV-PROTOCOL §5.1 template, with a closed minimal fix list if returning (VP14).

## 3. Blind package (the only files you may read)
1. **Target DoD** — §5 of this document, verbatim from the target atom's `INPUT.md`, plus the accepted-decisions list D1–D7 the DoD cites (§4 below, verbatim from the target INPUT §3).
2. **Deliverable under verification:** `framework/SYNTHESIS-PROTOCOL.md`.
3. **Reference standards the criteria cite:** `framework/ATOM-SPEC.md`, `framework/FEV-PROTOCOL.md`, `framework/REPO-STRUCTURE.md`, `framework/ORCHESTRATION.md` (H2 prefix set; H5/S1 tightens-never-relaxes; the T2/RC4 disciplines; FEV-PROTOCOL §5.1 for your own verdict template); `roles/framework-architect.md` (your role). For hard-criterion checks you MAY run non-content commands (`grep`, `wc`, fence counts) over these listed files as instruments; do not read file contents beyond this list.

## 4. Accepted decisions the DoD cites (verbatim from target INPUT §3 — "formalize, do not reopen")

- D1 — **Threshold.** The perspective **map** is mandatory broadly: every Formulate
  act includes it. Opt-out is a single recorded line — "single lens — narrow
  question" — logged as a deviation in the F3 discipline (justification logged, never
  silent). The execution **fan** (per-lens sibling atoms) is selective: mandatory
  when any of — a decomposition plan exists (OD1), maturity target ≥ `reviewed`, or
  the product crosses the perimeter.
- D2 — **Synthesis authority.** Conflicts of **fact** are reconciled by the synthesis
  act itself, with the reconciliation logged. Conflicts of **value** always gate to
  the human. Classification is by the *nature* of the conflict, not its magnitude.
- D3 — **Fan budget.** Lens atoms are siblings inside the parent's envelope (O6.1).
  Weights are assigned by the perspective map — default equal, with a minimum
  envelope per lens so no lens is starved. Lens atoms MAY run at tier S/M; the
  synthesis act always runs at tier L (extends the MT3 principle: quality is bought
  at Formulate, Verify — and now Synthesis).
- D4 — **Lens depth.** Sub-lenses are permitted, charged in the same depth currency
  against recursion_allowance (F6, default total depth 3). The default fan is flat;
  opening lens depth requires a logged justification (the O5.1 discipline).
- D5 — **Semantic fold-back, both axes.** The parent of any decomposition —
  perspective fan OR mono-role product decomposition — MUST integrate its children's
  products into its own view: an integration act with contradictions named, not mere
  collection or aggregation. This closes the accounting-only fold-back gap.
- D6 — **Prior art.** The human's council mechanism (multi-role clash + chaired
  synthesis) is source material: extract the mechanics of clashing views without
  smoothing conflicts, and of a chaired decision. Neutrality per RC3: no tool or
  product names appear in the framework text.
- D7 — **Cost visibility.** Cost blocks of fan parents report per-lens subtree
  lines, extending the O4.2 aggregation, so the cost of the fan is visible per lens.
  Minimal interpretation accepted as the decision; the executor was instructed to
  raise E1 rather than invent detail if it under-determined a rule.

## 5. Definition of Done of the TARGET atom (verbatim — verify against this)

**Hard criteria (machine-checkable):**
- H1. `framework/SYNTHESIS-PROTOCOL.md` exists and opens with the constitutional
  header table (Product / Parent product / Produced by / Maturity / Date). Check:
  file present; header fields grep-able.
- H2. The document declares its rule prefixes in its §0, and none collides with the
  existing set: R, A, F, C, U, RS, CL, K, V, M, L, E, O, T (ATOM-SPEC); P0, FP, VP,
  EP, DR, TP (FEV-PROTOCOL); LA, NC, KL, HP, RB, SM, BC (REPO-STRUCTURE); OD, MT,
  EC, GB, LP, SS, RC (ORCHESTRATION). Check: grep declared prefixes against this
  list; id-space disambiguation stated where letters could be confused (the §0
  discipline of ORCHESTRATION).
- H3. A coverage table maps each accepted decision D1–D7 (§3 above) to the rule
  id(s) implementing it (the RC4 discipline). Check: table present; every D row
  non-empty.
- H4. The document contains a fenced template for the perspective map and a fenced
  template for the synthesis product; every fenced block in the document is one of
  its declared templates (T2 discipline). Check: fence count equals declared
  template count; both named templates present.
- H5. The document's §0 states the R0.3 precedence: it tightens the earlier four
  documents and never relaxes them; an apparent relaxation is defective and the
  earlier document prevails. Check: grep.
- H6. Document length ≤ 500 lines (constitutional size discipline; the four existing
  documents run 250–420). Check: `wc -l`.

**Soft criteria (judgment — judge named per criterion):**
- S1. Tightens-never-relaxes actually holds: no rule in the document relaxes any
  obligation of the existing four documents — judge: Verify agent.
- S2. Scale invariance (A5): the map, fan, synthesis, and fold-back rules work
  unchanged for a paragraph-scale product and a company-strategy-scale product —
  judge: Verify agent.
- S3. The fact/value conflict classification (D2) is operational, not aspirational
  (the FP7 bar): two independent judges applying the document to the same conflict
  would classify it the same way — judge: Verify agent.
- S4. The threshold rules (D1) do not recreate bureaucracy at small scale: the cost
  of producing the map is negligible against the cost of the fan it may trigger —
  judge: Verify agent.
- S5. Applied retroactively to business-strategy-v1, the protocol would have forced
  at least one same-question multi-lens examination with at least one named conflict
  — judge: human (at sign-off).

**Maturity target:** reviewed. Do not gold-plate.

## 6. Method Hints (non-binding)
Run hard checks as commands and quote raw output. For S1, check each normative rule of the target document against the obligations of the four reference documents — a relaxation is any statement permitting what an existing rule prohibits, or weakening a MUST. For S3, construct 2–3 concrete conflict examples and test whether the document's classification rule decides them unambiguously. Findings need all three fields (VP11): severity, citation, evidence. S5 is human-judged: mark it deferred (VP9).

## 7. Escalation
Stop and escalate (one consolidated question set) on triggers E1–E7 of ATOM-SPEC §5.7. Gates: none — trigger gates only. Otherwise: do not ask for permission on the normal path. Execute.
