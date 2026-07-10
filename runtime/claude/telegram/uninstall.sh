#!/usr/bin/env bash
# uninstall.sh — remove both launchd jobs. State, log, and inbox are kept
# (they are records, not machinery); delete them by hand if truly wanted.

set -euo pipefail
AGENTS_DIR="$HOME/Library/LaunchAgents"
for label in md.qroky.telegram.listener md.qroky.telegram.digest; do
  launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
  rm -f "$AGENTS_DIR/$label.plist"
  echo "removed: $label"
done
echo "telegram head unloaded. State/log/inbox kept in place."
