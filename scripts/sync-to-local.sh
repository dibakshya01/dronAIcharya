#!/usr/bin/env bash
# Copy dronAIcharya's skills and agents into a local config so they work without the plugin system.
#   bash scripts/sync-to-local.sh            → copies into ~/.claude/skills and ~/.claude/agents (user scope)
#   bash scripts/sync-to-local.sh --cursor   → copies into ./.claude/skills and ./.claude/agents (current project, for Cursor)
# NOTE: a bare copy does NOT install the guardrail hooks (those need the plugin / --plugin-dir). The
# start/continue skills still carry the teaching contract in-content. See INSTALL.md.

set -eu
SRC="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

if [ "${1:-}" = "--cursor" ]; then
  DEST="$PWD/.claude"
  echo "Target: current project ($DEST) — for Cursor / project scope."
else
  DEST="$HOME/.claude"
  echo "Target: user scope ($DEST) — available in every project."
fi

echo "CAUTION: this copies dronAIcharya's skills (start, setup, status, plan, spec, deploy, ...) and"
echo "agents into $DEST WITHOUT the /dronaicharya: namespace. If you already have skills/agents with"
echo "those generic names, they will be OVERWRITTEN, and un-namespaced skills can trigger on ordinary"
echo "words. For isolation, prefer the plugin install or 'claude --plugin-dir'. Press Ctrl-C to abort;"
echo "continuing in 3s..." ; sleep 3

mkdir -p "$DEST/skills" "$DEST/agents"
cp -R "$SRC/skills/." "$DEST/skills/"
cp -R "$SRC/agents/." "$DEST/agents/"

# AGENTS.md helps Cursor and newer Claude Code understand the behavior contract.
if [ "${1:-}" = "--cursor" ]; then
  cp "$SRC/AGENTS.md" "$PWD/AGENTS.md" 2>/dev/null || true
fi

echo "Copied skills → $DEST/skills and agents → $DEST/agents"
echo "Reminder: guardrail hooks are NOT installed by this script. For the full guardrailed experience,"
echo "install as a plugin or run:  claude --plugin-dir \"$SRC\""
echo "Done. Start a journey by invoking the 'start' skill (e.g. /start)."
