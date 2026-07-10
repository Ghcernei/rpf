#!/usr/bin/env bash
# register.sh — add a workspace to the machine-level project registry
# (ATOM-111, INFO-034; the registry file is the ONE machine-level file —
# I3-class exception recorded in GATE-029).
#
# usage: register.sh <workspace-path>
#        register.sh --list
#
# Registry: ${QROKY_REGISTRY:-~/.qroky/registry} — plain text, one absolute
# workspace path per line, `#` comments and blank lines allowed. The FIRST
# entry is the primary workspace: its `.qroky/telegram/` is the human-level
# home (chat binding, token path, quiet hours, digest time — see lib.sh).
# Idempotent: registering an already-registered path changes nothing.

set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

RF="$(registry_file)"

if [[ "${1:-}" == "--list" ]]; then
  if [[ -f "$RF" ]]; then cat "$RF"; else echo "(registry not created yet: $RF)"; fi
  exit 0
fi

[[ -n "${1:-}" ]] || fatal register "usage: register.sh <workspace-path> | --list"
[[ -d "$1" ]] || fatal register "not a directory: $1 — register an existing workspace"
WS="$(cd "$1" && pwd)"

mkdir -p "$(dirname "$RF")"
if [[ -f "$RF" ]] && grep -qxF "$WS" "$RF"; then
  echo "already registered: $WS ($RF)"
  log register "already registered: $WS"
  exit 0
fi
printf '%s\n' "$WS" >> "$RF"
echo "registered: $WS -> $RF ($(registry_count) workspace(s) total)"
log register "registered workspace $WS (total $(registry_count))"
