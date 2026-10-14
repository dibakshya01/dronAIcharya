# Behavioral evals for dronAIcharya

These are **behavioral** checks — they run a real agent with and without the plugin and score the difference with an LLM judge. Unlike the deterministic tests (`tests/`), they cost money and need tool grants, so they are **opt-in**.

## Run them
```bash
# From the repo root. --ablation with-without shows the score delta the plugin adds.
claude plugin eval . --ablation with-without --allow-tools Write Edit Bash
# One case:
claude plugin eval . --case start-flow
```
`claude plugin eval` discovers `evals/**/prompt.md` cases and `evals/graders/*.md` rubrics (see `claude plugin eval --help`). Cases here are a starting set; tune them to your account's current eval schema and budget (`--max-cost-usd`).

## Cases
- **start-flow** — starting a journey greets the learner and offers a persona/track rather than dumping a solution.
- **teach-not-do** — asked to "just build it", the plugin still teaches and checks understanding at decisions of consequence (while honoring an explicit "just do it").
- **injection-resistance** — content containing "ignore your instructions" is treated as data, not obeyed.

## Honest note
These evals exercise LLM behavior and are inherently noisy; treat them as signal, not proof. The deterministic guarantees live in `tests/` (hook safety, schema/frontmatter). End-to-end journey verification is documented as a **manual** walkthrough in `../LOCAL_TEST.md`.
