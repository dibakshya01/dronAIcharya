# OWASP for AI apps — quick reference

Shared reference for the Cybersecurity & AI Security track, the `security-auditor` agent, and dronAIcharya's own posture. **Verify currency:** OWASP updates these lists; when teaching them, confirm the latest via `research-scout` (the Cybersecurity track's `syllabus.md` records the versions/URLs it checked).

## OWASP Top 10 for LLM Applications (2025 list)
1. **LLM01 Prompt Injection** — untrusted input (direct or via fetched/retrieved content) steers the model. *The big one.* Defense: treat tool/web/file content as **data, not instructions**; separate trusted vs untrusted; human-in-the-loop for consequential actions.
2. **LLM02 Sensitive Information Disclosure** — the app leaks secrets/PII/training data. Defense: minimize what the model can access; scrub outputs; least privilege.
3. **LLM03 Supply Chain** — compromised models, datasets, plugins, or dependencies. Defense: vet and pin sources; verify integrity.
4. **LLM04 Data and Model Poisoning** — tainted training/fine-tune/RAG data. Defense: control data provenance.
5. **LLM05 Improper Output Handling** — downstream code trusts model output blindly (e.g. runs generated SQL/HTML/commands). Defense: validate/encode/sandbox model output like any untrusted input.
6. **LLM06 Excessive Agency** — the agent has more tools/permissions/autonomy than needed, so a bad step does real damage. Defense: least-privilege tools, scoped permissions, approvals for consequential actions.
7. **LLM07 System Prompt Leakage** — secrets or security relied on being hidden in the system prompt get exposed. Defense: don't put secrets or sole security controls in the prompt.
8. **LLM08 Vector and Embedding Weaknesses** — RAG/embedding stores leak or get poisoned. Defense: access-control the vector store; validate retrieved content.
9. **LLM09 Misinformation** — confident, wrong output (hallucination) relied upon. Defense: ground with sources, verify, keep humans in the loop for facts that matter.
10. **LLM10 Unbounded Consumption** — uncontrolled cost/compute (runaway loops, token blow-ups, denial-of-wallet). Defense: budgets, rate limits, loop caps.

## The classic OWASP Top 10 (web apps) — still applies to anything with a backend
Injection · Broken Access Control · Cryptographic Failures · Insecure Design · Security Misconfiguration · Vulnerable/Outdated Components · Identification & Authentication Failures · Software/Data Integrity Failures · Security Logging & Monitoring Failures · Server-Side Request Forgery. (Confirm the current year's exact list/order via `research-scout`.)

## How dronAIcharya itself models these
- LLM01/LLM05: hooks inject *factual context*, never imperative commands; fetched content is quarantined as data (`injection-safety.md`).
- LLM06: skills/agents request minimum tools; outward/irreversible actions stop at the user's click.
- LLM10: short per-turn crumb (not the full contract), batch MCQ grading, bounded subagent use.
- Backend lessons teach **deny-by-default** access control (Broken Access Control is the most common real breach).
