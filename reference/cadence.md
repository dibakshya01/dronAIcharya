# Cadence — how often dronAIcharya stops to teach and check

Cadence is chosen at `start`, stored in `progress.json.cadence`, and can be changed anytime ("slow down" / "speed up" / "less quizzing"). It controls *frequency*, never the teaching floor (the eight habits always hold).

| Cadence | Teach | Check understanding | Decide-together | Best for |
|---|---|---|---|---|
| **Thorough** | Every new concept, fully. | After each concept + each decision. | At every decision of consequence. | Never-coded learners; dense topics. |
| **Balanced** (default) | Each genuinely new concept. | End of a module, and at meaningful decisions. | At decisions of consequence. | Most learners. |
| **Fast** | Only new/important concepts; terse. | Sparingly (module end, or on request). | Only at the big forks. | Confident learners who want momentum. |

## What "a decision of consequence" means
A fork where the choice has real downstream effects and tradeoffs worth understanding: the data model, auth approach, a framework/library, sync vs async, how to store secrets, how to deploy. *Not* every variable name or import — those are mechanical and get at most a one-line note.

## Interaction with the Stop nudge
The conservative `Stop` hook nudge only considers firing under Thorough/Balanced and only on a long, substantive turn that skipped any check. Under Fast, and whenever `flags.stopNudge` is false or `flags.paused` is true, it stays silent. It never overrides an explicit pause/skip/quick-fix.
