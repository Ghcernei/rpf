---
atom: ATOM-104
product: kit v0.2 — the installation journey a human can actually walk (G2-return fix, GATE-027/028)
parent: ATOM-100 lineage; NEW envelope ~250k total (tree A's own envelope is exhausted — honest E4 in GATE-027): executor ~150k, targeted verify ~60k, parent ≤5%
role: pilot-toolsmith (warm — built the installer AND the telegram head)
formulated_by: orchestrator from GATE-027 (CEO live G2 verdict, verbatim ×3) + GATE-028 (go + two verbatim answers), 2026-07-10
verification: targeted blind (same kit verifier, warm)
maturity_target: reviewed; G2 re-run by CEO — acceptance in HIS words: «понятно, что делать и в каком порядке»; «дал ключ — бот пнул»
model_tier: M
budget: ~150k executor
recursion_allowance: 0
---

# ATOM-104 — Input (executor)

Mandate sources (read first): decisions/GATE-027 (the return, verbatim
findings), decisions/GATE-028 (go + the two follow-up decisions). The CEO's
sentences are the acceptance bar, not decoration.

## 1. «Дал ключ → бот пнул» (the loudest finding)

Wire the reviewed Telegram head (runtime/claude/telegram/, r3-ACCEPT) into
the kit:

- Interview question 5 (Telegram) extends INSIDE itself (see §3 for the new
  inventory): token accepted → «теперь откройте вашего бота и нажмите
  Start» → installer polls getUpdates (ladder, honest timeout ~60s) →
  captures chat_id → binds (this IS the head's H4 binding) → the bot
  IMMEDIATELY replies «я на связи; утром пришлю первый дайджест» (localized
  properly). CEO verbatim acceptance: «Как минимум я ожидал, что он в
  Telegram пнёт, отправит какое-то сообщение».
- On token given: installer deploys the head from the vendored framework —
  renders profile.conf (token path from the kit's stored file, digest time
  default morning, quiet hours default night), installs both launchd plists,
  health-checks one listener pass.
- Timeout / no Start pressed / no token: honest line «бот подключается позже
  одной командой: …» — install continues, nothing dies. Enable-later
  command documented (mirrors --enable-heartbeat pattern).
- Skip must be ZERO effort and stated FIRST on the question screen: «Enter =
  пропустить, подключите позже».

## 2. Journey map + finale (findings 2–3)

- First screen of a fresh install: one-paragraph map — «9 вопросов → ~3
  минуты установки → в конце вы получите две строки для первого разговора».
- Every interview question header carries «N из 9».
- Finale becomes a READY copy-paste block with the REAL workdir path:
  `cd <workdir> && claude` then «скажите: qroky start» — plus the VS Code
  line (File → Open Folder → <workdir> → new chat). No prose steps.
- Finale also honestly warns: the FIRST `claude` launch asks its own
  questions (theme, login) — one line, all three locales (this closes the
  open minor from the first dry run).

## 3. Question 9 — machine-wide gesture (GATE-028 follow-up, CEO verbatim «да, спрашивать при установке»)

- New closed-list point 9: make «qroky start» available from ANY chat on
  this machine? [рекомендуем] Honest line: «запишем два файла в ~/.claude».
- «Да» → copy the vendored skill to `~/.claude/skills/qroky/SKILL.md` +
  marker-guarded trigger block appended to `~/.claude/CLAUDE.md` (create if
  absent). Idempotent (markers, cmp), removable (document the two paths).
  ONLY these two files ever touch `~`.
- «Нет» → project-folder wiring only (as now).
- Amend rule I3 in the VENDORED skill (runtime/claude/skill/qroky/SKILL.md)
  with the recorded exception: machine-wide strictly via the owner's
  explicit opt-in at install, provenance GATE-028. (The author-machine
  skill copy is amended by the orchestrator, not you.)
- Question inventory: EXACTLY NINE now — update the hardened count assert,
  README question lists (en/ro/ru), and the map of §2.

## 4. «Первые 5 минут»

README section (all three locales) + one finale pointer line: what to say
in the first conversation (qroky start → the system looks around and
proposes; you answer «го» or correct it), what success looks like, where
NARRATIVE/mission files appear. Keep it to one screen — this is a hand on
the shoulder, not a manual.

## 5. Harness

- New scenarios (stubbed Bot API reused from the head's stub): (a) token +
  Start pressed → chat_id bound, hello message sent (assert the actual
  sendMessage in the stub log), head deployed, plists rendered, one listener
  pass healthy; (b) token given, Start NEVER pressed → timeout → honest
  skip line, install continues, enable-later documented; (c) question 9
  «да» → exactly two files under fake-HOME, marker count 1 after re-run;
  (d) question 9 «нет» → fake-HOME untouched (negative assert).
- Update existing feeds for 9 answers; count assert «never 10+»; full
  harness re-run green; all assertions falsifiable (the standing r1-F1
  bar).
- Journey map + finale copy-paste block asserted (path substitution real).

## 6. Records & perimeter

Write: distribution/**, runtime/claude/skill/** (I3 amendment only),
runtime/claude/telegram/** ONLY if the wiring genuinely requires a hook
there (prefer zero edits — the head is reviewed; a needed change = declare
loudly), products/distribution-kit-v1/104-installation-journey/**. NO git.
run.log (breath lines, budget checkpoints, harness-checklist 9 answers),
RESULT.md, STATUS.md, NARRATIVE beat appended to
products/distribution-kit-v1/100-distribution-kit/NARRATIVE.md (ru, level
2–3). Budget ~150k — checkpoints honest, E4 the moment it projects.
