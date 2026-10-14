# Track: Learn Python — write real code, and understand every line

**Who it's for:** anyone who wants to actually *write* code, not just drive an AI that writes it. The natural next step after Vibecoding, but it stands alone: no prior programming required. Undergraduate-friendly, beginner-first.

**Promise:** by the end you'll have written, from scratch, a small real program (a command-line todo app that saves your tasks, talks to a live web API, and has tests) *and* you'll be able to explain what each piece does — variables, loops, functions, data structures, files, errors, packages, and tests — in your own words.

**How depth scales by level:** never-coded → heavy analogies, every term defined on first use, more ELI5; some → concept + example; confident → crisp + the subtlety (the traps that bite everyone). Cadence controls how often we stop to check.

---

## Modules & lessons

Each lesson carries: concept · ELI5 · deep-dive · build-task · knowledge check · mastery bar · under-the-hood note. `[teach]` default, `[deep-dive available]` optional depth, `[skippable]` if known.

### m1 — Setup & running your first code  `mcq: m1.json`
- L1 Installing Python and checking it's really there `[teach]`
- L2 The interpreter and the REPL: a place to try things instantly `[teach]`
- L3 Running a `.py` file: from one line to a saved program `[teach]` `[deep-dive available]`
- **Mastery:** can run a one-line program both in the REPL and from a saved `.py` file, and say how the two differ.

### m2 — Values, variables & types  `mcq: m2.json`
- L1 Values and their types: int, float, str, bool `[teach]`
- L2 Variables & assignment: a name pointing at a value `[teach]`
- L3 Dynamic typing & converting between types `[teach]` `[deep-dive available]`
- **Mastery:** can name the four basic types, assign a variable, and explain why `"3" + 3` is an error.

### m3 — Control flow  `mcq: m3.json`
- L1 Booleans & comparisons: questions that answer true or false `[teach]`
- L2 `if` / `elif` / `else`: choosing a path `[teach]`
- L3 `while` loops: repeat until done `[teach]`
- L4 `for` loops & `range`: do something for each item `[teach]` `[deep-dive available]`
- **Mastery:** can write an `if/elif/else` and a `for` loop over a range, and explain the difference between `while` and `for`.

### m4 — Functions  `mcq: m4.json`
- L1 Why functions exist: name a chunk of work, reuse it `[teach]`
- L2 Parameters, arguments & `return` `[teach]`
- L3 Scope: what a function can and can't see `[teach]` `[deep-dive available]`
- **Mastery:** can write a function that takes arguments and returns a value, and explain the difference between printing and returning.

### m5 — Data structures  `mcq: m5.json`
- L1 Lists: an ordered, changeable collection `[teach]`
- L2 Tuples: a fixed, unchangeable collection `[teach]`
- L3 Dictionaries: looking things up by key `[teach]` `[deep-dive available]`
- L4 Sets & choosing the right structure `[teach]`
- **Mastery:** can pick the right structure (list / tuple / dict / set) for a given job and say why.

### m6 — Strings & text  `mcq: m6.json`
- L1 Indexing & slicing: reaching into a string `[teach]`
- L2 f-strings: building text from values `[teach]`
- L3 Common string methods (and why they return new strings) `[teach]` `[deep-dive available]`
- **Mastery:** can slice a string, format one with an f-string, and explain why strings are immutable.

### m7 — Files & errors  `mcq: m7.json`
- L1 Reading & writing files with `open` and `with` `[teach]`
- L2 `try` / `except`: catching what goes wrong `[teach]`
- L3 Exceptions as signals, not scoldings `[teach]` `[deep-dive available]`
- **Mastery:** can read and write a file safely with `with`, and catch a specific exception instead of crashing.

### m8 — Modules, packages & virtual environments  `mcq: m8.json`
- L1 `import`: using code someone already wrote `[teach]`
- L2 `pip` & packages: the wider world of Python code `[teach]`
- L3 Virtual environments & why isolation matters `[teach]` `[deep-dive available]`
- **Mastery:** can import from the standard library, install a package with pip into a venv, and say why the venv exists.

### m9 — HTTP, JSON & a tiny API client  `mcq: m9.json`
- L1 What an HTTP request is (asking a server a question) `[teach]`
- L2 JSON: the shape data travels in `[teach]`
- L3 A tiny API client: fetch live data and parse it `[teach]` `[deep-dive available]`
- **Mastery:** can make a GET request, check it worked, and pull a value out of the JSON response.

### m10 — Testing & a small real project, end to end  `mcq: m10.json`
- L1 `assert`: the smallest possible test `[teach]`
- L2 pytest basics: tests that run themselves `[teach]`
- L3 Tying it together: the finished project `[teach]` `[deep-dive available]`
- **Mastery:** can write a passing pytest test for a function, run the suite, and explain what a green test proves and what it doesn't.

---

## Starter projects (simple-first)

Everything in this track is anchored to small, real programs you build as you go:
- **CLI todo app** (m2–m8, m10) — the spine of the track. Add, list, complete, and save tasks from the command line. Each module adds one real capability: values → choices → functions → data structures → text → files → packaging → tests.
- **Weather fetcher** (m9) — a tiny API client that asks a live weather service for a city's forecast and prints it, so you practice HTTP and JSON against real data.
- **Mini web API** (stretch / optional) — turn the todo logic into a tiny web service others can call, once the fundamentals are solid.

Default recommendation for never-coded learners: start and stay with the CLI todo app; it carries every core concept with nothing extra to learn.

## Exit

At track end, run the post-build "under the hood" recap (how the interpreter ran your code · how a function call and the call stack worked · how a package got imported · how an HTTP+JSON round-trip happened · what the tests actually checked) and a short mastery review. Then suggest the natural next track: **CS-from-scratch** to understand what's happening beneath the language (memory, data structures, algorithms, how computers really work), or **Cybersecurity & AI Security** to harden what you build and understand how code gets attacked.
