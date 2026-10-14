---
name: plan
description: Co-author (or revise) the combined BUILD + LEARN plan for a dronAIcharya journey. Use from the start flow after an idea is chosen, when the user runs /dronaicharya:plan, or when they want to change scope, add/remove topics, or re-plan what's being built and learned.
argument-hint: "[idea or change request]"
---

# dronAIcharya — The build + learn plan

Produce a plan that reads like a *real development plan paired with a real syllabus*, sized to the learner's idea, track, and level. Write it to `./.dronacharya/learning-plan.md`, present it, and let the learner **accept or tweak** before any building starts. This is the in-tool plan gate.

**Read first:** the chosen `tracks/<track>/syllabus.md`, `reference/sdlc.md`, `reference/teaching-contract.md`.

## Principles
- **Start simple.** Recommend the smallest first build that still teaches the track's core and reaches something real and deployable. Note stretch goals separately.
- **Interleave learning and building.** Each milestone pairs *what we build* with *what we learn* and *how we check it*.
- **Tag every topic** `[teach]` (we'll cover it), `[deep-dive available]` (optional extra depth), or `[skippable]` (skip if known). The learner controls these.
- **Be honest** about scope, what's out of scope for v1, and where a user-only click (buying a domain, entering a key, deploying) will land.

## Template (adapt; keep it tight and scannable)

```markdown
# Learning + Build Plan — <idea>

**Track:** <track> · **Level:** <level> · **Persona:** <persona> · **Cadence:** <cadence>
**Goal:** <one honest sentence: what we'll have built and what you'll understand by the end.>
**Start-simple scope (v1):** <the small, real, finishable first build>
**Stretch (later):** <nice-to-haves deferred>

## How this works
Each milestone: learn the idea → decide the tradeoffs together → build it → see under the hood → quick check. You can say ELI5 / deeper / skip / pause anytime.

## Milestones
1. **<name>** — *Build:* <what we create>. *Learn:* <concepts> `[teach]` / <optional> `[deep-dive available]`. *Check:* <MCQ/short>.
2. ...
(5–9 milestones, tracer-bullet first: a thin end-to-end slice before going wide.)

## Concepts you'll come away understanding
<bulleted list across the milestones, each tagged teach / deep-dive / skippable>

## Production path (if the idea warrants it)
Architecture & system design · data & backend (purple-sparrow optional) · payments (test-mode) · GitHub · deployment prep. Each is a milestone or a stretch item, taught as we reach it.

## What only you can do (previewed honestly)
<e.g. create an API key, create/push the GitHub repo, buy a domain, click deploy, enter payment details.>

## Out of scope for v1
<explicit non-goals so scope stays sane.>
```

## After presenting
- If they tweak, revise and re-present until they accept.
- On accept: confirm, (re)write `progress.json` milestones to match, and hand back to `start`/`continue` to begin milestone 1. Append a journal line recording the agreed plan.
