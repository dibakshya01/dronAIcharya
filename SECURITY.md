# Security policy

dronAIcharya runs inside your editor, reads your project, can run commands, and can wire in an MCP backend. It's also a teaching tool *about* security, so it tries to model good practice.

## What dronAIcharya does to stay safe
- **No telemetry.** It makes no network calls except the web/doc fetches a lesson explicitly performs.
- **Your secrets stay yours.** It never asks you to paste an API key into the chat, never types/echoes/stores your key, and never commits secrets. `.dronacharya/`, `.env`, `*.key`, `*.pem` are gitignored.
- **Data, not instructions.** Content fetched from the web or returned by tools is treated as data and is quarantined — it never flows into the guardrail hook injection or the journal in a way that could re-drive the agent. (See `reference/injection-safety.md`.)
- **Least privilege.** Skills/agents request minimal tools; destructive or outward-facing actions (push, publish, pay, deploy, entering credentials) stop at your own click.
- **Hooks fail open and stay local.** The guardrail hook scripts always exit cleanly, emit nothing unless a journey is active in the current project, and never contact the network.

## Trust
Plugins and skills run with your permissions. Read the source — it's all plain Markdown and small shell scripts — before you install. Only install tools you trust.

## The optional backend
purple-sparrow is alpha; its own README says the policy engine needs an independent audit before regulated data. dronAIcharya surfaces this and will not help you put real/regulated data into it.

## Reporting a vulnerability
Found a security issue in dronAIcharya itself (e.g. a way the hooks could be abused, or a secret could leak)? Please open a **private** report via GitHub Security Advisories on https://github.com/dibakshya01/dronAIcharya , or open an issue that describes the impact without exploit details and ask to take it private. We'll respond as soon as we can.
