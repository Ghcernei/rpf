# Changelog

One entry per release tag, written in user-benefit language (what gets
better for you). Rendered from the release's verified records — nothing here
is composed from memory. Rule (INFO-024): a release without a changelog
entry is not published.

## v0.3 — 2026-07-10

- One bot, all your projects: events arrive labeled «[project]», a button
  press files the decision in the RIGHT project, the morning digest is one
  message with a section per project, and «что в работе <имя>» filters to
  one. A thought that names no project gets exactly one clarifying question
  with buttons.
- If you have one project, nothing changes — output is byte-identical to
  before; the router switches on only when a second project appears (a new
  workspace simply JOINS the already-connected bot: no second key, no
  second Start).
- Existing installs migrate silently on update: no questions, no re-binding,
  no repeated greeting. Updating also auto-completes a half-connected
  Telegram (the «gave the key, nothing happened» case is gone).

## v0.2 — 2026-07-10

- Gave your bot key → the bot greets you right away: «Я на связи. Завтра
  утром пришлю первый дайджест» — and it means it. The Telegram assistant
  now installs itself with the kit: replies to you within a minute, sends a
  morning digest, delivers gates as buttons you can answer from your phone
  (a press has the same force as an answer typed at the computer).
- You always know where you are: the installer opens with a map (9
  questions → ~3 minutes → two lines to start), every question says «N из
  9», and the finish screen gives you a ready copy-paste block with YOUR
  real folder path — plus a line for VS Code users.
- New question 9: make «qroky start» work from any chat on this machine
  (optional, exactly two small files, removal documented).
- New «Первые 5 минут» guide section: what to say first and what success
  looks like.

## v0.1.2 — 2026-07-10

- «qroky start» now works out of the box: the starting gesture ships inside
  the kit and the installer wires it into your working folder automatically
  (this closes the first field-test finding — the finish screen used to
  promise a phrase your machine had never been taught).
- The default working folder moved to `~/qroky-work` — outside the
  downloaded kit, so kit updates never sit next to your own work.
- The finish screen and the guides now include a line for VS Code users
  (File → Open Folder → your working folder) and say honestly that the
  starting phrase lives in that folder.

*Earlier kit versions (v0.1.0 installer, v0.1.1 backup + disclaimer) predate
tagging and shipped by commit; their records live in
`products/distribution-kit-v1/`.*
