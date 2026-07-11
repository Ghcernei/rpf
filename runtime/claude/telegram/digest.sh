#!/usr/bin/env bash
# digest.sh — the digest contour (H6, INFO-033 п.2). Strictly scheduled: a
# launchd StartCalendarInterval fires this daily at the profile DIGEST_TIME
# (install.sh bakes the time into the plist — that is the ±5 min guarantee,
# launchd's own precision). Content: «сделано / в работе / ждёт тебя сегодня /
# расход» + the 3-line changelog when a new framework release tag exists
# (INFO-023). Events already sent by the dialogue contour today appear ONLY
# as status lines — never as a second alarm.
#
# Independence: reads plain files (status.yaml, signaled registry, spend
# ledger, heartbeat's out/ if present). Heartbeat absent or disabled — the
# digest still ships; a data source missing — the section says so honestly
# instead of going quiet.

set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

TODAY="$(date +%Y-%m-%d)"
MARKER="$STATE_DIR/digest-sent-$TODAY"
if [[ -f "$MARKER" && -z "${QROKY_TEST_FORCE_DIGEST:-}" ]]; then
  log digest "already sent today — no duplicate"
  exit 0
fi

require_python digest

# ---- сделано / в работе / ждёт (products/*/status.yaml, one python pass) ----
# ATOM-111: extracted to a function — the router digest runs it once per
# registered workspace; a v1 machine runs it once on TG_ROOT (byte-same body).
collect_status() { # $1 = products dir → fills DONE_LINES/RUN_LINES/WAIT_LINES
  DONE_LINES="" RUN_LINES="" WAIT_LINES=""
  [[ -d "$1" ]] || return 0
  while IFS=$'\t' read -r state prod atom note; do
    case "$state" in
      done)    DONE_LINES+="• $prod/$atom${note:+ — $note}"$'\n' ;;
      running) RUN_LINES+="• $prod/$atom${note:+ — $note}"$'\n' ;;
      waiting) WAIT_LINES+="• $prod/$atom${note:+ — $note}"$'\n' ;;
    esac
  done < <(py - "$1" <<'PYEOF'
import sys, os, re, glob
root = sys.argv[1]
for path in sorted(glob.glob(os.path.join(root, "*", "status.yaml"))):
    prod = os.path.basename(os.path.dirname(path))
    cur = None
    for ln in open(path, encoding="utf-8", errors="replace"):
        m = re.match(r'\s+([A-Z][A-Z0-9-]+):\s*$', ln) or re.match(r'\s+- id:\s*(\S+)', ln)
        if m: cur = m.group(1); continue
        m = re.match(r'\s+(?:status|state):\s*(.+)$', ln)
        if m and cur:
            s = m.group(1).strip()
            if s.startswith(("delivered", "closed", "reviewed")): kind = "done"
            elif s.startswith(("blocked", "awaiting", "pending")): kind = "waiting"
            else: kind = "running"
            print(f"{kind}\t{prod}\t{cur}\t{s}")
            cur = None
PYEOF
)
}

# ---- ждёт тебя сегодня: gates still awaiting an answer ----------------------
# ATOM-111: an optional workspace filter — a pending gate belongs to the
# project stored with it; a v1 entry (no workspace field) belongs to primary.
pending_gate_lines() { # $1 = workspace path filter ("" = all)
  local g gws out=""
  for g in "$STATE_DIR/pending-gates"/*; do
    [[ -f "$g" && "$g" != *.answered ]] || continue
    if [[ -n "${1:-}" ]]; then
      gws="$(sed -n 's/^workspace: //p' "$g" 2>/dev/null | head -1 || true)"
      [[ -z "$gws" ]] && gws="$TG_ROOT"
      if [[ "$gws" != "$1" ]]; then
        # An origin matching NO registry entry surfaces in the PRIMARY
        # section — a pending decision must never vanish from the digest.
        if [[ "$1" == "$TG_ROOT" ]] && ! registry_entries | grep -qxF "$gws"; then
          :
        else
          continue
        fi
      fi
    fi
    out+="• $(basename "$g")$(T_DG_PENDING_SUFFIX)"$'\n'
  done
  printf '%s' "$out"
}
# $() strips the trailing newline the v1 inline loop used to carry — restore
# it, or the v1 body loses its blank line before the next section and the
# merged section glues «…выше)расход:…» (verify r1-F2).
PENDING_LINES="$(pending_gate_lines "")"
[[ -n "$PENDING_LINES" ]] && PENDING_LINES+=$'\n'

# ---- уже просигналено сегодня → строки статуса, не алармы (H6) --------------
SIGNALED_LINES=""
if [[ -f "$(signaled_file)" ]]; then
  while IFS= read -r ev; do
    [[ -n "$ev" ]] && SIGNALED_LINES+="• $ev$(T_DG_SIGNALED_SUFFIX)"$'\n'
  done < <(sort -u "$(signaled_file)")
fi

# ---- расход (честно: ledger или «данных нет») -------------------------------
SPEND_LINE="$(T_DG_SPEND_NONE)"
[[ -f "$STATE_DIR/spend/$TODAY" ]] && SPEND_LINE="$(T_DG_SPEND "$(cat "$STATE_DIR/spend/$TODAY")")"

# ---- changelog line on a new framework release tag (INFO-023) ---------------
CHANGELOG=""
FW_DIR="$TG_ROOT/framework"
if command -v git >/dev/null 2>&1 && [[ -e "$FW_DIR/.git" ]]; then
  latest="$(git -C "$FW_DIR" tag -l 'v*' --sort=-v:refname 2>>"$LOG_FILE" | head -1 || true)"
  last_seen=""; [[ -f "$STATE_DIR/last-release-tag" ]] && last_seen="$(cat "$STATE_DIR/last-release-tag")"
  if [[ -n "$latest" && "$latest" != "$last_seen" ]]; then
    body="$(git -C "$FW_DIR" tag -l "$latest" --format='%(contents:body)' 2>>"$LOG_FILE" | sed '/^[[:space:]]*$/d' | head -3)"
    CHANGELOG="$(T_DG_CHANGELOG "$latest")"$'\n'"$body"
    printf '%s' "$latest" > "$STATE_DIR/last-release-tag.tmp" && mv "$STATE_DIR/last-release-tag.tmp" "$STATE_DIR/last-release-tag"
  fi
else
  log digest "changelog skipped: framework is not a git checkout here (or git missing) — honest degradation"
fi

if ! router_active; then
  # ---- v1 body (single workspace) — byte-shape unchanged from ATOM-110 ------
  collect_status "$PRODUCTS_DIR"
  # verify M6: blocked atoms and pending gates are ONE section — the
  # «решений не ждём» line appears only when BOTH are empty, so a phone screen
  # never shows waiting items and «ничего не ждёт» together.
  WAIT_COMBINED="$WAIT_LINES$PENDING_LINES"
  [[ -n "${WAIT_COMBINED//[$'\n' ]/}" ]] || WAIT_COMBINED="$(T_DG_NO_DECISIONS)"$'\n'

  MSG="$(T_DG_GREETING "$TODAY")

$(T_DG_DONE)
${DONE_LINES:-$(T_DG_EMPTY_DONE)}
$(T_DG_RUN)
${RUN_LINES:-$(T_DG_EMPTY_RUN)}
$(T_DG_WAIT_TODAY)
${WAIT_COMBINED}
${SIGNALED_LINES:+$(T_DG_SIGNALED_HEADER)
$SIGNALED_LINES}
$SPEND_LINE${CHANGELOG:+

$CHANGELOG}"
else
  # ---- router body (ATOM-111, H2): ONE message, a section per registered ----
  # project. Empty project = one line; a dead registry path = an honest ⚠
  # line, never a crash (H6); spend sums into a total when ledgers open with
  # a number (free-text ledgers stay listed, just not summed).
  SECTIONS="" TOTAL_SPEND=0 HAVE_SPEND=0
  while IFS= read -r ws; do
    [[ -n "$ws" ]] || continue
    name="$(workspace_name "$ws")"
    if [[ ! -d "$ws" ]]; then
      SECTIONS+="$(T_DG_DEAD "$name" "$ws")"$'\n\n'
      continue
    fi
    collect_status "$ws/products"
    PG="$(pending_gate_lines "$ws")"          # $() eats the final newline —
    [[ -n "$PG" ]] && PG+=$'\n'               # restore it (verify r1-F2 glue)
    WAIT_COMBINED="$WAIT_LINES$PG"
    sp_file="$ws/.qroky/telegram/state/spend/$TODAY"
    [[ "$ws" == "$TG_ROOT" ]] && sp_file="$STATE_DIR/spend/$TODAY"
    SPL="$(T_DG_SPEND_NONE_SHORT)"
    if [[ -f "$sp_file" ]]; then
      v="$(cat "$sp_file")"; SPL="$(T_DG_SPEND "$v")"
      n="$(printf '%s' "$v" | grep -oE '^[0-9]+' || true)"
      [[ -n "$n" ]] && { TOTAL_SPEND=$((TOTAL_SPEND + n)); HAVE_SPEND=1; }
    fi
    if [[ -z "${DONE_LINES//[$'\n' ]/}${RUN_LINES//[$'\n' ]/}${WAIT_COMBINED//[$'\n' ]/}" ]]; then
      SECTIONS+="$(T_DG_QUIET "$name")"$'\n\n'
      continue
    fi
    [[ -n "${WAIT_COMBINED//[$'\n' ]/}" ]] || WAIT_COMBINED="$(T_DG_NO_DECISIONS)"$'\n'
    SECTIONS+="[$name]
$(T_DG_DONE)
${DONE_LINES:-$(T_DG_EMPTY_DONE)}
$(T_DG_RUN)
${RUN_LINES:-$(T_DG_EMPTY_RUN)}
$(T_DG_WAIT)
${WAIT_COMBINED}$SPL

"
  done < <(registry_entries)

  TOTAL_LINE=""
  [[ $HAVE_SPEND -eq 1 ]] && TOTAL_LINE="$(T_DG_TOTAL "$TOTAL_SPEND")"
  MSG="$(T_DG_GREETING_MERGED "$TODAY")

$SECTIONS${SIGNALED_LINES:+$(T_DG_SIGNALED_HEADER)
$SIGNALED_LINES
}${TOTAL_LINE}${CHANGELOG:+

$CHANGELOG}"
fi

[[ ${#MSG} -gt 3900 ]] && MSG="${MSG:0:3900}"$'\n'"$(T_DG_TRUNCATED)"

CHAT="$(bound_chat_id)"
if [[ -z "$CHAT" ]]; then
  log digest "DEGRADED: no bound chat_id — digest not sent; run install.sh --bind"
  exit 0
fi
if send_text digest "$CHAT" "$MSG"; then
  : > "$MARKER"
  log digest "sent for $TODAY"
else
  log digest "send FAILED — will retry on next scheduled fire; check network and token file at $TOKEN_FILE"
  exit 1
fi
