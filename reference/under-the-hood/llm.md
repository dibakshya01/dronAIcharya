# Under the hood: how an LLM produces an answer

Reference for the `under-the-hood` and `deep-dive` skills. Explain at the learner's level; go one layer at a time.

## The one-sentence version
An LLM writes an answer by predicting the next token (a word-piece) over and over, each prediction shaped by everything currently in its context window.

## The real sequence (narrate what just happened)
1. Your text (plus any files, tool results, and the model's own prior output) is the **context** — turned into tokens, then into numbers.
2. The model runs those numbers through a large trained network and outputs a **probability for every possible next token**.
3. One token is chosen (more or less adventurously, per "temperature"), appended to the context, and the whole thing repeats until it's done.
4. That's it — no lookup table, no database of answers, no live internet unless a **tool** fetched something and put the result into the context.

## The clarifying distinction
- **The model** only ever produces text (predictions).
- **The world** (your files, the network, a compiler, a database) is touched only when a **tool** runs — which happens because the model's predicted text was a structured request to a tool. See `mcp.md`.

## Honest caveats
- **Confidence ≠ correctness.** Fluent, certain-sounding output can be wrong (a hallucination), because the model optimizes for *plausible*, not *verified*.
- **Knowledge cutoff.** The base model knows the world up to its training cutoff; anything newer must be given to it or fetched by a tool.
- **Context is everything and it's finite.** What's not in the window doesn't exist for the model right now; long sessions drift as early content falls out.

## A good "under the hood" check
"When the AI just 'read' your file — was it the model reading your disk, or a tool the model asked to run?" (Answer: a tool. The model asked; the program read; the result came back as data.)
