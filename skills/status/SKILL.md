---
name: status
description: Show dronAIcharya journey progress and control the session — where the learner is, what's mastered, and options to pause/resume teaching mode or disable the tool. Use when the user runs /dronaicharya:status, asks "where am I / what have I learned / how much is left", or wants to pause, resume, or turn off teaching.
---

# dronAIcharya — Status & controls

**Read:** `./.dronacharya/progress.json`, `learning-plan.md`, `journal.md`, and `${CLAUDE_PLUGIN_DATA}/profile.json` (if present).

## Show (persona-flavored, compact)
- **Track / idea / level / persona / cadence.**
- **Progress:** current module + lesson, and how far through the plan (e.g. "module 2 of 5").
- **Build:** current SDLC milestone and what's done vs next.
- **Mastery:** top concepts mastered and any marked weak/skipped (from the global profile).
- **Next step:** the single next thing.

## Controls (offer as needed)
- **Pause teaching** → set `flags.paused=true` in `progress.json`. The guardrail hooks go quiet; normal Claude Code resumes. Tell them to say "resume" (or `/dronaicharya:continue`) to turn it back on.
- **Resume** → set `flags.paused=false`.
- **Change cadence / persona** → update the flag/field and re-adopt.
- **Turn off the Stop nudge** → set `flags.stopNudge=false`.
- **Disable or uninstall dronAIcharya entirely** → explain honestly: it's a normal Claude Code plugin. They can disable it with `/plugin` (Manage → disable dronAIcharya) or uninstall with `claude plugin uninstall dronaicharya@dronaicharya`. Their `.dronacharya/` journey files stay in the project. When no journey is active, the hooks already do nothing.

Always write changes back to `progress.json` and confirm what you changed.
