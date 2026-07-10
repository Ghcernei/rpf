---
atom: ATOM-103
product: kit v0.1.2 — the «qroky start» gesture actually ships and gets wired (G2 BLOCKING finding fix)
parent: ATOM-100 (tree envelope remainder: ~111k TOTAL left of ~800k — executor ~70k, targeted verify ~35k; a breach is likely close — report checkpoints honestly, E4 the moment it happens)
role: pilot-toolsmith (fresh instance — the warm one is busy on ATOM-110)
formulated_by: orchestrator from live G2 dry run (CEO, second Mac, 10.07.2026)
verification: targeted blind re-check (delta scope)
maturity_target: reviewed (G2 re-run by CEO after fix)
model_tier: M
budget: ~70k executor
recursion_allowance: 0
---

# ATOM-103 — Input (executor)

## The finding (first G2 dry run, verbatim evidence)

Install on a clean Mac finished green in 202s, zero extra questions — but the
finale's promise «Say: qroky start» is EMPTY on any machine but the author's:

- `ls ~/.claude/skills/qroky/SKILL.md` → No such file or directory
- `grep -in qroky ~/.claude/CLAUDE.md` → No such file or directory
- install.sh has NO step that wires the gesture (verified by source read);
  the skill file itself is not part of the distributed repo AT ALL — it
  lives only on the author's machine at `~/.claude/skills/qroky/SKILL.md`.

## Fix mandate (closed)

1. **Ship the skill in the repo.** Vendor the gesture protocol into the
   framework repo as `runtime/claude/skill/qroky/SKILL.md`. Source of
   truth to copy from: `/Users/ghcernei/.claude/skills/qroky/SKILL.md`.
   HYGIENE PASS is mandatory: remove/generalize machine-local absolute
   paths (`/Users/ghcernei/...`, `~/Work/rpf`), author-machine specifics
   (delegation.log path stays as `~/.claude/qroky/delegation.log` — it is
   part of the protocol), keep the provenance table (INFO references are
   repo-public records). The protocol content itself is the product — do
   not rewrite it, only de-localize.
2. **install.sh — new automatic step (NOT an interview point; question
   inventory stays 8):** after framework vendoring, wire the gesture at
   PROJECT level (skill rule I3: never write into `~` or system paths):
   - `<workdir>/.claude/skills/qroky/SKILL.md` — copied from the vendored
     `framework/runtime/claude/skill/qroky/SKILL.md`;
   - `<workdir>/CLAUDE.md` — created (or appended between markers,
     idempotent) with the trigger block: message starting with
     «кроки»/«qroky» (case-insensitive, incl. «qroky start») → invoke the
     qroky skill; plus one line handing the NARRATIVE/mission orientation.
   - Same state-machine discipline: `step_gesture` check→do pair,
     re-run = no-op, failure ladder, plain-language announcement line.
3. **Finale + READMEs truth fix:** finale step 1 must say to open the
   terminal in the WORKDIR (it does) AND add one line for VS Code users:
   «In VS Code: File → Open Folder → <workdir>, new chat» (all three
   locales). READMEs: same one line + the honest note that the gesture
   lives in the project folder (a chat opened elsewhere won't know it).
4. **Harness:** new scenario — after a clean install: assert
   `<workdir>/.claude/skills/qroky/SKILL.md` exists and non-empty, assert
   `<workdir>/CLAUDE.md` contains the trigger block, assert re-run leaves
   ONE trigger block (idempotency), assert the vendored skill in
   framework/ matches what landed in workdir. Negative-able assertions
   (r1-F1 lesson). Full harness re-run green (11 scenarios), question
   inventory still exactly 8.
5. **Records:** RESULT.md append «v0.1.2», run.log story + budget
   checkpoints, README question lists untouched (still 8).

## Perimeter

Write: `distribution/**`, `runtime/claude/skill/**`,
`products/distribution-kit-v1/103-gesture-fix/**` (workspace, transcripts,
run.log). Read-only source: `/Users/ghcernei/.claude/skills/qroky/SKILL.md`.
NO git. NO edits to the 101/102 folders except nothing — your records live
in 103.

## Known minor findings to fold in if trivially cheap (else leave recorded)

- M1: default workdir suggestion landed INSIDE the repo clone
  (`…/distribution/qroky`) — suggest a path OUTSIDE the clone (e.g.
  `~/qroky-work`) as the default candidate; do it only if it is a one-line
  change in resolve_candidate_workdir + one harness assert.
