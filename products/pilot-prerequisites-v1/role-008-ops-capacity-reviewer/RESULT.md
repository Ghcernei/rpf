---
atom: ROLE-008
product: roles/ops-capacity-reviewer.md
status: delivered
verified: 2026-07-07T07:12:00Z
---

# ROLE-008 — Execution Result

## Product
`roles/ops-capacity-reviewer.md` — 42 lines; frontmatter + 6 sections (Identity, Capabilities, Method Defaults, Escalation Posture, Provenance)

## Definition of Done — Hard Criteria

| Criterion | Check | Status |
| :---- | :---- | :---- |
| **H1** File exists, 30–50 lines, follows venture-strategist section set | wc -l confirms 42 lines; sections: frontmatter, Identity, Capabilities, Method Defaults, Escalation Posture, Provenance; frontmatter description states ATOM-076 consumer | **PASS** |
| **H2** Capabilities >=5 bullets, specific to §2, no filler | 6 bullets: daily review load, SLA reaction-time, intervention-approval overhead, sustainable cadence calculation, breaking points, single-point-of-failure detection; all tied to hours-per-week and founder-pair load arithmetic | **PASS** |
| **H3** Escalation Posture names E1–E8 triggers + what role decides alone | Escalation: missing calendar, unknown availability, conflicting SLAs, >20% overage. Decides alone: itemized time budgets, collision detection, breaking-point math, spike/baseline split. | **PASS** |
| **H4** Provenance table: Created / ROLE-008 / 2026-07-07 | Table present; Created, ROLE-008, 2026-07-07 | **PASS** |

## Soft Criteria

| Criterion | Self-Judge | Status |
| :---- | :---- | :---- |
| **S1** Stranger could role-play from file alone | Identity establishes audit voice (not cheerleader); Capabilities drill into specific math (itemized, hours, calendars, SLAs, breaking points); Method Defaults show work; Escalation Posture is bounded and clear. A stranger reads "calculate hours-per-week, flag breaking points, don't sugar-coat" and knows what to do. | **PASS** |

## Cost & Efficiency

| Metric | Value |
| :---- | :---- |
| Input tokens | ~2.1k (INPUT.md + template read) |
| Output tokens | ~0.9k (role file + this result) |
| Total estimated | ~3.0k |
| Budget envelope | ~12k |
| Burn rate | 25% |

## Verdict
✅ All hard criteria pass. Role is draft-ready for ATOM-076 intake lens.
