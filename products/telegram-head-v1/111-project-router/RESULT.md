# RESULT — ATOM-111 (telegram-router-v1)

Contract: [INPUT.md](INPUT.md) · mandate: decisions/INFO-034 · gate: decisions/GATE-029
Executor: pilot-toolsmith (warm, 6th run). Date: 10.07.2026.

## What exists now

ONE bot per owner serves EVERY project of the machine:

- **Registry** — `~/.qroky/registry`: plain text, one absolute workspace path
  per line, `#` comments allowed. The ONLY machine-level file (I3-class
  exception inside GATE-029's scope). First entry = PRIMARY workspace; its
  `.qroky/telegram/` is the human-level home (chat binding, token path, quiet
  hours, digest time, detail level, offset, queue, signaled, pending-gates).
  `register.sh` / `unregister.sh` manage it idempotently.
- **Compat switch** — router rendering activates only when the registry holds
  >1 workspace. A single-project machine behaves byte-identically to v1: all
  15 pre-router harness scenarios stayed green untouched.
- **Labels & routing home (H1)** — outbound events carry «[project]» (basename
  or `PROJECT_NAME` override; never doubled). The origin workspace is
  persisted with each pending gate; a button press renders the decision record
  into the ORIGIN's `decisions/` via the unchanged `record-decision.sh
  --out-dir` — parity by construction preserved. Dead origin → honest local
  fallback + log line.
- **ONE merged digest (H2)** — a section per project («Сделано / В работе /
  Ждёт тебя / расход»), empty project = one line, pending gates confined to
  their origin's section, orphan origins surface in the primary section
  (a pending decision can never vanish), per-project spend + numeric total,
  already-signaled events as status lines (no duplicate alarms).
- **/status across projects (H3)** — labeled per project, ONE message;
  «что в работе <имя>» (or `/status <имя>`) narrows to one project; unknown
  name answered honestly with the registered list.
- **Free input (H4)** — a text naming a project routes there directly; a text
  naming none gets exactly ONE mechanical re-ask with project buttons
  («общий» appended when `DEFAULT_PROJECT` is set). The press routes the
  ORIGINAL text and skips the second clarify; a clarify-in-flight answer is
  never re-asked. Task-proposals land in the target workspace's inbox.
- **Sacred migration (H5)** — a bound v1 install gets its registry seeded on
  the FIRST pass after the code update: zero questions, zero sends, no
  re-bind, no second hello, offset untouched, narrative offsets keep their v1
  keys (no beat replay). The recorded upgrade defect («токен есть, головы
  нет») is folded: `--apply-update` auto-completes a token+binding
  half-connect with ZERO extra sends; token without a binding gets the one
  honest finishing command (`--enable-telegram`), never a half-alive listener.
- **Dead path (H6)** — a dead registry entry: rc 0 everywhere, live projects
  unaffected, one honest ⚠ line in /status and in the digest, log flag,
  `unregister.sh` removes it cleanly.
- **Kit hooks** — deploy registers the workspace (idempotent); a SECOND
  workspace on a bound machine only JOINS: «бот уже подключён» + registration,
  no second token ask/Start/hello/launchd pair. Question inventory stays NINE.
- **Risk-word rule, quiet hours, single getUpdates offset** — untouched; one
  poll per machine at the human level, routing by payload.

## Harness

- Head `runtime/claude/telegram/dry-run.sh`: **21/21** (15 v1 + 6 router:
  migration, cross-routing attack, status filter, merged digest, re-ask,
  dead-path poison). Every assertion falsifiable; transcripts in
  `products/telegram-head-v1/110-telegram-head/workspace/` (the head's living
  harness home).
- Kit `distribution/dry-run.sh`: **15/15** (14 v0.2 checks + new
  13-router-hooks a/b/c/d). Secrets negative greps stayed non-vacuous and
  empty.
- Falsifiability lived — run 1 was 19/21 and caught a REAL production gap:
  a path not byte-equal to its registry entry (macOS double-slash TMPDIR)
  silently dropped a pending gate from the merged digest. Fixed by
  construction (normalization in lib/send-event + orphan-origin surfacing),
  not by loosening asserts.

## NOT-DOING (unchanged, = defect if proposed)

Multi-user, per-project bots, forum topics, priorities, cross-machine registry.

## Deviations (declared)

1. Human-level home = PRIMARY workspace's `.qroky/telegram/` (first registry
   entry), NOT a second file/dir under `~/.qroky/` — GATE-029 covers exactly
   one machine-level file and the v1 home becomes the primary home with zero
   moves (§3.7 pick, run.log D1).
2. «что в работе <имя>» also accepts `/status <имя>` (superset, zero cost).
3. Clarify-in-flight guard: a free text while the handler's ONE clarifying
   question is open is treated as the ANSWER, not re-asked with buttons —
   keeps the v1 «exactly one question» contract (run.log D5 refinement).
4. Kit harness gained per-workdir registry isolation (each workdir = its own
   «machine») — required for scenario independence once install.sh touches a
   machine-level file; declared as harness infrastructure, not scope creep.
5. Digest total line renders only when ledgers open with a number
   («итого расход (по числовым ledger): N») — free-text ledgers stay listed
   per project, honestly unsummed (INPUT allows «may sum»).
6. Non-primary narrative offset keys are `<basename>--<slug>`; primary keeps
   v1 keys `<slug>` so migration never replays beats. Equal basenames of two
   NON-primary workspaces would share keys — noted as a known edge (paths
   differing only in parent dir), acceptable for v1 of the router.

## Spend

~175k of ~250k executor envelope (estimate, incl. design phase before a
context compaction). Harness: ~0 LLM tokens (stubs), 0 network calls, no git.
