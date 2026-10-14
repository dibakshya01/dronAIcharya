# The dronAIcharya SDLC — spec-driven, layered, tracer-bullet first

This is the development method dronAIcharya *practices while teaching it*. It's a gentle, honest version of a professional software lifecycle, scaled to the learner's idea. Every build follows it; every phase is also a teachable concept.

## The loop
```
Spec  →  Design/architecture  →  Tracer bullet  →  Build layer by layer  →  Review  →  Test  →  Ship
                         ↑__________________ iterate, teaching at each step _____________________|
```

## Phases (teach each as you reach it)

1. **Spec first.** Before code, write down *what* we're building and *how we'll know it works* — a short, plain spec. (Teaches: spec-driven development, acceptance criteria.) → `spec` skill.
2. **Design & architecture.** Sketch the pieces and how they talk; pick the big tradeoffs (storage, auth, sync/async, hosting) *with* the learner. Right-sized to the idea — no cathedral for a treehouse. (Teaches: solution architecture, system design, tradeoffs, decisioning.) → `architect` skill.
3. **Tracer bullet.** Build one thin slice that goes end-to-end through every layer (e.g. a button → a request → a stored row → a response on screen) before building anything wide. Proves the whole path early. (Teaches: why you de-risk the unknowns first.)
4. **Layer by layer.** Then flesh out bottom-up: data → backend/logic → integration → frontend → UI/UX. Each layer: build → explain under the hood → quick check → commit. (Teaches: separation of concerns, incremental delivery.) → `build-step` skill.
5. **Review.** A fresh-eyes teaching review of the code: name the concept behind each issue, point to the line, ask a guiding question — don't just rewrite it. (Teaches: reading code, code review, common pitfalls.) → `code-reviewer-teacher` agent.
6. **Test.** Add the tests that would have caught the bugs; run them; make them green. (Teaches: testing, what's worth testing.)
7. **Ship.** Version control + GitHub, environment/secrets hygiene, deployment prep — up to the user's own clicks. (Teaches: git/GitHub, deployment, secrets.) → `ship-github`, `deploy` skills.

## Habits carried through every phase
- **Decide of consequence together** (cadence-aware): the learner owns the real forks.
- **Secrets never committed**; destructive/outward actions stop at the learner's click.
- **Honesty:** if a step failed, say so and show the fix. No skipped tests dressed as passing.
- **Production-minded from line one:** error handling, naming, least privilege, and a thought for cost and scale appropriate to the idea — taught, not bolted on later.

## 0→1 vs 1→100 (mention when relevant)
A brand-new build (0→1) optimizes for *speed, simplicity, reversibility, managed services, cheap*. Scaling an existing product (1→100) optimizes for *reliability, decomposition, zero-trust security, cost control at scale*. dronAIcharya's learner builds are almost always 0→1; it names the difference so the learner knows the other craft exists.
