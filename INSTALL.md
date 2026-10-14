# Installing dronAIcharya

Three ways to use it. Pick based on your setup. When in doubt: **plugin** for Claude Code, **skills repo** for Cursor or hacking.

---

## 1. As a Claude Code plugin (recommended)

Gives you everything: skills, teaching subagents, the anti-drift guardrail **hooks**, and the optional MCP backend.

```bash
# In a Claude Code session:
/plugin marketplace add dibakshya01/dronAIcharya
/plugin install dronaicharya@dronaicharya
/dronaicharya:start
```

Or from your shell:
```bash
claude plugin marketplace add dibakshya01/dronAIcharya
claude plugin install dronaicharya@dronaicharya --scope user
```

- **Scopes:** `user` (just you, everywhere), `project` (committed in `.claude/settings.json` for a repo — teammates run the install once), `local` (this machine, uncommitted).
- **Update:** `claude plugin update dronaicharya@dronaicharya` (third-party marketplaces don't auto-update unless you enable it under `/plugin`).
- **Uninstall:** `claude plugin uninstall dronaicharya@dronaicharya`. Your `.dronacharya/` journey files stay in your projects.
- **Pin a version:** `/plugin marketplace add dibakshya01/dronAIcharya#v0.1.0`.

Requires a Claude Code recent enough to support plugins. Check with `claude --version`.

---

## 2. As a skills repo (transparent / hackable / older setups)

```bash
git clone https://github.com/dibakshya01/dronAIcharya
```

**Easiest:** run Claude Code pointed straight at the folder (loads it like a plugin, hooks included):
```bash
claude --plugin-dir ./dronAIcharya
# then:  /dronaicharya:start   (or /start depending on your version)
```

**Or copy into your user config** (skills become available everywhere as `/start`, `/teach`, …):
```bash
bash dronAIcharya/scripts/sync-to-local.sh
```
This copies `skills/` → `~/.claude/skills/` and `agents/` → `~/.claude/agents/`. Note: a bare copy like this does **not** install the guardrail hooks, so teaching-mode persistence is best-effort (the `start`/`continue` skills still carry the teaching contract in-content). To get hooks, use `--plugin-dir` or the plugin install.

- **Update:** `git pull` (then re-run the sync script if you copied).

---

## 3. In Cursor

Cursor reads Claude-style skills and agents and `AGENTS.md`:
```bash
git clone https://github.com/dibakshya01/dronAIcharya
bash dronAIcharya/scripts/sync-to-local.sh --cursor   # copies into .claude/skills, .claude/agents in the current project
```
Then open the project in Cursor and ask it to run the `start` skill.

**Honest caveat:** Claude Code's guardrail **hooks do not run in Cursor** (different hook system), so the anti-drift/teaching-mode persistence is absent or best-effort there. You still get the full tutor and all four tracks; the `start`/`continue` skills carry the teaching contract. MCP wiring also differs — follow Cursor's MCP docs if you want the optional purple-sparrow backend.

---

## Optional backend (purple-sparrow)

Entirely optional and advanced. See `.mcp.json.example` and run the `setup` skill inside a journey — it walks you through building purple-sparrow (Go), running it, and registering the MCP server with your key. dronAIcharya works fully without it.

## Verify your install
```bash
claude plugin validate .            # if you cloned the repo
```
Then `/dronaicharya:start` (plugin) or the `start` skill (skills repo) should greet you.
