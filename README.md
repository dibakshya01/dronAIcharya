<div align="center">

# 🏹 dronAIcharya

### Your AI guru — *learn as you build.*

**dronAIcharya turns Claude Code (or Cursor) into a patient master-teacher that builds real, production-grade software *with* you — and makes sure you actually understand what you built.**

LLMs · AI · MCP · development · vibecoding · architecture · system design · tradeoffs · GitHub · deployment — taught *before, during, and after* you build, with knowledge checks so it sticks.

[Install](#-install-pick-one) · [What you'll learn](#-four-tracks) · [How it works](#-how-it-works) · [Honest limits](#-honest-about-what-it-is-and-isnt)

</div>

---

## 🤔 Why this exists

Today you can either **learn** (tutorials that stop at toy apps) **or** **build** (AI that ships code you don't understand). dronAIcharya refuses that trade. It's a guru that teaches you *and* builds something real with you — from "what's an API key?" to a deployed, payment-capable, backend-backed app — and it won't quietly stop teaching and just do it for you. That last part is the hard part, and it's the point.

- 🎭 **Pick your teacher.** Four persona archetypes: **Vanilla**, **Serious & Strict**, **Warm & Witty**, **Dry & Deadpan**.
- 🛤️ **Pick your path.** Four tracks: **Vibecoding**, **Learn Python**, **CS from Scratch**, **Cybersecurity & AI Security**.
- 🧠 **Prove you got it.** MCQ and in-your-own-words checks; ELI5 or go-deeper on anything, anytime.
- 🏗️ **Build for real.** Spec-driven, layer-by-layer, production-minded — with payments, GitHub, deploy, and an optional real backend.
- 🛡️ **Stay on track.** Guardrails that keep the session *teaching*, even across long sessions — without ever overriding your "pause / skip / just do it."

---

## 🚀 Install (pick one)

> **Pasting this repo's link into Claude Code?** Claude will read this page and offer you the two choices below. You run the one you pick — dronAIcharya never auto-installs itself or runs commands it found on a web page (that would be unsafe, and lesson #1 of the security track is *why*).

### Option A — Install as a **plugin** *(recommended)*
The full experience: skills + teaching subagents + the anti-drift guardrail hooks + the optional MCP backend, one command, clean updates and uninstall.

```bash
/plugin marketplace add dibakshya01/dronAIcharya
/plugin install dronaicharya@dronaicharya
```
Then start:
```bash
/dronaicharya:start
```

| 👍 Pros | 👎 Cons |
|---|---|
| One-command install; namespaced `/dronaicharya:*` commands | Needs a recent Claude Code (plugin support) |
| **Guardrail hooks run** (teaching mode persists across long sessions & compaction) | Project-scope installs prompt to approve any MCP server |
| Optional purple-sparrow MCP backend wires in cleanly | |
| Clean update (`claude plugin update`) and uninstall | |

### Option B — Install as a **skills repo**
Clone it and use the skills directly. Transparent (you can read every file), hackable, works on older setups and in Cursor.

```bash
git clone https://github.com/dibakshya01/dronAIcharya
# then either run Claude Code pointed at it:
claude --plugin-dir ./dronAIcharya
# …or copy the skills/agents into your user config (see INSTALL.md), then: /start
```

| 👍 Pros | 👎 Cons |
|---|---|
| Fully transparent — read and tweak every skill | Manual updates (`git pull`) |
| Works on older Claude Code; portable to Cursor | **Guardrail hooks may not run** → teaching-mode persistence is best-effort (the `start`/`continue` skills still carry the contract) |
| No marketplace needed | No command namespacing |

**Not sure?** Pick **A** for the smoothest, guardrailed experience; pick **B** if you want to read/modify the internals or you're on Cursor. Full details, including Cursor, in **[INSTALL.md](INSTALL.md)**.

> 🧩 **Cursor:** Cursor reads `.claude/skills` and `AGENTS.md`, so the tutor works — but Claude Code's guardrail **hooks don't run in Cursor**, so anti-drift is lighter there. See [INSTALL.md](INSTALL.md).

---

## 🎓 How it works

```
Paste the repo link ─► pick an install path above ─► /dronaicharya:start
  → pick a persona  → pick a cadence (how often it stops to teach)
  → quick setup check (API key? web/MCP enabled?)   → pick a track + your level
  → bring an idea (or pick a starter)   → co-author a BUILD + LEARN plan you approve
  → go, step by step:  teach ▶ check ▶ decide together ▶ build ▶ show under the hood ▶ check ▶ next
  → production: architecture ▸ backend ▸ payments ▸ GitHub ▸ deploy (up to your own clicks)
  → finish: an "under the hood" recap + a mastery review + what to learn next
```

At **any** point you can say: **ELI5 that · go deeper · skip · quiz me · where am I? · pause**. Your progress lives in `./.dronacharya/` so `/dronaicharya:continue` always picks up where you left off.

---

## 🛤️ Four tracks

| Track | You'll build & understand |
|---|---|
| **Vibecoding** | What LLMs/agents/MCP really are, prompting & context, spec-before-build, then ship a small real app — and know how the AI wrote it and when to trust it. *Gentlest start.* |
| **Learn Python** | From "run your first line" to a small real project: types, control flow, functions, data structures, files, HTTP/JSON, testing. |
| **CS from Scratch** | Undergraduate *foundations*: bits & memory, how programs run, data structures, Big-O, recursion, OS/networking/DB basics, how the web works. (Foundations, honestly — not a full degree.) |
| **Cybersecurity & AI Security** | The security mindset, OWASP Top 10, secrets hygiene, and **AI security** (prompt injection, excessive agency, safe MCP, deny-by-default) — taught on your own app. |

---

## 🔌 Optional: a real backend (purple-sparrow)

dronAIcharya works fully on its own. If you want to learn backend work against a *real* agent-native backend instead of mock data, it can connect to **[purple-sparrow](https://github.com/dibakshya01/purple-sparrow)** over MCP — real tables, auth, deny-by-default row policies, and a security advisor you fix live. It's **opt-in and advanced** (the `setup` skill walks you through it), and dronAIcharya is honest that purple-sparrow is alpha and shouldn't hold real/regulated data yet.

---

## 🧭 Honest about what it is (and isn't)

- It **reduces** teaching drift with guardrails — it doesn't magically *guarantee* it, and it will always obey your "pause/skip/just do it."
- Mastery checks are **formative self-checks**, not certificates.
- The CS track is **undergraduate foundations**, not a degree.
- It **never** enters your real credentials, pays, buys domains, publishes, or deploys for you — it preps everything up to *your* click.
- **No telemetry.** Your API key stays on your machine; dronAIcharya never sees or transmits it.
- In Cursor, the guardrail hooks may not run (lighter experience).

---

## 📚 More
- **[INSTALL.md](INSTALL.md)** — plugin / skills-repo / Cursor, step by step
- **[CONTRIBUTING.md](CONTRIBUTING.md)** · **[SECURITY.md](SECURITY.md)** · **[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)**
- **[build-plan.md](build-plan.md)** / **[finding.md](finding.md)** — how and why it's built this way

## 📄 License
MIT © 2026 dibakshya01 — see [LICENSE](LICENSE).

<div align="center"><sub>Built to teach. If it ever stops teaching and starts just doing — say "teach me", and it will.</sub></div>
