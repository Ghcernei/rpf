#!/usr/bin/env bash
# record-decision.sh — the ONE decision-record renderer (decision parity by
# construction, H1). Called by the telegram pickup AND by a session recording
# an in-chat answer: both channels produce byte-identical records except the
# channel field.
#
# usage:
#   record-decision.sh --gate <gate-id> --question-file <path> \
#     --answer <verbatim answer/button label> --channel telegram|session \
#     [--timestamp <iso8601>] [--out-dir <dir>]
#
# The record carries: gate id, the FULL question text as sent, the answer
# verbatim (DR5), timestamp, channel. Output: <out-dir>/<gate-id>-decision.md
# (out-dir defaults to the repo decisions/ directory).

set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

GATE="" QFILE="" ANSWER="" CHANNEL="" TS="" OUT_DIR="$DECISIONS_DIR"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --gate) GATE="$2"; shift 2 ;;
    --question-file) QFILE="$2"; shift 2 ;;
    --answer) ANSWER="$2"; shift 2 ;;
    --channel) CHANNEL="$2"; shift 2 ;;
    --timestamp) TS="$2"; shift 2 ;;
    --out-dir) OUT_DIR="$2"; shift 2 ;;
    *) fatal record-decision "unknown argument: $1" ;;
  esac
done
[[ -n "$GATE" && -n "$QFILE" && -n "$ANSWER" && -n "$CHANNEL" ]] \
  || fatal record-decision "required: --gate --question-file --answer --channel"
[[ "$CHANNEL" == "telegram" || "$CHANNEL" == "session" ]] \
  || fatal record-decision "channel must be telegram or session, got: $CHANNEL"
[[ -f "$QFILE" ]] || fatal record-decision "question file not found: $QFILE"
[[ -n "$TS" ]] || TS="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

atomic_write "$OUT_DIR/$GATE-decision.md" <<EOF
# DECISION — $GATE

- gate: $GATE
- timestamp: $TS
- channel: $CHANNEL

## Question (full text as sent)

$(cat "$QFILE")

## Answer (verbatim, DR5)

> $ANSWER
EOF

log record-decision "rendered $GATE-decision.md channel=$CHANNEL"
printf '%s\n' "$OUT_DIR/$GATE-decision.md"
