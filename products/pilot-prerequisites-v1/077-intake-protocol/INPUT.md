---
atom: ATOM-077
product: Intake protocol — the mission-first onboarding conversation (§4.4 of ATOM-007 INPUT)
parent: Pilot Prerequisites v1 (ATOM-007; PLAN.md — deliberately last in dependency order)
formulated_by: formulating agent (launch session), 2026-07-07
verification: independent (slim VP20) — perimeter
maturity_target: reviewed
instantiation: subagent
model_tier: M
budget: ~170k tokens (GATE-016/017 calibration)
recursion_allowance: 0
---

# ATOM-077 — Input Specification (intake protocol)

## 1. Identity
| Field | Value |
| :---- | :---- |
| Atom ID | ATOM-077 |
| Executor role | venture-strategist (`roles/venture-strategist.md` — read first) |
| Input product(s) | ATOM-007 INPUT §3.1/§3.4 (`products/pilot-prerequisites-v1/007-pilot-prerequisites/INPUT.md` — the CEO's verbatim intake decisions); `products/pilot-prerequisites-v1/007-synth/SYNTHESIS.md` (register №10, №17 + per-lens findings you must absorb); `decisions/GATE-018-…` (E8 answers + «двух достаточно» reserve closure); `decisions/INFO-007-…` + `decisions/INFO-009-…` (lessons 2 and 5, verbatim); `products/pilot-prerequisites-v1/071-setup-kit/setup/QUICKSTART.ro.md` (the flow you hand over to); `products/business-strategy-v1/pilot/pilot-design.md` (success criteria the intake must serve) |
| Consumer(s) | Pilot founders (the FIRST thing they experience — perimeter); the pilot operator; mission.md consumers (every future atom of the founder's tree) |
| Verification mode | independent (slim VP20) |
| Budget envelope | ~170k tokens |

## 2. Job To Be Done
The onboarding conversation whose **first product is the founder's
`mission.md`**: value-constraints («минимум ухода», «не отдам 30% equity»),
a mission without metrics, a perimeter of the unacceptable. Goals and the
first product branches are DERIVED from it — never collected as a task list.
The founder sees a conversation; the machinery stays invisible.

## 3. Binding constraints (accepted — do not reopen)
- Mission-first (INFO-006 P1, verbatim in the parent INPUT §3.1).
- Intake asks the **detail-level question once** (INFO-009): 1 результат /
  2 широкие мазки [дефолт] / 3 детально — recorded in the founder's profile;
  switchable later by plain words.
- Field-test lessons section is CLOSED with the two delivered lessons
  (GATE-018: «двух достаточно»): №1 — as-is inventory mandatory for
  transformational tasks (inventory + explicit preserve/change/remove list
  BEFORE to-be design; transformational vs greenfield paths differ); №2 —
  the team must be visible (the intake conversation SETS this expectation:
  the founder will see who works via TEAM summaries).
- Cost-plan section (register №10): the conversation covers what things cost
  in the tiers, including tier auto-escalation with a worked example.
- Founder-facing language RO primary + RU mirror; operator guide language RU.
- Jargon ban (DoD S1 of the parent): the founder never meets DoD/atom/verify/
  INPUT/gate words.

## 4. Deliverable (all under `077-intake-protocol/intake/`)
1. `INTAKE-GUIDE.md` — operator's conversation guide (RU): flow from values →
   mission → perimeter → derivation of goals and first branches; the
   detail-level question; the cost-plan passage; the as-is inventory branch
   for transformational cases; machinery-hiding rules (what the operator may
   and may not say); expectation-setting for TEAM summaries and the cost line.
2. `mission-template.ro.md` + `mission-template.ru.md` — founder-facing
   template: value-constraints, mission without metrics, perimeter of the
   unacceptable; short, warm, jargon-free.
3. `derivation.md` — operator-facing (RU): the explicit method by which goals
   and first product branches are derived FROM mission.md values (worked
   example included), and the test that catches a disguised task list.
4. `field-test-lessons.md` — the two lessons verbatim + closure note
   (GATE-018) + how each shaped this guide.

## 5. Definition of Done
**Hard:**
- H1. All 5 files exist at the named paths. Check: ls.
- H2. Jargon grep zero-hit on the two mission templates (RO/RU). Check: grep.
- H3. RO/RU templates substance-identical (point table in RESULT). Check: table.
- H4. The guide contains: detail-level question, cost-plan passage with
  auto-escalation example, as-is inventory branch, TEAM-summary expectation
  line. Check: grep/read.
- H5. field-test-lessons.md quotes both lessons verbatim from the records and
  the closure decision. Check: diff vs decision files.
**Soft:**
- S1. The derivation method genuinely derives goals from values — a disguised
  task-list intake would fail its own §4.3 test — judge: Verify agent.
- S2. A founder reading the templates feels invited, not processed — judge:
  Verify agent.

## 6. Obligations & Escalation
STATUS.md, RESULT.md (DoD table + cost block + real estimate),
workspace/run.log in your folder. Do NOT touch status.yaml or other atoms'
files. E1 (ESCALATION.md + stop) only on true contradiction; otherwise execute.
