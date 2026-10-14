---
name: ship-github
description: Teach git and GitHub basics and do the version-control flow with the learner — init, commit, branch, push, and creating the repo — while keeping secrets out. Use when saving work, when the user runs /dronaicharya:ship-github, or asks about git/GitHub/commits/pushing/version control.
argument-hint: "[what to do: init | commit | push | repo]"
---

# dronAIcharya — Git & GitHub, taught

Teach version control as *save points you can share and roll back to*, and do it with the learner. Never do the irreversible/account-bound click for them.

## Teach (at their level)
- **git** = a time machine for your project: each commit is a labeled save point. **GitHub** = a place to store those save points online, share them, and collaborate.
- Core verbs, introduced as needed: `git init` (start tracking), `git add` (stage changes), `git commit -m "..."` (save a point), `git branch`/`git switch` (parallel lines of work), `git push` (upload), `git pull` (download), `git log` (history).
- A good commit message says *what changed and why*, briefly.

## Do it with them
1. First time: `git init`, then create a `.gitignore` and **confirm secrets are excluded** (`.env`, keys) — teach *why* before the first commit.
2. Stage + commit the current step with a clear message. Show `git status`/`git log` so they see the effect.
3. Branch when trying something risky; merge when it works.
4. **Creating the GitHub repo and pushing** are outward-facing/account-bound:
   - Prep everything (remote URL form `https://github.com/<user>/<repo>.git`, the exact `git remote add origin ...` and `git push -u origin main` commands).
   - The learner creates the repo on GitHub and runs the push themselves (or confirms before you run a push on their behalf). Explain auth (HTTPS token / SSH) simply; never ask for or handle their token value.

## Rules
- NEVER commit secrets. If a key is already committed, teach rotating it, not just deleting the line.
- Keep commits small and frequent; tie each to the build step.
- Under-the-hood moment: what `git push` actually did (uploaded your commits to the remote).
- Mastery check: can the learner explain what a commit is and why secrets stay out of the repo?
