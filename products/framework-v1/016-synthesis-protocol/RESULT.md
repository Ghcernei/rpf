---
atom: ATOM-016
product: Synthesis & Perspective Protocol (framework/SYNTHESIS-PROTOCOL.md)
status: delivered
maturity_claimed: draft
cost:
  units_in: ~95k
  units_out: ~12k
  unit: tokens
  wall_time: ~25m
  executor: claude-fable-5 (subagent)
  sub_atoms_spawned: 0
  sub_atoms_cost: 0
---

# RESULT — ATOM-016

## Summary
Produced `framework/SYNTHESIS-PROTOCOL.md` (227 lines) — the fifth constitutional document, structural twin of FEV-PROTOCOL, closing the framework's horizontal axis. It obliges a perspective map at every Formulate act (PM1–PM7), opens selective per-lens sibling fans on the same question (LF1–LF7), defines the synthesis act as an atom with a chaired-integration protocol, an operational fact/value classification test, the new value-conflict trigger E8, and anti-smoothing duties (SY1–SY12), and binds semantic fold-back on both axes — perspective fans and ordinary A4/K4 decomposition alike (FB1–FB4). All seven accepted decisions D1–D7 are formalized 1:1 (coverage table, §5); prior-art mechanics are extracted with zero platform/tool/product names (RC3 verified by grep). Maturity claimed `draft` per M3 — `reviewed` is conferred only by the pending blind Verify + human sign-off.

## Deliverables
| File | Purpose |
| :---- | :---- |
| `framework/SYNTHESIS-PROTOCOL.md` | The product — constitutional Synthesis & Perspective Protocol v1 |
| `products/framework-v1/016-synthesis-protocol/RESULT.md` | This self-check + cost block |
| `products/framework-v1/016-synthesis-protocol/STATUS.md` | Append-only state lines (O2) |
| `products/framework-v1/016-synthesis-protocol/workspace/run.log` | Append-only run log (O3) |

## DoD Self-Check
| Criterion | Result | Evidence |
| :---- | :---- | :---- |
| H1 — file exists, constitutional header table | met | `grep -E '^\| (Product\|Parent product\|Produced by\|Maturity\|Date) \|'` → 5 hits, lines 5–9 |
| H2 — §0 declares prefixes; no collision; id-space disambiguation | met | Declared SP, PM, LF, SY, FB (SP2, line 18); each checked by `grep -x` against the full 34-prefix existing set → all free; disambiguation stated in SP3 (SY/SP vs S-criteria; FB vs F/FP/findings; X-ids) |
| H3 — coverage table D1–D7 → rule ids, every row non-empty | met | `grep -E '^\| D[1-7] '` → 7 rows, each with rule ids (lines 135–141) |
| H4 — fenced map + synthesis templates; every fence a declared template | met | `grep -c '^\`\`\`'` → 4 fence markers = 2 blocks = declared count (SY12: "only two fenced blocks"); §6.1 perspective map + §6.2 SYNTHESIS.md both present |
| H5 — §0 states R0.3 precedence: tightens, never relaxes; relaxation defective, earlier document prevails | met | grep hit: SP4, line 23 |
| H6 — length ≤ 500 lines | met | `wc -l` → 227 |
| S1 — tightens-never-relaxes actually holds | self-reviewed | Reviewed every rule against the four documents: PM1 tightens F1/OD2; FB1 tightens L7; LF4 extends MT3; SY1/SP5/PM2 use forward references (HP4/GB5 discipline) instead of editing earlier documents; LF6 and SY8.4 explicitly close relaxation paths. No rule weakens an earlier obligation — judge: Verify agent |
| S2 — scale invariance (A5) | self-reviewed | All triggers and duties are structural (plan exists / maturity / perimeter / ≥2 lenses), no size- or domain-dependent special case; map, fan, synthesis, fold-back identical for a paragraph and a company strategy — judge: Verify agent |
| S3 — fact/value classification operational (FP7 bar) | self-reviewed | SY6 gives a decision-procedure test ("name the settling evidence every lens would accept"), a split rule for mixed conflicts (FP4 discipline), and a doubt-default (`value`) — two judges applying the test reach the same class or the same doubt-default — judge: Verify agent |
| S4 — thresholds don't recreate bureaucracy at small scale | self-reviewed | The map is one template-sized section, authored inline, MUST NOT spawn sub-atoms (PM7); opt-out is one recorded line (PM4); fan cost arises only when triggers + ≥2 lenses hold — judge: Verify agent |
| S5 — retroactive business-strategy-v1 bar | deferred | Judge: human (at sign-off) |

## Decisions Made by Executor
1. **Fan obligation conditional on ≥2 mapped lenses** (PM6): a fan of one lens is the atom itself; when a trigger fires but the map records the single-lens opt-out, the opt-out's logged justification governs. Simplest consistent reading of D1; reversible.
2. **Synthesis identity per the VP6 pattern** (SY1): id `<parent-atom-id>-SYNTH` (multiple fans: `-SYNTH-<k>`), folder `<parent-slug>-synth`, product `SYNTHESIS.md`; joins NC1/NC7 at REPO-STRUCTURE's next touch (GB5-style forward reference, no edit to REPO-STRUCTURE).
3. **Synthesis executor role defaults to the fan parent's role** (SY3) — the chaired-integration mechanic from the prior art; override permitted with logged justification.
4. **Classification doubt resolves to `value`** (SY6) — doubt routes to the human, consistent with the MT6/FP9 asymmetries; reversible.
5. **D7 concrete shape** (LF7): cost-block extension with one line per lens subtree + one line for the synthesis act, via T1 section extension — exactly the granularity of INFO-004's minimal interpretation; field naming left to the reporting atom. E1 judged not fired: the minimal interpretation fully determines the rule at its stated scope.
6. **Per-lens minimum envelope bound to the existing EC1 floor** (PM5) rather than a new constant — no new machinery.
7. **Prefixes SP/PM/LF/SY/FB; contradiction ids X1..Xn** (SP2–SP3) — all verified free of collision.
8. **Synthesis input package excludes lens run logs/workspaces** (SY4) — positions judged as delivered products, mirroring the VP2 discipline.

## Deviations & Known Limitations
- SM3 same-step sync missed once: the `running` transition was appended to `STATUS.md` before the matching `status.yaml` update; corrected at delivery (current state consistent; history intact in `STATUS.md` per SM2). Logged in run.log.
- Header `Date: 2026-07-06` is the UTC delivery date (STATUS timestamps are UTC).
- E8 and the `-SYNTH`/`SYNTHESIS.md`/map-section conventions bind via forward references until ATOM-SPEC, REPO-STRUCTURE, and ORCHESTRATION are next touched (HP4/GB5 discipline) — three pending migrations for the next constitutional touch, deliberate per INPUT §6 hints.
- "Recursive Product Framework" appears exactly once (header Parent-product row, identical to the four siblings) — sed-replaceable for the pending rebrand (TASKS §2.1).

## Handoff
Verification mode: independent + human. Verify receives: DoD (INPUT.md §5) + deliverable files only.
