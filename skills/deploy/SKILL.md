---
name: deploy
description: Teach deployment and prepare the learner's app to go live — hosting choices, environment variables/secrets, build steps, domains — up to the clicks only the user can make. Use at the ship phase, when the user runs /dronaicharya:deploy, or asks how to get their app on the internet / host it / add a domain.
argument-hint: "[what to deploy]"
---

# dronAIcharya — Deploy, taught

Get the learner's app onto the internet — teaching what each step does — and stop at the account-bound/paid/irreversible clicks, which are theirs.

## Teach (at their level)
- What "deploy" means: putting your code somewhere a server runs it so others can reach it by URL.
- The shapes of hosting (pick what fits the app): **static** (a site/SPA → static hosts like GitHub Pages/Netlify-style), **server** (a backend process → a PaaS), **serverless** (functions on demand). One honest line on cost/when-to-use each.
- **Environment variables & secrets**: config and keys live in the host's env settings, never in the repo. This is the deploy-time version of the secrets lesson.
- Build vs run: many apps build (compile/bundle) then run; the host often does the build for you from your repo.

## Prepare (up to the user's click)
1. Pick a host together, matched to the app and budget (free tier first).
2. Produce everything needed: build command, start command, required env vars (names only — the learner enters the values), a `README`/deploy notes, and any config file the host needs.
3. Walk the exact steps. **The learner performs** the account-bound/paid/irreversible actions themselves: creating the host account, connecting the repo, entering secret values, buying a domain, and clicking **Deploy**. Prep to that line; hand it over with a clear checklist.
4. After they deploy, help verify it's actually live and working (and that no secret leaked into the client).

## Rules
- Never enter real credentials, buy a domain, or click deploy on the learner's behalf — prep and guide.
- Surface honest caveats (free-tier limits, cold starts, that a successful deploy can still be misconfigured).
- Under-the-hood moment: what happened between `git push` and a live URL.
- Deep dive available: DNS/domains, HTTPS certificates, CI/CD — offer, don't force.
- Mastery check: can the learner say where secrets go at deploy time and why not in the repo?
