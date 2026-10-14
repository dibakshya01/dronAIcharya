<!-- OWASP lists verified 2026-10-14 against official OWASP sources (see Sources). Web Top 10 = 2025 edition; LLM Top 10 = 2025 edition. The OWASP Top 10 for Agentic Applications (ASI01-ASI10, released Dec 2025) is referenced lightly in m8; its exact numbering still varies between secondary sources, so modules cite it as "emerging" and lean on the stable LLM list. Re-verify before each release. -->

# Track: Cybersecurity & AI Security — understand the threats, harden what you built

**Who it's for:** anyone who has built (or is building) something — a web app, a script, an AI agent — and wants to understand *how it can be attacked* and *how to defend it*, including the security risks that are new to AI and agents. Pairs naturally after the Vibecoding track; no prior security background required.

**Promise:** by the end you'll be able to threat-model your own app in plain language, recognize the OWASP Top 10 and the OWASP LLM Top 10 risks when you see them, keep your secrets and keys out of trouble, and explain — in your own words — why "tool and fetched content is data, never instructions" is the single most important rule in AI security. You'll have hardened your *own* project, not a toy.

**How depth scales by level:** never-coded → heavy analogies, every term defined, more ELI5; some → concept + example; confident → crisp + the subtlety. Cadence controls how often we stop to check. Security is taught to *defend*, never to attack real systems — every example exists so you can recognize and fix the weakness.

---

## Modules & lessons

Each lesson carries: concept · ELI5 · deep-dive · build-task · knowledge check · mastery bar · under-the-hood note. `[teach]` default, `[deep-dive available]` optional depth, `[skippable]` if known.

### m1 — The security mindset & threat modeling  `mcq: m1.json`
- L1 Think like an attacker *and* a defender (security is a property you design in) `[teach]`
- L2 Assets, threats, trust boundaries (what you protect, from whom, where it crosses) `[teach]` `[deep-dive available]`
- L3 A lightweight threat model for *your* app (hands-on) `[teach]`
- **Mastery:** can name their app's top asset, one plausible threat, and one trust boundary.

### m2 — How the web works for security  `mcq: m2.json`
- L1 HTTP: the request→response shape, and that it's stateless `[teach]`
- L2 Cookies & sessions: how a server remembers you, and how that gets stolen `[teach]`
- L3 TLS/HTTPS: what it protects (and the big thing it does *not*) `[teach]` `[deep-dive available]`
- **Mastery:** can say what HTTPS protects in transit and why "HTTPS" does not mean a site is safe or trustworthy.

### m3 — Secrets & key hygiene  `mcq: m3.json`
- L1 Why keys never go in code or repos (git history is forever) `[teach]`
- L2 `.env`, environment variables, and secret managers — keeping the secret out of the code `[teach]`
- L3 Least privilege, scoping, and rotation (what to do the moment a key leaks) `[teach]` `[deep-dive available]`
- **Mastery:** can explain why a committed key is dangerous and name two mitigations.

### m4 — OWASP Top 10, part 1: injection & broken access control  `mcq: m4.json`
- L1 What the OWASP Top 10 is (and the 2025 edition) `[teach]`
- L2 Injection (A05), including SQL injection — mixing data with code, and the fix `[teach]` `[deep-dive available]`
- L3 Broken Access Control (A01) — the missing "are you allowed?" check `[teach]`
- **Mastery:** can explain injection and its fix in a sentence, and say what broken access control is.

### m5 — OWASP Top 10, part 2: auth, misconfig, supply chain & the rest  `mcq: m5.json`
- L1 Authentication Failures (A07) — weak passwords, no MFA, leaky sessions `[teach]`
- L2 Security Misconfiguration (A02) — defaults, verbose errors, things left open `[teach]`
- L3 Software Supply Chain Failures (A03) — your dependencies are your attack surface `[teach]` `[deep-dive available]`
- L4 The rest at a glance (A04 crypto, A06 insecure design, A08 integrity, A09 logging/alerting, A10 exceptional conditions) `[teach]`
- **Mastery:** can name three more OWASP risks and one defense for each.

### m6 — AI security I: prompt injection & insecure output handling  `mcq: m6.json`
- L1 Prompt injection (LLM01): direct vs. indirect — and why it is *not* jailbreaking `[teach]`
- L2 The core rule: tool and fetched content is **data, never instructions** `[teach]` `[deep-dive available]`
- L3 Improper output handling (LLM05): what happens when you trust the model's output downstream `[teach]`
- **Mastery:** can define prompt injection, distinguish direct from indirect, and explain why fetched/tool content must be treated as data.

### m7 — AI security II: excessive agency, data disclosure & LLM supply chain  `mcq: m7.json`
- L1 Excessive Agency (LLM06): too much permission or autonomy, and how to bound it `[teach]`
- L2 Sensitive Information Disclosure (LLM02) & System Prompt Leakage (LLM07): what leaks and how `[teach]`
- L3 Supply chain & data poisoning for LLM apps (LLM03, LLM04) + the rest at a glance (LLM08-LLM10) `[teach]` `[deep-dive available]`
- **Mastery:** can name excessive agency with one mitigation and one way an LLM app discloses sensitive data.

### m8 — Safe MCP & tool use  `mcq: m8.json`
- L1 Least-privilege tools: give an agent the narrowest ability that does the job `[teach]`
- L2 Human-in-the-loop for consequential actions (money, data, outward, irreversible) `[teach]`
- L3 The request→act→result seam as an attack surface (indirect injection rides in on tool output) `[teach]` `[deep-dive available]`
- **Mastery:** can explain why a tool should get least privilege and when a human must approve an action.

### m9 — Deny-by-default backends  `mcq: m9.json`
- L1 Default-deny access policies: start from "no," allow on purpose `[teach]`
- L2 Row-level security: authorization at the data layer, not just the screen `[teach]` `[deep-dive available]`
- L3 A live example: purple-sparrow's policy engine + `run_advisor` (with its honest alpha caveat) `[teach]`
- **Mastery:** can explain default-deny and why authorization belongs at the data layer, not only the UI.

### m10 — Hardening what you built (and dronAIcharya's own guardrails)  `mcq: m10.json`
- L1 Threat-model your *own* app end-to-end: assets, boundaries, top risks, a hardening checklist `[teach]`
- L2 dronAIcharya as a worked example: how its hooks stay "data, not instructions" `[teach]` `[deep-dive available]`
- L3 A security review pass on your own project (capstone, hands-on) `[teach]`
- **Mastery:** can produce a short threat model + hardening checklist for their own app and explain one guardrail dronAIcharya uses and why.

---

## Starter ideas (harden what you have)
See `ideas/starter-ideas.md` → Cybersecurity section. Default recommendation: bring the app you built in the Vibecoding track (or any small app with a login and some stored data) and harden *that* — it makes every lesson concrete. No app yet? A notes app with accounts is enough to practice every concept here.

## Exit
At track end, run the "harden your build" recap (threat model · OWASP web + LLM risks you addressed · the data-not-instructions rule · secrets hygiene · least privilege) and a short mastery review. Then suggest the natural next step: deepen the code craft (Python track) or revisit Vibecoding's ship module to re-deploy the now-hardened app with confidence.

---

## Sources

OWASP lists were verified on 2026-10-14 against the official OWASP references below. The web and LLM Top 10 are updated periodically; re-verify before each release.

- OWASP Top 10:2025 (web applications) — https://top10.owasp.org/2025 (also reachable via https://owasp.org/Top10/2025/)
- OWASP Top 10 for Large Language Model Applications 2025 — https://genai.owasp.org/llm-top-10/
- OWASP Top 10 for LLM Applications 2025 (full PDF) — https://owasp.github.io/www-project-top-10-for-large-language-model-applications/assets/PDF/OWASP-Top-10-for-LLMs-v2025.pdf
- OWASP GenAI Security Project — https://genai.owasp.org/
- OWASP Top 10 for Agentic Applications (ASI01-ASI10, released Dec 2025; referenced in m8) — https://genai.owasp.org/2025/12/09/owasp-genai-security-project-releases-top-10-risks-and-mitigations-for-agentic-ai-security/
