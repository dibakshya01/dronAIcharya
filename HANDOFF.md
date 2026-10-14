# HANDOFF — dronAIcharya

*This is the single list of things only you can do. Everything up to these clicks is done.*

## What was built
A complete, launch-ready Claude Code plugin: a guided *teach-and-build* guru with 4 personas, 4 full tracks (Vibecoding, Python, CS foundations, Cybersecurity & AI Security), MCQ knowledge checks, ELI5/deep-dive/skip toggles, a spec-driven production SDLC, anti-drift guardrail hooks, an optional purple-sparrow MCP backend, dual install (plugin / skills repo / Cursor), an animated GitHub Pages site, tests, and behavioral evals.

- **Code & docs:** everything in this repo (`skills/`, `agents/`, `hooks/`, `scripts/`, `tracks/`, `personas/`, `reference/`, `tests/`, `evals/`, `docs/` site, README/INSTALL/SECURITY/CONTRIBUTING/CODE_OF_CONDUCT).
- **Build record:** `finding.md`, `build-plan.md` (v2, spec-reviewed), `BUILD_LOG.md`.

## Quality gates passed
- `claude plugin validate --strict` ✔
- Guardrail hook safety: 17/17 ✔ (no-op in unrelated projects, no false-blocks, jq-less, fast)
- Content validation: all skills/agents frontmatter + 39 MCQ banks / 192 items ✔
- Spec reviewed by a fresh ExpertSpecReviewer (REVISE → all 10 MUST folded in)
- Content fact-checked per track (0 blockers) · Adversarially hardened ×3 (Round 1 fixed a prompt-injection hole; Rounds 2–3 clean; verdict: launch-ready)

## ✅ The clicks only you can do (numbered)

0. **Move this work into a real folder you keep.** Everything currently lives in a temporary folder this session made; to push it anywhere it first needs a permanent home. Tell me where (or let me open a folder picker) and I'll move it, then stage the commit.

1. **Create & push the repo.** The repo https://github.com/dibakshya01/dronAIcharya is empty. Once the work is in a real folder:
   ```bash
   git add -A && git commit -m "dronAIcharya v0.1.0"
   git branch -M main
   git remote add origin https://github.com/dibakshya01/dronAIcharya.git
   git push -u origin main
   ```
   *(Pushing is outward-facing — I can stage the commit for you, but the push is yours to run.)*

2. **Enable the website (GitHub Pages).** Repo → Settings → Pages → Source: *Deploy from a branch* → Branch `main`, folder `/docs` → Save. Your site goes live at `https://dibakshya01.github.io/dronAIcharya/` in ~1 minute.

3. **Test the real install** (confidence check), in any Claude Code session:
   ```
   /plugin marketplace add dibakshya01/dronAIcharya
   /plugin install dronaicharya@dronaicharya
   /dronaicharya:start
   ```

4. **(Optional) List it in the Anthropic plugin directory.** Requires a paid claude.ai plan; submit at claude.ai/directory/manage. *(GitHub Marketplace is NOT applicable — it only lists Actions/Apps, not teaching plugins.)*

5. **(Optional) Announce it.** A launch post (HN/Reddit/X/LinkedIn) — I can draft copy on request. Posting is yours to click.

6. **(Optional) Wire the purple-sparrow backend** if you want the backend track to run against the real thing — see `.mcp.json.example` and the `setup` skill.

## Heads-up before you post it publicly
- **The name.** "dronAIcharya" reads as the honorific "master teacher" (as in India's Dronacharya Award) — but in the Mahabharata, Dronacharya is also remembered for *withholding* knowledge (the Eklavya story). A sharp commenter on HN/Reddit may raise this. You clearly intend the honorific sense; just be ready for it, or add a one-line note on the site about the name if you'd like (I can draft it).
- **purple-sparrow** is referenced as the optional backend; its repo is public (verified), so the optional steps won't dead-end.

## Known honest limits (say these plainly if asked)
Guardrails are a strong nudge, not a guarantee; mastery checks are formative; CS track is undergraduate foundations; Cursor runs a lighter experience (hooks may not run); purple-sparrow is alpha (no real/regulated data). Full list in README "Honest about what it is."
