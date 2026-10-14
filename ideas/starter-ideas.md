# Starter ideas (simple-first)

When a learner has no idea in mind, offer 3–4 of these matched to their track. Always **recommend the smallest one that still teaches the core** — a first build they finish beats a big one they abandon. Each lists what it teaches and a one-line stretch goal.

## Vibecoding
- **Personal habit / notes tracker** *(recommended first build)* — add/list/complete items, saved locally. Teaches: data model, CRUD, UI basics, shipping. *Stretch:* sync across devices with a backend.
- **One-page site with a working contact form** — teaches: frontend, form handling, a tiny backend endpoint, deploy. *Stretch:* email the submission.
- **"Ask-my-notes" mini chatbot** — paste some notes, ask questions over them. Teaches: LLM calls, context, prompts, keys. *Stretch:* retrieve from many files.
- **Small bot** (chat/Discord/Telegram) — responds to a command. Teaches: APIs, webhooks, secrets. *Stretch:* add a second command and persistence.

## Learn Python
- **CLI to-do app** *(recommended first)* — add/list/done in the terminal, saved to a file. Teaches: variables, lists/dicts, functions, files. *Stretch:* due dates + sorting.
- **Weather / fact fetcher** — call a public API, print a tidy result. Teaches: HTTP, JSON, error handling, keys. *Stretch:* cache results.
- **Mini web API** — a couple of endpoints returning JSON. Teaches: functions→routes, request/response, testing. *Stretch:* add a tiny data store.

## CS from Scratch
- **Build-a-data-structure playground** — implement a list, then a hash map, then a tiny tree, and race them. Teaches: data structures, Big-O by feel. *Stretch:* visualize the operations.
- **Tiny "how the web works" demo** — a client that makes a request and prints each step (DNS→connect→HTTP). Teaches: networking foundations. *Stretch:* show the TLS handshake conceptually.
- **Mini key-value store with an index** — store/fetch records, add an index, measure the speedup. Teaches: databases foundations, indexes. *Stretch:* add a simple transaction.

## Cybersecurity & AI Security
- **Secrets-hygiene fixer** — take a small app, find and fix leaked keys / add `.gitignore` / rotate. Teaches: secrets, key hygiene. *Stretch:* add a pre-commit check.
- **Prompt-injection sandbox** *(recommended)* — a tiny app that fetches a page and (safely) demonstrates why fetched content is data, not commands. Teaches: LLM01, the data/instruction boundary. *Stretch:* add an indirect-injection example and defend it.
- **Deny-by-default to-do API** — build a small multi-user API where, by default, you can only see your own items. Teaches: access control, authz, deny-by-default. *Stretch:* add an admin role with explicit policy.
- **Threat-model your own build** — take the app they built in another track and threat-model + harden it. Teaches: threat modeling, OWASP in context.
