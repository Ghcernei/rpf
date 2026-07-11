# VERDICT — ATOM-130 (SEPARATION, kit v0.4) — blind verify, L-tier targeted, mutational

- **Verdict:** **ACCEPT** (round 1)
- **Verifier:** blind verify (INFO-037 mutational), 11.07.2026
- **Mandate:** /ATOM-130-LAUNCH.md (DoD 1–7 + NOT-DOING) + decisions/GATE-031
- **Blocking findings:** 0 · **Minor/notes:** 5 (below)

## What I re-ran myself (not trusted from RESULT)

1. **Kit harness** `distribution/dry-run.sh` — **23/23 PASS** (fresh run, own sandbox).
2. **Head harness** `runtime/claude/telegram/dry-run.sh` — **21/21 PASS**.
3. **Head untouched:** `git diff v0.3.2..HEAD -- runtime/claude/telegram/` = **empty** (0 lines).
4. **Direct freeze falsification** (novel name, outside the harness's junk set): built a
   manifest-only tree, planted `products/junk.md` → verify.sh exit 1, offender NAMED.
   Prefix edge: planted root `docsX.md` → also named (the `docs/` dir pattern does not
   false-green a `docsX*` file). Clean tree → exit 0.

## Mutations (3, in temp copies under scratchpad; repo untouched)

| Mutation | Broken code | Harness result | Killed? |
| :--- | :--- | :--- | :--- |
| A | `_framework_apply_manifest` → `return 0` (sparse never applied) | **19, 20, 21 FAIL** (junk in worktree, sparse=0, freeze red) — 20/23 | yes |
| B | verify.sh offender scan disabled (`find` loop → no-op) | **19 FAIL** (planted file not caught, verify=0/0/0) — 22/23 | yes |
| C | machine-trace read removed from `resolve_candidate_workdir` (back to clone-pointer only) | **21 FAIL** (uninstall could not find the install; state survived) — 22/23 | yes |

No surviving mutants. Scenarios 19/20/21 are falsifiable as claimed
(RESULT's "mutation-ready" statement independently confirmed).

## Targeted checks

- **Silent migration (item 3):** scenario 20 covers the exact live-instance path —
  install from a manifest-less old tag (fat instance PROVEN non-vacuous: junk vendored,
  exit 0 — old tags vendor whole without crash), then `--apply-update` to the manifest
  tag: factory history shed from framework/, chat_id + profile md5 + token mtime
  byte-stable, **0** interview lines, **0** telegram sends, freeze green after. Code path
  confirmed: `cmd_apply_update` → checkout → `_framework_apply_manifest`;
  manifest-absent tree → logged full vendoring; too-old git → logged honest degradation.
- **dist-manifest (item 4):** whitelist = exactly the claimed 11 entries. Reverse hole:
  every repo top-level path outside the manifest is precisely the factory set
  (products/ decisions/ roles/ TASKS.md ATOM-* RELEASE-v0.1.md) — nothing product-shaped
  is stranded. Forward hole: see findings 1–2. One file feeds both vendoring and
  verify.sh (same parse rules) — confirmed by reading both.
- **qroky.sh (item 5):** 90 lines, read whole. No `rm` at all (nothing to be unsafe on
  empty vars; `set -u` on). No duplicated reinstall logic — only clone/fetch/tag-checkout
  of the kit copy + `exec install.sh [--apply-update|--uninstall]`; the occupied-folder
  dialog stays install.sh's (the KIT_HOME occupied message is about the kit copy dir, a
  distinct concern, not a duplicate). Any-cwd: absolute paths only; proven live by
  scenario 21 from three neutral folders and by mutation C for the machine trace.
- **Git history (item 6):** tags v0.1.2…v0.3.2 all present and all ancestors of HEAD;
  delivery = one ordinary commit (f7ff1dd) on top; no rewrite, no force.
- **Lab (item 7):** /Users/ghcernei/Work/qroky-lab @ **842446d**, **582 files**, **no git
  remote** (unpublished — as required). Composition = the factory exactly (475 products,
  78 decisions, 10 roles, 15 ATOM launch/INPUT, TASKS.md, RELEASE-v0.1.md, README,
  .gitignore); no distribution/runtime/framework dupes; README explains the two houses +
  going-forward flow + history note. Secrets negative grep (bot-token pattern, ghp_,
  sk-ant, AKIA, private keys, xoxb, .env contents): **clean** — token mentions are
  documentation strings and the harness's fake GOODTOKEN only.
- **README/docs (item 8):** root README = map + lab links, zero factory rows;
  docs/separation.md's three freeze layers match the implementation 1:1; CHANGELOG v0.4
  factual against what I re-proved; distribution/README ×3 lead with the one command.

## Findings (none blocking)

1. **[minor — feeds the CEO curation HUMAN-TASK]** Factory artifacts inside manifest
   dirs ship to every instance: `docs/advisor/codex-review-2.md` (advisor review of the
   factory — factory artifact, not a universal doc) and `runtime/claude/heartbeat/`
   (the factory's own heartbeat tool; `heartbeat-prompt.md` hardcodes
   `/Users/ghcernei/Work/rpf`; `runtime/claude/skill/qroky/SKILL.md:90` carries a
   `FIN-010 (Finergy operations, _BUSOS)` provenance row). Mitigating: the executor
   flagged the first two in RESULT; `heartbeat.log`/`out/` are untracked+gitignored and
   do NOT ship; the installer generates its own per-workdir heartbeat, so the shipped
   factory tool is dead weight, not misbehavior. My classification: content curation is
   explicitly the CEO's parallel HUMAN-TASK (GATE-031 п.2, mandate "каталоги едут
   целиком") — correct to ship per mandate, but add heartbeat-prompt.md's personal path
   and the SKILL.md provenance row to the curation list.
2. **[note]** Root README and lab README link `github.com/qroky/lab`, which 404s until
   the deferred push — inherent to the deliberate "publish after CEO review" path, just
   sequence the push before tagging v0.4 public.
3. **[note — cosmetic]** RESULT.md breakdown "582 файла (products/ 580 factory-файлов +
   README + .gitignore)" is imprecise: actual 475 products + 78 decisions + 10 roles +
   15 launch/INPUT + TASKS + RELEASE + README + .gitignore = 582. Total and content
   match the mandate; only the sentence's arithmetic is off.
4. **[note]** My harness re-runs regenerated the committed transcripts in
   `products/*/workspace/` in place; diff verified to contain ONLY run artifacts
   (timestamps, sandbox paths, PIDs, fixture SHAs — 242 lines, zero semantic changes).
   Coordinator: commit the refresh or `git checkout --` it.
5. **[note — cosmetic]** lab/.gitignore carries `runtime/claude/heartbeat/*` entries
   though lab has no runtime/ — harmless baseline copy-over.

## Envelope

~38k of ~55k tokens. No network, no push, no writes outside this VERDICT.md,
scratchpad copies, and the harnesses' own transcript regeneration (finding 4).
