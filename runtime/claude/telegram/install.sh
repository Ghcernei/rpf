#!/usr/bin/env bash
# install.sh — Telegram head installer (idempotent, check->do; kit pattern).
# Re-run on a healthy install = free health check.
#
# usage:
#   bash install.sh            # install/repair both launchd jobs
#   bash install.sh --bind     # bind the owner's chat_id (one poll, confirm)
#   bash install.sh --status   # health check only
#   bash install.sh --render-plists-only <dir>   # harness hook: generate
#                              # plists into <dir>, do not touch launchd

set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

AGENTS_DIR="$HOME/Library/LaunchAgents"
LISTENER_LABEL="md.qroky.telegram.listener"
DIGEST_LABEL="md.qroky.telegram.digest"

render_plists() { # render_plists <target-dir>
  local target="$1" hour minute
  hour="${DIGEST_TIME%%:*}"; minute="${DIGEST_TIME##*:}"
  hour=$((10#$hour)); minute=$((10#$minute))     # strip leading zeros
  mkdir -p "$target"
  sed -e "s|__TG_DIR__|$TG_LIB_DIR|g" -e "s|__HOME__|$HOME|g" \
    "$TG_LIB_DIR/launchd/$LISTENER_LABEL.plist" > "$target/$LISTENER_LABEL.plist"
  sed -e "s|__TG_DIR__|$TG_LIB_DIR|g" -e "s|__HOME__|$HOME|g" \
      -e "s|__HOUR__|$hour|g" -e "s|__MINUTE__|$minute|g" \
    "$TG_LIB_DIR/launchd/$DIGEST_LABEL.plist" > "$target/$DIGEST_LABEL.plist"
}

health() {
  local ok=1
  [[ -f "$TOKEN_FILE" ]] && echo "token file: present ($TOKEN_FILE)" \
    || { echo "token file: MISSING at $TOKEN_FILE — create the bot via @BotFather, put the token there (mode 600)"; ok=0; }
  [[ -n "$(bound_chat_id)" ]] && echo "chat binding: bound" \
    || { echo "chat binding: NOT BOUND — run: bash install.sh --bind"; ok=0; }
  command -v /usr/bin/python3 >/dev/null && echo "python3: present" \
    || { echo "python3: MISSING — xcode-select --install"; ok=0; }
  if command -v launchctl >/dev/null 2>&1; then
    launchctl list "$LISTENER_LABEL" >/dev/null 2>&1 && echo "listener job: loaded" || { echo "listener job: not loaded"; ok=0; }
    launchctl list "$DIGEST_LABEL" >/dev/null 2>&1 && echo "digest job: loaded (fires daily at $DIGEST_TIME)" || { echo "digest job: not loaded"; ok=0; }
  else
    echo "launchctl: MISSING (not macOS?) — run listener.sh every 30 s and digest.sh at $DIGEST_TIME by your own scheduler"
  fi
  [[ $ok -eq 1 ]] && echo "HEALTH: OK" || echo "HEALTH: attention needed (lines above)"
}

case "${1:-install}" in
  --render-plists-only)
    render_plists "${2:?target dir required}"
    echo "plists rendered to $2 (digest at $DIGEST_TIME)"
    ;;
  --bind)
    echo "Открой своего бота в Telegram и отправь ему любое сообщение, затем нажми Enter здесь."
    read -r
    BODY="$(tg_api install getUpdates --data-urlencode "timeout=0")" || fatal install "getUpdates failed — check network and token file at $TOKEN_FILE"
    CANDIDATE="$(printf '%s' "$BODY" | py -c 'import sys,json; r=json.load(sys.stdin).get("result",[]); print(r[-1]["message"]["chat"]["id"] if r and "message" in r[-1] else "")')"
    [[ -n "$CANDIDATE" ]] || fatal install "no incoming message found — send the bot a message first, then re-run --bind"
    printf 'Найден chat_id: %s — это ты? [y/N] ' "$CANDIDATE"
    read -r yn
    [[ "$yn" == "y" || "$yn" == "Y" ]] || { echo "не записано."; exit 1; }
    printf '%s' "$CANDIDATE" > "$STATE_DIR/chat_id.tmp" && mv "$STATE_DIR/chat_id.tmp" "$STATE_DIR/chat_id"
    log install "chat_id bound"
    echo "привязано. Только этот chat_id будет обслуживаться; чужие — в карантин."
    ;;
  --status) health ;;
  install)
    command -v launchctl >/dev/null 2>&1 || fatal install "launchctl not found — this installer targets macOS; on other systems schedule listener.sh (30 s) and digest.sh ($DIGEST_TIME) yourself"
    mkdir -p "$AGENTS_DIR"
    render_plists "$AGENTS_DIR"
    for label in "$LISTENER_LABEL" "$DIGEST_LABEL"; do
      launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
      launchctl bootstrap "gui/$(id -u)" "$AGENTS_DIR/$label.plist" \
        || fatal install "launchctl bootstrap failed for $label — try: launchctl bootstrap gui/$(id -u) $AGENTS_DIR/$label.plist"
    done
    log install "launchd jobs installed (listener 30s; digest $DIGEST_TIME daily)"
    echo "установлено: listener каждые 30 с, дайджест ежедневно в $DIGEST_TIME."
    health
    ;;
  *) fatal install "unknown argument: $1" ;;
esac
