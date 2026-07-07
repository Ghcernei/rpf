---
atom: ATOM-018-VERIFY
product: VERDICT.md on ATOM-018 (constitutional touch v1)
parent: Recursive Product Framework v1
formulated_by: formulating agent (launch session), 2026-07-07
verification: self
maturity_target: draft
instantiation: session
model_tier: L (constitutional verification — MT3/MT4)
budget: ~275k tokens (blind package ~200 KB → ~67k read ×3.5 + 40k)
recursion_allowance: 0
---

# ATOM-018-VERIFY — Input Specification (blind package per VP2)

You are a blind Verify atom under `framework/FEV-PROTOCOL.md` §2. You receive ONLY this package. You MUST NOT read the target atom's `workspace/`, run log, or `RESULT.md` EXCEPT the H1 coverage table which the DoD itself names as a deliverable check (read only that table). Round: **1**. Returns used so far: **0**.

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `VERDICT.md` at `products/framework-v1/018-constitutional-touch-verify/` |
| Atom ID | ATOM-018-VERIFY |
| Executor role | framework-architect (`roles/framework-architect.md`) |
| Verification mode | self |
| Budget envelope | ~275k tokens |
| Recursion-depth allowance | 0 |

## 2. Job To Be Done
Accept/return verdict on the first constitutional amendment per FEV-PROTOCOL §2: re-run H1–H8 (VP3), judge S1–S4 with per-criterion findings or specific justifications (VP10), defer S5 (VP9), write `VERDICT.md` per §5.1.

## 3. Blind package (the only files you may read)
1. **Target DoD + queue** — §4–§5 below, verbatim from the target `INPUT.md` (§3 queue T1–T10 and §5 DoD).
2. **Deliverables under verification:** `framework/ATOM-SPEC.md`, `framework/FEV-PROTOCOL.md`, `framework/REPO-STRUCTURE.md`, `framework/ORCHESTRATION.md`, `framework/SYNTHESIS-PROTOCOL.md`, `roles/humans/ghenadie.md` — post-touch state; plus ONLY the H1 coverage table inside `products/framework-v1/018-constitutional-touch/RESULT.md`.
3. **Queue sources (to verify fidelity to the accepted decisions):** `products/business-strategy-v1/006-business-strategy/RESULT.md` (§Framework findings 1–5 only), `decisions/GATE-010-atom-006-g2-strategy-acceptance.md`, `decisions/GATE-011-atom-016-acceptance.md`, `decisions/INFO-005-d7-subtree-accounting-detail.md`, `knowledge/precedent/verify-envelope-calibration.md`.
4. **Instruments:** non-content commands over the listed files (`grep`, `wc -l`, fence counts) AND `git diff b6edd2c -- framework/ roles/humans/ghenadie.md` — the pre-touch state is commit `b6edd2c`; the diff is your primary instrument for S2 (no drive-by changes) and S1 (nothing relaxed: every `-` line must reappear or be a fulfilled forward-reference).

## 4. The queue the amendments must implement (T1–T10, verbatim from target INPUT §3)
- T1 — HP2 extension + plain-language briefs (GATE-010 verbatim reservation; GATE-011 S5 episode): gate packages judging a document MUST carry a reference copy/faithful summary in the human's decision language AND plain-language restatement of every human-judged criterion; `ghenadie.md` updated.
- T2 — HP4 migration: HP2–HP3 to FEV-PROTOCOL; REPO-STRUCTURE keeps mechanics + pointer.
- T3 — F3 row-2 precedence («feeds ≥2 downstream» vs INPUT-granted discretion) — one home, other references.
- T4 — Inline-conflation legality rule in ORCHESTRATION.
- T5 — Slim-verify codified in FEV with exactly two conditions + ≥25% margin.
- T6 — Writing-heavy executor envelopes ×3.5+40k in ORCHESTRATION EC; EC1 floor = minimum.
- T7 — E8 into ATOM-SPEC §5.7; `-SYNTH` into NC1; `SYNTHESIS.md`/`GATE-BRIEF-<gate-id>.md` into NC7; SP5/SY1/GB5 → past tense.
- T8 — Full D7 (INFO-005 verbatim): O4.2 transitive extension; §6.2 template fields `total_descendants`/`max_depth_reached`/`subtree_cost` + execute/verify/role-creation/synthesis breakdown; LF7 aligned.
- T9 — Perspective-map section into OD2 + §8.2 template; PM2 → past tense.
- T10 — Uniform amendment-provenance mark in all touched documents.

## 5. Definition of Done of the TARGET atom (verbatim — verify against this)
**Hard criteria:**
- H1. Coverage table in RESULT.md maps each T1–T10 to exact rule ids/sections; every row non-empty.
- H2. E8 row in ATOM-SPEC §5.7; `-SYNTH` in NC1; `SYNTHESIS.md` and `GATE-BRIEF` in NC7. Check: grep.
- H3. ATOM-SPEC §6.2 template frontmatter: `total_descendants`, `max_depth_reached`, `subtree_cost`, four-type breakdown. Check: grep.
- H4. HP2–HP3 in FEV-PROTOCOL; REPO-STRUCTURE §4 migration pointer; ghenadie.md updated. Check: grep.
- H5. ORCHESTRATION §8.2 template contains the perspective-map section. Check: grep.
- H6. Every touched document carries the T10 provenance mark. Check: grep.
- H7. No rule-prefix collisions introduced; each document's declared fenced-block count matches actual. Check: script.
- H8. Combined framework-doc growth ≤ 25% vs pre-touch (417/304/251/251/227). Check: wc -l.
**Soft criteria:**
- S1. Tightens-never-relaxes for every amendment (R0.3) — judge: Verify agent (use the git diff: no obligation weakened, no rule deleted/renumbered).
- S2. Amendments minimal — nothing outside the T-queue changed — judge: Verify agent (git diff hunks each attributable to a T-item).
- S3. The T3 precedence wording decides both recorded ATOM-006 ambiguity cases unambiguously — judge: Verify agent.
- S4. The five documents still read as one system; every cross-reference resolves post-amendment — judge: Verify agent.
- S5. Human acceptance — judge: human (deferred, VP9 — GATE-014).

## 6. Escalation
Triggers E1–E8. Otherwise execute. Write your own `STATUS.md`, `RESULT.md`, `workspace/run.log` per ATOM-SPEC obligations.
