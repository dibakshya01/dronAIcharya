# Track: CS from Scratch — the foundations under the code

**Who it's for:** anyone who can write (or vibe-code) a little program but wants to understand what's *actually happening* — how data is stored, how programs run, what data structures and algorithms are, and how the OS, network, and databases underneath it all work. No CS degree, no math background assumed.

**Promise:** by the end you'll be able to explain, in plain language and with tiny concrete examples, how a computer represents and runs your program, why one data structure beats another, what Big-O really measures, and how the web and databases work underneath the apps you build.

**Honesty about scope.** This is undergraduate *foundations and literacy*, **not** a full CS degree. It's a solid, build-anchored survey: enough to read, reason about, and talk about real systems with confidence — not a substitute for dedicated courses in computer architecture, theory of computation, compilers, operating systems, or databases. We go for durable, correct intuition over exhaustive coverage, and we say out loud where we're simplifying. Some topics here (stack vs heap, the CPU loop, concurrency) don't surface naturally in a small beginner program, so we teach them standalone and flag it when we do.

**How depth scales by level:** never-coded → heavy analogies, every term defined, more ELI5; some → concept + example; confident → crisp + the subtlety. Cadence controls how often we stop to check.

---

## Modules & lessons

Each lesson carries: concept · ELI5 · deep-dive · build-task · knowledge check · mastery bar · under-the-hood note. `[teach]` default, `[deep-dive available]` optional depth, `[skippable]` if known.

### m1 — How computers represent data  `mcq: m1.json`
- L1 Bits & bytes: everything is 0s and 1s `[teach]`
- L2 Binary and hex: counting in base 2 and base 16 `[teach]` `[deep-dive available]`
- L3 Text as numbers: ASCII and Unicode `[teach]`
- **Mastery:** can explain that data is stored as bits, that a byte is 8 bits (256 values), and that text is numbers mapped to characters.

### m2 — Memory & how programs hold data  `mcq: m2.json`
- L1 Variables as named places in memory `[teach]`
- L2 The stack vs the heap (mostly under the hood) `[teach]` `[deep-dive available]`
- L3 Pointers & references: the address, not the thing `[teach]`
- **Mastery:** can say what a variable is in memory, and the difference between a value and a reference to it.

### m3 — How programs run  `mcq: m3.json`
- L1 Source code → machine code: compiling vs interpreting `[teach]` `[deep-dive available]`
- L2 What machine code is `[teach]`
- L3 What a CPU does in a loop (fetch–decode–execute) `[teach]`
- **Mastery:** can explain the path from source to running, and that the CPU repeats fetch–decode–execute.

### m4 — Data structures I: arrays & lists  `mcq: m4.json`
- L1 Arrays: a contiguous row of boxes `[teach]`
- L2 Dynamic arrays (Python lists, JS arrays) `[teach]` `[deep-dive available]`
- L3 Linked lists and the cost of operations `[teach]`
- **Mastery:** can say why indexing an array is cheap and inserting in the middle is not.

### m5 — Data structures II: maps, trees, graphs  `mcq: m5.json`
- L1 Hash maps: lookup by key, fast on average `[teach]` `[deep-dive available]`
- L2 Trees: hierarchy and sorted order `[teach]`
- L3 Graphs: things and the connections between them `[teach]`
- **Mastery:** can match each structure (map / tree / graph) to a problem it's good at.

### m6 — Algorithms & Big-O  `mcq: m6.json`
- L1 What "complexity" means (steps, not seconds) `[teach]`
- L2 The common classes: O(1), O(log n), O(n), O(n²) `[teach]` `[deep-dive available]`
- L3 Reading and comparing Big-O in practice `[teach]`
- **Mastery:** can rank those classes by growth and explain that Big-O is about growth, not wall-clock time.

### m7 — Recursion  `mcq: m7.json`
- L1 Base case and recursive case `[teach]`
- L2 The call stack and stack overflow `[teach]` `[deep-dive available]`
- L3 When recursion helps (and when a loop is better) `[teach]`
- **Mastery:** can name the two parts every recursion needs and what the call stack has to do with it.

### m8 — Operating systems foundations  `mcq: m8.json`
- L1 What the OS actually does `[teach]`
- L2 Processes vs threads `[teach]` `[deep-dive available]`
- L3 Concurrency vs parallelism (concept level) `[teach]`
- **Mastery:** can explain the difference between a process and a thread, and between concurrency and parallelism.

### m9 — Networking & the web  `mcq: m9.json`
- L1 IP addresses and packets `[teach]`
- L2 TCP vs UDP (intuitively) `[teach]` `[deep-dive available]`
- L3 DNS: names to numbers `[teach]`
- L4 HTTP and how a page loads `[teach]`
- **Mastery:** can trace, at a high level, what happens from typing a URL to seeing the page.

### m10 — Databases foundations  `mcq: m10.json`
- L1 The relational model: tables, rows, columns `[teach]`
- L2 Keys and relationships `[teach]` `[deep-dive available]`
- L3 Indexes: why some queries are fast `[teach]`
- L4 Transactions & ACID `[teach]`
- **Mastery:** can explain primary vs foreign key and what a transaction guarantees.

---

## How this track is build-anchored
Every lesson ties concepts to a tiny, language-agnostic program or example (mostly Python or pseudocode) you can run and poke at — e.g. printing the bytes of a word, timing a lookup in a list vs a dict, watching a recursion hit its base case, reading an HTTP response. Where a concept genuinely doesn't show up in a small beginner build (the stack/heap split, the CPU's instruction loop, true parallelism), the lesson says so and teaches it standalone with an analogy and a diagrammatic example.

## Exit
At track end, run a short "zoom out" recap that stitches the layers together — bits → memory → running program → data structures → algorithms → OS → network → database — and a mastery review. Then suggest the natural next track: Python (to write more real code against these foundations) or Vibecoding (to ship something), or a dedicated algorithms/systems course to go deeper than a survey can.
