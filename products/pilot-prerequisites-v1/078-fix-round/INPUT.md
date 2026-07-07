---
atom: ATOM-078
product: Fix-round over the ATOM-071/072 artifacts per the synthesis register + E8 wiring + INFO-009 narrative spec
parent: Pilot Prerequisites v1 (ATOM-007; PLAN.md Addendum 2)
formulated_by: formulating agent (launch session), 2026-07-07
verification: independent (slim VP20 re-verify of changed artifacts)
maturity_target: reviewed
instantiation: subagent
model_tier: M
budget: ~170k tokens (GATE-016/017 calibration: many small edits × tool-call re-billing + 50k fixed)
recursion_allowance: 0
---

# ATOM-078 — Input Specification (fix-round)

## 1. Identity
| Field | Value |
| :---- | :---- |
| Atom ID | ATOM-078 |
| Executor role | pilot-toolsmith (`roles/pilot-toolsmith.md` — read first) |
| Input product(s) | `products/pilot-prerequisites-v1/007-synth/SYNTHESIS.md` (**the fix-priority register — your work order**); `decisions/GATE-018-atom-007-synthesis-e8-gate.md` (E8-1/E8-2 answers, verbatim); `decisions/INFO-009-field-test-lesson-5-run-transparency.md` (run-narrative spec, verbatim); the ATOM-071/072 artifacts you will edit |
| Consumer(s) | Founders + Startup Moldova (perimeter, via G2); ATOM-077; the parent closure (narrative render) |
| Verification mode | independent — slim re-verify after delivery |
| Budget envelope | ~170k tokens |

## 2. Job To Be Done
Land every register item marked «исполнитель» so the consolidated
«yes-with-conditions» becomes «yes»: the five blocking fixes, the significant
and minor items, the two answered E8 decisions wired into text and code, and
the new INFO-009 run-narrative added to the showcase. Where the register marks
a CEO text-choice (№3, №5, №9), implement BOTH variants side by side, clearly
labeled «вариант A / вариант B — выбор CEO на G2» — do not choose for him.

## 3. Work order (the register in `SYNTHESIS.md` §Fix-priority is canonical — read it in full; summary here)
- Blocking №1: rate checkstop in render.sh (refuse placeholder), disclaimer
  line in TIERS; no founder-visible dollar until a contract rate is written in.
- Blocking №2: consent's data-collection paragraph in plain language;
  file names into a marked technical footnote.
- Blocking №3: both variants (content filtering of the 4 whole-copied files
  vs honest whole-file disclosure) — CEO picks at G2.
- Blocking №4: bootstrap.sh installs push.sh + consent into the founder
  workspace and registers a real daily scheduler (cron/launchd) with explicit
  REPO_ROOT.
- Blocking №5: deletion-by-date and deletion-on-revocation mechanics — code
  or dated auditable runbook step (both drafted; runbook variant labeled for
  CEO confirmation); OFF triggers deletion path, not just push stop.
- Blocking №6: QUICKSTART step 0 — where bootstrap.sh comes from, which
  folder to open the terminal in.
- E8-1 wiring (GATE-018): TEAM summary local-only by default; separate
  explicit consent item «одну простую фразу о построенном можно показывать
  Startup Moldova» (RO/RU); render honors the flag (content line only when
  opted in); no INPUT.md reads in the perimeter-crossing path.
- E8-2 wiring (GATE-018): primary-duty commitment line + SLA-breach protocol
  (2 of 5 consecutive days → automatic pause + renegotiation) into consent
  and QUICKSTART expectations; drafted amendment diff for pilot-design.md
  saved as `workspace/pilot-design-amendment-proposal.md` (do NOT edit
  pilot-design.md itself — other tree's product; CEO applies at G2).
- Significant №9–№17 and minors №18–№22 per the register (№11 after-E8-1
  form now decidable: work_unit structural field, populated only under the
  opt-in flag; №20 render branch for parent atoms with descendants + graceful
  SYNTHESIS.md fallback — MUST be done before the parent's closure render).
- **INFO-009 (new)**: `showcase/narrative-spec.md` — spawn-brief and
  closure-debrief formats (meaning-language; sections mapped to named record
  fields like the other two specs), ≤5% subtree_cost budget rule, detail
  levels 1/2/3 with piercing events (E4/E8/E5); extend render.sh with a
  debrief render (worked example from THIS tree's real records — the fan and
  its synthesis are the perfect story).

## 4. Definition of Done
**Hard:**
- H1. Every register row marked «исполнитель» maps to a change; a coverage
  table in RESULT.md maps row № → file(s) → what changed. Check: table, every
  row non-empty or explicitly «CEO-на-G2, варианты готовы».
- H2. `bash -n` passes on every touched script; negative-test and OFF-switch
  test re-run green; new scheduler install is idempotent and dry-runnable.
  Check: outputs in run.log.
- H3. Founder-facing jargon grep (per ATOM-071 H3 pattern) still zero-hit on
  all touched RO/RU files. Check: grep.
- H4. E8-1/E8-2 texts quote GATE-018 semantics exactly (opt-in wording;
  2-of-5 protocol); both CEO-choice items present as labeled A/B variants.
  Check: grep + read.
- H5. narrative-spec.md exists; render.sh produces a debrief worked example
  from this repo's real records; ≤5% budget rule stated. Check: files + run.
**Soft:**
- S1. Fixes are minimal — no drive-by rewording beyond the register (the
  ATOM-018 S2 discipline) — judge: re-verify agent.
- S2. The debrief example reads like a story a founder would actually read —
  judge: re-verify agent.

## 5. Obligations & Escalation
STATUS.md, RESULT.md (coverage table + cost block + real estimate),
workspace/run.log in `products/pilot-prerequisites-v1/078-fix-round/`. Do NOT
touch status.yaml, pilot-design.md, or anything outside the 071/072 artifact
folders + your own folder. Escalate E1 (ESCALATION.md + stop) only if a
register row is unimplementable as written; otherwise execute.
