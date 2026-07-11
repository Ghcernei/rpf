# lang/en.sh — owner-visible strings of the Telegram head, English (ATOM-105).
# Selected by LANGUAGE="en" in profile.conf (the kit writes the question-1
# answer there). Same function catalog as ru.sh.

T_KROKY_ACK() { printf '%s' "Got it. Starting the «qroky» protocol — I will look around and send my proposal here; nothing happens before your explicit go."; }
T_FREE_ACK() { printf '%s' "Got it, on it — I will answer here."; }
T_GATE_ACK() { printf 'Recorded: «%s» — writing the decision for %s.' "$1" "$2"; }
T_GATE_DECLINE() { printf '%s' "I can't find that question — it may already be closed. If it still needs a decision, type your answer as text."; }
T_RISK_BUTTON_REJECT() { printf 'This is a risk-level confirmation — a button cannot accept it. Type the word %s as text.' "$1"; }
T_RISK_NONE() { printf '%s' "No risk-level confirmations are waiting right now."; }
T_RISK_WHICH() { printf 'Waiting for confirmation: %s. Specify: %s <id>.' "$1" "$2"; }
T_RISK_ACK() { printf 'Confirmation for %s accepted — writing the decision.' "$1"; }
T_ROUTE_DECLINE() { printf '%s' "I can't find that follow-up — it may already be closed. Send the thought again, ideally naming the project."; }
T_ROUTE_ACK() { printf 'Got it — routing to [%s]; I will shape it and show it here.' "$1"; }
T_REASK_QUESTION() { printf '%s' "Which project should this go to? One tap and I will shape it."; }
T_BTN_COMMON() { printf '%s' "general"; }
T_BEAT_MORE() { printf '…(continued in %s/NARRATIVE.md)' "$1"; }

T_PROMISE() { printf 'Got it, result by %s — looking around per the «qroky» protocol.' "$1"; }
T_KROKY_NOLLM() { printf '%s' "I can't start the «qroky» handler on this machine (claude CLI unavailable) — your request is saved; a live session will pick it up. Details: telegram.log."; }
T_TASK_FILED() { printf 'Filed as a task — a live session will see it in %s. Wording:' "$1"; }
T_FORMULATE_NOLLM_ROUTED() { printf '%s' "I can't formulate without the handler (claude CLI unavailable) — the message is saved; a live session will shape it. Details: telegram.log."; }
T_FORMULATE_NOLLM() { printf '%s' "I can't formulate without the handler (claude CLI unavailable) — your answer is saved; a live session will shape it. Details: telegram.log."; }
T_CLARIFY_NOLLM() { printf '%s' "Noted. The handler on this machine is unavailable (claude CLI) — a live session will pick your message up from decisions/inbox."; }
T_ORPHAN_PROMISE() { printf 'About the promise «result by %s»: the work was interrupted and its input was lost — please repeat the request. This is an honest failure, and it is recorded.' "$1"; }

T_STATUS_DEAD() { printf '[%s] ⚠ registry path not found: %s' "$1" "$2"; }
T_STATUS_NOT_FOUND() { printf 'No registered project has that name. Registered: %s' "$1"; }
T_STATUS_EMPTY() { printf '%s' "No tasks in products/ yet — nothing to report."; }
T_STATUS_EMPTY_BLOCK() { printf '%s' "• empty for now"; }
T_STATUS_DONE_CLOSED() { printf '%s' "done/closed"; }
T_STATUS_TRUNCATED() { printf '%s' "…(truncated — the full picture is in the morning digest)"; }

T_DG_GREETING() { printf 'Good morning. Digest for %s:' "$1"; }
T_DG_GREETING_MERGED() { printf 'Good morning. Combined digest for %s:' "$1"; }
T_DG_DONE() { printf '%s' "Done:"; }
T_DG_RUN() { printf '%s' "In progress:"; }
T_DG_WAIT_TODAY() { printf '%s' "Waiting for you today:"; }
T_DG_WAIT() { printf '%s' "Waiting for you:"; }
T_DG_EMPTY_DONE() { printf '%s' "• empty for now"; }
T_DG_EMPTY_RUN() { printf '%s' "• nothing running"; }
T_DG_NO_DECISIONS() { printf '%s' "• no decisions pending"; }
T_DG_PENDING_SUFFIX() { printf '%s' " — waiting for your decision (buttons in the chat above)"; }
T_DG_SIGNALED_HEADER() { printf '%s' "Already in the feed today (status, not an alarm):"; }
T_DG_SIGNALED_SUFFIX() { printf '%s' " — already arrived as an event today, no repeat alarm"; }
T_DG_SPEND_NONE() { printf '%s' "spend: no data for today"; }
T_DG_SPEND_NONE_SHORT() { printf '%s' "spend: no data"; }
T_DG_SPEND() { printf 'spend: %s' "$1"; }
T_DG_CHANGELOG() { printf 'Rulebook update %s:' "$1"; }
T_DG_QUIET() { printf '[%s] — quiet: no changes, no decisions pending' "$1"; }
T_DG_DEAD() { printf '⚠ [%s] — registry path not found: %s (fix ~/.qroky/registry)' "$1" "$2"; }
T_DG_TOTAL() { printf 'total spend (numeric ledgers): %s' "$1"; }
T_DG_TRUNCATED() { printf '%s' "…(truncated)"; }
