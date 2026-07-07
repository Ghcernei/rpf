---
plan_for: Pilot Prerequisites v1 (products/pilot-prerequisites-v1/ tree)
formulated_by: formulating agent (launch session, chair role venture-strategist), 2026-07-07
parent_envelope: ~350k tokens granted (O6.1) — arithmetic below shows ~760k required; E4 raised at G1 (consolidated per §7 of INPUT)
date: 2026-07-07
---

# DECOMPOSITION PLAN — Pilot Prerequisites v1 (ATOM-007)

## Perspective map — ATOM-007 (OD2 item 7; PM1–PM6)

**Question under examination:** *do these prerequisites let the pilot start and
be measured safely?* (INPUT §3.2 — the one question, each lens answers it over
the same deliverables.)

**Fan triggers (PM6):** decomposition plan = yes; maturity ≥ reviewed = yes;
crosses perimeter = yes.
**Fan decision:** opened — mandatory (all three triggers hold and the map names
4 lenses; INPUT declares this the framework's first real fan — SYNTHESIS-PROTOCOL
validation path).

| Lens | Role (F2) | Why the whole demands this optic | Weight | Tier |
| :---- | :---- | :---- | :---- | :---- |
| Non-technical founder UX | founder-ux-reviewer — created by ROLE-003 | Every §4 deliverable is founder-facing product UX; S1/S5 hang on it; the founder must never meet the machinery (§3.1) | equal | M |
| Token economics | token-economist — created by ROLE-004 | Real cost of the founder-month decides pricing re-anchor at pilot exit; tier discipline + envelope defaults are deliverable substance (§4.2) | equal | S |
| Security + telemetry | security-telemetry-reviewer — created by ROLE-005 | Whitelist boundary, consent integrity, open script — the perimeter's trust surface; a leak kills the pilot and the brand (§3.5) | equal | M |
| Owner operational capacity | ops-capacity-reviewer — created by ROLE-006 | Flow Support at ≥2 concurrent founders inside the SLA (pilot-design criteria 3–4) — if the owner can't operate it, nothing else matters | equal | S |

Lens derivation source: INFO-006 P2 — the four lenses are the map's **input**
(CEO decision), not its invention; the map verifies each against PM3 (why the
whole demands it) — all four hold, none merged, none added (PM5/O5.1: no
justification needed for zero changes).

Synthesis act (fan opens): `ATOM-007-SYNTH`, tier L (LF4), envelope ~45k tokens
— in the OD4 arithmetic (LF3).
Per-lens floor check (PM5): lens read estimate ~12k → EC1 floor ~24k; allocations
25–30k ≥ floor — holds.

## Product tree

| Atom | Product (deliverable path) | Role | Tier | Budget | Verification | Gates | Instantiation | Depends on |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| ROLE-004 | `roles/pilot-toolsmith.md` | framework-architect | S | 12k | self (ROLE-001 precedent) | none | subagent | — |
| ROLE-005 | `roles/founder-ux-reviewer.md` | framework-architect | S | 12k | self | none | subagent | — |
| ROLE-006 | `roles/token-economist.md` | framework-architect | S | 12k | self | none | subagent | — |
| ROLE-007 | `roles/security-telemetry-reviewer.md` | framework-architect | S | 12k | self | none | subagent | — |
| ROLE-008 | `roles/ops-capacity-reviewer.md` | framework-architect | S | 12k | self | none | subagent | — |
| ATOM-071 | Setup kit + execution tiers (§4.1+§4.2) — `products/pilot-prerequisites-v1/071-setup-kit/` (kit files under `setup/`) | pilot-toolsmith | M | 60k | independent (slim VP20) — feeds 4 lenses + founders | none | subagent | ROLE-004 |
| ATOM-071-VERIFY | VERDICT.md | framework-architect | L | 60k | — | — | subagent | ATOM-071 |
| ATOM-072 | Telemetry + consent RO/RU + work showcase (§4.3+§4.5: cost line **+ TEAM summary, INFO-007**) — `products/pilot-prerequisites-v1/072-telemetry-showcase/` | pilot-toolsmith | M | 70k | independent (slim VP20) — feeds 4 lenses + perimeter | none | subagent | ROLE-004 |
| ATOM-072-VERIFY | VERDICT.md | framework-architect | L | 65k | — | — | subagent | ATOM-072 |
| ATOM-073 | Lens verdict: founder UX — `products/pilot-prerequisites-v1/073-lens-founder-ux/` | founder-ux-reviewer | M | 30k | self (feeds 1 consumer — SYNTH; draft) | none | subagent | ROLE-005, ATOM-071, ATOM-072 |
| ATOM-074 | Lens verdict: token economics — `.../074-lens-token-economics/` | token-economist | S | 25k | self | none | subagent | ROLE-006, ATOM-071, ATOM-072 |
| ATOM-075 | Lens verdict: security + telemetry — `.../075-lens-security-telemetry/` | security-telemetry-reviewer | M | 30k | self | none | subagent | ROLE-007, ATOM-071, ATOM-072 |
| ATOM-076 | Lens verdict: owner capacity — `.../076-lens-owner-capacity/` | ops-capacity-reviewer | S | 25k | self | none | subagent | ROLE-008, ATOM-071, ATOM-072 |
| ATOM-007-SYNTH | `SYNTHESIS.md` (§6.2 of SYNTHESIS-PROTOCOL) — `.../007-synth/` | venture-strategist (chair, SY3) | L | 45k | per SY (E8 → gate on value conflict) | E8 if triggered | subagent | ATOM-073..076 |
| ATOM-077 | Intake protocol (§4.4, **last** — §3.4) — `.../077-intake-protocol/` | venture-strategist | M | 55k | independent (slim VP20) — perimeter | E1 hold if field-test verdict absent | subagent | ATOM-007-SYNTH; field-test verdict (external) |
| ATOM-077-VERIFY | VERDICT.md | framework-architect | L | 60k | — | — | subagent | ATOM-077 |
| ATOM-007-VERIFY | Parent-level VERDICT.md vs H1–H6/S1–S4 (slim VP20) | framework-architect | L | 90k | — | — | subagent | all above |
| — G2 | human gate: founder-facing final (S5 «я бы подписал как фаундер») | Ghenadie | — | — | — | G2 | — | ATOM-007-VERIFY |

## Tier justifications (MT1 — one line per atom)

- ROLE-004..008: template-following role files (~60 lines each) from explicit specs — S sufficient (MT2).
- ATOM-071/072/077: structured founder-facing writing + scripts from fixed accepted inputs (pilot-design master, INFO-005/006/007) — M sufficient; not tier-L normative prose, EC7 does not bind (envelopes sized ~2.5–3× reads).
- ATOM-073/075 (UX, security): judgment-heavy lenses on the trust surface — M.
- ATOM-074/076 (economics, capacity): arithmetic + SLA-check against named criteria — S.
- ATOM-007-SYNTH: tier L mandatory (LF4).
- All Verify atoms: tier L mandatory (MT3); slim packages per VP20 (all hard criteria script-checkable; package lists every cited file), envelopes package-read ×3.5+40k with ≥25% margin.

## Budget arithmetic (OD4)

Sum of child envelopes: 5×12k + 60+60 + 70+65 + 30+25+30+25 + 45 + 55+60 + 90 = **675k tokens**.
Parent's own remaining consumption (formulating ~15 INPUTs/packages, 2 gate briefs, synthesis consumption, FB4 fold-back, closure + first live TEAM-summary render): **~85k**.
Total required: **~760k tokens**. Parent envelope: **~350k granted**.
Fits (O6.1): **NO — E4 raised at planning time (EP4), consolidated into G1** per INPUT §7 (one question set). Request: raise to **~800k hard stop (O6.2)** — required 760k + margin. Alternative (economy variant, human's call at G1): builds ATOM-071/072/077 verified `self` under an FP9 advance grant recorded in the gate answer (the fan + parent-level blind Verify + G2 carry the risk) — saves ~185k → total **~575k**.

## Sequencing (OD5)

1. **Wave 0** (parallel): ROLE-004..008.
2. **Wave 1** (parallel): ATOM-071, ATOM-072 → each blind-verified on delivery (071-VERIFY, 072-VERIFY).
3. **Wave 2 — the fan** (parallel, LF2: same question, same inputs): ATOM-073..076 over the delivered 071+072 products + this PLAN + INPUT §3 (intake is examined at spec level — it is deliberately built last).
4. **Wave 3**: ATOM-007-SYNTH (fact conflicts reconciled with log, SY6; value conflicts → E8 gate, SY8; anti-smoothing SY9–SY10).
5. **Wave 4**: ATOM-077 intake protocol — consumes SYNTHESIS.md + the CEO field-test verdict (§3.4; E1 hold on this atom only if absent — the tree does not block) → 077-VERIFY.
6. **Wave 5**: ATOM-007-VERIFY (parent, slim) → **G2** (human: S5) → closure per L7/RB6 with FB4 fold-back evidence, O4.3 subtree fields, per-lens cost lines (LF7), and the **first live TEAM summary** (INFO-007 self-application).

Depth check (OD6/F6): children at depth 1, flat fan (LF5, no sub-lenses), allowance 2 — holds.

## Open risks

- Field-test verdict timing (§3.4): if absent at Wave 4, ATOM-077 holds on E1; G2 slips with it. No replanning needed — sequenced last by design.
- E8 value conflict in synthesis (e.g. UX-lens «hide everything» vs security-lens «show consent mechanics») → extra human gate; budgeted inside SYNTH+parent margins.
- Slim-verify estimates: historical full verifies ran 120–180k real; slim packages are structurally smaller, and each carries the VP20 ≥25% margin — but if two verifies overrun, the E4-raised envelope absorbs it; economy variant does not.
- INFO-007 TEAM-summary render is new surface in ATOM-072 (+~10k already inside its 70k) — if the render needs live data the repo lacks, executor escalates E1, not improvises.

## Erratum (logged, not silent — 2026-07-07, post-G1)

Role-atom ids ROLE-002/003 in the G1-accepted table collided with existing atoms
(ROLE-002 = venture-strategist, ROLE-003 = market-analyst, created 2026-07-05).
Ids renumbered to ROLE-004..008; tree shape, roles, budgets, sequencing —
unchanged (no OD7 replanning). Logged in run.log.
