# Contributing to dronAIcharya

Thanks for wanting to help teach people to build! Contributions of curriculum, personas, fixes, and translations are all welcome.

## Ground rules
- **Teach, don't just do.** Every change should serve the teaching contract (`reference/teaching-contract.md`): understanding first, learner in control, honesty throughout.
- **Be factually correct.** A tutor that teaches wrong things is worse than none. Cite sources for anything non-obvious; flag uncertainty.
- **No real-person or trademarked-character impersonation** in personas or docs. Use original archetypes.
- **No secrets, ever**, in examples or fixtures.

## Project layout
See `build-plan.md` §4. In short: `skills/` (capabilities), `agents/` (subagents), `hooks/` + `scripts/` (guardrails), `tracks/` (curriculum as data), `personas/`, `reference/`, `tests/`.

## Adding or editing a lesson
1. Follow the format of `tracks/vibecoding/modules/m1.md` exactly (Concept · ELI5 · Deep dive · Build-task tie-in · Under the hood · Check).
2. Add/extend the module's MCQ bank in `tracks/<track>/mcq/` per `tests/mcq.schema.json`.
3. Run the tests (below). Have the content fact-checked (the `content-accuracy-reviewer` agent is built for this).

## Adding a skill or agent
- Skills: `skills/<name>/SKILL.md` with `name` + `description` frontmatter (keep portable skills to those fields plus `disable-model-invocation`; see the Cursor caveats in `finding.md`). Keep under ~500 lines.
- Agents: `agents/<name>.md` with `name` + `description` (+ optional `tools`, `model: inherit`, `maxTurns`).

## Before you open a PR
```bash
claude plugin validate . --strict   # manifests + structure
bash tests/test-hooks.sh            # guardrail safety
bash tests/validate-content.sh      # JSON/schema + frontmatter checks
```
All green, plus a clear description of what you changed and why. Small, focused PRs are easier to review.

## Code of conduct
By participating you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).
