# VERDICT — ATOM-111 (telegram project router v1), independent blind verify (L)

- **Verdict: ACCEPT** (0 blocking, 3 minor findings)
- **Verifier:** blind L-tier session, 2026-07-10; same verifier as ATOM-110 (three
  rounds), delta-scoped over that reviewed base. Commit under verify: 7d070d0.
- **Method:** contract (INPUT.md, INFO-034, GATE-029) + full diff read FIRST; both
  harnesses run MYSELF; seven attack-probe groups in independent sandboxes; a
  byte-level compat diff against the extracted pre-111 code; executor's
  RESULT.md/run.log read only after my findings were formed.
- **Blindness/hygiene:** both committed transcript sets (head 110 workspace, kit 104
  workspace) backed up before my runs and restored byte-identical (cmp-verified);
  sandboxed HOME everywhere — no real `~/.qroky/registry` was created; zero git
  operations.

## Harness scores (my own runs)

| Harness | My run | Committed |
| :---- | :---- | :---- |
| Head `runtime/claude/telegram/dry-run.sh` | **21/21 PASS, exit 0** | PASS lines identical |
| Kit `distribution/dry-run.sh` | **15/15 PASS, exit 0** | PASS lines identical to the transcripts on disk — but see F1: the kit evidence was never committed |

All 15 v1 head scenarios green in my run — the compat switch held under the full
regression (H8). Kit question inventory still NINE (scenario 1-question-inventory
asserts «none beyond 9» and passed in my run).

## Hard criteria — independent evidence

- **H1 cross-routing, attacked:** scenario 17 (my run) + my own attack battery:
  (a) `--workspace` with a **double slash** → normalized in the pending-gates entry,
  decision landed in beta's `decisions/`, zero cross into alpha; (b) **trailing-slash
  re-register** → «already registered», registry stays 2 lines; (c) **symlinked
  registry entry** with the gate carrying the real path → decision reached the project
  through the real path AND the pending gate SURFACED in the primary digest section
  (never vanished); (d) **PROJECT_NAME collision** (two workspaces claiming «beta») →
  routing is by PATH, decision landed home only, no duplicate. The executor's own
  19/21 catch (TMPDIR double slash) is genuinely fixed by construction: I planted a
  crash-era RAW `//` workspace path directly into a pending-gates file — the digest
  surfaced it in the primary section, rc 0 (my first probe's "VANISHED" readings were
  my own helper truncating texts at 100 chars — retested with full text: SURFACED).
- **H5 sacred migration:** scenario 16 in my run — v1-shaped bound state (chat_id,
  consumed offset, narrative offsets) → registry seeded with the workspace as line 1,
  **zero sends, zero questions, offset untouched, no beat replay, seed idempotent**;
  the main harness registry seeded implicitly at scenario 1 (asserted). Upgrade-path
  fold: kit scenario 13c/13d in my run — token+binding half-connect auto-completes on
  `--apply-update` with **zero sends** (wrapper + 2 plists deployed, state bound);
  token-without-binding → only the `--enable-telegram` hint, nothing deployed. The kit
  wrapper exports `QROKY_TG_HOME`/`QROKY_TG_ROOT` per workspace (install.sh:620–641,
  pre-existing), so the production seed writes the workspace, not the clone root.
- **Compat switch:** beyond the 15 green v1 scenarios, I extracted the pre-111 code
  (27844b7) and byte-diffed ALL outbound texts (gate send + digest + /status) against
  the new code with a one-entry registry on an identical fixture: **identical except
  newline artifacts** — see F2 (one blank line lost in the v1 digest when a pending
  gate exists; an invisible EOF newline in /status).
- **H2 merged digest:** scenario 19 (my run): ONE sendMessage, per-project sections,
  empty project = one line, GATE-B2 confined to bankco's section (0 in miapos),
  numeric spend total, signaled events as status lines. Orphan origins: my symlink and
  raw-`//` plants both surfaced in primary — a pending decision cannot vanish.
- **H4 re-ask:** scenario 20 (my run): exactly ONE mechanical re-ask with project
  buttons (+«общий» via DEFAULT_PROJECT), press routed the ORIGINAL text with
  `routed: 1` (no second clarify), clarify-in-flight answer never re-asked, named text
  routed directly and its clarify round-trip kept the target. **Risk-word not
  weakened:** my probe — a `--risk` gate with the router active carries NO buttons,
  names the word, keeps the `[beta]` label; the typed word routed the decision record
  to beta's `decisions/`. **R2-1 discipline holds on route callbacks:** stale
  double-tap on an answered re-ask and a malformed idx (`9/junk`) both decline
  politely, rc 0, offset advances (listener.sh handle_route_callback validates idx
  numeric + file existence before sed).
- **H6 dead path:** scenario 21 (my run) + my harder probe: registry poisoned to
  ZERO live paths including a dead PRIMARY → listener rc 0, free text fell back to the
  honest v1 plain user-message (durable, nothing lost); unregister clean + idempotent.
- **H7 settings home:** ONE home = primary workspace's `.qroky/telegram/` — coherent
  in code (lib.sh TG_HOME/TG_ROOT resolution) and consistent with GATE-029's
  one-file-only scope; but see F3 on operator documentation. Secrets: negative greps
  in my probe sandboxes = zero raw-token traces; head scenario 11 and kit scenario 6
  remain non-vacuous in my runs.
- **Kit hooks:** scenario 13a/b in my run — deploy registers idempotently; a second
  workspace on a bound machine JOINS: no BotFather walkthrough, no second launchd
  pair (delta 0), no own token file, zero sends (no second hello), registry 2 lines
  with the primary first; «бот уже подключён» present in all three locales
  (en/ru/ro `L_TELEGRAM_ALREADY_CONNECTED`, grep-verified).
- **NOT-DOING:** no multi-user, per-project bots/tokens, topics, priorities, or
  cross-machine registry code found in the diff.

## Findings (all minor, ranked)

- **F1 (minor, records/LP).** The commit claims «kit 15/15» but the kit evidence was
  never committed: `git ls-tree HEAD` of
  `products/distribution-kit-v1/104-installation-journey/workspace/` shows the
  PRE-111 run (14 files, SUMMARY of 17:02Z with 14 PASS and «8 files» in scenario 6);
  `scenario-13-router-hooks.txt` exists only as an untracked working-tree file, and
  the updated SUMMARY/transcripts (20:21Z, 15 PASS, «9 files») are uncommitted
  modifications. The claim is TRUE — my own run reproduces 15/15 — but H9's records
  discipline expects the evidence in the delivery. Fix: commit the kit workspace
  transcripts (one `git add`).
- **F2 (minor, S2 cosmetic + compat-claim precision).** The digest refactor wrapped
  line-builders in command substitutions, which strip trailing newlines; three
  manifestations, one root cause:
  (a) **user-visible glue** in the merged digest — the last pending-gate line and the
  spend line render as ONE line: `• GATE-B2 — ждёт твоего решения (кнопки в чате
  выше)расход: 300k токенов` (executor's own committed
  scenario-19-merged-digest.txt:34 and my run alike; digest.sh:149
  `WAIT_COMBINED="$WAIT_LINES$(pending_gate_lines "$ws")"` + :169
  `${WAIT_COMBINED}$SPL`); the harness greps are line-boundary-blind so 19 passes;
  (b) the v1 branch loses one blank line vs pre-111 when a pending gate exists
  (digest.sh:84 `PENDING_LINES="$(pending_gate_lines "")"`) — my old-vs-new byte diff
  shows exactly this one-line delta, so «byte-identically v1» (RESULT) is off by one
  blank line in that case; (c) /status lost its EOF newline (invisible on a phone).
  Fix: re-append `$'\n'` after the substitutions (or emit the spend line on its own
  template line).
- **F3 (minor, docs).** Operator documentation not extended: `README.md` and
  `profile.conf.example` were untouched by the commit — the registry,
  `register.sh`/`unregister.sh`, the `PROJECT_NAME` override, and the new
  `DEFAULT_PROJECT` knob are documented only in code comments and RESULT.md. H7 asks
  for the human-level home to be DOCUMENTED; lib.sh's header does say it, but the
  operator-facing files a human actually reads at setup lag one atom behind.

## Deviations (RESULT.md §Deviations) — each checked

1. Human home = primary's `.qroky/telegram/` — accurate; keeps GATE-029 at exactly
   one machine-level file; migration-zero-moves confirmed by scenario 16. Declared, sound.
2. `/status <имя>` superset — code-verified, harmless.
3. Clarify-in-flight guard — exercised in scenario 20 (my run), keeps the one-question
   contract. Declared, sound.
4. Kit harness per-workdir registry isolation — infrastructure, correctly scoped;
   scenario 13 shares one registry deliberately. Declared, sound.
5. Numeric-only spend total — INPUT says «may sum»; free-text ledgers listed unsummed.
   Declared, sound.
6. Narrative offset key collision for equal-basename NON-primary workspaces — a real
   (silent beat-suppression) edge, honestly declared as v1-acceptable; primary keeps
   v1 keys so H5 holds. Declared; recommend a registry-index or hash suffix in v2.

run.log carries the INFO-025 checklist answers for the router additions, breath
lines, the honest three-catch bug trail (19/21 path-normalization production gap;
20/21 harness assert; kit 12/14 cross-scenario registry contamination) — the
committed code matches every claim I checked against my own evidence.

## Bottom line

The router holds under attack: cross-routing by path (not by name) survived
double-slash, trailing-slash, symlink, and name-collision attempts; orphaned origins
surface rather than vanish; migration is genuinely silent; the compat switch renders
single-project machines v1 except one lost blank line; R2-1 discipline carried over
to the new route callbacks; the kit joins second workspaces without a second bot and
keeps the inventory at nine. Three minors — an uncommitted evidence set, a
newline-stripping cosmetic with one user-visible glue line, and lagging operator
docs — none touching a hard criterion. **ACCEPT.** Next: G2 — two live projects, a
gate from each answered from the phone, one merged digest.

*Verifier spend estimate: ~75k of the ~150k envelope (contract + full diff ~35k, two
harness runs + seven probe groups + compat byte-diff ~30k, cross-check + verdict ~10k).*
