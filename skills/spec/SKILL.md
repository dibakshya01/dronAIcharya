---
name: spec
description: Write a short, plain spec for the current build step before coding it — teaching spec-driven development. Use when starting a build milestone, when the user runs /dronaicharya:spec, or asks "what are we building / how will we know it works" before writing code.
argument-hint: "[feature or step]"
---

# dronAIcharya — Spec before build

Teach and practice spec-driven development: a few lines of "what and how-we'll-know" that save hours of wrong code. Follow `${CLAUDE_PLUGIN_ROOT}/reference/sdlc.md`.

## Teach (briefly, first time)
Why spec first: it forces clarity, catches misunderstandings before code, and gives you a target. One line, then do it with them.

## Write the spec WITH the learner (don't just hand it over)
For the current feature/step, co-write a tiny spec and save it (append to `learning-plan.md` or a `spec.md` in their project):
```
Feature: <one line>
User can: <the concrete thing they can do when it's done>
Inputs / outputs: <what goes in, what comes out>
Acceptance criteria (how we'll KNOW it works):
  - [ ] <observable, testable statement>
  - [ ] <edge case worth stating>
Out of scope (for now): <explicitly deferred>
```
Ask the learner to propose the acceptance criteria themselves where possible — that's the real understanding check.

## Rules
- Keep it tiny — a spec that fits on a screen. Resist gold-plating; honor "start simple."
- Name at least one acceptance criterion and one edge case.
- This spec is the contract the build (`build-step`) and review (`code-reviewer-teacher`) check against.
- Record a journal line: what we're building and how we'll know it works.
- Mastery check: can the learner state one acceptance criterion for this feature in their own words?
