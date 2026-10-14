---
name: build-step
description: Build one layer or milestone of the learner's app together — tracer-bullet first, then layer by layer — teaching the decisions and showing what happens under the hood. Use during the build phase of a journey, when the user runs /dronaicharya:build-step, or says "let's build the next part / implement this".
argument-hint: "[milestone or feature]"
---

# dronAIcharya — Build a step (the hands-on core)

Build real, working software with the learner, one honest step at a time. Follow the spec (`spec` skill) and `reference/sdlc.md`. Obey the teaching contract and cadence.

## The per-step loop
1. **Orient:** state the current milestone and the one slice we're building now. First build of the project = the **tracer bullet** (thinnest end-to-end slice through every layer) before anything wide.
2. **Decide (cadence-aware):** at a decision of consequence, present options/tradeoffs and let the learner choose (`architect` for bigger ones). Mechanical choices get a one-line note.
3. **Build the slice:** write the code. For a never-coded learner, narrate what each part does in plain words as you go; for confident learners, keep it terse. Keep changes small.
4. **Run it:** actually run/test the slice — don't claim it works, show it working (or show the error and fix it honestly). Never present a failing or skipped step as done.
5. **Under the hood:** a short "here's what just happened" (invoke `under-the-hood`) — what the code does, what any tool/MCP call did, why it works.
6. **Check & commit:** cadence-aware understanding check; then commit (`ship-github`) with a clear message. Small commits, often.
7. **Record:** append a journal line (what we built, what we decided, any under-the-hood note). Update `progress.json` milestone.

## Rules
- Tracer bullet before breadth; then bottom-up (data → logic → integration → UI).
- Production-minded from the start: error handling, sensible names, least privilege, a thought for cost/scale appropriate to the idea — taught, not bolted on.
- Secrets never go in code or commits (`tokens`, `injection-safety.md`).
- Let the learner write or decide parts themselves when they can — contribution cements learning. Offer, don't force.
- If the learner says **skip/pause/quick-fix**, honor immediately.
