#!/usr/bin/env bash
# pickup.sh — inbox consumption (H1/H2). Run by a live session, by heartbeat,
# or by the handler the listener wakes — whoever wakes first. Mechanical, no
# LLM: renders gate answers into decision records of full parity.
#
# Exactly-once physics: the render is deterministic (timestamp comes FROM the
# inbox record, not from the clock), so render-then-move is idempotent — a
# crash between the two re-renders a byte-identical record on the next run,
# then moves. A consumed file lives in decisions/inbox/done/ (the CEO-orders
# ledger pattern).

set -euo pipefail
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

CONSUMED=0
for f in "$INBOX_DIR"/*-gate-answer-*.md; do
  [[ -f "$f" ]] || continue
  gate="$(sed -n 's/^gate: //p' "$f" | head -1)"
  answer="$(sed -n 's/^answer: //p' "$f" | head -1)"
  ts="$(sed -n 's/^timestamp: //p' "$f" | head -1)"
  channel="$(sed -n 's/^channel: //p' "$f" | head -1)"
  qfile="$STATE_DIR/pending-gates/$gate"
  if [[ ! -f "$qfile" ]]; then
    if [[ -f "$qfile.answered" ]]; then qfile="$qfile.answered"
    else
      log pickup "gate-answer for $gate has no stored question — quarantined, needs a human look"
      mv "$f" "$INBOX_DIR/quarantine/$(basename "$f")"
      continue
    fi
  fi
  # ATOM-111: the decision record goes HOME — the origin workspace persisted
  # with the pending gate wins over the local default; no field (v1 entry) or
  # a dead path → v1 behavior (local decisions/), logged honestly.
  out_dir="$DECISIONS_DIR"
  ws="$(sed -n 's/^workspace: //p' "$qfile" 2>/dev/null | head -1 || true)"
  if [[ -n "$ws" ]]; then
    if [[ -d "$ws" ]]; then out_dir="$ws/decisions"; mkdir -p "$out_dir"
    else log pickup "origin workspace of $gate not found ($ws) — record kept locally in $DECISIONS_DIR"
    fi
  fi
  # strip the pending-gate header (risk/workspace/sent/---) to the question
  qtext="$(mktemp "$STATE_DIR/.q.XXXXXX")"
  awk 'flag{print} /^---$/{flag=1}' "$qfile" > "$qtext"
  "$TG_LIB_DIR/record-decision.sh" --gate "$gate" --question-file "$qtext" \
    --answer "$answer" --channel "$channel" --timestamp "$ts" --out-dir "$out_dir" >/dev/null
  rm -f "$qtext"
  [[ -f "$STATE_DIR/pending-gates/$gate" ]] \
    && mv "$STATE_DIR/pending-gates/$gate" "$STATE_DIR/pending-gates/$gate.answered"
  mv "$f" "$INBOX_DIR/done/$(basename "$f")"
  log pickup "consumed gate-answer gate=$gate channel=$channel -> decision record"
  CONSUMED=$((CONSUMED + 1))
done

log pickup "pass done, consumed=$CONSUMED"
