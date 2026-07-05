---
atom: ATOM-002
product: FEV & Escalation Protocol (framework/FEV-PROTOCOL.md)
status: delivered
maturity_claimed: draft (target reviewed — pending independent Verify + human sign-off, M3)
cost:
  units_in: ~32000          # estimated; ATOM-SPEC + launch file + ATOM-001 full record + own INPUT
  units_out: ~13000         # estimated; protocol + 3 decision records + step-0 materialization + metadata
  unit: tokens
  wall_time: ~10m
  executor: claude-fable-5 (session instantiation per INPUT)
  sub_atoms_spawned: 1      # ROLE-001 (prerequisite role-creation atom, executed in strict sequence per launch file)
  sub_atoms_cost: ~5500     # ROLE-001 aggregate (~4000 in + ~1500 out), per O4.2; Verify cost to be added by parent as separate line (VP5)
---

# RESULT — ATOM-002

## Summary
Produced `framework/FEV-PROTOCOL.md` (304 lines) — the executable protocol for the "govern" half of the framework: Formulate mechanics (FP1–FP13: DoD authoring, ordered verification-depth assignment, gate placement), the Verify operating manual (VP1–VP19: blind package, execution steps, findings/verdict/return formats, re-verify scope, anti-rubber-stamp), per-trigger escalation routing E1–E7 (EP1–EP7), decision recording (DR1–DR8), and exactly three fenced templates (`VERDICT.md`, decision record, `GATE-BRIEF.md`). Backfilled the three founding decision records under `/decisions/` as the template's validation examples. Both precedents encoded: ATOM-000 negative (P0.3 self-waiver generalization, EP6), ATOM-001 positive (§2.7 canonical run, reproducible step by step).

## Deliverables
| File | Purpose |
| :---- | :---- |
| framework/FEV-PROTOCOL.md | The product — FEV & Escalation Protocol v1 |
| decisions/GATE-001-standalone-harness.md | Backfill: standalone harness, vendored conventions (§4.5) |
| decisions/RISK-001-claude-first-neutral-core.md | Backfill: platform risk acceptance (§4.5) |
| decisions/GATE-002-atom-001-acceptance.md | Backfill: ATOM-001 human acceptance (§4.5) |
| products/framework-v1/002-fev-protocol/{INPUT,STATUS,RESULT}.md + workspace/run.log | Atom record |

## DoD Self-Check
| Criterion | Result | Evidence |
| :---- | :---- | :---- |
| H1 file exists, 250–800 lines | met | `wc -l` = 304 |
| H2 five protocol sections by headings | met | grep '^## ': 1. Formulate Protocol / 2. Verify Protocol / 3. Escalation Protocol / 4. Decision Recording / 5. Templates |
| H3 exactly three fenced templates, YAML frontmatter | met | `grep -c '^```'` = 6 (3 open + 3 close); each opens with `---` YAML block |
| H4 zero platform/product names | met | grep -c -E 'Claude Code\|MCP\|Codex\|OpenClaw\|Hermes\|BMAD' = 0 |
| H5 ≥3 conforming files under /decisions/ | met | 3 files; all contain mandatory frontmatter fields (DR4) and four mandatory sections |
| H6 all ATOM-SPEC references resolve, zero contradictions | met | script: 40 distinct cited ids, each defined as rule or table row in ATOM-SPEC; 0 unresolved; every FP/VP/EP/DR statement tightens or operationalizes — none relaxes |
| H7 RESULT with cost block incl. ROLE-001 aggregate; STATUS delivered | met | this file (sub-atom line per O4.2); STATUS.md last line = delivered |
| S1 Verify could run ATOM-001-style verification without improvising | self-reviewed | VP2 package → VP7 steps → VP11–VP14 formats → VP16 re-verify; §2.7 maps the precedent 1:1 (judge: Verify agent) |
| S2 every normative statement testable | self-reviewed | MUST/MUST NOT/SHOULD/MAY per R0.1; purpose-tests attached where behavioral (VP10, EP7) |
| S3 tightens, never relaxes ATOM-SPEC | self-reviewed | header rule: on apparent relaxation ATOM-SPEC prevails + report; FP9 downward-override restriction is a tightening |
| S4 backfilled records usable as precedents | deferred | judge: human (VP9 discipline applies to own DoD) |
| S5 core readable ≤ 12 min | self-reviewed | core (excl. templates §5) ≈ 200 lines, table-heavy |

## Decisions Made by Executor
1. **Rule prefixes** P0/FP/VP/EP/DR/TP — no collisions with ATOM-SPEC prefixes (P0.2); citable side by side.
2. **Verify identity/location** (VP6): id `<target>-VERIFY`, sibling folder `<target-folder>-verify/` — placeholder until the repository-structure product fixes layout; reversible.
3. **Verdict versioning** (VP17): current always `VERDICT.md`, superseded rounds renamed `VERDICT-round-<k>.md`, never edited — append-only ethos without a filename scheme change.
4. **FP9 asymmetric overrides**: downward verification-depth override requires recorded human risk acceptance — derived from P0.3 generalization of O6.2; tightens F3, does not relax.
5. **EP3 record-embedded question sets**: the escalation question set lives inside the pending decision record (one file: question → answer → feedback), rather than a separate escalation file.
6. **DR3 id assignment at record creation** (not reserved at Formulate) — avoids id collisions across parallel atoms.
7. **VP18 recording of human acceptance**: `gate` record for `independent + human` acceptance; `risk-acceptance` for `production` sign-off — maps cleanly onto O8.1's three products.
8. **VP12 minor-only accept**: with only `minor` findings Verify MAY accept-with-findings; on any return all open findings (incl. minors) enter the fix list — matches the ATOM-001 precedent.
9. **VP14 dispute path**: executor believing a fix-list entry wrong routes one question set to the formulating agent (E7-analogous), never skips or reinterprets.
10. **Step-0 folder naming** `role-001-framework-architect/`, `002-fev-protocol/` — follows the `001-atom-spec` convention.

## Deviations & Known Limitations
- Cost figures are estimates (`~`) — no exact token meter on this runtime (same limitation ATOM-001 recorded).
- Finding numbers (`F1..Fn`) visually resemble ATOM-SPEC Formulate rules F1–F6; context disambiguates (findings exist only inside a verdict), but Verify may consider whether VP11 should scope them explicitly.
- The three backfilled answers are reconstructions from source documents, marked per DR5 — S4 judgment on their usability belongs to the human.

## Handoff
Verification mode: `independent + human`. Verify receives (VP2): DoD (INPUT.md §5) + `framework/FEV-PROTOCOL.md` + the three `/decisions/` files + this RESULT.md and STATUS.md (cited by H7) + reference standard `framework/ATOM-SPEC.md` (cited by H6) + round/returns counters. Human sign-off after Verify acceptance; S4 judged by human at that step.
