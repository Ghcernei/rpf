---
atom: ATOM-071
product: Setup kit + execution tiers (deliverables §4.1 + §4.2 of ATOM-007 INPUT)
parent: Pilot Prerequisites v1 (ATOM-007; plan: 007-pilot-prerequisites/PLAN.md)
formulated_by: formulating agent (launch session), 2026-07-07
verification: independent (slim VP20) — feeds 4 lens atoms + founders (perimeter via G2)
maturity_target: reviewed
instantiation: subagent
model_tier: M
budget: ~110k tokens (raised per GATE-016 subagent-overhead calibration)
recursion_allowance: 0
---

# ATOM-071 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `products/pilot-prerequisites-v1/071-setup-kit/setup/` — files per §4 below |
| Atom ID | ATOM-071 |
| Executor role | pilot-toolsmith (`roles/pilot-toolsmith.md` — read it first, it is your identity) |
| Input product(s) | This INPUT; `products/business-strategy-v1/pilot/pilot-design.md` (timeline, consent context); `products/business-strategy-v1/STRATEGY.md` (self-hosted model §; execution tiers §); `decisions/INFO-006-atom-007-intake-decisions.md` (P5 setup minimum — verbatim CEO decision); `runtime/claude/README.md` (what the founder's runtime actually is) |
| Consumer(s) | 4 lens atoms (ATOM-073..076); pilot founders (via G2); the pilot operator |
| Verification mode | independent (slim VP20) |
| Budget envelope | ~110k tokens (GATE-016) |

## 2. Job To Be Done
A non-technical founder who said «да» is running their first atom **within 15
minutes, with zero technical questions asked of them** (INFO-006 P5). Deliver
the complete path from «да» to first atom: bootstrap + quickstart + the three
execution tiers explained in founder language.

## 3. Binding constraints (accepted decisions — do not reopen)
- Self-hosted: founder's machine, founder's runtime subscription (Claude Code),
  founder's **private repo** with the Qroky constitution as a dependency
  (repo-separation model per STRATEGY).
- The founder NEVER meets the words DoD, atom, verify, INPUT, gate in any
  founder-facing text — the machinery is invisible (INFO-006 P1). Internal
  file names the machinery uses are fine; explanatory prose is not.
- Founder-facing language: **Romanian primary, Russian mirror** (pilot is
  Moldova; consent is RO/RU per INFO-006). Scripts and code comments: English.
- Execution tiers to deliver: **inline / micro / full** per STRATEGY — what
  each is, when each applies, what the founder sees in each.

## 4. Deliverable (all under `071-setup-kit/setup/`)
1. `bootstrap.sh` — one command from «да» to ready repo: creates the private
   repo structure, vendors/references the constitution (`qroky/framework` as
   dependency — pinned, read-only), installs the runtime binding, verifies
   prerequisites (git, Claude Code CLI) and **tells the founder in plain words
   what to do** if one is missing (that is not a «technical question» — it is
   the script doing the work). Idempotent; fails loudly, never silently.
2. `QUICKSTART.ro.md` + `QUICKSTART.ru.md` — founder-facing, substance-identical:
   the ≤15-minute path, step by step, each step timed; what the founder will
   see; where their first conversation starts. Zero method jargon.
3. `TIERS.ro.md` + `TIERS.ru.md` — the three execution tiers in founder terms
   («быстрый ответ / короткая проработка / полная проработка с проверкой»),
   when each fires, what each costs in waiting time, founder-visible behavior.
4. `dry-run.sh` + `dry-run-transcript.txt` — scripted timed dry run on a clean
   machine profile (temp dir, no repo): runs bootstrap end-to-end, stamps
   elapsed time, records every prompt shown. The transcript is DoD evidence.

## 5. Definition of Done
**Hard criteria:**
- H1. All 6 files of §4 exist at the named paths. Check: ls.
- H2. `dry-run-transcript.txt` shows elapsed ≤ 15 min and **zero questions
  requiring technical knowledge** (any question in the transcript is listed at
  its end with a one-line classification). Check: transcript.
- H3. `grep -iE "DoD|атом|atom|verify|INPUT|гейт|gate" QUICKSTART.*.md TIERS.*.md`
  returns zero founder-facing hits (English machinery words inside file paths /
  code spans excepted — list any such spans in RESULT). Check: grep.
- H4. RO and RU renders are substance-identical (same steps, same numbers, same
  promises) — self-attested by a point-by-point table in RESULT. Check: table.
- H5. `bootstrap.sh` passes `bash -n` (syntax) and the dry run exits 0. Check: script output.
**Soft criteria:**
- S1. A non-technical founder could follow QUICKSTART alone, unaided — judge: Verify agent (UX lens verdict arrives later; Verify judges from the founder's chair).
- S2. Tier descriptions are honest about waiting time and cost — no marketing gloss — judge: Verify agent.

**Maturity target:** reviewed. Do not gold-plate.

## 6. Method Hints (non-binding)
- The dry run may stub the actual Claude Code invocation (network-free) — what
  must be real is the repo bootstrap, timings, and the founder-visible flow.
- Steal accepted wording from pilot-design.md rather than inventing parallel
  phrasing.
- Keep QUICKSTART under ~80 lines per language: the founder reads it once.

## 7. Obligations & Escalation
Write `STATUS.md` (state transitions, UTC), `RESULT.md` (per ATOM-SPEC §6.2:
DoD check table, cost block with your real token estimate), `workspace/run.log`
(key decisions, pre/post checks). Do NOT touch status.yaml (orchestrator syncs).
Escalate (write `ESCALATION.md`, stop) on E1 (missing/contradictory input) —
e.g. STRATEGY's tier definitions insufficient to write TIERS honestly. Otherwise
execute; do not ask permission on the normal path.
