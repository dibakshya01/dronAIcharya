#!/usr/bin/env bash
# Shared helpers for dronAIcharya hook scripts. Sourced, not executed directly.
#
# DESIGN RULES (do not break — the plugin's hooks run in EVERY session it's enabled):
#   1. Fail OPEN. Callers always end with `exit 0`; a bug here must never break a user's session.
#   2. Emit NOTHING unless a dronAIcharya journey is active in the current project.
#   3. Tolerate a missing `jq` (degrade to a crude parser; never error).
#   4. Be fast (<50ms): no network, no large reads.

# Per-project journey directory (learner's project, not the plugin).
dron_state_dir() {
  local base="${CLAUDE_PROJECT_DIR:-$PWD}"
  printf '%s/.dronacharya' "$base"
}

dron_progress_file() {
  printf '%s/progress.json' "$(dron_state_dir)"
}

# Read a field from progress.json.
#   $1 = jq path (e.g. '.flags.teachingMode'); $2 = bare key for the jq-less fallback.
# Prints the value or empty string; always returns 0.
dron_field() {
  local jqpath="$1" key="$2" file val
  file="$(dron_progress_file)"
  [ -f "$file" ] || { printf ''; return 0; }
  # Bound the read (defense against a pathological multi-MB progress.json slowing every turn).
  # A valid state file is well under 64 KB; truncating a huge/garbage file makes jq fail → empty → inactive.
  if command -v jq >/dev/null 2>&1; then
    # NOTE: do NOT use `// empty` here — jq's `//` treats a literal `false` as empty,
    # which would make a boolean `false` indistinguishable from an absent field.
    val="$(head -c 65536 "$file" 2>/dev/null | jq -r "${jqpath}" 2>/dev/null)"
    [ "$val" = "null" ] && val=""
    printf '%s' "$val"
  else
    # Crude fallback: find  "key": "value"  or  "key": value  and print the value.
    head -c 65536 "$file" 2>/dev/null | sed -n "s/.*\"${key}\"[[:space:]]*:[[:space:]]*\"\{0,1\}\([^\",}]*\)\"\{0,1\}.*/\1/p" 2>/dev/null | head -n1
  fi
}

# Return $1 ONLY if it exactly matches one of the allowed values ($3..); else return the default ($2).
# SECURITY: use this to sanitize any progress.json field before it is injected into model context,
# so a poisoned/corrupt state file cannot smuggle instruction-shaped text (or megabytes) into a hook.
#   persona="$(dron_enum "$(dron_field '.persona' 'persona')" vanilla vanilla strict witty deadpan)"
dron_enum() {
  local val="$1" default="$2" a
  shift 2
  for a in "$@"; do
    [ "$val" = "$a" ] && { printf '%s' "$val"; return 0; }
  done
  printf '%s' "$default"
}

# Is a dronAIcharya journey active here? (progress.json exists, teachingMode true, not paused)
# Returns 0 if active, 1 otherwise. Never prints.
dron_active() {
  local file tm paused
  file="$(dron_progress_file)"
  [ -f "$file" ] || return 1
  tm="$(dron_field '.flags.teachingMode' 'teachingMode')"
  [ "$tm" = "true" ] || return 1
  paused="$(dron_field '.flags.paused' 'paused')"
  [ "$paused" = "true" ] && return 1
  return 0
}
