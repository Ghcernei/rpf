#!/usr/bin/env bash
# unregister.sh — remove a workspace from the machine-level project registry
# (ATOM-111; pair of register.sh). Removing a path that is not registered is
# an honest no-op. Comments and other lines are preserved byte-identically.
#
# usage: unregister.sh <workspace-path>

set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

RF="$(registry_file)"
[[ -n "${1:-}" ]] || fatal unregister "usage: unregister.sh <workspace-path>"
WS="$1"
[[ -d "$WS" ]] && WS="$(cd "$WS" && pwd)"

if [[ ! -f "$RF" ]] || ! grep -qxF "$WS" "$RF"; then
  echo "not registered (nothing to do): $WS"
  log unregister "not registered: $WS — no-op"
  exit 0
fi
TMP="$RF.tmp.$$"
grep -vxF "$WS" "$RF" > "$TMP" || true
mv "$TMP" "$RF"
echo "unregistered: $WS (remaining: $(registry_count))"
log unregister "unregistered workspace $WS (remaining $(registry_count))"
