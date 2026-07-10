#!/usr/bin/env bash
# dry-run.sh — sandbox harness for distribution/install.sh
#
# Author: pilot-toolsmith (ATOM-101, Distribution Kit v1) · Date: 2026-07-10
# Pattern: 071-setup-kit/setup/dry-run.sh (proven: PATH-shadow stubs + a
# local offline git repo standing in for the framework remote + isolated
# HOME so a real, unmodified install.sh runs for real against fakes).
#
# What is REAL in every scenario below: every filesystem action install.sh
# performs (workspace creation, git init, framework vendoring + pinned
# checkout, install-state.json / install.log / decisions/ writes, the
# heartbeat file generation, the token file with its real mode-600
# permission) and the wall-clock timing of the full-clean-run scenario.
#
# What is STUBBED, and how (all sandbox-only, zero effect on a real
# install.sh — see its own header comment for the two extra in-script test
# hooks, QROKY_TEST_STUBS and QROKY_TEST_DELAY_*):
#   - `claude`      — a two-line fake answering only --version (071 pattern)
#   - `curl`        — a fake answering ONLY Telegram's getMe endpoint (the
#                     one external call install.sh makes); GOODTOKEN* is
#                     accepted, anything else is rejected, exactly like the
#                     real Bot API would reject a bad token
#   - `launchctl`   — a fake that logs bootout/bootstrap calls to a sandbox
#                     file instead of touching this machine's real launchd
#                     (a real near-miss during manual smoke-testing is what
#                     surfaced the need for this — see run.log)
#   - framework source — a real, local, offline git repository (tags
#                     included) standing in for https://github.com/qroky/
#                     framework.git, via the same QROKY_FRAMEWORK_SOURCE
#                     override install.sh already reads for exactly this
#   - HOME          — an isolated sandbox HOME (git config allowing the
#                     local file:// transport — a hardening default that
#                     only matters for this local-path trick, never for a
#                     real founder's https default; see 071's dry-run.sh)
#
# Transcripts are written next to this comment's sibling folder
# (v0.1.2 / ATOM-103 — records live in the CURRENT atom's workspace):
#   products/distribution-kit-v1/103-gesture-fix/workspace/
#   scenario-1-full-clean-run.txt
#   scenario-2-kill-mid-install.txt
#   scenario-3-healthy-rerun.txt
#   scenario-4-broken-dependency.txt
#   scenario-5-idempotency-diff.txt
#   scenario-6-secrets-negative-grep.txt
#   scenario-7-self-update.txt
#   scenario-8-heartbeat-both-branches.txt
#   scenario-9-backup-optin-optout.txt
#   scenario-10-gesture-wiring.txt
#   SUMMARY.txt
#
# Usage: ./dry-run.sh   (no arguments; self-contained; safe to re-run)

set -uo pipefail   # NOT -e: scenarios intentionally capture non-zero exits

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ATOM_WORKSPACE="$(cd "$HERE/../products/distribution-kit-v1/103-gesture-fix/workspace" && pwd)"
SANDBOX="$(mktemp -d /private/tmp/qroky-install-dry-run.XXXXXX)"
cleanup() { rm -rf "$SANDBOX"; }
trap cleanup EXIT

PASS_COUNT=0
FAIL_COUNT=0
SUMMARY_LINES=()

record() {
  # $1 = scenario name, $2 = PASS|FAIL, $3.. = one-line reason
  if [[ "$2" == "PASS" ]]; then PASS_COUNT=$((PASS_COUNT + 1)); else FAIL_COUNT=$((FAIL_COUNT + 1)); fi
  SUMMARY_LINES+=("$2 — $1: $3")
}

# ---------------------------------------------------------------------------
# Shared sandbox scaffolding (built once, reused by every scenario)
# ---------------------------------------------------------------------------
KIT="$SANDBOX/kit"
mkdir -p "$KIT/lang"
cp "$HERE/install.sh" "$KIT/install.sh"
cp "$HERE"/lang/*.sh "$KIT/lang/"
chmod +x "$KIT/install.sh"
INSTALL="$KIT/install.sh"

BIN="$SANDBOX/bin"
mkdir -p "$BIN"

cat > "$BIN/claude" <<'EOF'
#!/usr/bin/env bash
echo "claude-code 0.0.0-dry-run-stub"
EOF
chmod +x "$BIN/claude"

CURL_REAL="$(command -v curl)"
cat > "$BIN/curl" <<EOF
#!/usr/bin/env bash
for a in "\$@"; do
  case "\$a" in
    *api.telegram.org/bot*/getMe*)
      token="\$(printf '%s' "\$a" | sed -E 's#.*/bot([^/]*)/getMe.*#\1#')"
      case "\$token" in
        GOODTOKEN*) echo '{"ok":true,"result":{"id":123456789,"username":"qroky_test_bot","first_name":"Qroky Test"}}'; exit 0 ;;
        *) echo '{"ok":false,"error_code":401,"description":"Unauthorized"}'; exit 0 ;;
      esac
      ;;
  esac
done
exec "$CURL_REAL" "\$@"
EOF
chmod +x "$BIN/curl"

LAUNCHCTL_STATE="$SANDBOX/fake-launchctl.log"
touch "$LAUNCHCTL_STATE"
cat > "$BIN/launchctl" <<EOF
#!/usr/bin/env bash
STATE="$LAUNCHCTL_STATE"
echo "fake-launchctl \$*" >> "\$STATE"
case "\$1" in
  bootout) exit 0 ;;
  bootstrap) exit 0 ;;
  list) exit 0 ;;
  *) echo "fake launchctl (dry-run stub): unsupported args: \$*" >&2; exit 1 ;;
esac
EOF
chmod +x "$BIN/launchctl"

# --- stub gh (v0.1.1, ATOM-102): GitHub's CLI, faked for the backup step.
# `auth status` fails until `auth login` writes an auth marker (so the
# walkthrough path is genuinely exercised); `repo create --source --push`
# creates a REAL local bare repo under fake-github/ and performs a REAL
# `git push` into it — the backup scenario's negative grep therefore runs
# over an actually-pushed payload, not a simulation. --------------------
FAKE_GH_STATE="$SANDBOX/fake-gh"
FAKE_GITHUB="$SANDBOX/fake-github"
mkdir -p "$FAKE_GH_STATE" "$FAKE_GITHUB"
cat > "$BIN/gh" <<EOF
#!/usr/bin/env bash
STATE_DIR="$FAKE_GH_STATE"
GITHUB_DIR="$FAKE_GITHUB"
case "\$1 \$2" in
  "auth status")
    [[ -f "\$STATE_DIR/authed" ]] || { echo "You are not logged into any GitHub hosts." >&2; exit 1; }
    exit 0 ;;
  "auth login")
    touch "\$STATE_DIR/authed"
    echo "fake-gh: logged in (dry-run stub)"
    exit 0 ;;
  "repo create")
    name="\$3"; shift 3
    src=""; remote_name="origin"; want_push=0
    while [[ \$# -gt 0 ]]; do
      case "\$1" in
        --source) src="\$2"; shift 2 ;;
        --remote) remote_name="\$2"; shift 2 ;;
        --push) want_push=1; shift ;;
        --private) shift ;;
        *) shift ;;
      esac
    done
    bare="\$GITHUB_DIR/\$name.git"
    [[ -d "\$bare" ]] || git init -q --bare "\$bare"
    if [[ -n "\$src" ]]; then
      git -C "\$src" remote add "\$remote_name" "\$bare" 2>/dev/null \\
        || git -C "\$src" remote set-url "\$remote_name" "\$bare"
      if [[ \$want_push -eq 1 ]]; then
        git -C "\$src" push -q "\$remote_name" HEAD || exit 1
      fi
    fi
    echo "https://github.com/dry-run-user/\$name (fake)"
    exit 0 ;;
esac
echo "fake gh (dry-run stub): unsupported args: \$*" >&2
exit 1
EOF
chmod +x "$BIN/gh"

# --- offline framework origin, real git repo, with a real release tag -----
FAKE_FW="$SANDBOX/fake-framework-origin"
mkdir -p "$FAKE_FW"
git -C "$FAKE_FW" init -q
echo "# stub framework — dry-run only, not the real rulebook" > "$FAKE_FW/README.md"
# v0.1.2 (ATOM-103): the framework repo now ships the gesture file that
# step_gesture vendors into the workspace — the fake origin carries the
# REAL vendored file from this repo, so scenario 10's "workdir copy matches
# vendored source" diff compares against the genuine article, not a stub.
VENDORED_SKILL="$HERE/../runtime/claude/skill/qroky/SKILL.md"
mkdir -p "$FAKE_FW/runtime/claude/skill/qroky"
cp "$VENDORED_SKILL" "$FAKE_FW/runtime/claude/skill/qroky/SKILL.md"
git -C "$FAKE_FW" -c user.email=dryrun@qroky.local -c user.name="Qroky dry run" add -A
git -C "$FAKE_FW" -c user.email=dryrun@qroky.local -c user.name="Qroky dry run" commit -q -m "stub commit 1"
git -C "$FAKE_FW" -c user.email=dryrun@qroky.local -c user.name="Qroky dry run" \
  tag -a v1.0.0 -m "v1.0.0

first stub release
nothing behavioral, dry-run fixture only
baseline for idempotency + self-update scenarios"

FAKE_HOME="$SANDBOX/home"
mkdir -p "$FAKE_HOME"
git config --file "$FAKE_HOME/.gitconfig" protocol.file.allow always
git config --file "$FAKE_HOME/.gitconfig" user.email "dryrun@qroky.local"
git config --file "$FAKE_HOME/.gitconfig" user.name "Qroky dry run"

export PATH="$BIN:$PATH"
export HOME="$FAKE_HOME"
export QROKY_FRAMEWORK_SOURCE="$FAKE_FW"
export QROKY_TEST_STUBS=1

run_install() {
  # $1 = workdir, $2 = stdin content (answers, one per line), $3.. = extra
  # args to install.sh (e.g. --check-update). A subshell with a real
  # `export` is required here — `VAR=val cmd | cmd2` only sets VAR for the
  # FIRST stage of a pipeline in bash, never for the stage after the pipe,
  # so the naive one-liner would silently install.sh fall back to its
  # pointer-file/default workdir instead of the sandbox path. (Caught by
  # actually running this harness — see run.log for the real stray
  # directory this produced under distribution/ before the fix.)
  local workdir="$1" stdin_content="$2"; shift 2
  ( export QROKY_WORKSPACE_DIR="$workdir"; printf '%s' "$stdin_content" | "$INSTALL" "$@" ) 2>&1
}

# ---------------------------------------------------------------------------
# SCENARIO 1 — full clean run, timed, zero questions outside the interview
# ---------------------------------------------------------------------------
T1="$ATOM_WORKSPACE/scenario-1-full-clean-run.txt"
W1="$SANDBOX/w1"
{
  echo "Scenario 1 — full clean run (H6 baseline, H2 question inventory)"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Command a founder actually types: bash install.sh   (no arguments)"
  echo "Answers fed (stdin, in order): en / <accept suggested folder> / y / GOODTOKEN123 / n / y"
  echo ""
} > "$T1"
START1=$(date +%s)
OUT1="$(run_install "$W1" $'en\n\ny\nGOODTOKEN123\nn\ny\nn\n')"
STATUS1=$?
END1=$(date +%s)
ELAPSED1=$((END1 - START1))
{
  echo "$OUT1"
  echo ""
  echo "--- exit code: $STATUS1 ; elapsed: ${ELAPSED1}s (budget: 900s / 15min) ---"
} >> "$T1"

if [[ $STATUS1 -eq 0 && $ELAPSED1 -le 900 ]]; then
  record "1-full-clean-run" PASS "exit 0 in ${ELAPSED1}s"
else
  record "1-full-clean-run" FAIL "exit $STATUS1, elapsed ${ELAPSED1}s"
fi

# Question inventory (H2, v0.1.1: EIGHT points): every interactive read in
# the eight step functions is tagged; count call sites vs tags — must match
# exactly, AND point 8 must actually be present (the amendment's own check
# cannot pass on the old seven-point build). The --apply-update
# confirmation (cmd_apply_update) is deliberately outside this count: it is
# a separate, explicitly-invoked maintenance command the founder runs
# later, not part of the eight-point interview (main_interview).
{
  echo ""
  echo "--- Question inventory check (H2: zero questions outside the interview; v0.1.1 = exactly 8 points) ---"
  STEP_BLOCK="$(awk '/^step_language\(\)/,/^cmd_enable_heartbeat\(\)/' "$INSTALL")"
  READ_SITES=$(printf '%s' "$STEP_BLOCK" | grep -cE 'read_answer' || true)
  TAGGED_SITES=$(printf '%s' "$STEP_BLOCK" | grep -cE '# IV-POINT:' || true)
  echo "read_answer call sites inside the eight step_* functions: $READ_SITES"
  echo "of those, tagged with # IV-POINT\\:<n>\\:<name>: $TAGGED_SITES"
  DISTINCT_POINTS="$(printf '%s' "$STEP_BLOCK" | grep -oE 'IV-POINT:[0-9]+' | sort -u | tr '\n' ' ')"
  echo "distinct interview points referenced: $DISTINCT_POINTS(closed list is 1..8)"
  HAS_POINT8=$(printf '%s' "$STEP_BLOCK" | grep -c 'IV-POINT:8:backup_optin' || true)
  MAX_POINT="$(printf '%s' "$STEP_BLOCK" | grep -oE 'IV-POINT:[0-9]+' | sed 's/IV-POINT://' | sort -n | tail -1)"
  echo "point 8 (backup) present: $([[ "$HAS_POINT8" -gt 0 ]] && echo yes || echo no); highest point referenced: $MAX_POINT (must be 8, never 9+)"
  if [[ "$READ_SITES" -eq "$TAGGED_SITES" && "$HAS_POINT8" -gt 0 && "$MAX_POINT" == "8" ]]; then
    echo "PASS — every interactive prompt in the interview is accounted for in the closed list of 8 (v0.1.1)."
    record "1-question-inventory" PASS "$READ_SITES/$READ_SITES prompts tagged, all within points 1-8, point 8 = backup present, none beyond 8"
  else
    echo "FAIL — an untagged prompt exists, point 8 is missing, or a point beyond 8 was found."
    record "1-question-inventory" FAIL "$TAGGED_SITES/$READ_SITES prompts tagged, point8=$HAS_POINT8, max=$MAX_POINT"
  fi
} >> "$T1"

# ---------------------------------------------------------------------------
# SCENARIO 2 — kill mid-install, rerun completes (H6a, H9 happy-path q1)
# ---------------------------------------------------------------------------
T2="$ATOM_WORKSPACE/scenario-2-kill-mid-install.txt"
W2="$SANDBOX/w2"
{
  echo "Scenario 2 — kill the install mid-way, rerun completes to the end"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Mechanism (round-2 fix, verify F1): RUN A opts INTO Telegram (y +"
  echo "GOODTOKEN456) so the QROKY_TEST_DELAY_STEP=telegram hook — which sits"
  echo "AFTER the token is stored but BEFORE the telegram step's state commit"
  echo "— is guaranteed to be reached; the process is SIGKILLed inside that"
  echo "5-second window, after workdir+claude_code+framework+subscription have"
  echo "already committed 'done' for real. The round-1 feed opted OUT of"
  echo "Telegram, whose branch returns before the hook, so nothing was ever"
  echo "killed — this scenario now FAILS unless the kill verifiably landed"
  echo "mid-flight (kill confirmed + post-kill state shows telegram NOT done)."
  echo ""
  echo "--- RUN A (will be killed mid-step) ---"
} > "$T2"
(
  export QROKY_WORKSPACE_DIR="$W2"
  export QROKY_TEST_DELAY_STEP="telegram"
  export QROKY_TEST_DELAY_SECONDS="15"
  printf 'en\n\ny\nGOODTOKEN456\nn\ny\nn\n' | "$INSTALL" >> "$T2" 2>&1 &
  echo $! > "$SANDBOX/killpid"
)
sleep 4
KILL_LANDED=0
KILLPID="$(cat "$SANDBOX/killpid" 2>/dev/null || true)"
if [[ -n "$KILLPID" ]] && kill -0 "$KILLPID" 2>/dev/null; then
  kill -9 "$KILLPID" 2>/dev/null || true
  KILL_LANDED=1
  echo "(process $KILLPID SIGKILLed mid-step, as intended)" >> "$T2"
else
  echo "(FAIL: process already exited before the kill — the kill never landed; this scenario's evidence is void)" >> "$T2"
fi
wait 2>/dev/null
STATE_AFTER_KILL=""
[[ -f "$W2/install-state.json" ]] && STATE_AFTER_KILL="$(cat "$W2/install-state.json")"
# The kill is only meaningful if the state file PROVES a mid-flight stop:
# earlier steps committed done, telegram (the step hosting the delay) NOT.
TELEGRAM_DONE_AT_KILL=$(printf '%s' "$STATE_AFTER_KILL" | grep -c '"step_telegram": "done"' || true)
WORKDIR_DONE_AT_KILL=$(printf '%s' "$STATE_AFTER_KILL" | grep -c '"step_workdir": "done"' || true)
{
  echo ""
  echo "--- state file immediately after the kill ---"
  echo "${STATE_AFTER_KILL:-<no state file — kill happened before the first commit>}"
  echo ""
  echo "mid-flight proof: kill landed on a live process: $([[ $KILL_LANDED -eq 1 ]] && echo yes || echo no);"
  echo "  step_workdir committed done before the kill: $([[ "$WORKDIR_DONE_AT_KILL" -gt 0 ]] && echo yes || echo no);"
  echo "  step_telegram NOT yet done at the kill: $([[ "$TELEGRAM_DONE_AT_KILL" -eq 0 ]] && echo yes || echo no)"
  echo ""
  echo "--- RUN B (rerun; language/workdir must NOT be re-asked — telegram, cut down mid-flight, is asked again) ---"
} >> "$T2"
OUT2B="$(run_install "$W2" $'n\nn\ny\nn\n')"
STATUS2B=$?
{
  echo "$OUT2B"
  echo ""
  echo "--- RUN B exit code: $STATUS2B ---"
} >> "$T2"
FINAL_STATE2="$(cat "$W2/install-state.json" 2>/dev/null || echo "MISSING")"
ALL_DONE2=$(printf '%s' "$FINAL_STATE2" | grep -c '"pending"\|"failed"' || true)
REASKED_LANG2=$(printf '%s' "$OUT2B" | grep -c "Which language do you want to use?" || true)
{
  echo ""
  echo "--- final state file ---"
  echo "$FINAL_STATE2"
  echo ""
  echo "language question re-asked in RUN B (must be no): $([[ "$REASKED_LANG2" -eq 0 ]] && echo no || echo YES-DEFECT)"
} >> "$T2"
if [[ $KILL_LANDED -eq 1 && "$TELEGRAM_DONE_AT_KILL" -eq 0 && "$WORKDIR_DONE_AT_KILL" -gt 0 \
      && $STATUS2B -eq 0 && "$ALL_DONE2" -eq 0 && "$REASKED_LANG2" -eq 0 ]]; then
  record "2-kill-mid-install" PASS "SIGKILL landed mid-telegram (state: prior steps done, telegram not), rerun resumed without re-asking and completed all-done"
else
  record "2-kill-mid-install" FAIL "kill_landed=$KILL_LANDED telegram_done_at_kill=$TELEGRAM_DONE_AT_KILL workdir_done=$WORKDIR_DONE_AT_KILL rerun_exit=$STATUS2B remaining=$ALL_DONE2 lang_reasked=$REASKED_LANG2"
fi

# ---------------------------------------------------------------------------
# SCENARIO 3 — healthy rerun = free health-check, changes nothing (H3, H6b)
# ---------------------------------------------------------------------------
T3="$ATOM_WORKSPACE/scenario-3-healthy-rerun.txt"
BEFORE_TREE="$(find "$W1" -type f ! -name 'install.log' -exec sh -c 'echo "$1  $(md5 -q "$1" 2>/dev/null || md5sum "$1" | cut -d" " -f1)"' _ {} \; | sort)"
BEFORE_STATE_NO_TS="$(grep -v generated_at "$W1/install-state.json")"
{
  echo "Scenario 3 — rerun on the already-healthy Scenario-1 workspace"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "No answers should be needed — every step is already 'done'."
  echo ""
} > "$T3"
OUT3="$(run_install "$W1" '')"
STATUS3=$?
{
  echo "$OUT3"
  echo ""
  echo "--- exit code: $STATUS3 ---"
} >> "$T3"
AFTER_TREE="$(find "$W1" -type f ! -name 'install.log' -exec sh -c 'echo "$1  $(md5 -q "$1" 2>/dev/null || md5sum "$1" | cut -d" " -f1)"' _ {} \; | sort)"
AFTER_STATE_NO_TS="$(grep -v generated_at "$W1/install-state.json")"
HEALTH_LINES=$(printf '%s' "$OUT3" | grep -c "already set up\|already your Qroky workspace\|already in place\|found (" || true)
{
  echo ""
  echo "--- file tree diff (content hashes, excluding install.log which is append-only by design) ---"
  diff <(printf '%s' "$BEFORE_TREE") <(printf '%s' "$AFTER_TREE") && echo "(no differences — no file content changed)"
  echo ""
  echo "--- state diff (excluding the generated_at timestamp, which always updates on commit) ---"
  diff <(printf '%s' "$BEFORE_STATE_NO_TS") <(printf '%s' "$AFTER_STATE_NO_TS") && echo "(no differences — every field identical)"
  echo ""
  echo "'already done' health-check lines printed: $HEALTH_LINES (expect 9 — one per step incl. the v0.1.2 gesture step)"
} >> "$T3"
TREE_DIFF="$(diff <(printf '%s' "$BEFORE_TREE") <(printf '%s' "$AFTER_TREE"))"
STATE_DIFF="$(diff <(printf '%s' "$BEFORE_STATE_NO_TS") <(printf '%s' "$AFTER_STATE_NO_TS"))"
if [[ $STATUS3 -eq 0 && -z "$TREE_DIFF" && -z "$STATE_DIFF" ]]; then
  record "3-healthy-rerun" PASS "exit 0, zero file/state changes, $HEALTH_LINES health-check lines"
else
  record "3-healthy-rerun" FAIL "exit $STATUS3, tree_diff_empty=$([[ -z "$TREE_DIFF" ]] && echo yes || echo no), state_diff_empty=$([[ -z "$STATE_DIFF" ]] && echo yes || echo no)"
fi

# ---------------------------------------------------------------------------
# SCENARIO 4 — broken dependency -> concrete human instruction (H6c, H9)
# ---------------------------------------------------------------------------
T4="$ATOM_WORKSPACE/scenario-4-broken-dependency.txt"
W4="$SANDBOX/w4"
{
  echo "Scenario 4 — broken dependency (framework source unreachable)"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "QROKY_FRAMEWORK_SOURCE points at a path that does not exist — the"
  echo "network/dependency failure a founder would see as 'can't reach it'."
  echo ""
} > "$T4"
OUT4="$( ( export QROKY_WORKSPACE_DIR="$W4"; export QROKY_FRAMEWORK_SOURCE="/private/tmp/qroky-nonexistent-source-$$"; \
  printf 'en\n\n' | "$INSTALL" ) 2>&1)"
STATUS4=$?
{
  echo "$OUT4"
  echo ""
  echo "--- exit code: $STATUS4 (non-zero expected — setup stopped) ---"
} >> "$T4"
RETRY_COUNT4=$(printf '%s' "$OUT4" | grep -c "trying again automatically" || true)
HAS_HUMAN_MSG4=$(printf '%s' "$OUT4" | grep -c "Could not download the assistant's rulebook" || true)
# Round-2 checks (verify F7): the failure must NOT be attributed to the
# Claude Code check, and no raw git noise (fatal:, error:) may reach the
# founder's screen — it belongs in install.log. Attribution is correct
# when (a) the Claude check visibly SUCCEEDED on its own line before the
# failure ("Claude Code — found"), and (b) the failure block itself names
# the rulebook download, not the assistant.
UNDER_CLAUDE_HEADER4=1
CLAUDE_OK_LINE4=$(printf '%s' "$OUT4" | grep -c "Claude Code — found" || true)
FAIL_NAMES_CLAUDE4=$(printf '%s' "$OUT4" | sed -n '/SETUP STOPPED/,$p' | grep -c "Claude Code" || true)
if [[ "$CLAUDE_OK_LINE4" -gt 0 && "$FAIL_NAMES_CLAUDE4" -eq 0 ]]; then
  UNDER_CLAUDE_HEADER4=0
fi
RAW_GIT_SPEW4=$(printf '%s' "$OUT4" | grep -c "^fatal:\|^error:" || true)
GIT_NOISE_IN_LOG4=$(grep -c "fatal:" "$W4/install.log" 2>/dev/null || true)
STATE4="$(cat "$W4/install-state.json" 2>/dev/null || echo "MISSING")"
{
  echo ""
  echo "--- state file after the failure (workdir stays done, framework marked failed) ---"
  echo "$STATE4"
  echo ""
  echo "auto-retry lines seen: $RETRY_COUNT4 (ladder cap is 2, harness-checklist point 3)"
  echo "concrete human instruction present (rulebook download named, not the Claude check): $([[ $HAS_HUMAN_MSG4 -gt 0 ]] && echo yes || echo no)"
  echo "failure mis-attributed under the Claude Code header (must be no): $([[ $UNDER_CLAUDE_HEADER4 -eq 0 ]] && echo no || echo YES-DEFECT)"
  echo "raw git fatal:/error: lines on the founder's screen (must be 0): $RAW_GIT_SPEW4"
  echo "git technical details preserved in install.log (for support): $([[ "$GIT_NOISE_IN_LOG4" -gt 0 ]] && echo yes || echo no)"
} >> "$T4"
if [[ $STATUS4 -ne 0 && "$RETRY_COUNT4" -eq 2 && "$HAS_HUMAN_MSG4" -gt 0 \
      && "$UNDER_CLAUDE_HEADER4" -eq 0 && "$RAW_GIT_SPEW4" -eq 0 ]] \
   && printf '%s' "$STATE4" | grep -q '"step_workdir": "done"' \
   && printf '%s' "$STATE4" | grep -q '"step_framework": "failed"'; then
  record "4-broken-dependency" PASS "2 auto-retries then a concrete human instruction under the correct step, no raw git spew on screen, exit $STATUS4, prior steps' state preserved"
else
  record "4-broken-dependency" FAIL "retries=$RETRY_COUNT4 human_msg=$HAS_HUMAN_MSG4 misattributed=$UNDER_CLAUDE_HEADER4 raw_git=$RAW_GIT_SPEW4 exit=$STATUS4"
fi

# ---------------------------------------------------------------------------
# SCENARIO 5 — double-run idempotency diff (H3)
# ---------------------------------------------------------------------------
T5="$ATOM_WORKSPACE/scenario-5-idempotency-diff.txt"
W5="$SANDBOX/w5"
{
  echo "Scenario 5 — run the same command twice with identical answers,"
  echo "diff the state file (structural fields only, excluding the commit"
  echo "timestamp) and the workspace file listing between the two runs."
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""
  echo "--- RUN 1 ---"
} > "$T5"
OUT5A="$(run_install "$W5" $'en\n\nn\nn\ny\nn\n')"; STATUS5A=$?
LIST5A="$(find "$W5" -type f | sed "s|$W5/||" | sort)"
STATE5A="$(grep -v generated_at "$W5/install-state.json")"
{
  echo "$OUT5A"
  echo "--- RUN 1 exit: $STATUS5A ---"
  echo ""
  echo "--- RUN 2 (identical answers) ---"
} >> "$T5"
OUT5B="$(run_install "$W5" $'en\n\nn\nn\ny\nn\n')"; STATUS5B=$?
LIST5B="$(find "$W5" -type f | sed "s|$W5/||" | sort)"
STATE5B="$(grep -v generated_at "$W5/install-state.json")"
{
  echo "$OUT5B"
  echo "--- RUN 2 exit: $STATUS5B ---"
  echo ""
  echo "--- file listing diff (run 1 vs run 2) ---"
  diff <(printf '%s' "$LIST5A") <(printf '%s' "$LIST5B") && echo "(identical file listing — no duplicates, nothing destroyed)"
  echo ""
  echo "--- state field diff (run 1 vs run 2, excluding generated_at) ---"
  diff <(printf '%s' "$STATE5A") <(printf '%s' "$STATE5B") && echo "(identical structural state)"
} >> "$T5"
LIST_DIFF5="$(diff <(printf '%s' "$LIST5A") <(printf '%s' "$LIST5B"))"
STATE_DIFF5="$(diff <(printf '%s' "$STATE5A") <(printf '%s' "$STATE5B"))"
if [[ $STATUS5A -eq 0 && $STATUS5B -eq 0 && -z "$LIST_DIFF5" && -z "$STATE_DIFF5" ]]; then
  record "5-idempotency-diff" PASS "identical file listing and state across two runs"
else
  record "5-idempotency-diff" FAIL "run1=$STATUS5A run2=$STATUS5B list_diff_empty=$([[ -z "$LIST_DIFF5" ]] && echo yes || echo no) state_diff_empty=$([[ -z "$STATE_DIFF5" ]] && echo yes || echo no)"
fi

# ---------------------------------------------------------------------------
# SCENARIO 6 — secrets negative grep (H4)
# ---------------------------------------------------------------------------
T6="$ATOM_WORKSPACE/scenario-6-secrets-negative-grep.txt"
TOKEN_PLAINTEXT="GOODTOKEN123"
{
  echo "Scenario 6 — secrets negative grep, against Scenario-1's workspace"
  echo "(which opted into Telegram with token '$TOKEN_PLAINTEXT')"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""
  echo "Checked (must be EMPTY of the raw token):"
  echo "  - install-state.json"
  echo "  - install.log"
  echo "  - telemetry/ (whole directory)"
  echo "  - git status / git-tracked content (framework/ + workspace repo)"
  echo ""
} > "$T6"
LEAK_STATE=$(grep -c "$TOKEN_PLAINTEXT" "$W1/install-state.json" 2>/dev/null || true)
LEAK_LOG=$(grep -c "$TOKEN_PLAINTEXT" "$W1/install.log" 2>/dev/null || true)
LEAK_TELEMETRY=$(grep -rc "$TOKEN_PLAINTEXT" "$W1/telemetry" 2>/dev/null | awk -F: '{s+=$2} END{print s+0}')
LEAK_GIT=$( (cd "$W1" && git grep -c "$TOKEN_PLAINTEXT" $(git rev-list --all 2>/dev/null) 2>/dev/null; cd "$W1/framework" && git grep -c "$TOKEN_PLAINTEXT" $(git rev-list --all 2>/dev/null) 2>/dev/null) | awk -F: '{s+=$NF} END{print s+0}')
TOKEN_FILE_PERMS="$(stat -f '%Lp' "$W1/.qroky/telegram.token" 2>/dev/null || stat -c '%a' "$W1/.qroky/telegram.token" 2>/dev/null)"
TOKEN_FILE_CONTENT="$(cat "$W1/.qroky/telegram.token" 2>/dev/null)"
# Round-2 fix (verify F4): the masked confirmation is now WRITTEN to
# install.log by install.sh ("telegram TOKEN-STORED masked=****..."), so
# this is a hard requirement, not an informational line — redaction must
# be auditable from the log alone while the raw-token grep stays empty.
MASKED_IN_LOG=$(grep -c "TOKEN-STORED masked=\*\*\*\*" "$W1/install.log" 2>/dev/null || true)
{
  echo "grep hits in install-state.json: ${LEAK_STATE:-0}"
  echo "grep hits in install.log: ${LEAK_LOG:-0}"
  echo "grep hits in telemetry/: ${LEAK_TELEMETRY:-0}"
  echo "grep hits across all git history (workspace + framework): ${LEAK_GIT:-0}"
  echo ""
  echo "masked-token confirmation line present in install.log (REQUIRED): $([[ "$MASKED_IN_LOG" -gt 0 ]] && echo yes || echo no)"
  echo "token file mode: ${TOKEN_FILE_PERMS:-MISSING} (must be 600)"
  echo "token file contains the real token (expected — this is the ONE sanctioned place): $([[ "$TOKEN_FILE_CONTENT" == "$TOKEN_PLAINTEXT" ]] && echo yes || echo no)"
} >> "$T6"
if [[ "${LEAK_STATE:-0}" -eq 0 && "${LEAK_LOG:-0}" -eq 0 && "${LEAK_TELEMETRY:-0}" -eq 0 && "${LEAK_GIT:-0}" -eq 0 \
      && "$MASKED_IN_LOG" -gt 0 \
      && "$TOKEN_FILE_PERMS" == "600" && "$TOKEN_FILE_CONTENT" == "$TOKEN_PLAINTEXT" ]]; then
  record "6-secrets-negative-grep" PASS "zero raw-token leaks across state/log/telemetry/git; masked line present in log; token file mode 600"
else
  record "6-secrets-negative-grep" FAIL "state=$LEAK_STATE log=$LEAK_LOG telemetry=$LEAK_TELEMETRY git=$LEAK_GIT masked_in_log=$MASKED_IN_LOG perms=$TOKEN_FILE_PERMS"
fi

# ---------------------------------------------------------------------------
# SCENARIO 7 — self-update: tag N -> N+1, local edit, conflict shown,
# apply only on explicit yes, decisions record written (H11)
# ---------------------------------------------------------------------------
T7="$ATOM_WORKSPACE/scenario-7-self-update.txt"
{
  echo "Scenario 7 — self-update channel, against Scenario-1's workspace"
  echo "(already installed and pinned to v1.0.0)"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""
} > "$T7"

# publish v1.1.0 on the fake origin
git -C "$FAKE_FW" -c user.email=dryrun@qroky.local -c user.name="Qroky dry run" \
  commit -q --allow-empty -m "stub commit 2"
git -C "$FAKE_FW" -c user.email=dryrun@qroky.local -c user.name="Qroky dry run" \
  tag -a v1.1.0 -m "v1.1.0

fixes the stub thing
improves the other stub thing
adds a third stub improvement"

# plant a local edit inside the user's own framework/ copy — this is the
# conflict the update must SHOW, never silently overwrite
echo "-- founder's own note, must not be silently discarded --" >> "$W1/framework/README.md"

{
  echo "--- check-update (read-only) ---"
} >> "$T7"
OUT7A="$(run_install "$W1" '' --check-update)"
{
  echo "$OUT7A"
} >> "$T7"
HAS_DIGEST=$(printf '%s' "$OUT7A" | grep -c "v1.0.0 -> v1.1.0" || true)
# Round-2 fix (verify F2): the digest must carry ALL THREE changelog body
# lines — the round-1 extraction wasted the head -3 budget on the tag
# subject + blank separator, silently dropping two of them.
CHANGELOG_LINES_OK=0
if printf '%s' "$OUT7A" | grep -q "fixes the stub thing" \
   && printf '%s' "$OUT7A" | grep -q "improves the other stub thing" \
   && printf '%s' "$OUT7A" | grep -q "adds a third stub improvement"; then
  CHANGELOG_LINES_OK=1
fi

# Round-2 check (verify F5): the "нет" cancel MUST be exercised while the
# update is genuinely pending — BEFORE the "да" apply, not after it.
{
  echo ""
  echo "--- apply-update with the update PENDING, answering 'нет' (must cancel, tag must stay v1.0.0) ---"
} >> "$T7"
OUT7N="$(run_install "$W1" $'нет\n' --apply-update)"
echo "$OUT7N" >> "$T7"
STATE7N="$(cat "$W1/install-state.json")"
TAG_STILL_OLD=$(printf '%s' "$STATE7N" | grep -c '"framework_tag": "v1.0.0"' || true)
CANCELLED_SHOWN=$(printf '%s' "$OUT7N" | grep -ci "cancelled\|anulat\|отменено" || true)
REACHED_PROMPT_N=$(printf '%s' "$OUT7N" | grep -c "Apply this update now\|Aplici această actualizare\|Применить это обновление" || true)
{
  echo ""
  echo "cancel check: confirm prompt reached: $([[ "$REACHED_PROMPT_N" -gt 0 ]] && echo yes || echo no); cancelled message shown: $([[ "$CANCELLED_SHOWN" -gt 0 ]] && echo yes || echo no); framework_tag still v1.0.0: $([[ "$TAG_STILL_OLD" -gt 0 ]] && echo yes || echo no)"
} >> "$T7"

{
  echo ""
  echo "--- apply-update, answering 'да' (yes) ---"
} >> "$T7"
OUT7B="$(run_install "$W1" $'да\n' --apply-update)"
{
  echo "$OUT7B"
} >> "$T7"
HAS_CONFLICT_SHOWN=$(printf '%s' "$OUT7B" | grep -c "README.md" || true)
# Round-2 check (verify F3): the conflict display must show ONLY the real
# founder edit (M README.md), never the installer's own PROVENANCE.md —
# an untouched install must not cry "local changes".
PROVENANCE_FALSE_ALARM=$( (printf '%s\n%s' "$OUT7N" "$OUT7B") | grep -c "PROVENANCE" || true)
STATE7="$(cat "$W1/install-state.json")"
DECISION_FILE="$(ls "$W1"/decisions/UPDATE-*.md 2>/dev/null | head -1)"
{
  echo ""
  echo "--- state after apply ---"
  echo "$STATE7"
  echo ""
  echo "--- decisions record ---"
  [[ -n "$DECISION_FILE" ]] && cat "$DECISION_FILE" || echo "MISSING"
  echo ""
  echo "all 3 changelog lines reached the digest: $([[ "$CHANGELOG_LINES_OK" -eq 1 ]] && echo yes || echo no)"
  echo "PROVENANCE.md false-alarm lines in conflict displays (must be 0): $PROVENANCE_FALSE_ALARM"
} >> "$T7"
TAG_UPDATED=$(printf '%s' "$STATE7" | grep -c '"framework_tag": "v1.1.0"' || true)
if [[ "$HAS_DIGEST" -gt 0 && "$CHANGELOG_LINES_OK" -eq 1 \
      && "$REACHED_PROMPT_N" -gt 0 && "$CANCELLED_SHOWN" -gt 0 && "$TAG_STILL_OLD" -gt 0 \
      && "$HAS_CONFLICT_SHOWN" -gt 0 && "$PROVENANCE_FALSE_ALARM" -eq 0 \
      && "$TAG_UPDATED" -gt 0 && -n "$DECISION_FILE" ]]; then
  record "7-self-update" PASS "3-line changelog in digest; нет cancelled a genuinely pending update (tag stayed v1.0.0); conflict shown (README.md only, no PROVENANCE false alarm); да applied to v1.1.0; decisions record written"
else
  record "7-self-update" FAIL "digest=$HAS_DIGEST changelog3=$CHANGELOG_LINES_OK cancel_prompt=$REACHED_PROMPT_N cancelled=$CANCELLED_SHOWN tag_stayed=$TAG_STILL_OLD conflict_shown=$HAS_CONFLICT_SHOWN provenance_alarm=$PROVENANCE_FALSE_ALARM tag_updated=$TAG_UPDATED decision_file=${DECISION_FILE:-none}"
fi

# ---------------------------------------------------------------------------
# SCENARIO 8 — heartbeat consent, BOTH branches (H10 explicitly requires
# both exercised in this harness; "no" leaves no running agent).
# ---------------------------------------------------------------------------
T8="$ATOM_WORKSPACE/scenario-8-heartbeat-both-branches.txt"
W8YES="$SANDBOX/w8yes"
W8NO="$SANDBOX/w8no"
{
  echo "Scenario 8 — heartbeat consent, both branches (H10)"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""
  echo "--- fresh install answering 'y' at the heartbeat question ---"
} > "$T8"
: > "$LAUNCHCTL_STATE"
OUT8Y="$(run_install "$W8YES" $'en\n\nn\nn\ny\nn\n')"
echo "$OUT8Y" >> "$T8"
LABEL8Y="$(basename "$(ls "$W8YES"/.qroky/launchd/*.plist 2>/dev/null | head -1)" .plist)"
BOOTSTRAPPED_Y=$(grep -c "bootstrap.*$LABEL8Y" "$LAUNCHCTL_STATE" 2>/dev/null || true)
{
  echo ""
  echo "plist generated: $([[ -n "$LABEL8Y" ]] && echo yes || echo no) ($LABEL8Y)"
  echo "fake-launchctl saw a bootstrap call for it: $([[ "$BOOTSTRAPPED_Y" -gt 0 ]] && echo yes || echo no)"
  echo ""
  echo "--- fresh install answering 'n' at the heartbeat question ---"
} >> "$T8"
: > "$LAUNCHCTL_STATE"
OUT8N="$(run_install "$W8NO" $'en\n\nn\nn\nn\nn\n')"
echo "$OUT8N" >> "$T8"
LABEL8N="$(basename "$(ls "$W8NO"/.qroky/launchd/*.plist 2>/dev/null | head -1)" .plist)"
BOOTSTRAPPED_N=$(grep -c "bootstrap" "$LAUNCHCTL_STATE" 2>/dev/null || true)
HAS_ENABLE_INSTR=$(printf '%s' "$OUT8N" | grep -c -- "--enable-heartbeat" || true)
{
  echo ""
  echo "plist generated (installed, but not loaded): $([[ -n "$LABEL8N" ]] && echo yes || echo no) ($LABEL8N)"
  echo "fake-launchctl saw ANY bootstrap call during this run: $([[ "$BOOTSTRAPPED_N" -gt 0 ]] && echo yes || echo no) (must be no)"
  echo "one-command enable instruction printed: $([[ "$HAS_ENABLE_INSTR" -gt 0 ]] && echo yes || echo no)"
} >> "$T8"
if [[ -n "$LABEL8Y" && "$BOOTSTRAPPED_Y" -gt 0 && -n "$LABEL8N" && "$BOOTSTRAPPED_N" -eq 0 && "$HAS_ENABLE_INSTR" -gt 0 ]]; then
  record "8-heartbeat-both-branches" PASS "yes branch bootstraps + enables, no branch installs disabled with a one-command enable instruction, no agent registered"
else
  record "8-heartbeat-both-branches" FAIL "label_y=$LABEL8Y bootstrapped_y=$BOOTSTRAPPED_Y label_n=$LABEL8N bootstrapped_n=$BOOTSTRAPPED_N enable_instr=$HAS_ENABLE_INSTR"
fi

# ---------------------------------------------------------------------------
# SCENARIO 9 — backup opt-in + opt-out (v0.1.1, ATOM-102, INFO-030 p.3).
# Opt-in branch: fresh install WITH a Telegram token in the workspace (so
# the secrets-exclusion proof cannot pass vacuously), backup = yes; the gh
# stub walks auth (status fails until login), creates a real local bare
# repo and REALLY pushes into it. Assertions: state step done + optin yes,
# negative grep for the raw token over the pushed history EMPTY, the token
# FILENAME absent from the pushed tree, the pushed tree non-empty
# (install-state.json present), the restore command printed, and the auth
# walkthrough actually shown.
# Opt-out branch: state records the choice, the enable-later command is
# printed, and NO new repo appears on the fake GitHub.
# ---------------------------------------------------------------------------
T9="$ATOM_WORKSPACE/scenario-9-backup-optin-optout.txt"
W9A="$SANDBOX/w9a"
W9B="$SANDBOX/w9b"
BACKUP_TOKEN="GOODTOKEN789"
rm -f "$FAKE_GH_STATE/authed"   # start un-authed so the walkthrough path runs
{
  echo "Scenario 9 — backup opt-in + opt-out (v0.1.1, interview point 8)"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "gh stub: auth status fails until auth login; repo create --push does a"
  echo "REAL git push into a local bare repo (fake-github/) — the negative grep"
  echo "below runs over an actually-pushed payload."
  echo ""
  echo "--- OPT-IN branch: fresh install, Telegram token $BACKUP_TOKEN stored, backup = yes ---"
} > "$T9"
OUT9A="$(run_install "$W9A" $'en\n\ny\nGOODTOKEN789\nn\nn\ny\n')"
STATUS9A=$?
echo "$OUT9A" >> "$T9"
STATE9A="$(cat "$W9A/install-state.json" 2>/dev/null || echo MISSING)"
BACKUP_DONE9=$(printf '%s' "$STATE9A" | grep -c '"step_backup": "done"' || true)
BACKUP_OPTIN9=$(printf '%s' "$STATE9A" | grep -c '"answer_backup_optin": "yes"' || true)
WALKTHROUGH_SHOWN9=$(printf '%s' "$OUT9A" | grep -c "Login with a web browser" || true)
RESTORE_SHOWN9=$(printf '%s' "$OUT9A" | grep -c "gh repo clone qroky-backup" || true)
BARE9="$FAKE_GITHUB/qroky-backup.git"
PUSHED_LEAK9=1; PUSHED_TOKENFILE9=1; PUSHED_NONEMPTY9=0
if [[ -d "$BARE9" ]]; then
  PUSHED_LEAK9=$(git -C "$BARE9" grep -c "$BACKUP_TOKEN" $(git -C "$BARE9" rev-list --all 2>/dev/null) 2>/dev/null | awk -F: '{s+=$NF} END{print s+0}')
  PUSHED_TOKENFILE9=$(git -C "$BARE9" ls-tree -r --name-only HEAD 2>/dev/null | grep -c "telegram.token" || true)
  PUSHED_NONEMPTY9=$(git -C "$BARE9" ls-tree -r --name-only HEAD 2>/dev/null | grep -c "install-state.json" || true)
fi
{
  echo ""
  echo "--- opt-in assertions ---"
  echo "exit code: $STATUS9A"
  echo "state: step_backup done: $([[ $BACKUP_DONE9 -gt 0 ]] && echo yes || echo no); answer_backup_optin=yes: $([[ $BACKUP_OPTIN9 -gt 0 ]] && echo yes || echo no)"
  echo "gh auth walkthrough shown (numbered steps): $([[ $WALKTHROUGH_SHOWN9 -gt 0 ]] && echo yes || echo no)"
  echo "restore command printed (gh repo clone qroky-backup): $([[ $RESTORE_SHOWN9 -gt 0 ]] && echo yes || echo no)"
  echo "pushed bare repo exists: $([[ -d "$BARE9" ]] && echo yes || echo no)"
  echo "raw token grep over PUSHED history (must be 0): $PUSHED_LEAK9"
  echo "token FILENAME in pushed tree (must be 0): $PUSHED_TOKENFILE9"
  echo "pushed tree non-empty (install-state.json present — the grep cannot pass vacuously): $([[ $PUSHED_NONEMPTY9 -gt 0 ]] && echo yes || echo no)"
  echo ""
  echo "--- pushed tree listing (for the record) ---"
  git -C "$BARE9" ls-tree -r --name-only HEAD 2>/dev/null || echo "(missing)"
} >> "$T9"

{
  echo ""
  echo "--- OPT-OUT branch: fresh install, backup = no ---"
} >> "$T9"
REPOS_BEFORE9B=$(ls -d "$FAKE_GITHUB"/*.git 2>/dev/null | wc -l | tr -d ' ')
OUT9B="$(run_install "$W9B" $'en\n\nn\nn\nn\nn\n')"
STATUS9B=$?
echo "$OUT9B" >> "$T9"
REPOS_AFTER9B=$(ls -d "$FAKE_GITHUB"/*.git 2>/dev/null | wc -l | tr -d ' ')
STATE9B="$(cat "$W9B/install-state.json" 2>/dev/null || echo MISSING)"
OPTOUT_RECORDED9=$(printf '%s' "$STATE9B" | grep -c '"answer_backup_optin": "no"' || true)
OPTOUT_STEP_DONE9=$(printf '%s' "$STATE9B" | grep -c '"step_backup": "done"' || true)
ENABLE_LATER_SHOWN9=$(printf '%s' "$OUT9B" | grep -c -- "--enable-backup" || true)
{
  echo ""
  echo "--- opt-out assertions ---"
  echo "exit code: $STATUS9B"
  echo "state: answer_backup_optin=no recorded: $([[ $OPTOUT_RECORDED9 -gt 0 ]] && echo yes || echo no); step done (never re-asked): $([[ $OPTOUT_STEP_DONE9 -gt 0 ]] && echo yes || echo no)"
  echo "enable-later command printed: $([[ $ENABLE_LATER_SHOWN9 -gt 0 ]] && echo yes || echo no)"
  echo "repos on fake GitHub before/after opt-out run: $REPOS_BEFORE9B/$REPOS_AFTER9B (must be equal — nothing pushed)"
} >> "$T9"

if [[ $STATUS9A -eq 0 && $BACKUP_DONE9 -gt 0 && $BACKUP_OPTIN9 -gt 0 \
      && $WALKTHROUGH_SHOWN9 -gt 0 && $RESTORE_SHOWN9 -gt 0 \
      && -d "$BARE9" && "$PUSHED_LEAK9" -eq 0 && "$PUSHED_TOKENFILE9" -eq 0 && "$PUSHED_NONEMPTY9" -gt 0 \
      && $STATUS9B -eq 0 && $OPTOUT_RECORDED9 -gt 0 && $OPTOUT_STEP_DONE9 -gt 0 \
      && $ENABLE_LATER_SHOWN9 -gt 0 && "$REPOS_BEFORE9B" == "$REPOS_AFTER9B" ]]; then
  record "9-backup-optin-optout" PASS "opt-in: auth walkthrough shown, real push, zero token leaks in pushed history, token file excluded, tree non-empty, restore command printed; opt-out: choice recorded, enable-later shown, nothing pushed"
else
  record "9-backup-optin-optout" FAIL "a_exit=$STATUS9A done=$BACKUP_DONE9 optin=$BACKUP_OPTIN9 walk=$WALKTHROUGH_SHOWN9 restore=$RESTORE_SHOWN9 bare=$([[ -d "$BARE9" ]] && echo 1 || echo 0) leak=$PUSHED_LEAK9 tokenfile=$PUSHED_TOKENFILE9 nonempty=$PUSHED_NONEMPTY9 b_exit=$STATUS9B recorded=$OPTOUT_RECORDED9 stepdone=$OPTOUT_STEP_DONE9 enable=$ENABLE_LATER_SHOWN9 repos=$REPOS_BEFORE9B/$REPOS_AFTER9B"
fi

# ---------------------------------------------------------------------------
# SCENARIO 10 — gesture wiring (v0.1.2, ATOM-103, first G2 dry-run BLOCKING
# finding: the finale promised "qroky start" but neither the skill file nor
# any trigger ever reached the target machine). Fresh install in W10, then a
# re-run. Asserts (each negative-able — all four fail on the v0.1.1 build):
#   a) <workdir>/.claude/skills/qroky/SKILL.md exists and is NON-EMPTY
#   b) <workdir>/CLAUDE.md contains the trigger block (start marker present)
#   c) after the re-run, CLAUDE.md contains exactly ONE start marker
#      (idempotency — no duplicate blocks) and the skill file is unchanged
#   d) the workdir copy is byte-identical to the vendored source
#      (runtime/claude/skill/qroky/SKILL.md in this repo — the same file the
#      fake framework origin ships)
# Plus the M1 fold-in assert: install.sh's default workdir suggestion is
# $HOME/qroky-work — OUTSIDE the kit clone (the old "./qroky" default landed
# the workspace inside distribution/).
# ---------------------------------------------------------------------------
T10="$ATOM_WORKSPACE/scenario-10-gesture-wiring.txt"
W10="$SANDBOX/w10"
{
  echo "Scenario 10 — gesture wiring (v0.1.2): the 'qroky start' promise is kept on the TARGET machine"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo ""
  echo "--- RUN 1 (fresh install) ---"
} > "$T10"
OUT10A="$(run_install "$W10" $'en\n\nn\nn\ny\nn\n')"
STATUS10A=$?
{
  echo "$OUT10A"
  echo "--- RUN 1 exit: $STATUS10A ---"
} >> "$T10"
SKILL10="$W10/.claude/skills/qroky/SKILL.md"
SKILL_EXISTS10=0; [[ -s "$SKILL10" ]] && SKILL_EXISTS10=1
MARKERS_RUN1=$(grep -cF '<!-- qroky-gesture:start -->' "$W10/CLAUDE.md" 2>/dev/null || true)
SKILL_MD5_RUN1="$( (md5 -q "$SKILL10" 2>/dev/null || md5sum "$SKILL10" 2>/dev/null | cut -d' ' -f1) || true)"
{
  echo ""
  echo "--- RUN 2 (re-run — must not duplicate the trigger block) ---"
} >> "$T10"
OUT10B="$(run_install "$W10" '')"
STATUS10B=$?
{
  echo "$OUT10B"
  echo "--- RUN 2 exit: $STATUS10B ---"
} >> "$T10"
MARKERS_RUN2=$(grep -cF '<!-- qroky-gesture:start -->' "$W10/CLAUDE.md" 2>/dev/null || true)
SKILL_MD5_RUN2="$( (md5 -q "$SKILL10" 2>/dev/null || md5sum "$SKILL10" 2>/dev/null | cut -d' ' -f1) || true)"
VENDOR_DIFF10="$(diff "$VENDORED_SKILL" "$SKILL10" 2>&1)"
DEFAULT_OUTSIDE10=$(grep -cF 'printf '"'"'%s'"'"' "$HOME/qroky-work"' "$INSTALL" || true)
TRIGGER_MENTIONS_SKILL10=$(grep -cF '.claude/skills/qroky/SKILL.md' "$W10/CLAUDE.md" 2>/dev/null || true)
{
  echo ""
  echo "--- assertions ---"
  echo "a) skill file exists and is non-empty: $([[ $SKILL_EXISTS10 -eq 1 ]] && echo yes || echo NO-DEFECT) ($SKILL10)"
  echo "b) CLAUDE.md trigger block present after RUN 1: $([[ "$MARKERS_RUN1" -eq 1 ]] && echo yes || echo NO-DEFECT) (start markers: $MARKERS_RUN1)"
  echo "   trigger block points at the skill file: $([[ "$TRIGGER_MENTIONS_SKILL10" -gt 0 ]] && echo yes || echo NO-DEFECT)"
  echo "c) exactly ONE start marker after the re-run (must be 1): $MARKERS_RUN2"
  echo "   skill file unchanged across the re-run: $([[ -n "$SKILL_MD5_RUN1" && "$SKILL_MD5_RUN1" == "$SKILL_MD5_RUN2" ]] && echo yes || echo NO-DEFECT)"
  echo "d) workdir copy byte-identical to the vendored source: $([[ -z "$VENDOR_DIFF10" ]] && echo yes || echo NO-DEFECT)"
  [[ -n "$VENDOR_DIFF10" ]] && { echo "--- diff (vendored vs workdir) ---"; echo "$VENDOR_DIFF10"; }
  echo "M1) default workdir suggestion is \$HOME/qroky-work (outside the clone): $([[ "$DEFAULT_OUTSIDE10" -gt 0 ]] && echo yes || echo NO-DEFECT)"
  echo ""
  echo "--- CLAUDE.md as landed (for the record) ---"
  cat "$W10/CLAUDE.md" 2>/dev/null || echo "(missing)"
} >> "$T10"
if [[ $STATUS10A -eq 0 && $STATUS10B -eq 0 && $SKILL_EXISTS10 -eq 1 \
      && "$MARKERS_RUN1" -eq 1 && "$MARKERS_RUN2" -eq 1 \
      && "$TRIGGER_MENTIONS_SKILL10" -gt 0 \
      && -n "$SKILL_MD5_RUN1" && "$SKILL_MD5_RUN1" == "$SKILL_MD5_RUN2" \
      && -z "$VENDOR_DIFF10" && "$DEFAULT_OUTSIDE10" -gt 0 ]]; then
  record "10-gesture-wiring" PASS "skill file landed non-empty, ONE trigger block after re-run, workdir copy identical to vendored source, default workdir outside the clone"
else
  record "10-gesture-wiring" FAIL "exit_a=$STATUS10A exit_b=$STATUS10B skill=$SKILL_EXISTS10 markers_run1=$MARKERS_RUN1 markers_run2=$MARKERS_RUN2 trigger_ref=$TRIGGER_MENTIONS_SKILL10 md5_stable=$([[ "$SKILL_MD5_RUN1" == "$SKILL_MD5_RUN2" ]] && echo yes || echo no) vendor_diff_empty=$([[ -z "$VENDOR_DIFF10" ]] && echo yes || echo no) default_outside=$DEFAULT_OUTSIDE10"
fi

# ---------------------------------------------------------------------------
# SUMMARY
# ---------------------------------------------------------------------------
SUMMARY="$ATOM_WORKSPACE/SUMMARY.txt"
{
  echo "dry-run.sh — summary of all scenarios"
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Sandbox: $SANDBOX (removed on exit)"
  echo ""
  for line in "${SUMMARY_LINES[@]}"; do echo "$line"; done
  echo ""
  echo "Totals: $PASS_COUNT passed, $FAIL_COUNT failed"
} > "$SUMMARY"

cat "$SUMMARY"
if [[ "$FAIL_COUNT" -gt 0 ]]; then
  exit 1
fi
exit 0
