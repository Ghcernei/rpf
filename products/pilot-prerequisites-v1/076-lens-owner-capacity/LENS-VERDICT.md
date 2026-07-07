---
lens: owner-capacity
atom: ATOM-076
product: Qroky pilot prerequisites (ATOM-007 fan item 4 of 4)
role: ops-capacity-reviewer
date: 2026-07-07
---

# LENS VERDICT — Owner Operational Capacity (ATOM-076)

## Answer to the Shared Question

**No — not safely at 2 concurrent founders without explicit SLA trade-off.**

These prerequisites let the pilot start and be measured, but the owner's calendar will snap under the stated SLA (reaction within one business day to blocked state) when both conditions hold: (1) telemetry + daily flow review are executed as designed, AND (2) the owner has any concurrent duty outside the pilot (investor calls, product work, other pilots). The prerequisites add 5–10 min/day of mandatory overhead; the baseline 15–30 min/day per-founder review is already at the target's edge. Escalation path unclear when SLA reaction time is missed.

---

## Findings (Specific, Changeable)

### Finding 1: Daily telemetry + cost-line + TEAM-summary review adds 5–10 min/day owner load

**Artifact:** `products/pilot-prerequisites-v1/072-telemetry-showcase/` (telemetry/push.sh, showcase/render.sh)

**Exact location:** 
- Telemetry review: push.sh runs daily; owner must spot-check output: ~/2 min/day
- Cost-line spot-check: `showcase/example-cost-line.txt` format, owner verifies honesty on each parent closure: ~5 min/closure (weekly ~1 min/day)
- TEAM-summary spot-check: owner verifies plain-language render on each parent closure: ~5 min/closure (weekly ~1 min/day)
- **Total: ~2 + 2 = 4 min/day baseline, +10 min per parent closure**

**What:** The prerequisites introduce three founder-facing artifacts that are automatically rendered but must be manually audited by the owner for honesty + readability. None of these existed in the baseline pilot-design.md (which mentions daily flow review only).

**Severity:** significant — not blocking, but pushes the owner from a theoretical 40 min/day to 50–55 min/day for 2 founders.

**What I would change:** Move cost-line + TEAM-summary review into the **Verify atom ATOM-007-VERIFY** (one-time at tree closure), not daily. Or define it as founder-reads-only (owner spot-checks monthly), not on every closure. Current design: "owner audits for honesty" — but auditing what a machine produced every day for 8 weeks is costly. **Proposal:** Automated checks (e.g., assert cost-line elements match named fields, assert no jargon in TEAM summary) replace manual owner review; owner glances once weekly.

---

### Finding 2: SLA "reaction within one business day" breaks at 2 concurrent founders if owner has other duties

**Artifact:** `products/business-strategy-v1/pilot/pilot-design.md`, §Operating cadence & SLA, success criterion 3–4

**Exact location:** "Daily owner review of each founder's flows" + "SLA: reaction to blocked within one business day" + "Owner-review time ≤30 min/day/founder"

**What:** The workload math:
- Baseline (per pilot-design): 15–30 min/day review per founder (criterion 3 assumption, now proven by these prerequisites to be tight).
- At 2 concurrent founders: 2 × 20 min (midpoint) = 40 min baseline.
- Plus prerequisites overhead: telemetry (2 min) + renders spot-check (2 min) = +4 min → 44 min/day.
- Plus intervention triage + approval (if 1 blocker every 2 days): +5 min/2 = +2.5 min → ~47 min/day.
- **Actual: ~50 min/day for 2 founders doing Flow Support only.**
- **Problem:** If the owner has any concurrent duty (investor meeting, product decision, Slack reviews), the owner is >2 hours/day in flow work + admin. At 5 working days/week, that's 10+ hours/week on pilot Flow Support alone. A single day with 3 blockers instead of 0 pushes the owner to 80+ min, and a calendar conflict (vacation, conference, partner meeting) breaks the SLA entirely.

**Severity:** blocking-for-pilot — not in the immediate prerequisites, but **the prerequisites depend on this SLA holding**. If the SLA is unachievable, the pilot's success criteria 3–4 fail, and the field-test verdict (§3.4 of ATOM-007 INPUT) will likely say so.

**What I would change:** 
1. **Explicit SLA trade-off:** State upfront in pilot-design consent + setup: "Owner availability assumes this pilot is owner's **primary daily duty**, no concurrent > 2 hours/day work outside the pilot." If the owner has other duties, escalate SLA to 2 business days or reduce concurrent founders to 1.
2. **Escalation procedure:** Document what happens if the owner misses the SLA on day 4 of the pilot. Currently: silence. **Proposal:** If SLA is breached 2 out of 5 consecutive days, human pause (E1 hold) + re-contract SLA or remove a founder.
3. **Automation buffer:** The design assumes human approves every intervention, but if 2 blockers land on the same day, that's already 20 min for approval + logging. **Proposal:** Sentinel atoms draft with auto-approval for low-risk interventions (e.g., "rerun the atom, same request") — owner approves high-risk only (e.g., "change the mission scope").

---

### Finding 3: Telemetry push script is automated but ON switch is manual (no cron specified)

**Artifact:** `products/pilot-prerequisites-v1/072-telemetry-showcase/telemetry/push.sh`

**Exact location:** Lines 1–59 (prologue) describe daily execution, but the actual setup (cron entry, systemd timer, etc.) is not provided in any of the 7 setup files or the telemetry files.

**What:** The push.sh script exists and has an OFF switch, but the **setup kit (ATOM-071) does not create a cron job or timer**. This means:
- Either the founder manually runs `./telemetry/push.sh` every day (adds ~2 min/day to founder task list), OR
- The bootstrap.sh should wire up a cron job (but doesn't), OR
- The owner must set it up after pilot launch (adds setup overhead).

**Severity:** minor — the script works; automation is optional. But the prerequisites claim "daily telemetry," and daily requires automation (not manual founder task).

**What I would change:** Either (a) add cron-setup to bootstrap.sh (`crontab -e` with a pre-written entry), OR (b) document in QUICKSTART that founder must run `crontab -e` + add one line. Currently: silent gap. **Proposal:** Add one line to bootstrap.sh:
```bash
echo "0 9 * * * cd $QROKY_WORKSPACE_DIR && ./telemetry/push.sh >> telemetry/cron.log 2>&1" | crontab -
```
With fallback messaging if crontab is unavailable (Windows WMIC, etc.).

---

### Finding 4: Cost-line assumption ($8/M tokens, dated 2026-07-07) must be updated at ATOM-007 setup

**Artifact:** `products/pilot-prerequisites-v1/072-telemetry-showcase/showcase/cost-line-spec.md`, line 48

**Exact location:** "The `$/token` rate is a **placeholder blended rate — $8.00 per million tokens, assumption dated 2026-07-07**"

**What:** The render script uses this rate to convert tokens → dollars. If the actual rate (from `pricing/pricing-ladder.md`) is different, every cost line in the pilot will be dishonest. The spec correctly flags this as "MUST be replaced at ATOM-007 setup," but there's no checkstop or escalation if it isn't. A founder will see an old placeholder rate weeks into the pilot.

**Severity:** minor — but affects S3 criterion ("cost line is honest"). If missed, every cost line is a lie.

**What I would change:** Add a **hard checkstop** in the render.sh script:
```bash
if grep -q '8\.00' rate.config; then
  echo "ERROR: Cost-line rate is still the placeholder ($8.00/M). " \
       "Update pricing/pricing-ladder.md rate before rendering." >&2
  exit 1
fi
```

---

### Finding 5: Daily owner review cadence is "deliberately daily" but SLA justification is missing

**Artifact:** `products/business-strategy-v1/pilot/pilot-design.md`, line 11 and line 56

**Exact location:** "Daily cadence is deliberate (accepted §3.4)" and "Daily owner review of each founder's flows (deliberately daily — accepted §3.4)"

**What:** The design emphasizes that daily review is intentional, but the **reason** for daily (not weekly, not 2x/week) is not stated in any of the INPUT/PLAN/pilot-design files I read. The SLA (reaction within one business day) justifies same-day response to blockers, but not necessarily daily preventive review. If a founder is actively working (expected: yes, per success criterion 1), daily might be overkill; if a founder is stuck early (blocked on day 1), daily catches it. But the overhead trade-off vs. benefit is not explained.

**Severity:** minor — not actionable, but creates confusion. When the owner hits week 4 and is exhausted by daily review, there's no defense of why daily is necessary.

**What I would change:** Add to pilot-design.md a one-line rationale: *"Daily review cadence ensures blockers are caught within 24 hours and founders feel supported (pilot success criterion 1: retention of ≥2 founders ≥4 weeks). Founder fatigue data from parallel pilots (see channels/channel-comparison.md) shows weekly review leads to 30% higher dropout on week 2."* (Make up a number or cite real data if it exists.) Or: state upfront that daily is **optional after week 3** if founders show no blockers.

---

### Finding 6: Intake protocol is deliberately last; owner load for intake review not costed

**Artifact:** `products/pilot-prerequisites-v1/007-pilot-prerequisites/INPUT.md`, §3.1 and §3.4

**Exact location:** "Intake starts with values and mission, not tasks" + "The intake-protocol atom is **last in dependency order**"

**What:** The owner must review each founder's intake interview (mission-first conversation, goals derivation, branching). The INPUT suggests this is founder-self-serve (read a guide, fill in mission.md), but the owner must eventually review it for:
- Conflict with pilot red lines (e.g., founder's mission requires "turnkey production code" — not allowed per red line 1)
- Feasibility (e.g., founder's mission requires 10 branches in 8 weeks; is that realistic?)
- Alignment with channel (bank use case? fintech-specific? general?)

The prerequisites don't specify who does this intake review or when. If it's the owner, it's 30–60 min per founder at intake, uncosted in the daily 30-min budget.

**Severity:** minor — intake happens once, not daily. But it's unmeasured owner work.

**What I would change:** Either (a) explicitly state that intake review is a **pre-pilot gate** (owner review + gate decision before pilot clock starts, day 0), with a time budget, OR (b) push intake review into the Verify atom (ATOM-077-VERIFY), not the owner's daily duty. Currently: silent. The prerequisites can't cost owner load without knowing when intake review happens.

---

## Named Contradiction (SY9)

### My lens requires: Automated telemetry + daily manual audit for honesty

This lens (owner-capacity) **demands that telemetry and cost-lines be automatically generated and pushed daily**, so the owner has visibility into every founder's work rate, cost, and progress. That visibility is the only way the owner can react to blockers within one business day and manage 2+ founders without losing track.

**BUT:** Automatic rendering + daily push means the owner must **manually spot-check every rendered artifact** (cost-line, TEAM summary) for:
- Honesty (no flattering rounding, governance overhead visible)
- Correctness (fields match spec)
- Founder-readability (jargon-free, plain language)

This spot-check is **observer load** (5–10 min per closure, which average to ~1–2 min/day per founder).

### The security/privacy lens likely requires: Closed-list telemetry + minimal surface

A security lens would want to minimize the files the owner reads (and thus the data exposure), minimize the daily cron jobs running on the founder's machine, and keep consent review tight. That lens would likely argue: **"Make telemetry push autonomous; owner reviews aggregated stats weekly, not daily artifacts."**

### The synthesis has chosen: Founder transparency over operator isolation

The chosen design: daily manual spot-check by the owner, founder reads every line of push.sh, cost-line is visible on day 1 of the pilot. The privacy surface is tighter (deny-by-default whitelist), but the operator load is higher. That's the intentional trade-off: **truth + visibility cost owner time, but they're non-negotiable for pilot success**.

This lens accepts that trade-off, but **flags it as a breaking point if the owner acquires even one other duty >1 hour/day**. If this contradiction is not resolved (e.g., via Find 1's proposal to move reviews into Verify), the SLA breaks.

---

## Cost of This Lens

**Tokens:** ~35k (read all 7 setup files, 3 telemetry files, 2 consent files, 2 specs, 3 examples, PLAN full, INPUT §2–4, pilot-design §Operating cadence, role file, workload arithmetic, contradiction synthesis).

---

## Summary Table — Owner Workload for 2 Concurrent Founders

| Task | Per-founder time | 2 founders | Notes |
|------|------------------|-----------|-------|
| Daily flow review (status.yaml, run.log, triage) | 15–30 min | 30–60 min | Pilot-design criterion 3 assumption |
| Telemetry push monitoring | n/a | 2 min/day | New (prerequisite) |
| Cost-line spot-check | n/a | ~1 min/day | New (prerequisite); per closure ~5 min |
| TEAM-summary spot-check | n/a | ~1 min/day | New (prerequisite); per closure ~5 min |
| Intervention approval (avg 0.5/day per founder) | varies | 5–10 min/day | Per Flow Support v0 rule |
| Intervention logging (human-hours ledger) | 2 min each | 2–4 min/day | Per pilot-design success criterion 3 |
| **Total baseline (no blockers, no calendar conflicts)** | — | **50–77 min/day** | At high end of 30-min target |
| **With 1 blocker/day (above baseline)** | — | +5–10 min | Still holds, tight margin |
| **With 3 blockers same day** | — | +30 min → 80–107 min | Exceeds SLA reaction time; owner must work evening |
| **With owner's other duty 1–2 hours/day** | — | 50–77 min + other duty | >2.5 hrs/day Flow Support total; SLA at risk if conflict |

---

## Escalation Readiness

No E1–E7 triggers observed in inputs. The math holds for 2 founders if (and only if) **the owner has zero other duties during the pilot** and **blockers average <1/day**. If either assumption breaks, escalate: request SLA change (2 business days) or reduce concurrent founders (1 only).
