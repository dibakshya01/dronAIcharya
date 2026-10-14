# Under the hood: from your machine to a live URL

Reference for `under-the-hood` and `deep-dive`. What actually happens when code "goes live."

## The one-sentence version
Deploying means putting your code somewhere a server runs it so anyone can reach it at a URL — usually: push to GitHub → a host pulls your code → builds it → runs it → routes a domain to it over HTTPS.

## The real sequence (narrate what just happened)
1. **`git push`** uploads your commits to a remote (GitHub). (Under the hood of git: each commit is a snapshot; push sends the ones the remote doesn't have.)
2. **The host** (a PaaS / static host / serverless platform) is connected to that repo. On a push it **pulls** the code.
3. **Build step** (if any): it compiles/bundles your app using your build command, producing the runnable artifact.
4. **Run/serve:** static files go on a CDN; a server app is started with your start command; serverless functions are registered to run on demand.
5. **Config & secrets** come from the host's **environment variables** you set in its dashboard — not from the repo.
6. **Domain & HTTPS:** DNS points your domain at the host; the host provisions a TLS certificate so traffic is encrypted (the padlock).

## Honest caveats
- A **successful deploy can still be misconfigured** (missing env var, wrong build output, a secret accidentally shipped to the browser). Always verify the live site actually works and that no secret leaked client-side.
- Free tiers have limits (sleeping dynos / cold starts / quotas) — fine for learning, worth knowing.

## The user-only clicks
Creating the host account, connecting the repo, entering secret values, buying a domain, and clicking **Deploy** are the learner's own actions. dronAIcharya preps everything up to those clicks.

## A good "under the hood" check
"Between `git push` and your live URL, name two things the host did for you." (e.g. pulled the code, ran the build, started the server, set up HTTPS.)
