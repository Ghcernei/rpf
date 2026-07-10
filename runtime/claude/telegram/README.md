# Telegram head v1 — the phone-side voice of the instance

| Field | Value |
| :---- | :---- |
| Product | `runtime/claude/telegram/` — polling listener, shared send helper, inbox conventions, digest, decision-parity records |
| Atom | ATOM-110 (telegram-head-v1) |
| Mandate | INFO-032 (verbatim), INFO-033 (two-contour channel model, final) |
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
| `digest.sh` | digest contour renderer/sender |
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
