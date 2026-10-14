# Local verification walkthrough

How to try dronAIcharya yourself and confirm it behaves. The deterministic checks are automated (`tests/`); the end-to-end journey is an **LLM-driven experience**, so this part is a **manual walkthrough**, not CI.

## 1. Deterministic checks (automated, free)
From the repo root:
```bash
bash tests/run-all.sh
```
Expect: `claude plugin validate --strict` passes, hook-safety tests pass (no-op in unrelated projects, no false-blocks, jq-less degradation), and content validation passes (all skills/agents frontmatter + all MCQ banks).

## 2. Load the plugin
```bash
claude --plugin-dir .
```
In the session, confirm the commands exist: type `/dronaicharya:` and look for `start`, `continue`, `status`, `teach`, `quiz`, etc.

## 3. Walk a journey (manual)
1. Run `/dronaicharya:start`.
2. **Greeting + persona:** it greets you and offers the four personas. Pick one — confirm the voice changes.
3. **Cadence:** pick Balanced.
4. **Setup check:** it asks about an API key / web+MCP. Say you're set.
5. **Track + level:** pick **Vibecoding**, level *never coded*.
6. **Idea:** say "I don't know" → it should offer simple starters and recommend the smallest.
7. **Plan:** it writes `./.dronacharya/learning-plan.md` and asks you to accept/tweak. Check the file reads like a real build + learn plan.
8. **First lesson:** it teaches the first concept, then asks an MCQ. Answer wrong on purpose → it should re-explain (try "ELID5") and re-check, not march on.
9. **Toggles:** say "go deeper", then "skip", then "where am I?" — confirm each is honored.
10. **State:** confirm `./.dronacharya/progress.json` and `journal.md` exist and update. `cat .dronacharya/progress.json`.

## 4. Guardrails (manual)
- **Persistence:** start a new session in the same folder (`claude --plugin-dir .` again) and confirm it knows a journey is active (the SessionStart hook injected the contract). `/dronaicharya:continue` resumes.
- **Pause:** `/dronaicharya:status` → pause teaching. Confirm normal Claude Code behavior resumes and the guru goes quiet.
- **No blast radius:** open Claude Code in a DIFFERENT folder (no `.dronacharya/`) with the plugin enabled; confirm dronAIcharya stays completely silent.

## 5. Behavioral evals (optional, cost money)
```bash
claude plugin eval . --ablation with-without --allow-tools Write Edit Bash
```
See `evals/README.md`. Treat as signal, not proof.

## What "passing" means
- Automated checks green.
- The journey greets, plans, teaches, checks, and honors toggles/pause.
- State persists and resumes; hooks never fire in unrelated projects.
- It teaches — it does not silently just build.
