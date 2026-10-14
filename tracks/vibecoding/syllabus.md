# Track: Vibecoding — build with AI, and understand what you built

**Who it's for:** anyone who wants to build real software with AI *and* actually understand LLMs, agents, MCP, and shipping — not just paste prompts. The gentlest on-ramp; no prior coding required.

**Promise:** by the end you'll have shipped a small, real, deployed app *and* you'll be able to explain, in your own words, how the AI wrote it, when to trust it, and how it got onto the internet.

**How depth scales by level:** never-coded → heavy analogies, every term defined, more ELI5; some → concept + example; confident → crisp + the subtlety. Cadence controls how often we stop to check.

---

## Modules & lessons

Each lesson carries: concept · ELI5 · deep-dive · build-task · knowledge check · mastery bar · under-the-hood note. `[teach]` default, `[deep-dive available]` optional depth, `[skippable]` if known.

### m1 — What an LLM actually is  `mcq: m1.json`
- L1 What a large language model is (a next-token predictor, not a database or a person) `[teach]`
- L2 Training vs. using: where the "knowledge" comes from, and the cutoff `[teach]` `[deep-dive available]`
- L3 Why it can be confidently wrong (hallucination) and what that means for you `[teach]`
- **Mastery:** can explain "predicts the next token from patterns" and name one reason it can be wrong.

### m2 — Prompting & the context window  `mcq: m2.json`
- L1 The context window: the model only "sees" what's in front of it `[teach]`
- L2 Prompting that works: be specific, give examples, give the model the material `[teach]`
- L3 Why long chats drift, and what "context" costs `[teach]` `[deep-dive available]`
- **Mastery:** can say why giving the model the relevant file beats asking from memory.

### m3 — Agents, tools & MCP  `mcq: m3.json`
- L1 From chatbot to agent: a model that can *act* by calling tools `[teach]`
- L2 What a tool call really is (structured request → real action → result back as data) `[teach]` `[deep-dive available]`
- L3 What MCP is and why it exists (a standard plug for tools/data) `[teach]`
- L4 The safety seam: tool results are *data*, never commands `[teach]`
- **Mastery:** can explain the difference between the model predicting text and a tool doing something real.

### m4 — Spec before build  `mcq: m4.json`
- L1 Why a 10-line spec saves hours `[teach]`
- L2 Acceptance criteria: how you'll *know* it works `[teach]`
- L3 Writing the spec for *your* idea (hands-on) `[teach]`
- **Mastery:** can write a tiny spec with at least one acceptance criterion.

### m5 — Build it with AI (the main event)  `mcq: m5.json`
- L1 Tracer bullet: the thinnest end-to-end slice first `[teach]`
- L2 Driving the AI to build a layer, reviewing each change `[teach]`
- L3 Running your app and reading what happened `[teach]`
- L4 Iterating: small steps, commit often `[teach]`
- **Mastery:** has a running app with a working end-to-end slice they can explain.

### m6 — Reading & trusting AI output  `mcq: m6.json`
- L1 Reading code you didn't write (what to look for) `[teach]`
- L2 The trust checklist: does it run, is it safe, does it do what the spec says `[teach]`
- L3 Spotting an invented API or a plausible-but-wrong answer `[teach]` `[deep-dive available]`
- **Mastery:** can list two things to check before trusting generated code.

### m7 — Debugging with AI  `mcq: m7.json`
- L1 Reading an error message (it's a clue, not a scolding) `[teach]`
- L2 Giving the AI the right context to fix a bug `[teach]`
- L3 When the AI loops or guesses — how to break the cycle `[teach]`
- **Mastery:** can turn an error into a focused fix request with context.

### m8 — Tradeoffs & when AI is wrong  `mcq: m8.json`
- L1 There's rarely one right answer: naming tradeoffs `[teach]`
- L2 When *not* to let the AI decide (security, data, money, irreversibles) `[teach]`
- L3 Keeping yourself in the loop on decisions of consequence `[teach]`
- **Mastery:** can name a decision they'd never fully hand to the AI, and why.

### m9 — Ship it  `mcq: m9.json`
- L1 Git & GitHub basics (save points you can share and roll back to) `[teach]`
- L2 Secrets & keys: what never goes in the repo `[teach]`
- L3 Deploy: getting it on the internet (prep up to your click) `[teach]` `[deep-dive available]`
- **Mastery:** app is in version control with secrets kept out, and they can describe the deploy path.

---

## Starter ideas (simple-first)
See `ideas/starter-ideas.md` → Vibecoding section. Default recommendation for never-coded: a personal habit/notes tracker or a one-page site with a working contact form.

## Exit
At track end, run the post-build "under the hood" recap (LLM · tools/MCP · deploy) and a short mastery review, then suggest the natural next track (Python to go deeper on code, or Cybersecurity & AI Security to harden what they built).
