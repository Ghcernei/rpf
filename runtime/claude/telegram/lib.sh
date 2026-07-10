#!/usr/bin/env bash
# lib.sh — shared plumbing of the Telegram head (ATOM-110).
# Sourced by listener.sh / handler.sh / send-event.sh / digest.sh /
# record-decision.sh / pickup.sh. Plain bash + curl + /usr/bin/python3 (JSON
# parsing only). No inbound ports, no daemons, no LLM here.
#
# Sandbox overrides (tests only; production needs no env):
#   QROKY_TG_HOME     — where profile.conf / state / telegram.log live
#                       (default: registry primary's home, else this directory)
#   QROKY_TG_ROOT     — the CURRENT workspace: repo root holding decisions/
#                       and products/ (default: registry primary, else three
#                       levels up from this directory)
#   QROKY_REGISTRY    — registry file path (default: ~/.qroky/registry)
#   QROKY_TEST_NOW_HM — fake "HH:MM" clock for quiet-hours logic
#   QROKY_TEST_DELAY_INBOX — seconds to sleep between tmp-write and rename
#                       (kill-mid-write scenario hook)
#
# PROJECT ROUTER (ATOM-111, INFO-034 — one bot per owner, many projects):
# `~/.qroky/registry` — plain text, ONE workspace path per line, `#` comments
# and blank lines allowed; the ONLY machine-level file (I3-class exception,
# GATE-029). The FIRST entry is the PRIMARY workspace, and its telegram home
# (`<primary>/.qroky/telegram/`) is the HUMAN-LEVEL home (H7 — the ONE
# documented place): chat_id binding, token path, quiet hours, digest time,
# detail level, offset, queue, signaled registry, pending-gates all live
# there. Per-project settings = PROJECT_NAME override only (in that
# workspace's own `.qroky/telegram/profile.conf`). The env split IS the
# routing: QROKY_TG_ROOT says «which project am I», TG_HOME says «which
# human». Router rendering (labels, merged digest, project re-ask) activates
# only when the registry holds MORE THAN ONE workspace — a single-project
# machine behaves exactly like v1.

set -euo pipefail

TG_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

registry_file() { printf '%s' "${QROKY_REGISTRY:-$HOME/.qroky/registry}"; }

# All registered workspaces (comments/blank lines stripped). No registry (or
# an effectively empty one) → empty output; callers fall back to TG_ROOT.
registry_entries() {
  local rf; rf="$(registry_file)"
  [[ -f "$rf" ]] || return 0
  grep -v '^[[:space:]]*#' "$rf" 2>/dev/null | grep -v '^[[:space:]]*$' || true
}

registry_count() { registry_entries | grep -c . || true; }

TG_PRIMARY="$(registry_entries | head -1)"
TG_HOME="${QROKY_TG_HOME:-${TG_PRIMARY:+$TG_PRIMARY/.qroky/telegram}}"
TG_HOME="${TG_HOME:-$TG_LIB_DIR}"
TG_ROOT="${QROKY_TG_ROOT:-${TG_PRIMARY:-$(cd "$TG_LIB_DIR/../../.." && pwd)}}"
# Normalize (ATOM-111): registry entries are written via `cd && pwd`
# (register.sh) — every path COMPARED against them must be normalized the
# same way, or a stray double slash silently unroutes a project.
[[ -d "$TG_ROOT" ]] && TG_ROOT="$(cd "$TG_ROOT" && pwd)"

STATE_DIR="$TG_HOME/state"
LOG_FILE="$TG_HOME/telegram.log"
INBOX_DIR="$TG_ROOT/decisions/inbox"
DECISIONS_DIR="$TG_ROOT/decisions"
PRODUCTS_DIR="$TG_ROOT/products"

mkdir -p "$STATE_DIR" "$STATE_DIR/queue" "$STATE_DIR/signaled" \
  "$STATE_DIR/narrative" "$STATE_DIR/pending-gates" "$STATE_DIR/router" \
  "$INBOX_DIR" "$INBOX_DIR/done" "$INBOX_DIR/quarantine"

# ---- profile (KEY=VALUE, shell-sourceable); defaults first, file overrides --
DIGEST_TIME="09:05"          # digest contour: daily send time (profile)
QUIET_START="23:00"          # dialogue contour: quiet hours start
QUIET_END="08:00"            # dialogue contour: quiet hours end
DETAIL_LEVEL="2"             # narrative feed level: 1 gates only, 2 beats, 3 full
RISK_WORD="ПОДТВЕРЖДАЮ"      # explicit word for risk-level HUMAN-TASKs
TOKEN_FILE="$TG_HOME/.token" # PRODUCTION: point at the kit's stored path
                             #   <workspace>/.qroky/telegram.token
DEFAULT_PROJECT=""           # router: adds an «общий» button to the project
                             # re-ask, routing to the workspace of this name
API_BASE="https://api.telegram.org"
[[ -f "$TG_HOME/profile.conf" ]] && . "$TG_HOME/profile.conf"

# ---- project router helpers (ATOM-111) --------------------------------------
workspace_name() { # human label of a workspace: PROJECT_NAME override or basename
  local w="$1" n=""
  [[ -f "$w/.qroky/telegram/profile.conf" ]] \
    && n="$(sed -n 's/^PROJECT_NAME="\{0,1\}\([^"]*\)"\{0,1\}$/\1/p' "$w/.qroky/telegram/profile.conf" 2>/dev/null | head -1 || true)"
  [[ -n "$n" ]] || n="$(basename "$w")"
  printf '%s' "$n"
}

router_active() { # >1 registered workspace → router rendering on
  [[ "$(registry_count)" -gt 1 ]]
}

workspaces_or_root() { # iteration source: registry entries, else current root
  local e; e="$(registry_entries)"
  if [[ -n "$e" ]]; then printf '%s\n' "$e"; else printf '%s\n' "$TG_ROOT"; fi
}

workspace_by_name() { # first registry workspace whose label matches $1 (ci)
  local want w
  want="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  while IFS= read -r w; do
    [[ -n "$w" ]] || continue
    if [[ "$(workspace_name "$w" | tr '[:upper:]' '[:lower:]')" == "$want" ]]; then
      printf '%s' "$w"; return 0
    fi
  done <<EOF
$(workspaces_or_root)
EOF
  return 1
}

log() { # log <component> <message...> — self-sufficient line, no secrets
  printf '[%s] %s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" "${*:2}" >> "$LOG_FILE"
}

fatal() { # loud failure with a concrete human action, never silent
  log "$1" "FATAL: ${*:2}"
  printf 'telegram-head %s: %s\n' "$1" "${*:2}" >&2
  exit 1
}

tg_token() { # token from file path ONLY; never echoed into any log
  [[ -f "$TOKEN_FILE" ]] || fatal "${1:-lib}" \
    "no bot token at $TOKEN_FILE — create the bot via @BotFather and put the token in that file (mode 600)"
  tr -d ' \n' < "$TOKEN_FILE"
}

tg_api() { # tg_api <component> <method> [--data-urlencode k=v ...] -> body
  # curl only. The token-bearing URL is NEVER logged: curl's stderr (which
  # can echo the URL on connection errors) is captured and the token masked
  # to bot****<last4> before any of it reaches the log (verify M5).
  local component="$1" method="$2"; shift 2
  local token; token="$(tg_token "$component")"
  local body="" rc=0 attempt err errfile="$STATE_DIR/.curl-err.$$"
  for attempt in 1 2 3; do            # 1 try + max 2 auto-retries (ladder)
    body="$(curl -sS --max-time 20 "$API_BASE/bot$token/$method" "$@" 2>"$errfile")" && rc=0 || rc=$?
    if [[ $rc -eq 0 ]] && printf '%s' "$body" | grep -q '"ok"[[:space:]]*:[[:space:]]*true'; then
      rm -f "$errfile"; printf '%s' "$body"; return 0
    fi
    err="$(cat "$errfile" 2>/dev/null || true)"
    err="${err//"$token"/bot****${token: -4}}"   # mask — never the raw token
    log "$component" "api $method attempt $attempt failed rc=$rc${err:+ err: ${err//$'\n'/ | }}"
  done
  rm -f "$errfile"
  log "$component" "api $method GAVE UP after 2 retries — check network and the token file at $TOKEN_FILE"
  return 1
}

py() { /usr/bin/python3 "$@"; }
require_python() {
  command -v /usr/bin/python3 >/dev/null 2>&1 || fatal "$1" \
    "/usr/bin/python3 not found — install Apple Command Line Tools (xcode-select --install); unprocessed updates stay on Telegram's side and are re-delivered next pass"
}

atomic_write() { # atomic_write <dest-path>  (content on stdin): tmp+rename
  local dest="$1" dir tmp
  dir="$(dirname "$dest")"; tmp="$dir/.tmp.$$.$RANDOM"
  cat > "$tmp"
  [[ -n "${QROKY_TEST_DELAY_INBOX:-}" ]] && sleep "$QROKY_TEST_DELAY_INBOX"
  mv "$tmp" "$dest"
}

inbox_write_to() { # inbox_write_to <inbox-dir> <kind> <id> (stdin) -> path
  # ATOM-111: same atomic physics as inbox_write, but into ANOTHER project's
  # decisions/inbox/ — the router lands task-proposals in the workspace they
  # belong to, not where the listener happens to run.
  local dir="$1" kind="$2" id="$3"
  mkdir -p "$dir" "$dir/done" "$dir/quarantine"
  local name; name="$(date +%s)-$$-$RANDOM-$kind-$id.md"
  atomic_write "$dir/$name"
  printf '%s' "$dir/$name"
}

inbox_write() { # inbox_write <kind> <id> (frontmatter+body on stdin) -> path
  inbox_write_to "$INBOX_DIR" "$1" "$2"
}

now_hm() { printf '%s' "${QROKY_TEST_NOW_HM:-$(date +%H:%M)}"; }

in_quiet_hours() { # true when now is inside [QUIET_START, QUIET_END)
  local now s e
  now="$(now_hm)"; s="$QUIET_START"; e="$QUIET_END"
  if [[ "$s" < "$e" ]]; then          # window inside one day
    [[ "$now" > "$s" || "$now" == "$s" ]] && [[ "$now" < "$e" ]]
  else                                # window crosses midnight (23:00-08:00)
    [[ "$now" > "$s" || "$now" == "$s" || "$now" < "$e" ]]
  fi
}

signaled_file() { printf '%s' "$STATE_DIR/signaled/$(date +%Y-%m-%d).list"; }
mark_signaled() { printf '%s\n' "$1" >> "$(signaled_file)"; }
was_signaled_today() { [[ -f "$(signaled_file)" ]] && grep -qxF "$1" "$(signaled_file)"; }

bound_chat_id() { [[ -f "$STATE_DIR/chat_id" ]] && tr -d ' \n' < "$STATE_DIR/chat_id" || printf ''; }

send_text() { # send_text <component> <chat_id> <text> [reply_markup_json]
  local component="$1" chat="$2" text="$3" markup="${4:-}"
  local args=(--data-urlencode "chat_id=$chat" --data-urlencode "text=$text")
  [[ -n "$markup" ]] && args+=(--data-urlencode "reply_markup=$markup")
  tg_api "$component" sendMessage "${args[@]}" >/dev/null
}

render_status() { # /status [name-filter]: plain-language summary, no LLM.
  # v1 (single workspace): products/*/status.yaml of TG_ROOT, unlabeled.
  # Router (registry >1): every registered workspace, labeled «[name]»;
  # an optional filter narrows to one project by its label (ci). Dead
  # registry paths render one honest line — never break the reply (H6).
  local filter="${1:-}" out="" w n
  if router_active; then
    while IFS= read -r w; do
      [[ -n "$w" ]] || continue
      n="$(workspace_name "$w")"
      if [[ -n "$filter" ]]; then
        [[ "$(printf '%s' "$n" | tr '[:upper:]' '[:lower:]')" == "$(printf '%s' "$filter" | tr '[:upper:]' '[:lower:]')" ]] || continue
      fi
      if [[ ! -d "$w" ]]; then
        out+="[$n] ⚠ путь из реестра не найден: $w"$'\n'
        continue
      fi
      out+="[$n]"$'\n'"$(_render_status_one "$w/products")"$'\n'
    done <<EOF
$(workspaces_or_root)
EOF
    [[ -n "${out//[$'\n' ]/}" ]] || out="Проект с таким именем в реестре не найден. Зарегистрированы: $(workspaces_or_root | while IFS= read -r x; do [[ -n "$x" ]] && printf '%s ' "$(workspace_name "$x")"; done)"
  else
    out="$(_render_status_one "$PRODUCTS_DIR")"
    [[ -n "${out//[$'\n' ]/}" ]] || out="Пока нет ни одной задачи в products/ — статусов нет."
  fi
  # ≤1 message: Telegram cap 4096; keep margin and say so when truncated
  if [[ ${#out} -gt 3800 ]]; then out="${out:0:3800}"$'\n'"…(обрезано — полная картина в утреннем дайджесте)"; fi
  printf '%s' "$out"
}

_render_status_one() { # one products/ dir -> per-product status lines
  local pdir="$1" out="" f prod
  for f in "$pdir"/*/status.yaml; do
    [[ -f "$f" ]] || continue
    prod="$(basename "$(dirname "$f")")"
    out+="$(py - "$f" "$prod" <<'PYEOF'
import sys, re
path, prod = sys.argv[1], sys.argv[2]
lines = open(path, encoding="utf-8", errors="replace").read().splitlines()
cur = None; rows = []
for ln in lines:
    m = re.match(r'\s+(?:- id:\s*)?([A-Z][A-Z0-9-]+):?\s*$', ln)
    if m: cur = m.group(1); continue
    m = re.match(r'\s+- id:\s*(\S+)', ln)
    if m: cur = m.group(1); continue
    m = re.match(r'\s+(?:status|state):\s*(.+)$', ln)
    if m and cur:
        rows.append((cur, m.group(1).strip())); cur = None
act = [(a, s) for a, s in rows if not s.startswith(("closed", "delivered"))]
done = [(a, s) for a, s in rows if s.startswith(("closed", "delivered"))]
if act or done:
    print(f"• {prod}:")
    for a, s in act: print(f"    {a} — {s}")
    if done: print(f"    готово/закрыто: {len(done)}")
PYEOF
)"$'\n'
  done
  printf '%s' "$out"
}
