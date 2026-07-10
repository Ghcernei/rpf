---
atom: ATOM-103
product: kit v0.1.2 — the «qroky start» gesture ships and gets wired (fix of the first G2 dry run's BLOCKING finding)
status: delivered (awaiting targeted blind re-check + G2 re-run by CEO)
maturity_claimed: self-checked (harness 11/11; maturity_target "reviewed" needs the CEO's G2 re-run)
cost:
  units_in: ~130k          # estimate (BC4): closed read list — install.sh, dry-run.sh, source SKILL.md, 3 locales, 3 READMEs, harness-checklist, core-card, 101/RESULT, 102/INPUT, role file, status.yaml
  units_out: ~30k          # estimate (BC4): vendored skill + step_gesture + 3 locales + 3 READMEs + scenario 10 + records; one network interruption mid-run, no rework lost
  unit: tokens
  wall_time: ~50m
  executor: pilot-toolsmith (fresh instance, tier M per INPUT frontmatter)
  sub_atoms_spawned: 0
  sub_atoms_cost: 0
---

# RESULT — ATOM-103 (kit v0.1.2)

> Version chain: v0.1.0 + v0.1.1 are recorded in
> `../101-distribution-installer/RESULT.md`. This v0.1.2 record lives HERE
> because ATOM-103's perimeter forbids any edit to the 101/102 folders —
> the stricter reading of «RESULT.md append v0.1.2» (S6), declared in
> `workspace/run.log`, not silent.

## The finding fixed (G2 dry run, BLOCKING)

Install on a clean Mac finished green in 202s — but the finale's promise
«Say: qroky start» was empty on any machine but the author's: the skill
file was not in the distributed repo at all, and no install step wired any
trigger. v0.1.2 makes the closing promise true on the target machine.

## What changed

1. **The gesture ships in the repo** — `runtime/claude/skill/qroky/SKILL.md`
   vendored from the author-machine source (`~/.claude/skills/qroky/SKILL.md`,
   read-only). Hygiene pass only, protocol content untouched: author-machine
   paths generalized (`~/Work/rpf/framework/` → "the framework source (in a
   kit install, the pinned `framework/` folder at the top of your
   workspace)"; `~/Work/_BUSOS...` examples → repo-record references without
   paths); the provenance table kept with its INFO references (paths
   generalized to `rpf`/`_BUSOS`), plus one new row for this vendoring;
   `~/.claude/qroky/delegation.log` KEPT — it is part of the protocol.
2. **install.sh `step_gesture`** — automatic (no question; the interview
   inventory stays EXACTLY 8), runs right after framework vendoring. Wires
   the gesture at PROJECT level only (skill rule I3 — never `~` or system
   paths): copies the vendored file to
   `<workdir>/.claude/skills/qroky/SKILL.md` (only when missing or
   different, `cmp -s`) and appends a marker-guarded trigger block
   (`<!-- qroky-gesture:start/end -->`) to `<workdir>/CLAUDE.md` — message
   starting with «кроки»/«qroky» (case-insensitive, incl. «qroky start») →
   follow the skill file; one line hands the NARRATIVE/mission orientation.
   Same state-machine discipline: `step_gesture` field in
   `install-state.json`, check→do, re-run = health-check no-op, ladder-
   wrapped (≤2 auto-retries), loud concrete failure (rulebook copy predates
   v0.1.2 → `--apply-update` / ask the kit provider), plain-language
   announcement line in all three locales.
3. **Finale + READMEs truth fix** — finale step 1 gains the VS Code line
   («In VS Code: File → Open Folder → <workdir>, then start a new chat»)
   in en/ro/ru, plus the honest note: the phrase lives in that folder — a
   chat opened anywhere else will not know it. All three READMEs gain a
   "Your first conversation" section with the same two facts. Question
   lists untouched (still eight).
4. **Harness — scenario 10 (11 scenarios total)** — fresh install + re-run;
   asserts, each negative-able (all fail on the v0.1.1 build by
   construction): (a) `<workdir>/.claude/skills/qroky/SKILL.md` exists and
   is non-empty; (b) `CLAUDE.md` contains the trigger block pointing at the
   skill file; (c) exactly ONE start marker after the re-run and the skill
   file's hash is unchanged; (d) the workdir copy is byte-identical to the
   vendored source (the fake framework origin ships the REAL vendored file
   from this repo, so the diff compares against the genuine article).
   Negative-ability spot-probed live: a doubled-marker file counts 2 (would
   FAIL c); a missing file fails the `-s` test (would FAIL a). Transcripts
   in `workspace/` (dry-run.sh retargeted there — 101/102 folders stay
   untouched, per perimeter).
5. **M1 folded in (genuinely one line)** — `resolve_candidate_workdir`
   default suggestion `./qroky` → `$HOME/qroky-work` (outside the kit
   clone), plus one harness assert in scenario 10.

## Harness status

Full re-run, first attempt after the changes: **11/11 PASS**
(`workspace/SUMMARY.txt`). Scenarios 1–9 untouched in intent; question
inventory check: 7/7 prompts tagged, all within points 1–8, none beyond —
the gesture step adds NO prompt.

## Deliverables

| File | Change |
| :---- | :---- |
| `runtime/claude/skill/qroky/SKILL.md` | NEW — vendored gesture protocol, de-localized |
| `distribution/install.sh` | `step_gesture` + state plumbing + M1 default-workdir fix + header truth |
| `distribution/lang/{en,ro,ru}.sh` | 3 gesture announcement lines + finale VS Code line + honest folder note, each locale |
| `distribution/README.{en,ro,ru}.md` | "Your first conversation" section (VS Code line + honest folder note) |
| `distribution/dry-run.sh` | scenario 10, fake framework ships the real vendored skill, transcripts → 103 workspace |
| `products/distribution-kit-v1/103-gesture-fix/workspace/` | 10 scenario transcripts + SUMMARY.txt (11/11 PASS) + run.log (harness-checklist answers, budget checkpoints, breath lines) |

## Deviations (none silent)

- **v0.1.2 RESULT lives in 103, not appended to 101's RESULT.md** — INPUT §5
  vs Perimeter conflict resolved by the stricter reading (S6); see the
  note at the top and run.log.
- **status.yaml not updated** — outside my write perimeter; the ATOM-103
  registry row is left to the orchestrator (logged in run.log).
- **The gesture-failure branch (missing skill in an old rulebook) is
  code-reviewed, not scenario-exercised** — the fake framework always ships
  the file; same evidence class as the F8 launchctl and gh-degradation
  notes in prior rounds.
- **One network interruption mid-run** — connection closed after the
  workspace/skill directories were created; transcript intact, resumed at
  the vendoring step, no work lost (logged).
- **CLAUDE.md trigger block is English-only** regardless of interview
  language — it is read by the assistant, not the founder (the founder-
  facing lines are localized); noted here so Verify judges it consciously.

## Handoff

Targeted blind re-check (delta scope) per INPUT frontmatter; then the CEO's
G2 re-run on the second Mac is the maturity gate. The G2 re-check commands
that produced the finding will now answer differently on a fresh install:
`ls <workdir>/.claude/skills/qroky/SKILL.md` → exists;
`grep -in qroky <workdir>/CLAUDE.md` → the trigger block.
