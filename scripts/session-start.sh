#!/usr/bin/env bash
# dronAIcharya SessionStart hook: when a journey is active, inject the FULL teaching contract
# plus the current persona/track/cadence. This is the main anti-drift anchor; it re-loads the
# contract after a fresh start, a resume, or a context compaction. Non-blocking; always exit 0.

SELF="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)"
ROOT="${CLAUDE_PLUGIN_ROOT:-$SELF/..}"
# shellcheck source=/dev/null
. "$ROOT/scripts/dron-common.sh" 2>/dev/null || exit 0

dron_active || exit 0

# SECURITY: sanitize every field to a known short value before injecting it into model context.
# A poisoned/corrupt progress.json must never smuggle instruction-shaped text or megabytes into the context.
persona="$(dron_enum "$(dron_field '.persona' 'persona')" vanilla vanilla strict witty deadpan)"
track="$(dron_enum "$(dron_field '.track' 'track')" unset vibecoding python cs-from-scratch cyber-ai-security)"
cadence="$(dron_enum "$(dron_field '.cadence' 'cadence')" balanced thorough balanced fast)"
contract="$ROOT/reference/teaching-contract.md"

printf '%s\n' "[dronAIcharya] A guided teach-and-build journey is active in this project."
printf 'Persona: %s · Track: %s · Cadence: %s\n' "${persona}" "${track}" "${cadence}"
printf '%s\n\n' "The learner wants to understand what gets built, not just receive code. The agreed teaching contract for this session follows."

if [ -f "$contract" ]; then
  cat "$contract" 2>/dev/null
fi

printf '\n%s\n' "Progress and the approved plan live in ./.dronacharya/ . Resume with /dronaicharya:continue. The learner may say pause, skip, ELI5, or go deeper at any time, and those always take priority."
exit 0
