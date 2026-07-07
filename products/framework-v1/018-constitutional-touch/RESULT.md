---
atom: ATOM-018
product: Constitutional touch v1 (amendments to the five framework documents + human profile)
status: delivered
maturity_claimed: reviewed
cost:
  units_in: ~140k
  units_out: ~12k
  unit: tokens
  wall_time: ~35m
  executor: claude-fable-5
  sub_atoms_spawned: 0
  sub_atoms_cost: 0
  # O4.3 voluntary fields (this atom spawned nothing; carried per the rule this touch itself lands)
  total_descendants: 0
  max_depth_reached: 0
  subtree_cost:
    total: ~152k tokens / ~35m (own consumption only)
    execute: ~152k
    verify: 0
    role_creation: 0
    synthesis: 0
---

# RESULT — ATOM-018

## Summary
The constitution's first amendment touch. All ten queued items (T1–T10) — gate
reservations (GATE-010, GATE-011), the ATOM-006 framework findings, the full D7
detail (INFO-005), and the five outstanding forward references (SP5, SY1, GB5,
HP4, PM2) — are formalized in place across the five framework documents and
`roles/humans/ghenadie.md`. No rule was renumbered or deleted; new rules take
fresh numbers in existing prefix spaces; fulfilled forward references became
past-tense pointers («landed per ATOM-018»). Nothing was relaxed (R0.3); no E7
fired. Combined framework growth: +51 lines (+3.5%, cap 25%).

## Deliverables
| File | Purpose |
| :---- | :---- |
| `framework/ATOM-SPEC.md` | Amended: F3 precedence reference; E8 row in §5.7; O4.3 + informative purpose passage; §6.1 template E1–E8; §6.2 template subtree fields; §6.3 ROLE template E1–E8; Amended header row |
| `framework/FEV-PROTOCOL.md` | Amended: P0.2 HP-hosting note; FP14; VP20; §3.1 (HP2, HP3 migrated; HP6, HP7 new); DR4 + §5.2 template + EP2 E-range → E1–E8; §5.3 GATE-BRIEF template HP6–HP7 section; Amended header row |
| `framework/REPO-STRUCTURE.md` | Amended: NC1 `-SYNTH` row; NC7 + `SYNTHESIS.md` + `GATE-BRIEF-<gate-id>.md`; HP2/HP3 migration pointers; HP4 past-tense; Appendix A updated; Amended header row |
| `framework/ORCHESTRATION.md` | Amended: OD2 item 7; EC7; SS7; GB5 past-tense; §8.2 template perspective-map section; Amended header row |
| `framework/SYNTHESIS-PROTOCOL.md` | Amended: SP5/SY1/PM2 past-tense pointers; LF7 aligned to O4.3; Amended header row |
| `roles/humans/ghenadie.md` | Amended: HP6/HP7 decision-input preferences (GATE-010 reservation verbatim + GATE-011 S5 lesson); Provenance row |

## T1–T10 coverage (H1 — RC4 discipline)
| Queue item | Exact rule ids / sections amended |
| :---- | :---- |
| T1 — HP2 extension + plain-language briefs | FEV-PROTOCOL **HP6**, **HP7** (new, §3.1); §5.3 `GATE-BRIEF.md` template — new *Judged document & criteria (HP6–HP7)* section; `roles/humans/ghenadie.md` §Decision-input preferences + Provenance row |
| T2 — HP4 migration | FEV-PROTOCOL §3.1 hosts **HP2**, **HP3** (ids retained) + **P0.2** hosting note; REPO-STRUCTURE **HP2**, **HP3** → migration pointer lines, **HP4** → past-tense pointer, Appendix A language-routing bullet updated |
| T3 — F3 row-2 precedence | FEV-PROTOCOL **FP14** (home); ATOM-SPEC **F3** — one reference sentence to FP14 |
| T4 — Inline-conflation legality | ORCHESTRATION **SS7** (four conditions; outside them, per-INPUT authorization as before) |
| T5 — Slim-verify codification | FEV-PROTOCOL **VP20** (two conditions: script-checkable hard criteria; every product-cited file listed by path; plus normative ≥25% envelope margin; GATE-008 provenance informative) |
| T6 — Envelope discipline | ORCHESTRATION **EC7** (writing-heavy executors sized ×3.5 + ~40k per EC2 basis; EC1 2× floor = minimum, not calibration) |
| T7 — SYNTHESIS-PROTOCOL migrations | ATOM-SPEC §5.7 **E8 row**, §6.1 template §7 (E1–E8), §6.3 ROLE template (E1–E8); FEV-PROTOCOL **DR4**, §5.2 template `trigger`, **EP2** item 2 (E1–E8); REPO-STRUCTURE **NC1** (`-SYNTH` row), **NC7** (`SYNTHESIS.md`, `GATE-BRIEF-<gate-id>.md`); SYNTHESIS-PROTOCOL **SP5**, **SY1** → past-tense pointers; ORCHESTRATION **GB5** → past-tense pointer |
| T8 — Full D7 (INFO-005) | ATOM-SPEC **O4.3** (new) + *(informative)* purpose passage + §6.2 `RESULT.md` template frontmatter (`total_descendants`, `max_depth_reached`, `subtree_cost` with execute/verify/role_creation/synthesis breakdown); SYNTHESIS-PROTOCOL **LF7** alignment sentence |
| T9 — Perspective map in plan template | ORCHESTRATION **OD2** item 7 + §8.2 template *Perspective map* section; SYNTHESIS-PROTOCOL **PM2** → past-tense pointer |
| T10 — Amendment provenance | Mechanism (O9.1): an **Amended** row in each framework document's header table — `ATOM-018, 2026-07-07 — first constitutional touch (queue T1–T10)` — applied uniformly to all five; `roles/humans/ghenadie.md` (no header table) carries an equivalent row in its Provenance table. Rules changed cite nothing retroactively; fulfilled forward references cite «landed per ATOM-018» |

## DoD Self-Check
| Criterion | Result | Evidence |
| :---- | :---- | :---- |
| H1 coverage table, every row non-empty | met | Table above — 10/10 rows populated with exact rule ids |
| H2 E8 in §5.7; `-SYNTH` in NC1; `SYNTHESIS.md` + `GATE-BRIEF` in NC7 | met | grep: ATOM-SPEC L244 (E8 row); REPO-STRUCTURE L85 (NC1), L94 (NC7) |
| H3 §6.2 template subtree fields + four-type breakdown | met | grep: ATOM-SPEC L351–359 (`total_descendants`, `max_depth_reached`, `subtree_cost`, execute/verify/role_creation/synthesis) |
| H4 HP2–HP3 in FEV; REPO §4 pointer; ghenadie.md updated | met | grep: FEV L173–176 (HP2/HP3/HP6/HP7); REPO L154–156 (pointers); ghenadie.md L15, L21 |
| H5 ORCH §8.2 perspective-map section | met | grep: ORCHESTRATION L233 (inside the §8.2 fenced template) |
| H6 provenance mark in every touched document | met | grep -c ATOM-018: ATOM-SPEC 4, FEV 8, REPO 7, ORCH 5, SYNTH 5, ghenadie.md 1 |
| H7 no prefix collisions; declared fenced-block counts match | met | Fence lines: ATOM-SPEC 6 (=3, T2), FEV 6 (=3, TP2), ORCH 4 (=2, LP7), SYNTH 4 (=2, SY12); FP14/VP20/HP6/HP7/O4.3/SS7/EC7 each defined exactly once; no rule renumbered/deleted |
| H8 combined growth ≤ 25% | met | wc -l: pre 1450 (417/304/251/251/227) → post 1501 (431/324/253/265/228); +51 = +3.5% |
| S1 tightens-never-relaxes | self-reviewed | No obligation weakened; T5 codifies the human-accepted GATE-008 practice under two strict conditions plus a new MUST margin — judge: Verify |
| S2 minimal, no drive-by rewording | self-reviewed | Only T-queue positions touched; historical framing lines (e.g. FEV intro E1–E7) deliberately left — judge: Verify |
| S3 FP14 decides both ATOM-006 cases | self-reviewed | Consumers-counted-at-Formulate: six analyses and role specs each fed 1 named consumer → row 2 not triggered → `self`/`draft` legal; anything below the row needs the advance FP9 grant — judge: Verify |
| S4 cross-references resolve | self-reviewed | F3→FP14; SP5→§5.7 E8 row; SY1→NC1/NC7; PM2→OD2/§8.2; HP4→FEV §3.1; GB5→NC7; LF7→O4.3 — judge: Verify |
| S5 human acceptance | deferred | GATE-014 (brief must itself satisfy HP6–HP7: Russian summary of every amendment) |

## Decisions Made by Executor
1. T10 provenance mechanism: `Amended` header-table row (framework docs) / Provenance-table row (profile) — simplest uniform greppable mark.
2. HP2–HP3 migrate keeping their rule ids (never-renumber); hosted in new FEV §3.1; P0.2 declares the hosting; extensions numbered HP6–HP7 in the existing HP space.
3. T3 home = FEV-PROTOCOL FP14 (FP8 is where the row test is operational); ATOM-SPEC F3 carries the reference.
4. SS7 inline-conflation legality: four conditions (subagent/auto; verification untouched; no self-authored gate brief; SS1 logging + conflation line).
5. VP20 slim package: exactly the two INPUT conditions; the ≥25% margin made a normative MUST (a tightening); GATE-008 provenance informative.
6. EC7 scope: "writing-heavy" = executor atoms whose primary deliverable is normative or long-form prose (tier-L writing class).
7. E8 row points to SY8 for mechanics; EP4 table untouched (SY8 already carries the routing row).
8. O4.3 binds parent atoms (≥1 sub-atom); non-parents MAY omit; purpose text one *(informative)* passage.
9. T9: map section added inside the existing §8.2 fenced block (LP7 count stays 2).
10. GATE-BRIEF template gained an HP6–HP7 section so template-copying authors cannot miss the duty.
11. Found at self-verify: DR4, §5.2 template, EP2 item 2, and the §6.3 ROLE template still said E1–E7 — E8-gate records would have violated DR4; updated to E1–E8 within T7 scope. Historical intro framing left untouched.

## Deviations & Known Limitations
None. All hard criteria met; budget closed inside the envelope without a raise (~152k est. vs ~205k — no mid-flight counter, BC4 `~` discipline; the runtime-measured total should be recorded at closure per EC6). Verify should probe decision 11 (scope of the E1–E8 range updates) and decision 5 (MUST-strength margin) under the S2 no-drift lens.

## Handoff
Verification mode: independent + human. Verify receives: DoD (INPUT.md §5) + the six amended files + this RESULT.md and STATUS.md. Then GATE-014 — human acceptance; per HP6–HP7 (which this touch itself landed), the gate brief carries a Russian summary of every amendment and plain-language criteria.
