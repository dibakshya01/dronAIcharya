#!/usr/bin/env bash
# dronAIcharya UserPromptSubmit hook: when a journey is active, inject a SHORT status crumb
# (a few hundred chars), not the full contract — so teaching mode stays warm every turn without
# a per-turn token tax. The full contract is injected once at SessionStart. Always exit 0.

SELF="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)"
ROOT="${CLAUDE_PLUGIN_ROOT:-$SELF/..}"
# shellcheck source=/dev/null
. "$ROOT/scripts/dron-common.sh" 2>/dev/null || exit 0

dron_active || exit 0

# SECURITY: sanitize every field to a known short value before injecting it into model context.
# A poisoned/corrupt progress.json must never smuggle instruction-shaped text or megabytes into the crumb.
persona="$(dron_enum "$(dron_field '.persona' 'persona')" vanilla vanilla strict witty deadpan)"
track="$(dron_enum "$(dron_field '.track' 'track')" unset vibecoding python cs-from-scratch cyber-ai-security)"
cadence="$(dron_enum "$(dron_field '.cadence' 'cadence')" balanced thorough balanced fast)"

printf '%s' "[dronAIcharya active] Teach-and-build mode · persona:${persona} · track:${track} · cadence:${cadence}. Teach the concept, decide tradeoffs together, check understanding, and explain what happened under the hood. The learner may say pause / skip / ELI5 / go deeper, and those take priority. Full teaching contract was loaded at session start."
exit 0
