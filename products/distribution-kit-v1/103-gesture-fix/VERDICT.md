ACCEPT

# ATOM-103-VERIFY — targeted verdict on the v0.1.2 delta (gesture fix, G2 blocking finding)

Same verifier as ATOM-101 r1/r2 and ATOM-102. Artifacts first; executor records last.
Contract: `products/distribution-kit-v1/103-gesture-fix/INPUT.md`.

## Method

Full harness re-run myself in an isolated copy (with `runtime/claude/skill/qroky/`
staged as in the repo): **11/11 PASS**, matching the committed transcripts and
SUMMARY. Line-level review of `step_gesture`, the trigger block, the vendored
SKILL.md (full diff against the source of truth
`/Users/ghcernei/.claude/skills/qroky/SKILL.md`), scenario 10's assertions, all three
locales and READMEs.

## Does the fix actually fix the G2 finding? Yes.

- Delivery chain is real end-to-end: the skill ships in the framework repo
  (`runtime/claude/skill/qroky/SKILL.md`, 102 lines, non-empty); the harness's fake
  framework origin is built by copying THAT repo file (`dry-run.sh:182-184`), so a
  clean install vendors it into `<workdir>/framework/…` and `step_gesture`
  (`install.sh:409-434`) copies it to `<workdir>/.claude/skills/qroky/SKILL.md` and
  appends the marker-guarded trigger block to `<workdir>/CLAUDE.md` — exactly the two
  artifacts the live G2 dry run found missing.
- Trigger block read critically (`install.sh:394-403`): "A chat message STARTING with
  «кроки» or «qroky» (case-insensitive) — including «qroky start» — triggers the
  protocol in `.claude/skills/qroky/SKILL.md`: read that file and follow it exactly
  (survey read-only → propose a one-screen plan → wait for an explicit «го»). The
  word inside ordinary prose does NOT trigger." — specific, project-relative,
  actionable, and mirrors the author-machine gesture grammar that provably works;
  it names the exact action (read the file, follow it) rather than a vague hint. The
  mission-orientation line (mission.md / NARRATIVE.md, skill §7 M6) is present as
  mandated. `<workdir>/CLAUDE.md` is what a session opened in the workdir loads; the
  finale and READMEs now tell the founder to open the session THERE (plus the VS Code
  line), with the honest "a chat opened anywhere else will not know it" note in all
  three languages (README.en.md:35-38, README.ro.md:36-38, README.ru.md:38).

## Skepticism points 2–6

- **SKILL.md hygiene:** grep for `ghcernei|/Users/|Work/rpf` over the vendored file —
  clean. Full diff vs the source of truth: every hunk is de-localization only
  (`~/Work/_BUSOS` → generalized reference, `~/Work/rpf/framework/` → "the pinned
  framework/ folder", provenance-table paths → repo names) plus ONE added provenance
  row recording the vendoring itself. Protocol content (D/I/R rules, §§ structure)
  unchanged — mandate's "do not rewrite, only de-localize" honored.
- **Idempotency (vacuous-test lesson):** `_gesture_wire_attempt` is check→do (`cmp -s`
  before copy; marker grep before append). Scenario 10's assertions are negative-able
  and would all fail on the v0.1.1 build: skill non-empty, marker count == 1 after
  RUN 1 AND after re-run (committed transcript line 142: "start markers: 1"), skill
  md5 stable across runs, workdir copy byte-identical to the vendored source
  (`VENDOR_DIFF` empty). The resume guard (`step_gesture`, install.sh:411-413) also
  re-verifies file + marker, not just state — self-healing.
- **Question inventory:** `step_gesture` has no `read_answer` (automatic, announced
  via `L_GESTURE_WIRING/DONE/ALREADY`, present in all 3 locales); inventory check
  still asserts 7/7 prompts within points 1–8, none beyond 8 — PASS on my run.
  READMEs still list eight questions.
- **M1 default workdir:** `resolve_candidate_workdir` (install.sh:243-249) now
  suggests `$HOME/qroky-work` — outside the clone; scenario 10 asserts it.
- **Prior scenarios:** 1–9 all green on my full re-run (scenario 3 now 9 health-check
  lines — the gesture step reports its own health line; kill-proof, нет-cancel-first,
  pushed-history secrets grep all still non-vacuous and passing).
- **Failure path:** `run_with_ladder` + `fail_to_human` with a concrete action naming
  `--apply-update` and the rulebook-version cause (install.sh:423-432) — consistent
  with H9.

## Findings

None blocking, none minor.

## Notes (no action required)

- The trigger relies on the session honoring project CLAUDE.md instructions — the
  right (and only project-level) mechanism per the skill's own I3 rule (never write
  into `~`); the definitive proof remains the G2 re-run on the clean Mac, which this
  atom's DoD already schedules.
- The vendored skill will drift from the author's live skill as future INFO touches
  land; the provenance row + self-update channel (tags) is the designed sync path —
  fine as long as releases are tagged after skill touches.

## Verdict

ACCEPT. The two artifacts the G2 dry run proved missing now demonstrably land on the
target machine via a real chain (repo file → vendored framework → workdir skill +
CLAUDE.md trigger), the trigger text is specific enough to fire on «qroky start», the
vendored protocol is de-localized without rewriting, wiring is idempotent with
negative-able assertions, the interview stays at exactly eight points, M1 is folded
in, and the full 11-scenario harness passes on my independent re-run.

Token cost (this round): ~28k — inside the ~35k budget. Cumulative verifier total
across all four rounds: ~228k.

One-line justification: the fix is verified at the artifact level end-to-end (ship →
vendor → wire → trigger), its new evidence fails on the old build by construction,
and nothing previously verified regressed.
