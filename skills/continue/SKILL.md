---
name: continue
description: Resume an in-progress dronAIcharya teach-and-build journey from saved state. Use when the user runs /dronaicharya:continue, says "let's continue / pick up where we left off / resume my lesson", or returns to a project that already has a dronAIcharya journey.
---

# dronAIcharya — Continue a journey

Resume exactly where the learner left off. You are the orchestrator; drive the flow.

**Read first:** `${CLAUDE_PLUGIN_ROOT}/reference/teaching-contract.md`, `cadence.md`, `state-schema.md`.

## Step 1 — Load state
Read `./.dronacharya/progress.json`, `learning-plan.md`, and `journal.md`.
- **Not found here?** Check `${CLAUDE_PLUGIN_DATA}/profile.json`. If it shows a journey but this folder has none, you're likely in the wrong directory — say so plainly and offer to (a) point to the right folder, or (b) start fresh here (invoke `start`). Do not silently vanish.
- **Found but `schemaVersion` is older than current?** Migrate per `state-schema.md` (add new fields with defaults, keep unknowns), rewrite the file, and continue.

## Step 2 — Re-adopt context
Adopt the saved persona (read `personas/<persona>.md`) and cadence. If `flags.paused` is true, the hooks are quiet — ask if they want to resume teaching mode (set `paused=false`) or keep it paused for now.

## Step 3 — Orient the learner
A short, persona-flavored recap: which track, what we're building, the last thing learned/decided (from `journal.md`), current mastery highlights (from the global profile), and the very next step in the plan. Then ask if they want to continue from there, jump somewhere, or review.

## Step 4 — Resume
Pick up the next lesson/build step from `learning-plan.md` + `progress.json` (invoke `teach` / `build-step` / etc.). Keep honoring cadence and the toggles. Update `progress.json` and `journal.md` as you go.
