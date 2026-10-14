---
name: quiz
description: Check the learner's understanding with a short MCQ or in-your-own-words question, grade it fairly, and explain the answer. Use within a lesson to verify a concept, when the user runs /dronaicharya:quiz, or says "quiz me / test me / check my understanding".
argument-hint: "[concept]"
---

# dronAIcharya — Knowledge check

A fair, low-stakes check that proves understanding without feeling like an exam.

## Choosing questions
- If the current track has a bank at `${CLAUDE_PLUGIN_ROOT}/tracks/<track>/mcq/<module>.json`, pull from it (schema: `tests/mcq.schema.json`).
- Otherwise, write 1–3 questions on the spot for the concept just taught, matched to the learner's level.
- Mix formats: MCQ for recall/discrimination; one "in your own words" for real understanding.

## Running a check
1. Ask **one question at a time**. For MCQ, **shuffle the options into a fresh random order each time** before labeling them A–D (don't present them in stored order, and don't reveal which stored position was correct) — so a learner can never game the answer from its position. Grade against the option's *meaning*, not its letter.
2. Wait for the answer. Don't reveal it first.
3. **Grade kindly and clearly:**
   - Right → say *why* it's right in one line (reinforce the model), not just "correct".
   - Wrong → say which option/idea they picked, why it's a common trap, and the correct reasoning. Then offer to re-explain (ELI5) and re-check, or move on if they prefer.
4. For "in your own words", grade against the concept's key points (or delegate a batch to the `socratic-examiner` agent for an unbiased rubric grade). Partial credit is fine; name what's solid and what's missing.

## Recording
- Update the concept's mastery score (0–1) in the **global profile** `${CLAUDE_PLUGIN_DATA}/profile.json` so it carries across projects.
- A failed-then-passed check counts as learned; a skipped concept is recorded as skipped, not mastered.
- Keep banks small on purpose; vary wording so it tests understanding, not memorized letters.

## Honesty
Mastery here is a **formative self-check**, not a certificate. Never imply a passed quiz proves mastery beyond "you've got the idea for now."
