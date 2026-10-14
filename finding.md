# finding.md — dronAIcharya research synthesis

> Research dossier for **dronAIcharya**, an open-source, Claude-Code-native *teach-while-you-build* tool.
> Date: 2026-10-14. Every external claim is cited. Items that could not be verified are flagged **[UNVERIFIED]**.

---

## 1. The problem & who has it

People who want to use AI to build real software fall into a trap with today's tools. They can either **learn** (tutorials, courses, AI tutors that explain concepts) **or** **build** (vibecoding tools that ship something) — but almost nothing does both *well, to a production bar, while actively making sure the learner understands what was built*. The result:

- **Beginners** paste prompts, get working code, and learn nothing about what is under the hood — so they cannot debug, extend, or secure it.
- **Vibecoders** ship fast but carry no mental model of LLMs, MCP, architecture, tradeoffs, or deployment — the "it works but I don't know why" problem.
- **Self-learners** lack structure and accountability: no syllabus, no knowledge checks, no sense of mastery or progression.
- **Non-technical people** are blocked at the very first steps (what's an API token? where do I paste it? what is git?) and most tools assume that away.

**Who has this pain:** absolute beginners who want to learn-by-building; vibecoders who want to understand what they're shipping; CS students who want undergraduate fundamentals from scratch; people who want AI / AI-security literacy; and self-taught builders who need a structured, accountable path from idea to deployed, production-grade product.

**The one-line opportunity:** a guru that *teaches you AND builds with you* — from "what is an API key" all the way to a deployed, payment-integrated, backend-backed product — and strongly steers you not to skip the understanding (while still honoring your choice to).

---

## 2. Prior art & the gap

Research (recon subagent, 2026-10-14; URLs below) found the landscape clusters into two camps, with a clear gap between them.

**Camp A — learner-facing AI tutors (explain, but ship toys):**
- AITutorAgent — LangGraph interactive tutor, Q&A, knowledge evaluation. https://github.com/Ebimsv/AITutorAgent
- Code.org AI Tutor — Socratic tutor embedded in limited curriculum units. https://code.org/en-US/tools/ai-tutor
- ybabulkov/learning-plugin — "learn how to build while AI writes the code," adapts to experience level. https://github.com/ybabulkov/learning-plugin
- Anthropic `learning` output style — interactive learning mode that requests code contributions at decision points (closest first-party comparator). **[UNVERIFIED exact name/path]**
- code-sensei — in-context coding tutor, quizzes, belt progression. **[UNVERIFIED]**
- Research: TRAVER (turn-by-turn verifiers / knowledge tracing, https://arxiv.org/pdf/2502.13311), AI2T (https://arxiv.org/pdf/2411.17924).

**Camp B — educator-facing course builders (for teachers, not learners):**
- YujxZJCN/teaching-skills — course-designer / lesson-builder for professors. https://github.com/yujxzjcn/teaching-skills
- GarethManning/education-agent-skills — 165 pedagogy/assessment skills. https://github.com/GarethManning/education-agent-skills
- StudentSuite/awesome-skills-plugins-for-students — curated student list. https://github.com/StudentSuite/awesome-skills-plugins-for-students/

**The gap dronAIcharya fills — no surfaced project combines all of these axes:**
1. **Teach AND build to production** — most tutors stop at sandbox/toy exercises; dronAIcharya drives a real, deployable, backend-backed, payment-capable artifact while teaching.
2. **Persona-driven guru** — a sustained *teaching persona* (the Drona/guru framing) rather than a tone-flat output style.
3. **Guardrailed against drift** — explicit, enforced anti-drift so the session never silently stops teaching. This is a *named feature*, enforced by hooks, not a hope.
4. **Real MCP backend** — pairing with purple-sparrow gives learners a genuine agent-native backend (auth, row-level policies, storage, realtime) instead of mock data. This integration angle appears **absent** from surfaced competitors.
5. **Multi-track** — a structured curriculum across Vibecoding, Python, CS-from-scratch, and Cybersecurity & AI Security, with level detection and skip/deep-dive/ELI5 controls.

---

## 3. Documented failure modes to design out

From prior art and research, the recurring ways teaching-builders fail — each mapped to a dronAIcharya countermeasure:

| Failure mode | Countermeasure in dronAIcharya |
|---|---|
| **Teaching drift** — the agent quietly stops teaching and just writes the code (the exact thing Camp A keeps fighting). | Guardrail **hooks** (`SessionStart` + `UserPromptSubmit` re-inject the teaching contract after every turn and after compaction; `Stop` hook enforces a check-for-understanding). In-content rule: a learner decision/contribution is required at each decision point before code is written. |
| **Too-shallow builds** — "build" tutorials that never reach anything deployable. | Production SDLC spine (spec → layered build → review → deploy) + the real purple-sparrow backend + payments/deploy prep to the user-only click. |
| **No knowledge checks / no retention** — explain but never verify. | Dedicated MCQ/knowledge-check engine (fresh-memory examiner subagent), mastery map persisted in state, gates before advancing. |
| **Pacing mismatch** — over-explaining experts, under-scaffolding beginners. | Level detection at intake + per-concept **skip / deep-dive / ELI5** toggles + multi-track. |
| **Trust/safety of a code-running tutor** — it reads your project and runs commands. | Full transparency (two honest install paths, pros/cons), least-privilege tooling, deny-by-default backend, and honest caveats surfaced as *teaching moments* (including purple-sparrow's own alpha/audit caveat). |
| **Context loss on long journeys** — the model forgets the plan over many turns. | A persistent **learning Hub** in the learner's project (`.dronacharya/`: plan + progress + journal), re-read by `continue`/`next` and re-injected by the `SessionStart` hook. |

---

## 4. Technical landscape (how it will actually be built)

### 4.1 Claude Code plugin system (verified against code.claude.com, 2026-10-14)
dronAIcharya is a **Claude Code plugin** (also installable as a plain skills repo, and portable to Cursor). Verified mechanics that constrain the design:

- **Structure:** `.claude-plugin/plugin.json` (manifest; only `name` required, kebab-case — use `"name":"dronaicharya"`, `"displayName":"dronAIcharya"`), `skills/<name>/SKILL.md`, `agents/<name>.md`, `commands/<name>.md`, `hooks/hooks.json`, `.mcp.json`, optional `bin/`. Commands become `/dronaicharya:<name>`.
- **One repo = plugin + its own marketplace:** put both `plugin.json` and `marketplace.json` in `.claude-plugin/` with plugin `source: "./"`. Install: `/plugin marketplace add dibakshya01/dronAIcharya` → `/plugin install dronaicharya@<marketplace-name>`.
- **Skills:** frontmatter `name` + `description` drive auto-invocation; `description`+`when_to_use` capped at 1,536 chars; `SKILL.md` under ~500 lines (push detail into supporting files); listing budget ~1% of context (so curricula must be *data files*, not skills). `disable-model-invocation: true` = user-only step skills; `context: fork` + `agent:` runs a skill in a subagent.
- **Subagents:** `agents/<name>.md`, frontmatter `name`+`description` required, `tools`, `model: inherit`, `maxTurns`. Plugin agents are namespaced (`dronaicharya:<name>`). Plugin agents silently ignore `hooks`/`mcpServers`/`permissionMode` — those live at plugin level.
- **Hooks (the guardrail engine):** `hooks/hooks.json`; events include `SessionStart` (matcher `startup|resume|compact`), `UserPromptSubmit`, `Stop`. Exit 0 stdout is injected as context for `SessionStart`/`UserPromptSubmit`; `Stop` can emit `{"decision":"block","reason":...}` (loop-guarded by `stop_hook_active`, cap 8). Env: `CLAUDE_PLUGIN_ROOT`, `CLAUDE_PLUGIN_DATA`, `CLAUDE_PROJECT_DIR`. **Plugin hooks fire in every session the plugin is enabled → must be gated by a state file** (`.dronacharya/` in the project). Injected text must be *factual/context-shaped*, not imperative system-speak (triggers injection defenses). `additionalContext` ≤ 10,000 chars.
- **MCP in a plugin:** `.mcp.json` or inline `mcpServers`; stdio and `type:"http"` supported; `${user_config.KEY}` substitution via `userConfig`. A plugin **cannot declare a dependency on a separate MCP server** — so purple-sparrow is wired via `userConfig` (ask for `PS_API_URL`/`PS_API_KEY`) **and** graceful detection, matching the "optional enhancement" decision.
- **Dev loop:** `claude --plugin-dir ./dronaicharya`, `claude plugin validate ./dronaicharya --strict`, `/reload-plugins`.
- Sources: https://code.claude.com/docs/en/plugins/ (create, components, manifest-reference, marketplace-reference, install, publish, loading), https://code.claude.com/docs/en/skills.md, https://code.claude.com/docs/en/sub-agents.md, https://code.claude.com/docs/en/hooks.md, https://code.claude.com/docs/en/mcp.md.

### 4.2 Cursor portability (verified against cursor.com docs)
Cursor reads `.claude/skills/`, `~/.claude/skills/`, `.claude/agents/`, and (with third-party configs on) `.claude/settings.json` hooks — but **does not** install a Claude Code plugin package, uses different manifest/hook dialects, and ignores Claude-only skill fields (`allowed-tools`, `context: fork`, `$ARGUMENTS`, etc.). **Portability path:** keep a clean source tree of `skills/` + `agents/` + `AGENTS.md`; use only `name`/`description`/`disable-model-invocation` in skill frontmatter for portable skills; ship a sync helper that copies into `.claude/skills` etc.; be honest in docs about what does not port. Sources: https://cursor.com/docs/skills, /subagents, /rules, /reference/plugins, /reference/third-party-hooks.

### 4.3 purple-sparrow — the optional backend (verified from source)
- **What:** agent-native backend-as-a-service, single **Go** binary; embedded SQLite (Postgres/S3 scale-out); deny-by-default **policy engine**; auth (JWT/JWKS, API keys); storage (presigned URLs); sandboxed **WASM** edge functions; realtime via SSE; `GET /meta` introspection; OpenAPI 3.1. License Apache-2.0. Maturity: early (README "beta", badge "alpha", 22 commits). README caveat: policy engine "needs an independent security audit before regulated data"; SSE realtime is per-node. https://github.com/dibakshya01/purple-sparrow
- **Native MCP (first-class):** `purplesparrow mcp` → JSON-RPC 2.0 over **stdio only** (protocol `2024-11-05`, server `purple-sparrow` v0.1). It is a **proxy** to the running HTTP backend (`PS_API_URL` default `http://127.0.0.1:8787`, `PS_API_KEY`/`PS_ADMIN_API_KEY`). So the `serve` process must be running.
- **8 MCP tools:** `fetch_docs`, `get_meta`, `list_tables`, `create_table`, `query_records`, `insert_record`, `create_policy`, `run_advisor`.
- **Exact client config** (from `purplesparrow mcp-config`):
  ```json
  { "mcpServers": { "purple-sparrow": {
      "command": "purplesparrow", "args": ["mcp"],
      "env": { "PS_API_KEY": "<your-api-key>", "PS_API_URL": "http://127.0.0.1:8787" } } } }
  ```
- **Run:** `CGO_ENABLED=0 go build -o purplesparrow ./cmd/purplesparrow` then `PS_ADMIN_API_KEY=ps_sk_dev ./purplesparrow`.
- **Fit:** lets dronAIcharya teach *real* backend work (tables, row-level policies, auth, storage, the advisor's security findings) against a genuine backend, not mock data — a differentiator competitors lack. Wired as optional enhancement: detected → supercharge the backend track; absent → fall back to teaching the same concepts conceptually or via a simple local store, and offer a guided purple-sparrow setup.

### 4.4 dronAIcharya repo state
**Empty** (verified: "This repository is empty", raw README 404 on `main` and `master`). Clean slate — nothing to overwrite. Default branch will be created on first push.

---

## 5. Security posture (AI/LLM/MCP/security project → OWASP-anchored)

Because dronAIcharya runs code, reads the learner's project, wires an MCP server, teaches an AI-Security track, and handles API tokens, it must itself be a model of safe practice. Anchors (OWASP LLM/Agentic + general secure defaults; to be refreshed against the latest list during the security-track build):

- **Secrets:** never commit API keys; teach `.env` + `.gitignore`; keys pasted by the learner stay local; dronAIcharya never transmits them anywhere.
- **Prompt injection:** the guardrail hooks inject *factual context*, never imperative system-speak; the tool treats file/web/tool content as data, not instructions, and teaches this (LLM01-style).
- **Least privilege:** skills/agents request the minimum tools; destructive/outward actions (push, publish, pay, deploy, token entry) stop at the user's own click.
- **Backend:** purple-sparrow's deny-by-default policy engine is used as the default, and its own "needs audit" caveat is surfaced as a lesson, not hidden.
- **Honesty:** no invented tools/metrics; every "can and cannot do" is stated plainly.

---

## 6. Synthesized direction (what we will build)

A Claude Code **plugin** (dual-installable as a skills repo; portable to Cursor) named **dronAIcharya** — "your AI guru: learn as you build." A paste of the GitHub URL hits a **greeter** (README + `START-HERE.md`) that offers two honest install paths with pros/cons + exact commands. Once installed, an **orchestrator** runs a persistent, guardrailed journey:

**choose persona → check setup (tokens/editor) → choose track + level → bring an idea (or pick a starter) → co-author a combined BUILD + LEARN plan (approve/tweak) → execute linearly, teaching before/during/after each step with MCQ checks, ELI5/deep-dive/skip toggles, real production SDLC (spec → layered build → adversarial teaching-review → deploy prep) → optional purple-sparrow backend → payments + GitHub + deployment up to the user's own clicks → post-build "under the hood" mastery recap.**

State lives in the learner's project (`.dronacharya/`), guardrail hooks keep it in teaching mode and on-plan across long sessions and compaction, and fresh-memory subagents handle assessment and adversarial review so grading and critique stay unbiased. Full spec in `build-plan.md`.

---

## 7. Sources
- Claude Code plugins/skills/agents/hooks/mcp: https://code.claude.com/docs/en/plugins/ · /skills.md · /sub-agents.md · /hooks.md · /mcp.md · /tools-reference.md · /memory.md
- Cursor: https://cursor.com/docs/skills · /subagents · /rules · /reference/plugins · /reference/third-party-hooks
- purple-sparrow: https://github.com/dibakshya01/purple-sparrow · https://dibakshya01.github.io/purple-sparrow/ · source `internal/mcp/{server,tools}.go`, `cmd/purplesparrow/main.go`
- dronAIcharya: https://github.com/dibakshya01/dronAIcharya (empty)
- Prior art: https://github.com/Ebimsv/AITutorAgent · https://code.org/en-US/tools/ai-tutor · https://github.com/ybabulkov/learning-plugin · https://github.com/yujxzjcn/teaching-skills · https://github.com/GarethManning/education-agent-skills · https://github.com/StudentSuite/awesome-skills-plugins-for-students/ · https://arxiv.org/pdf/2502.13311 · https://arxiv.org/pdf/2411.17924
