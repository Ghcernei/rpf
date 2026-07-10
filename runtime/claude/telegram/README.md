# Telegram head v1 — the phone-side voice of the instance

| Field | Value |
| :---- | :---- |
| Product | `runtime/claude/telegram/` — polling listener, shared send helper, inbox conventions, digest, decision-parity records, project router |
| Atom | ATOM-110 (telegram-head-v1), ATOM-111 (project router) |
| Mandate | INFO-032 (verbatim), INFO-033 (two-contour channel model, final), INFO-034 (one bot — many projects) |
| Maturity | reviewed target; validated after the first real phone-answered gate (G2) |

## The two contours (INFO-033)

**Dialogue contour** — event-driven, instant, bidirectional:

- Your message never waits more than 1 minute for at least an acknowledgment.
  The listener itself sends the ack, persists the event, then wakes the
  handler (the only place an LLM lives). Complex asks get an honest «принял,
  результат к N» — and the promise is a durable inbox file, so a crash cannot
  silently drop it.
- System events — **gate / E1 / result / overdue dependency** — reach the
  phone the moment they occur, sent by the side where they were born (session
  or heartbeat) through ONE shared helper: `send-event.sh`.
- Gates and E1 arrive as inline-button messages with **decision parity**: a
  press becomes a record in `decisions/` of the same force as an answer typed
  in a session — the records differ in the `channel:` field only.
- NARRATIVE beats ride this contour at your profile detail level (1 = gates
  only, 2 = beat headlines, 3 = full reasoning). Strike the feed with one
  word if you don't want it — open detail per INFO-033 п.6.
- **Quiet hours** (profile): night events queue and deliver when the window
  ends, blockers first. Your own messages are acked even at night.

**Digest contour** — strictly scheduled: daily at the profile `DIGEST_TIME`
(±5 min, launchd calendar job): «сделано / в работе / ждёт тебя сегодня /
расход», plus the 3-line changelog when a new framework release tag exists.
Anything already signaled by the dialogue contour appears as a status line,
never as a second alarm.

## Physics (INFO-032 §3)

Polling only (`getUpdates`): no inbound ports, no webhooks, no resident
daemons. launchd runs `listener.sh` — a plain script — every 30 seconds; the
LLM lives only in `handler.sh`, which the listener wakes after the ack is
sent and the event is durable. The file bus (`decisions/inbox/`) is the
safety net: a press while NO session runs persists and is consumed exactly
once on wake (the mandated DoD scenario, proven by `dry-run.sh`).

## Project router (ATOM-111, INFO-034) — one bot, many projects

One listener/digest pair per MACHINE serves every registered project. The
registry is `~/.qroky/registry` — plain text, one absolute workspace path per
line, `#` comments and blank lines allowed. It is the ONLY machine-level file
the head owns (the recorded I3-class exception, GATE-029). Manage it with
`register.sh <path>` / `unregister.sh <path>` — both idempotent, both honest
about no-ops; `register.sh --list` shows the current entries.

- **Primary workspace = the FIRST registry entry.** Its `.qroky/telegram/` is
  the human-level home: chat binding, token path, quiet hours, digest time,
  detail level, offset, queue, pending gates — everything about the HUMAN
  lives there, in ONE documented place. Per-project configuration is the name
  override only (`PROJECT_NAME` in that workspace's own `profile.conf`).
- **Compat switch:** router rendering activates only when the registry holds
  MORE than one workspace. A single-project machine behaves byte-identically
  to v1 — including a freshly migrated one, until a second project registers.
- **Labels & routing home:** with the router active, every outbound event is
  labeled «[проект]» (folder basename, or `PROJECT_NAME`). A button press
  renders the decision record into the ORIGIN project's `decisions/` — same
  renderer, parity by construction untouched.
- **ONE merged digest:** a section per project («Сделано / В работе / Ждёт
  тебя / расход»), a quiet project is one line, pending gates stay in their
  origin's section, spend gets a numeric total when the ledgers allow it.
- **/status across projects**, and «что в работе <имя>» (or `/status <имя>`)
  narrows to one project by its label.
- **Free input:** a message that names a project routes there directly; one
  that names none gets exactly ONE mechanical re-ask with project buttons
  (plus «общий» when `DEFAULT_PROJECT` is set). The press routes the original
  text — no second question.
- **Joining a second project:** run the kit installer in the new workspace —
  with a bound primary on the machine it only REGISTERS («бот уже подключён»):
  no second token, no second Start, no second hello, no second launchd pair.
- **Migration from v1:** automatic and silent — a bound v1 install seeds the
  registry with itself as primary on the first listener pass after the code
  update. Zero questions, zero sends, no re-bind, no replayed beats.
- **Dead registry path:** flagged in the log, one honest ⚠ line in /status
  and in the digest — never a crash; `unregister.sh` removes it.

NOT in the router (closed list, INFO-034): multi-user, per-project bots,
forum topics, priorities, cross-machine registry.

## Security v1 (INFO-032 §4 — instead of 2FA)

- **chat_id binding**: only the owner's chat_id is honored; anything else is
  ignored, flagged in the log, and quarantined to `decisions/inbox/quarantine/`.
  Until `install.sh --bind` is run, EVERYTHING is quarantined (deny by default).
- **Risk-level HUMAN-TASKs**: no buttons, ever. The message names the explicit
  word (`RISK_WORD`, default ПОДТВЕРЖДАЮ); a button-style reply is rejected
  and re-asked; only the typed word is recorded (verbatim).
- **Token**: read from a file path only (`TOKEN_FILE` in `profile.conf`).
  Production = the path the kit interview stored
  (`<workspace>/.qroky/telegram.token`); no second registration. The token
  never appears in logs, state, or records — the harness proves it by
  negative grep.

## Files

| File | Role |
| :---- | :---- |
| `lib.sh` | shared plumbing: profile, token, API, atomic writes, quiet hours |
| `listener.sh` | one polling pass: ack, persist, wake; narrative sweep; queue flush |
| `handler.sh` | the LLM side: kroky protocol, free-input router (ONE re-ask → task-proposal), promise keeping |
| `pickup.sh` | mechanical inbox consumption → decision records (session/heartbeat callable) |
| `send-event.sh` | THE shared outbound helper (session + heartbeat callers) |
| `record-decision.sh` | THE decision-record renderer (both channels — parity by construction) |
| `digest.sh` | digest contour renderer/sender (merged per-project sections when the router is active) |
| `register.sh` / `unregister.sh` | machine registry (`~/.qroky/registry`) — add/remove a project, idempotent |
| `install.sh` / `uninstall.sh` | launchd jobs (listener 30 s; digest at profile time), `--bind`, health check |
| `profile.conf.example` | the two contours' independent settings |
| `dry-run.sh` | sandboxed harness, stubbed Bot API — run before anything real |

## Inbox conventions (`decisions/inbox/`)

One event per file, atomic (tmp+rename): `<epoch>-<pid>-<rand>-<kind>-<id>.md`
with a small `key: value` head and the payload after `---`. Kinds:
`gate-answer`, `user-message`, `kroky`, `task-proposal`, `promise`.
Consumed = moved to `done/` (the CEO-orders ledger pattern). Foreign-chat
material lands in `quarantine/` untouched.

## NOT in v1 (closed list — INFO-032 §5)

2FA, groups, inline editing, media. No hooks «for later».

## Setup (production)

1. Kit interview question 5 already stored your bot token — point
   `profile.conf` `TOKEN_FILE` at it. (Test rig: any file with a test token.)
2. `cp profile.conf.example profile.conf`, set digest time and quiet hours.
3. `bash install.sh` — loads both launchd jobs, prints a health check.
4. `bash install.sh --bind` — send your bot one message, confirm the chat_id.
5. Smoke: send the bot «что в работе» — an answer within a minute means the
   dialogue contour is alive; the next morning's digest proves the second.
