---
name: backend
description: Teach and build the backend for the learner's app — data model, storage, auth, access rules, APIs — using a real backend when available (purple-sparrow via MCP) or a simple fallback otherwise. Use at the data/backend layer of a build, when the user runs /dronaicharya:backend, or asks about databases, auth, storing data, or APIs.
argument-hint: "[what the backend needs to do]"
---

# dronAIcharya — Backend, taught

Teach real backend thinking — data, access control, auth, APIs — and build it against a genuine backend when one is available, or a simple local fallback otherwise. The **fallback is the default**; purple-sparrow is an optional enhancement.

## Teach the concepts (at their level)
- **Data model first:** what are the "things" (entities) and their fields? Tables/collections, keys, relationships. Co-design it from the spec.
- **Access control = who can do what:** teach **deny-by-default** — nobody can read/write unless a rule allows it. This prevents the classic "the database leaked everyone's data" bug.
- **Auth vs access:** authentication (who you are) vs authorization (what you're allowed to do).
- **APIs:** how the frontend asks the backend for data (endpoints, requests, JSON).

## Detect the backend, then branch
1. Check whether the **purple-sparrow** MCP tools are available (e.g. `get_meta`/`create_table`) and `flags.purpleSparrow`.
2. **If present (enhanced path):** build against it, letting the learner SEE each tool call:
   - `get_meta` to inspect structure, `create_table` for the data model, `insert_record`/`query_records` for data, `create_policy` to add deny-by-default row-level rules, and `run_advisor` to surface security gaps (a great teaching moment — fix what it flags). Surface its alpha/"needs audit" caveat; no real/regulated data.
3. **If absent (default fallback):** teach the exact same concepts with a simple local store appropriate to the stack (e.g. SQLite / a JSON file / an in-memory store), and build it directly. Mention that a hosted/managed backend (or purple-sparrow via `setup`) is the next step when they want multi-user, auth, and policies for real — and that the *concepts* are identical.

## Rules
- Deny-by-default and least privilege are taught and applied, not deferred.
- Secrets/keys never in code or commits.
- Decisions of consequence (data model, auth approach) are the learner's — present tradeoffs (`architect`/`architect-advisor`).
- Under-the-hood moment: what a query/policy actually does; if using MCP, what the tool call did.
- Mastery check: can the learner explain deny-by-default and why it's safer?
