ACCEPT

# ATOM-104-VERIFY — targeted verdict on the v0.2 delta (installation journey, GATE-027/028 fix)

Same kit verifier (ATOM-101 r1/r2, 102, 103). Mandate read first (GATE-027 verbatim
CEO verdict + GATE-028 go); artifacts + my own harness run before any executor
records. Contract: `products/distribution-kit-v1/104-installation-journey/INPUT.md`.

## Method

Full harness re-run myself in an isolated copy (distribution + runtime/claude/{skill,
telegram} staged as in the repo): **14/14 PASS**, matching the committed transcripts
value-for-value. Line-level trace of the q5 connect flow, head deployment, q9
machine-wide wiring; read-only `git diff` on commit 9b226be for perimeter checks;
locale and README review in all three languages.

## 1. «Дал ключ → бот пнул» — the CEO sentence, traced end to end: met

- Full path in code (`install.sh:727-803`): token validated (`getMe`) and stored
  (mode 600, masked log line) → `L_TELEGRAM_PRESS_START` names the bot @username and
  the honest wait budget → `_telegram_wait_for_start` polls `getUpdates` every 2s up
  to 60s (`install.sh:547-561`) → chat_id written atomically to the HEAD's own state
  (`.qroky/telegram/state/chat_id` — this IS the binding; no `--bind` needed) →
  **offset handoff is correct**: the installer stores the CONSUMED update_id
  (`install.sh:782-785`) and the reviewed head polls `offset=$((OFFSET + 1))`
  (`runtime/claude/telegram/listener.sh:51`), so the Start press is never processed
  twice → hello sent IMMEDIATELY (`_telegram_send_hello`, ≤2 auto-retries, ladder
  shape) → head deployed: profile.conf rendered with the KIT's token path
  (asserted: `TOKEN_FILE="<workdir>/.qroky/telegram.token"`), two 2-line wrappers,
  both plists, one health-checked listener pass BEFORE launchd takes over, today's
  digest pre-marked so the hello's "завтра утром" promise is literally true.
- Non-vacuous proof (scenario 11A, committed and my run): hello ACTUALLY in the
  stub's sent-log — "sends during run: 1 — must be exactly 1: the hello, and nothing
  else"; chat_id 424242; offset 111; 2 plists bootstrapped; listener pass OK.
- Break attempts held: **timeout path** (11B) leaves NO half-deployed unbound
  listener — profile.conf absent, zero telegram bootstraps (both asserted), token
  kept, honest line + `--enable-telegram`; **enable-later** (11B2) completes the
  whole journey from the stored token without re-asking it (re-ask asserted 0),
  binds, sends hello, deploys. `_telegram_connect_flow` returns 0 on every path —
  the install can never die on q5.
- Skip is zero-effort and stated FIRST: `L_TELEGRAM_ASK_OPTIN` opens with «Enter =
  пропустить, подключите позже (одной командой…)»; empty answer skips
  (`install.sh:809-816`) — GATE-027 finding 1 closed as specified.

## 2. Reviewed head untouched: confirmed

`git diff 9b226be^ 9b226be -- runtime/claude/telegram/` → **0 lines**. The kit
renders its own plists and wrappers; wrappers are exactly two env exports + `exec
/bin/bash "$head_src/<listener|digest>.sh"` (`install.sh:617-623`) — the vendored
head runs byte-identical and unmodified.

## 3. Question 9 + inventory NINE: met

- Inventory: 8/8 `read_answer` sites tagged within points 1–9, point 9 present,
  hardened "none beyond 9" guard — PASS on my run. READMEs say nine questions in all
  three languages; the journey map says «9 вопросов».
- q9 requires a TYPED yes — Enter deliberately declines (`install.sh:1113-1120`,
  prompt states it: «Введите y — на весь компьютер; Enter = нет») — the
  conservative reading for writing into `~`, with the honest «ровно два файла в
  ~/.claude» line and removability named in the prompt itself.
- «Да» writes EXACTLY two files (scenario 12: fake HOME total = 3 incl. its
  .gitconfig), marker count 1 after re-run, skill copy byte-identical to vendored,
  removal instructions inside the trigger block. «Нет»/Enter: fake HOME untouched —
  and the negative assert is falsifiable (file count must equal exactly 1).
- Failure path honestly leaves the step PENDING so a re-run re-asks (documented
  choice, `install.sh:1127-1134`), install continues.

## 4. Journey map + finale: met

- Map after the language question (fresh installs only — scenario 3 asserts no map
  on a rerun), «N из 9» headers on every question (`L_STEP_HEADER`, 3 locales),
  finale is a REAL-path copy-paste block (`cd $1 && claude` with the workdir
  substituted — asserted against the actual sandbox path, not a placeholder), VS
  Code line, claude-first-run honesty line, "first 5 minutes" pointer — all three
  locales, natural wording (parity 79/79/79 L_* functions).
- README «Первые 5 минут / Your first 5 minutes / Primele 5 minute» present ×3.

## 5. I3 amendment: exactly scoped

`git diff` on `runtime/claude/skill/qroky/SKILL.md` shows precisely two hunks: the
I3 line gains the recorded exception (two named files, explicit opt-in at question
9, typed yes / Enter declines, idempotent, removable, "extends to no other installer
and no other path") with GATE-028 provenance, plus one provenance-table row. No
other protocol drift. Scenario 12 asserts the exception text is aboard the deployed
copy.

## 6. Regressions: none

Scenarios 1–10 all green with the reworked 9-answer feeds; scenario 6 secrets grep
now also sweeps the deployed head's home (8 files, non-vacuous count assert);
scenario 9 backup and 10 gesture unchanged in substance and passing; kill-proof and
нет-cancel-first remain non-vacuous.

## Findings

None blocking, none minor.

## Notes (no action required)

- profile.conf defaults (digest 09:05, quiet 23:00–08:00, detail 2) are stated as
  editable plain KEY=VALUE; the README documents them — fine for v0.2; a future
  interview point would need the list owner's E1 (list is closed at nine).
- The hello and press-Start prompts are properly localized; branch-B honesty line
  «nobody pressed Start — that is fine, nothing broke» is exactly the tone GATE-027
  demanded.
- Final word remains the CEO's G2 re-run («понятно, что делать и в каком порядке»)
  — scheduled by the atom's own DoD; the machine side of his sentence is now proven.

## Verdict

ACCEPT. The loudest finding is closed with a real, non-vacuous chain (token → Start
→ bind → offset handoff with no double-processing → hello provably sent → head
deployed with a healthy listener pass), the timeout can never strand a half-alive
listener, the reviewed head ships untouched behind byte-identical wrappers, the
interview is exactly nine with q9's ~-writes gated on a typed yes and provably
limited to two idempotent files, the journey map/finale close GATE-027's findings 2–3
in all three locales, and the full 14-scenario harness passes on my independent run
with falsifiable assertions throughout.

Token cost (this round): ~50k (mandate + delta reads, full harness re-run, code
traces, git perimeter checks) — inside the ~60k budget. Cumulative verifier total
across five rounds: ~278k.

One-line justification: every GATE-027 sentence maps to a verified artifact and a
falsifiable assertion that would fail on the v0.1.2 build, and my independent 14/14
harness run plus break attempts on the timeout and enable-later paths found nothing
to return.
