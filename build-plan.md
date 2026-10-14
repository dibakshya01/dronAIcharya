# build-plan.md — dronAIcharya (v2, post spec-review)

> The spec-driven plan of record. Nothing gets built that isn't here; if reality forces a change, this file is updated first, then the code. Companion to `finding.md`.
> Status: **APPROVED by user (plan gate) + REVISED per ExpertSpecReviewer (REVISE verdict, 10 MUST + 5 NICE folded in).** Date: 2026-10-14.
> Changelog from v1 at the bottom (§14).

---

## 0. One-liner & name

**dronAIcharya** — *your AI guru: learn as you build.* Named for Dronacharya, the master teacher of the Mahabharata, + AI. A Claude-Code-native tool that takes a person from an idea (or none) to a deployed, production-grade product **while teaching everything under the hood** — LLMs, AI, MCP, development, vibecoding, solution architecture, system design, tradeoffs, decisioning, GitHub, deployment — and strongly steers them not to skip the understanding.

- Plugin name (manifest): `dronaicharya` · Display name: `dronAIcharya` · Commands: `/dronaicharya:<skill>`
- License: **MIT** · Repo: https://github.com/dibakshya01/dronAIcharya (empty; build from scratch)
- No telemetry. No network calls except the web/docs fetches a lesson explicitly performs. Learner's API key never leaves their machine.

---

## 1. Goals / Non-goals

**Goals**
1. **Teach AND build**, in one linear, guardrailed journey, to a production bar (not toy apps).
2. **Dual install** from a single pasted GitHub URL: the README *greets the human* and hands them copy-paste commands for two honest paths ("plugin" vs "skills repo") with pros/cons; Cursor path included with honest caveats.
3. **Four learning tracks**: Vibecoding · Learn Python · CS from Scratch (undergraduate foundations) · Cybersecurity & AI Security — each a real syllabus with lessons, build-tasks, MCQ checks, mastery.
4. **Teacher personas (archetypes)**: Vanilla · Serious & Strict · Warm & Witty · Dry & Deadpan — persona is flavor over an unchanging teaching-quality floor. No real-person or trademarked-character names in shipped text.
5. **Teaching mechanics**: explain → check understanding (MCQ/short-answer) → proceed; per-concept **skip / deep-dive / ELI5** toggles; a **cadence** control (Thorough / Balanced / Fast) so checks fire at decisions-of-consequence, not every micro-step; teach *before, during, and after* building; "under the hood" explanations (how the LLM/AI/MCP/deploy actually work).
6. **Production SDLC**, taught and practiced: spec-driven development, layered build (infra→data→backend→middleware→frontend→UI, tracer-bullet first), adversarial teaching-review, local testing, deployment prep, payments.
7. **Strong anti-drift guardrails** (hooks) that *nudge* the session to stay in teaching mode and on-plan across long sessions and compaction — explicitly a strong nudge, **not a guarantee**, and never able to override the learner's own "pause/skip/stop."
8. **Optional purple-sparrow MCP backend** — opt-in, advanced; detected → supercharges backend lessons with a real agent-native backend; absent (the default) → graceful fallback + guided setup behind an advanced wall.
9. **Hand-holding for absolute beginners**: getting & safely pasting AI API tokens, enabling web/MCP in the editor, basic GitHub — broken down as simply as needed, ELI5 on demand; honest about the parts outside the tool's control.
10. Ship it as a **spotless OSS project**: README deck, animated GitHub Pages site (a11y-checked), tests + `claude plugin eval`, adversarial hardening, honest handoff.

**Non-goals (v1)**
- Not a passive course/video platform; interactive and build-anchored.
- Not an autonomous "write my whole app" vibecoder — understanding is strongly steered (the point).
- Not a hosted SaaS; runs inside the user's Claude Code / Cursor.
- Does not enter real credentials, publish, pay, or deploy on the user's behalf — preps to the click.
- Does not guarantee Cursor feature-parity; **the anti-drift hooks likely do not run in Cursor** (see §7).
- English-only content in v1 (i18n is a stated future item).

---

## 2. Personas (teacher) — archetypes, with a teaching floor

Stored at `personas/*.md`, chosen at `start`, persisted in state, re-injected (as a short crumb) so it persists. **Every persona obeys the same floor:** teach before doing, require a learner decision at each decision-of-consequence, check understanding, offer ELI5/deep-dive/skip, explain under the hood, never belittle, never skip safety.

| Archetype | Voice | Guardrail note |
|---|---|---|
| **Vanilla** | Clear, friendly, neutral. The default. | Baseline. |
| **Serious & Strict** | Rigorous, demanding, no hand-waving; expects precision. | Firm, never harsh or discouraging. |
| **Warm & Witty** | Erudite, playful, generous analogies, delight. | Wit serves clarity, never replaces it. |
| **Dry & Deadpan** | Precise, understated, mock-exasperated affection; **opt-in with a one-line warning**. | Never mean; sarcasm never aimed at the learner's ability; auto-softens on struggle. |

Voices are **original registers**, not impersonations. No real person's name and no copyrighted/trademarked character appears in any shipped file. (Internal design note — the inspirations behind "Warm & Witty" and "Dry & Deadpan" are *not* shipped.)

---

## 3. Learner-facing journey (the linear flow)

```
0. GitHub README greets the human ─► copy-paste one install path (plugin | skills repo). Human runs it.
1. /dronaicharya:start ─► Guru intro (ELI5 of what this is & what will happen)
2. Pick PERSONA            (AskUserQuestion)
3. Pick CADENCE            Thorough | Balanced | Fast   (how often it stops to teach/check)
4. SETUP check             API token? editor web/MCP enabled?  ─► tokens / setup skills if needed
5. Pick TRACK + LEVEL      Vibecoding | Python | CS | Cyber&AI-Sec  ×  never-coded | some | confident
6. IDEA intake             bring your own, or pick a preloaded starter (simple-first recommended)
7. PLAN co-authoring       combined BUILD plan (SDLC milestones) + LEARN plan (concepts & checkpoints),
                           each topic tagged [teach | deep-dive available | skippable]  ─► approve/tweak
8. LINEAR EXECUTION        at each decision-of-consequence (cadence-tuned):  teach ─► MCQ check
                           ─► decide together (tradeoffs) ─► build layer (tracer-bullet first)
                           ─► explain under-the-hood ─► check ─► advance.  toggles: skip/deep-dive/ELI5
9. PRODUCTION PATH         architecture ▸ backend (purple-sparrow optional) ▸ payments ▸ GitHub ▸
                           deployment prep ▸ go-live up to the user's own clicks
10. POST-BUILD TEACHING    "under the hood" recap (LLM, AI, MCP, deploy) + mastery recap + next steps
```

Escape hatches honored at any time and **respected by the guardrails**: "pause", "stop teaching for now", "skip ahead", "just fix this quickly", "ELI5 that", "go deeper", "quiz me", "where am I?". `/dronaicharya:continue` resumes from saved state.

---

## 4. Component architecture

Single repo = plugin + its own marketplace. A clean source tree (`skills/`, `agents/`, `AGENTS.md`) doubles as the "skills repo" install and the Cursor path.

### 4.0 Invocation model (resolved per review §1d)
The journey is driven by **one orchestrator** (`start`, and its resumer `continue`), which contains the state-machine logic and **reads the other capabilities as reference/data files** (`reference/*`, `tracks/*`, `personas/*`). The other skills are also shipped as **genuinely user-invocable commands** (`/dronaicharya:quiz`, `:eli5`, `:deep-dive`, `:under-the-hood`, `:spec`, `:architect`, `:build-step`, `:backend`, `:payments`, `:deploy`, `:ship-github`, `:tokens`, `:setup`) so a learner can pull any of them on demand — but the linear flow does **not** depend on fragile skill-to-skill auto-chaining, and no step skill is marked `disable-model-invocation` in a way that would stall the flow. The orchestrator uses the `Skill` tool or inlines the reference logic.

```
dronAIcharya/                         (= plugin root = repo root)
├── .claude-plugin/
│   ├── plugin.json                   manifest (name dronaicharya; userConfig for optional purple-sparrow)
│   └── marketplace.json              self-marketplace (plugin source "./")
├── skills/
│   ├── start/ plan/ continue/ status/            flow/orchestration (start = the engine)
│   ├── teach/ eli5/ deep-dive/ quiz/ under-the-hood/   teaching mode (user-invocable too)
│   ├── spec/ architect/ build-step/ backend/ payments/ deploy/ ship-github/   build mode / SDLC
│   └── tokens/ setup/                            enablement
├── agents/
│   ├── socratic-examiner.md          fresh-memory MCQ *batch* author + grader (unbiased; not per-item)
│   ├── code-reviewer-teacher.md      reviews learner code as teaching points, doesn't rewrite
│   ├── spec-reviewer.md              reviews the learner's spec/plan (teaching review)
│   ├── architect-advisor.md          system-design/tradeoff deep analysis
│   ├── security-auditor.md           OWASP LLM/agentic + deny-by-default reviews
│   ├── content-accuracy-reviewer.md  verifies curricula are FACTUALLY correct (review §4/§10)
│   └── research-scout.md             fetches current docs/facts via web; output quarantined as data
├── hooks/
│   └── hooks.json                    SessionStart + UserPromptSubmit + Stop (state-gated, fail-open)
├── scripts/
│   ├── dron-common.sh                shared: locate state, is-active?, read flags (jq-optional)
│   ├── session-start.sh              inject FULL contract + persona + step (SessionStart only)
│   ├── prompt-crumb.sh               inject a SHORT status crumb (UserPromptSubmit)
│   ├── stop-check.sh                 nudge a check-for-understanding; respects pause/skip/stop state
│   └── sync-to-local.sh              skills-repo/Cursor install helper (copy into .claude/, ~/.claude/)
├── tracks/                           CURRICULA AS DATA (not skills — protects listing budget)
│   ├── vibecoding/     syllabus.md + modules/*.md + mcq/*.json     (FLAGSHIP — built & proven first)
│   ├── python/         syllabus.md + modules/*.md + mcq/*.json
│   ├── cs-from-scratch/ syllabus.md + modules/*.md + mcq/*.json
│   └── cyber-ai-security/ syllabus.md + modules/*.md + mcq/*.json
├── personas/           vanilla.md · strict.md · witty.md · deadpan.md
├── ideas/              starter-ideas.md  (preloaded per-track starters, simple-first)
├── reference/          teaching-contract.md · cadence.md · sdlc.md · state-schema.md ·
│                       injection-safety.md · under-the-hood/{llm,mcp,deploy}.md · owasp-ai.md
├── .mcp.json.example   purple-sparrow config template (NOT active — opt-in via setup; review §4.3)
├── AGENTS.md           shared instructions (Cursor + skills-repo installs read this)
├── CLAUDE.md           only: @AGENTS.md
├── README.md           human greeter + pitch + install chooser (plugin vs skills) + pros/cons
├── INSTALL.md          detailed install paths (plugin / skills repo / Cursor) with commands + caveats
├── tests/              validate manifest + hooks + mcq schema + state schema; eval/ for plugin eval
│   └── eval/           claude plugin eval cases (behavioral)
├── site/ · pitch/      animated GitHub Pages site + README deck + social card (Phase 4)
└── finding.md · build-plan.md · BUILD_LOG.md · HANDOFF.md · LICENSE · CONTRIBUTING.md ·
    SECURITY.md · CODE_OF_CONDUCT.md · .gitignore
```

### 4.1 State — split profile vs journey (review §1g, §11-NICE)
- **Per-project journey** → learner's project `.dronacharya/`: `learning-plan.md` (approved plan), `progress.json` (`{schemaVersion, persona, cadence, track, level, module, lessonIndex, buildMilestone, flags:{teachingMode,eli5Default,paused,purpleSparrow}}`), `journal.md` (decisions + rationale; **no secrets, gitignored**).
- **Global learner profile** → `${CLAUDE_PLUGIN_DATA}/profile.json`: `{schemaVersion, mastery:{concept:score0-1}, tracksTouched, lastPersona, lastCadence}` so mastery carries across projects.
- **`schemaVersion`** on both; a migration note in `reference/state-schema.md` so a schema bump never corrupts existing learners.
- **Recovery (review §1f):** if a journey was expected (profile says active) but `.dronacharya/` isn't found in cwd, the orchestrator says so plainly and offers to re-locate or re-init, rather than silently vanishing.

### 4.2 Guardrails — strong nudge, never a cage (review §1a-e, §3)
Defense in depth; **all hook scripts fail OPEN (always `exit 0`), emit nothing on the no-journey path, tolerate missing `jq`, and target <50ms**:
1. **`SessionStart` (startup|resume|compact)** → `session-start.sh`: only if teaching mode is on AND not paused, inject (as factual context) the **full** teaching contract + active persona + current track/step + that ELI5/deep-dive/skip/pause exist. Re-anchors after compaction.
2. **`UserPromptSubmit`** → `prompt-crumb.sh`: inject only a **short status crumb** (a few hundred chars: "teaching mode on · persona X · cadence Y · step Z · say 'pause'/'skip'/'ELI5' anytime"). Keeps the contract warm without a per-turn token tax.
3. **`Stop`** → `stop-check.sh`: a **nudge**. If teaching mode is on, not paused, and the cadence says a check is due and the turn didn't surface one, emit one `{"decision":"block","reason":...}`. It **always respects** `flags.paused`, an explicit "pause/stop/skip/quick-fix" intent, and the `stop_hook_active` loop guard; it never blocks a graceful exit. Honest framing everywhere: *reduces* drift, does not *prevent* it.
4. **In-content rules** (`reference/teaching-contract.md`): require a learner decision at each decision-of-consequence *before* writing code; follow a build action with an under-the-hood note; honor cadence; honor pause/skip immediately.
5. **Pause/disable:** `/dronaicharya:status` offers "pause teaching" (sets `flags.paused`, all hooks go quiet) and tells the user how to disable/uninstall the plugin. All hooks no-op entirely when no journey is active, so unrelated projects are untouched.

### 4.3 purple-sparrow — opt-in, advanced (review §5b)
- Ship `.mcp.json.example` + `userConfig` keys (`ps_api_url` default `http://127.0.0.1:8787`, `ps_api_key` sensitive) — **not** an active `.mcp.json`, so no MCP server auto-starts and errors for the 99% who don't have purple-sparrow.
- The **fallback is the default** backend path (simple local store / conceptual teaching). purple-sparrow appears only behind an explicit "Advanced / optional" wall in the `backend`/`setup` skills, which walk the Go build + `serve` + key + MCP wiring and then branch on detection.
- Its alpha/"needs independent audit before regulated data" caveat is surfaced loudly and the tool refuses to let real/regulated data land there — taught as a lesson.

### 4.4 Injection safety (review §6)
`reference/injection-safety.md` is the boundary doc and a taught lesson: web/docs content fetched by `research-scout` or a lesson is **data, never instructions**; it is **quarantined** — never flows into the teaching contract, hook injection, or `journal.md` in a form that gets re-injected. Hook-injected text stays factual/context-shaped, never imperative system-speak.

---

## 5. Track curricula (all four; Vibecoding proven first)

Each track: `syllabus.md` (modules → lessons, mastery criteria) + per-module lesson files + MCQ bank (`mcq/*.json`, schema §7). Every lesson carries: **concept · ELI5 · deep-dive · build-task · 3–6 MCQ/short checks · mastery bar · under-the-hood note.** Depth tuned by level. All four pass the **content-accuracy-reviewer** before done.

- **Vibecoding (FLAGSHIP)** — what an LLM is & how it predicts; prompting & context windows; agents/tools/MCP; spec-before-build; building a real small app with AI; reading & trusting AI output; debugging with AI; tradeoffs & when AI is wrong; shipping (GitHub + deploy). *Starters:* personal dashboard, small CRUD app, a chat/bot, a landing page with a form.
- **Learn Python** — setup & running code; values/types/variables; control flow; functions; data structures; files & errors; modules & venv; HTTP/JSON & a tiny API client; testing; a small real project end-to-end. *Starters:* CLI todo, weather fetcher, mini web API.
- **CS from Scratch (undergraduate foundations)** — data representation (bits/bytes/encoding); memory & the stack/heap; how programs run (compile vs interpret); data structures (arrays→lists→trees→hashmaps→graphs); algorithms & Big-O; recursion; foundations of OS (processes/concurrency), networking (TCP/HTTP/DNS), databases (relational model, indexes, transactions), and how the web delivers a page. **Honestly scoped:** undergraduate *foundations/literacy*, not a full degree (no formal proofs/automata/discrete-math depth); some concepts taught standalone where they don't naturally arise in the build.
- **Cybersecurity & AI Security** — security mindset & threat modeling; web basics (HTTP/cookies/sessions/TLS); OWASP Top 10; secrets & key hygiene; **AI-specific:** OWASP LLM/Agentic Top 10 (prompt injection, insecure output handling, excessive agency, data exfiltration), safe MCP/tool use, deny-by-default backends (taught live on purple-sparrow's policy engine + `run_advisor` when present), and dronAIcharya's own guardrails as a worked example.

Tracks are navigable (branch/detour) with state tracking.

---

## 6. Tech choices & rationale (deltas from review in *italics*)

| Choice | Why |
|---|---|
| Claude Code plugin (primary) + portable skills repo + Cursor | Matches pasted-URL UX; namespacing, hooks, MCP, auto-update. |
| Curricula as data files, not skills | Skill listing budget ~1% of context; fat syllabi as skills would crowd it. |
| *One orchestrator reading others as reference; other skills user-invocable but not relied on for auto-chaining* | *Skills are description-matched, not deterministic callers; a reliable linear flow needs a single driver.* |
| *Journey state per-project `.dronacharya/`; learner profile/mastery global `CLAUDE_PLUGIN_DATA`* | *Mastery must carry across projects; plan/journal are per-project.* |
| Guardrails via hooks, fail-open, crumb-not-contract per turn | Prose fades after compaction; hooks re-anchor; but injection must be cheap + safe + never cage the user. |
| Fresh-memory subagents, *batch* grading | Unbiased assessment/review; *per-item forks are a cost/latency trap.* |
| *purple-sparrow via `.mcp.json.example` + opt-in setup, fallback default* | *An always-on plugin MCP server errors for users without the binary; optional must mean non-breaking.* |
| Bash hooks (POSIX) + optional `jq` | Matches documented mechanics; `jq`-missing degrades, never breaks. |
| MIT license, no telemetry | Max adoption; privacy posture for an OSS teaching tool. |

---

## 7. Cursor portability — honest up front (review §7)
Cursor reads `.claude/skills/`, `~/.claude/skills/`, `.claude/agents/`, and (with third-party configs on) `.claude/settings.json` hooks — but uses different manifest/hook dialects and ignores Claude-only skill fields. **The anti-drift guardrail hooks — the #1 differentiator — may not run in Cursor**, so Cursor gets skills + agents (a useful tutor) but **teaching-mode persistence and the Stop nudge are best-effort or absent** → a materially lighter, more drift-prone experience. This sentence appears wherever "Cursor" is mentioned in shipped docs. `sync-to-local.sh` is provided for the skills-repo/Cursor path with this caveat.

## 8. Cost / token budget (review §9)
A teaching tool must not silently multiply a beginner's usage. Measures: UserPromptSubmit injects only a short crumb (not the full contract); full contract only on SessionStart; subagents spawned sparingly and grade MCQs in **batch**; curricula loaded on demand, not all at once; cadence "Fast" minimizes check frequency. `reference/` documents the rough per-turn overhead so it's inspectable.

## 9. Milestones (build sequence — engine proven on flagship track first)
> Built autonomously end-to-end (user's chosen cadence). Status line per milestone; `BUILD_LOG.md` throughout.

- **M0 — Scaffold & tracer bullet.** Tree, `plugin.json` + `marketplace.json`, `teaching-contract.md`, `LICENSE`, `.gitignore`; `claude plugin validate --strict` green; a thin end-to-end slice runs.
- **M1 — Guardrail engine.** `hooks.json` + `dron-common.sh`/`session-start.sh`/`prompt-crumb.sh`/`stop-check.sh`, fail-open + gated + jq-optional + pause-aware; state read/write (both stores) + `state-schema.md`.
- **M2 — Orchestrator & flow.** `start` (state machine), `plan`, `continue`, `status` (incl. pause/disable), AskUserQuestion menus (persona, cadence, track, level), recovery path.
- **M3 — Teaching mode + examiner, PROVEN ON VIBECODING END-TO-END.** `teach`, `eli5`, `deep-dive`, `quiz`, `under-the-hood`; `socratic-examiner` (batch); MCQ + state schemas; **Vibecoding track fully built** and walked start→finish as the proof the whole thesis works.
- **M4 — Build mode / SDLC.** `spec`, `architect`, `build-step`, `ship-github`, `deploy`, `payments` + `code-reviewer-teacher`, `spec-reviewer`, `architect-advisor`.
- **M5 — Backend + enablement.** `backend` (purple-sparrow opt-in/fallback), `setup`, `tokens`, `.mcp.json.example`, `security-auditor` + `research-scout`, `injection-safety.md`, `under-the-hood/*`, `owasp-ai.md` (refreshed vs web).
- **M6 — Remaining 3 tracks against the proven schema.** Python, CS-foundations, Cyber&AI-Sec syllabi + lessons + MCQ banks + starters. (Parallel minions, one per track.)
- **M6.5 — Content-accuracy pass.** `content-accuracy-reviewer` over all four tracks; fix factual errors.
- **M7 — Greeter & install.** `README.md` (human greeter + pitch + pros/cons + commands), `INSTALL.md`, `AGENTS.md`, `CLAUDE.md`, `sync-to-local.sh`, `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`.
- **M8 — Tests + eval.** Manifest/hook/schema validation; **required test: hooks no-op cleanly & fast in an unrelated project**; injected-crumb size cap test; Stop-hook no-false-block test; jq-missing degradation test; `claude plugin eval` behavioral cases. Manual journey walkthrough labeled as manual verification, not CI.
- **M9 — Site + deck (Phase 4).** master-designer system → animated multi-page GitHub Pages site (Home, ELI5-for-non-technical, Docs, Architecture, Contact) + README deck + social card + demo GIF; a11y (contrast/keyboard/alt) + `prefers-reduced-motion` verified. Floor = one strong page + README deck if time-pressed.
- **M10 — Adversarial hardening ×3+ (Phase 5).** adversarial-code-review; fix; re-verify; attack-tests; log each round.
- **M11 — Handoff (Phase 7).** `HANDOFF.md` + numbered user-only clicks (create/push repo, enable Pages, optional Anthropic plugin-directory submission, announce).

Exit per milestone: its piece runs/validates; `BUILD_LOG.md` updated. Bounded loops; escalate on no-progress.

## 10. Test strategy (review §8 — honest about what's testable)
- **Static:** `claude plugin validate ./ --strict`; all frontmatter parses; `CLAUDE.md` is only `@AGENTS.md`.
- **Schema:** `progress.json`, `profile.json`, every `mcq/*.json` validate against JSON Schemas.
- **Hooks (deterministic, required):** scripts with sample stdin per event; **no-op + fast in an unrelated project**; teaching-mode gating on/off; pause respected; Stop loop-guard + no false-block on a normal turn; `jq`-missing degradation; injected-crumb under size cap.
- **Behavioral:** `claude plugin eval` cases (with/without plugin). The full LLM-driven journey is **manual verification**, labeled as such — not claimed as CI.
- **Claims:** every README/site claim reproducible from a clean checkout via `--plugin-dir`.

## 11. Honest "can & cannot do"
**Can:** install as plugin or skills repo (and run in Cursor, with degraded guardrails); run a guardrail-nudged, persona-driven, multi-track, cadence-tuned teach-and-build journey with MCQ checks, ELI5/deep-dive/skip, persistent per-project journey + global mastery, production SDLC, optional real backend, and prep for payments/GitHub/deploy. **Cannot (by design):** enter real credentials, publish, pay, buy domains, submit to stores, or deploy on your behalf. **Cannot guarantee:** that drift never happens (it's a strong nudge), Cursor parity (hooks may not run there), or that purple-sparrow (alpha) is production-safe for regulated data. **Depends on:** a recent Claude Code with plugin support; web/MCP enabled for live-doc lessons.

## 12. Definition of done
`finding.md`, `build-plan.md`, working plugin (skills+agents+hooks+MCP example+4 curricula), dual install + Cursor path, tests + eval green, `BUILD_LOG.md`, live-verified a11y animated site + README deck (reduced-motion verified), content-accuracy pass on all tracks, ≥3 adversarial hardening rounds logged, honest `HANDOFF.md`. GitHub Marketplace note: a teaching **plugin is not a GitHub Action/App**, so Marketplace listing is **skipped**; distribution is the Claude Code plugin flow + optional Anthropic plugin directory (on the handoff).

## 13. Honesty ledger (claims we will NOT make)
- Not "the session never drifts" → "strongly nudges against drift."
- Not "a CS degree" → "undergraduate CS foundations."
- Not "mastery proves understanding" → "formative self-checks."
- Not "works identically in Cursor" → "Cursor is lighter; guardrail hooks may not run."
- Not "frictionless for everyone" → honest about token setup and the parts outside our control.

## 14. Changelog v1 → v2 (from ExpertSpecReviewer, verdict REVISE)
Folded in all 10 [MUST]: (1) drift reframed to nudge + Stop respects pause/skip/quick-fix; (2) engine proven on Vibecoding before other 3 tracks, CS relabeled "foundations"; (3) personas → archetypes, no real-person/character names; (4) human-run install, no agent self-install from web; (5) crumb-not-contract per turn + token cap/test; (6) hooks fail-open/gated/jq-optional/<50ms + unrelated-project test; (7) single-orchestrator invocation model; (8) Cursor-degraded stated up front; (9) purple-sparrow opt-in/advanced, fallback default; (10) content-accuracy review pass. And 5 [NICE]: schemaVersion+migration & profile/journey split; web-content quarantine; cost/budget section + `claude plugin eval`; cadence/pacing control; site a11y + no-telemetry + i18n stance + batch grading.
