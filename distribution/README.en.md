# Qroky — self-service install

## What this installer does

One script, `install.sh`, takes a clean computer to a working assistant in
under 15 minutes. It asks you exactly **eight questions** (listed below),
sets up a private folder on your own computer, and ends with the words you
say to start your first conversation. It never asks anything beyond those
eight questions — every other line it prints is either progress, a check
result, or (on a real problem) a plain-language fix instruction naming the
exact next step.

## The one-liner

```
bash install.sh
```

Run it from the folder where you unpacked/cloned this kit. If something is
missing (git, curl, the Claude Code assistant itself), the script stops and
tells you exactly what to install and how — then you run the same command
again, and it continues from exactly where it stopped. Nothing is repeated,
nothing you already answered is asked twice.

## Your first conversation

When setup finishes, start like this:

1. Open a terminal **in your working folder** (the one you chose at
   question 2). In VS Code instead: File → Open Folder → your working
   folder, then start a new chat.
2. Type: `claude`
3. Say: `qroky start`

One honest note: the starting phrase lives **in the working folder** — the
installer wires it into that folder (a small rules file plus a note the
assistant reads there). A chat opened anywhere else on the computer will
not know it.

## The eight questions

1. **Language** — English, Română, or Русский. Everything after this point
   is shown in the language you pick.
2. **Working folder** — where your private Qroky workspace should live. A
   sensible default is suggested; press Enter to accept it, or type your
   own path.
3. **Claude Code check** — the installer checks whether the Claude Code
   assistant is already on this machine. If not, you get the exact install
   link and instructions; run the installer again once it's in.
4. **Subscription check** — a quick, non-blocking check that your Claude
   Code login/subscription looks active. This is a check, not a purchase
   flow — if it can't tell, it just reminds you, it never stops you.
5. **Telegram (optional)** — want a morning digest and updates through
   Telegram? If yes, the installer walks you through creating your own bot
   with BotFather, step by step, and checks the token works live before
   saving it. Skippable any time — type "skip".
6. **Daily support sharing (optional)** — see "What leaves this computer"
   below before you're asked. Off by default.
7. **Morning digest (optional)** — a short daily message: what got done,
   what's waiting for you. Recommended: yes. You can change your mind any
   time (see "Don't touch my instance" below).
8. **Backup (optional, recommended)** — keep a private safety copy of your
   Qroky folder in **your own** GitHub account. You don't need to know what
   GitHub is: if you say yes, the installer walks you through connecting
   (or creating, for free) your account step by step, the same hand-held
   way as the Telegram bot. **The backup goes to YOUR account** — a private
   copy visible only to you, never to us or anyone else. Your secret files
   (like the Telegram token) are excluded from every backup, automatically.

## What leaves this computer

If you turn on daily support sharing at question 6, this — and only this —
would ever leave this machine (the complete list; anything not on it is
skipped, never read):

1. **Task progress files (`STATUS.md`)** — status word, date, and task id
   only; free-text notes stripped.
2. **Cost summaries (`RESULT.md`)** — the token/time cost figures ONLY;
   the summary and content sections, where your product would be
   described, are never copied.
3. **Step logs (`run.log`)** — timestamps and step names only.
4. **The status board (`status.yaml`)** — one line per task; free-text
   notes stripped.
5. **Independent check results (`VERDICT.md`)** — the verdict line only,
   never the findings text.

Never your product's code, specs, or content — those are not on the list
and are never read. Note that this installer only **records your choice**:
no sending mechanism is installed today, so nothing can leave even after a
yes. Before any sending script is ever added to your workspace, you will
be shown that script itself — plain, readable bash you can check line by
line against the list above.

## Don't touch my instance

The installer never changes anything you didn't ask for, and every
optional piece it turns on can be turned off just as easily:

- **Disable the morning digest:** delete the file inside your workspace's
  `.qroky/launchd/` folder from `~/Library/LaunchAgents/`, or simply don't
  answer "yes" at question 7 in the first place — the digest ships
  installed-but-off in that case, with the exact enable command printed
  for you.
- **Enable the morning digest later:** `bash install.sh --enable-heartbeat`
- **Enable the backup later** (if you said no at question 8):
  `bash install.sh --enable-backup`
- **Check for a framework update (read-only, changes nothing):**
  `bash install.sh --check-update`
- **See more detail on a pending update:**
  `bash install.sh --show-update-details`
- **Apply a pending update (only after you explicitly confirm):**
  `bash install.sh --apply-update` — if you have made your own edits inside
  the vendored `framework/` folder, the installer SHOWS you exactly what
  would be affected before touching anything; it never silently overwrites
  your changes.

## Safe to re-run, always

Every step the installer takes is a "check, then do" pair: on a healthy,
already-set-up workspace, running `install.sh` again is a free health
check that changes nothing and re-asks nothing. If the installer gets
killed partway through (power loss, closed terminal, anything), running it
again resumes exactly where it left off — the answers you already gave are
remembered in `install-state.json` inside your workspace, a plain text file
you're welcome to read.

## Backup and restore

If you turned the backup on (question 8), a private copy of your Qroky
folder named `qroky-backup` lives in **your own** GitHub account — nobody
else's, and nobody else can see it. Restoring on any computer is one
command:

```
gh repo clone qroky-backup
```

Then run `bash install.sh` once inside the restored folder — it re-attaches
the pinned rulebook and re-checks everything, asking nothing you already
answered. Your secret files (the Telegram token and anything secret-shaped)
are excluded from every backup by a `.gitignore` the installer writes for
you — they never leave this machine.

## A note on responsibility

The system produces drafts and analysis; legal, financial, and medical
decisions and signatures are always made by a human. Not professional
advice.
