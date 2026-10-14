# BUILD_LOG.md — dronAIcharya

Running log of what was built, verified, and decided. Newest at the bottom.

---

## 2026-10-14

**Research & plan**
- Two research subagents: Claude Code plugin mechanics (verified vs code.claude.com) + recon on purple-sparrow/dronAIcharya/prior-art. Synthesized into `finding.md`.
- Wrote `build-plan.md` (v1). Fresh ExpertSpecReviewer returned **REVISE** with 10 MUST + 5 NICE findings.
- Revised to `build-plan.md` v2, folding in all findings (drift→nudge, archetype personas, human-run install, engine-proven-on-Vibecoding-first, crumb-not-contract injection, fail-open hooks, single-orchestrator model, Cursor-degraded honesty, purple-sparrow opt-in, content-accuracy pass, + NICE items). User approved the plan ("go") and chose: build all four tracks to the finish line; purple-sparrow optional; plan-gate then autonomous.

**M0 — Scaffold & tracer bullet**
- Created full directory tree; `git init`.
- Verified tooling: `claude` 2.1.233 present; `jq` present at /usr/bin/jq.
- Wrote: `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json` (single-repo = plugin + marketplace, source "./"), `LICENSE` (MIT), `.gitignore` (ignores `.dronacharya/`, secrets), `reference/teaching-contract.md` (the teaching floor), tracer `skills/start/SKILL.md`.
- `claude plugin validate --strict` ✔ green.

**M1 — Guardrail engine** ✔
- `hooks/hooks.json` (SessionStart|resume|compact, UserPromptSubmit, Stop) + `scripts/dron-common.sh`, `session-start.sh` (full contract), `prompt-crumb.sh` (short crumb), `stop-check.sh` (conservative nudge). Fail-open, state-gated, jq-optional, pause/stopNudge/loop-guard aware.
- `reference/state-schema.md` (per-project journey + global profile, schemaVersion, recovery), `injection-safety.md`, `cadence.md`.
- Fixed a real bug: jq `// empty` collapses boolean `false` → `stopNudge:false` wasn't detected. `tests/test-hooks.sh`: **17/17 pass** (no-op in unrelated project, no false-blocks, jq-less degradation, ~26ms).

**M2 — Orchestrator & flow** ✔ — `start` (full state machine), `continue` (resume + recovery + migration), `status` (pause/disable controls), `plan` (combined BUILD+LEARN plan, in-tool plan gate). Personas `vanilla/strict/witty/deadpan` + `reference/sdlc.md`.

**M3 — Teaching mode** ✔ — `teach`, `eli5`, `deep-dive`, `quiz`, `under-the-hood` + `socratic-examiner` agent + `tests/mcq.schema.json`. Flagship **Vibecoding** track m1–m3 (modules + MCQ banks) written by hand; m4–m9 by a content minion (validated).

**M4 — Build mode / SDLC** ✔ — `spec`, `architect`, `build-step`, `ship-github`, `deploy`, `payments` + agents `code-reviewer-teacher`, `spec-reviewer`, `architect-advisor`.

**M5 — Backend + enablement** ✔ — `backend` (purple-sparrow detect/fallback), `setup`, `tokens` + agents `security-auditor`, `research-scout`, `content-accuracy-reviewer`. `reference/under-the-hood/{llm,mcp,deploy}.md`, `owasp-ai.md`, `.mcp.json.example`, `ideas/starter-ideas.md`.

**M6 — Tracks** (in progress) — Vibecoding ✔ (9 modules/9 banks), Python ✔ (10/10, verified runnable), CS-from-scratch + Cyber-AI-security landing via minions.

**M7 — Greeter & install** ✔ — `README.md` (human greeter + pitch + install chooser w/ pros-cons), `INSTALL.md`, `AGENTS.md` (no root CLAUDE.md, to keep `--strict` clean), `SECURITY.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `scripts/sync-to-local.sh`.

**M8 — Tests** ✔ — `tests/run-all.sh`, `tests/validate-content.sh` (python stdlib; 18 skills/7 agents/39 banks/192 items green, + golden-answer lock + min-count guards), `evals/` (behavioral cases + graders for `claude plugin eval`), `LOCAL_TEST.md` (manual walkthrough, honestly labeled).
**M6 — Tracks** ✔ — all four complete: Vibecoding (9 modules), Python (10), CS-from-scratch (10), Cybersecurity & AI Security (10). **39 MCQ banks / 192 items.** OWASP Web + LLM 2025 lists verified current against official sources.

**M6.5 — Content-accuracy pass** ✔ — four parallel fresh fact-checkers (one per track). Result: **0 blockers across all four.** Fixes applied: (1) Python m7 — `except Exception:` doesn't catch Ctrl-C/SystemExit (only bare `except:`); (2) CS m3 — Python-JIT overclaim scoped to CPython-interprets/PyPy/experimental; (3) Cyber m1 — "Insecure Design" dated to its 2021 introduction. Also fixed a systemic **MCQ answer-position bias** (minion banks were 37–47/… clustered at option B): deterministic reshuffle of 161 items, answer *text* preserved (integrity-asserted), new spread {0:57,1:5,2:47,3:52}. Re-validated: strict validate ✔, 17/17 hooks ✔, 192 items ✔.

**M7 — Greeter & install** ✔ (see above). **M8 — Tests** ✔.
**M9 — Site** ✔ — animated, a11y GitHub-Pages site in `docs/` (5 pages: Home/ELI5/Docs/Architecture/Contact), "Taking Aim" archery concept, via master-designer. Verified in-browser (light+dark, reveals, theme toggle, install commands); IntersectionObserver reveals + noscript + reduced-motion fallbacks; only Google Fonts loaded externally; all internal links resolve.

**M10 — Adversarial hardening**
- **Round 1** (fresh red-teamer): CRITICAL 0 · HIGH 1 · MED 2 · LOW 3. HIGH = hooks injected `persona`/`track`/`cadence` from progress.json *verbatim* → indirect prompt-injection + token-tax channel (a poisoned shared-repo `.dronacharya/progress.json` could smuggle instruction-shaped text into every turn). **Fixed:** added `dron_enum` whitelist — hooks now inject only known short constants, else a safe default. Also fixed: MED2 length-tax (same fix bounds it), MED3 Stop-nudge overclaim (raised threshold 600→1200, corrected docs/architecture.html + script comments to not claim the hook reads per-turn quick-fix), LOW typo "interruraces" (shipped into context), LOW finding.md wording softened, injection-safety.md documents the whitelist. Added 5 adversarial hook tests (poisoned-field not injected, oversized bounded, malformed never activates). **22/22 hook tests ✔, strict validate ✔, content ✔.** Things Round 1 could NOT break: install flow, manifest, secrets handling, curriculum safety, site.
- **Round 2** (fresh red-teamer): verified the Round-1 injection fix is **SOLID and not bypassable** (tried array/number/object/dup-key/leading-space/5MB/jq-less vectors — all fall back to safe defaults). CRITICAL 0 · HIGH 0 · MED 2 · LOW 4. **Fixed:** M1 content test only range-checked answers → added a **golden-answer lock** (`tests/mcq-answers.golden.json`, 161 verified answers; validator now asserts `options[answer]` matches); M2 reshuffle had over-corrected ({0:57,1:5,2:47,3:52}, "never B" exploitable) → **de-biased reshuffle** to {0:56,1:35,2:26,3:44} (no exploitable pattern) and the `quiz` skill now shuffles options at presentation time so stored order is irrelevant; L1 validator could pass vacuously → added min-count guards; L2 hook read unbounded → cap reads at 64KB; L3 stale BUILD_LOG counts fixed. L4 "production-grade" deliberately kept (user's explicit positioning; capability backed by real skills). **22/22 hooks ✔, strict validate ✔, content+golden ✔.**
- **Round 3** (fresh red-teamer, final): proved the golden lock catches corruption (flip/reshuffle-stale/text-edit all caught; legit reshuffle passes), proved the 64KB cap never breaks valid files, couldn't bypass the injection whitelist or make hooks misfire in a non-journey project. CRITICAL 0 · HIGH 0 · MEDIUM 0 · LOW 3 · INFO 3. **Verdict: launch-ready, YES.** Applied the polish: F1 hooks.json had no coverage → `validate-content.sh` now parses it + checks referenced scripts exist/are executable (proven to catch a malformed copy); F2 relabeled "uniform"→"de-biased" + `quiz` skill now shuffles options at presentation time (stored order irrelevant); F3 `sync-to-local.sh` warns before clobbering same-named skills; F4 site "No telemetry" card clarified (plugin sends none; the site itself loads Google Fonts). INFO: F5 (the Dronacharya namesake is double-edged — surfaced to the user), F6 (purple-sparrow repo confirmed public by recon). **Final: strict validate ✔ · 22/22 hooks ✔ · content+golden+hooks.json ✔.**

**M11 — Handoff** ✔ — `HANDOFF.md` finalized with the numbered user-only clicks. Definition of done met: finding.md, build-plan.md (spec-reviewed), working plugin (18 skills, 7 agents, 3 guardrail hooks, MCP example, 4 full tracks / 39 banks / 192 items), dual install + Cursor path, tests + golden lock + evals, animated a11y site, BUILD_LOG, 3 adversarial rounds logged, honest HANDOFF.
