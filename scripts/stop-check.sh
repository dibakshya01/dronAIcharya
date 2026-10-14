#!/usr/bin/env bash
# dronAIcharya Stop hook: a CONSERVATIVE anti-drift nudge — NOT a cage.
# It only fires to catch *accidental* drift (a long, substantive turn that silently skipped any
# check-for-understanding). The hook canNOT see the user's prompt, so it cannot itself detect a
# per-turn "just do it / quick-fix". It yields on the signals it CAN see:
#   - teaching mode off / paused,
#   - the learner's flags.stopNudge = false,
#   - the loop guard (stop_hook_active) — so it blocks AT MOST ONCE per turn,
#   - a turn that already asked a question,
#   - short turns (acknowledgements, quick answers).
# Per-turn skip/quick-fix is honored by the MODEL via the block `reason`; a learner who wants the nudge
# gone for a stretch sets flags.stopNudge=false (offered by /dronaicharya:status). It never blocks a
# graceful exit, and always exits 0.

SELF="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)"
ROOT="${CLAUDE_PLUGIN_ROOT:-$SELF/..}"
# shellcheck source=/dev/null
. "$ROOT/scripts/dron-common.sh" 2>/dev/null || exit 0

payload="$(cat 2>/dev/null)"

dron_active || exit 0

# Opt-out flag.
nudge="$(dron_field '.flags.stopNudge' 'stopNudge')"
[ "$nudge" = "false" ] && exit 0

# Parse the Stop payload (loop guard + last assistant message).
if command -v jq >/dev/null 2>&1; then
  guard="$(printf '%s' "$payload" | jq -r '.stop_hook_active // false' 2>/dev/null)"
  last="$(printf '%s' "$payload" | jq -r '.last_assistant_message // ""' 2>/dev/null)"
else
  case "$payload" in
    *'"stop_hook_active":true'*|*'"stop_hook_active": true'*) guard=true ;;
    *) guard=false ;;
  esac
  last="$payload"
fi

# Respect the loop guard — never nag twice in a row.
[ "$guard" = "true" ] && exit 0

# If the turn already asked something, assume a check/decision happened.
case "$last" in *\?*) exit 0 ;; esac

# Only nudge on clearly substantive silent work; leave short turns alone. The threshold is deliberately
# high (a quick answer or a quick-fix is well under this) so the nudge stays rare and doesn't fight the user.
len=${#last}
[ "${len:-0}" -lt 1200 ] && exit 0

printf '%s\n' '{"decision":"block","reason":"dronAIcharya teaching mode is on, and this turn delivered substantial work without a check-for-understanding or a shared decision point. Before ending, add one short check (an MCQ or an in-your-own-words question) on what was just built, or surface the key under-the-hood point and the next decision. If the learner has said pause, skip, or quick-fix, honor that instead and simply continue."}'
exit 0
