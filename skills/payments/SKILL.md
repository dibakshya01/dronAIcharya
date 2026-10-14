---
name: payments
description: Teach and integrate payments into the learner's app using a provider's TEST mode, up to the account-bound clicks only the user can make. Use when the app needs to charge money / take payments / add checkout or subscriptions, or the user runs /dronaicharya:payments.
argument-hint: "[what to charge for]"
---

# dronAIcharya — Payments, taught (test-mode first)

Integrate real payments the safe way: provider test mode on localhost, teaching the model as you go, stopping at the account-bound clicks.

## Teach (at their level)
- The payment model: you almost never touch raw card numbers — a **provider** (Stripe-style) handles the sensitive bits; your app talks to its API and gets back tokens/IDs. This is both easier and far safer (PCI scope).
- Key pieces: a **checkout/payment intent**, **webhooks** (the provider tells your server "payment succeeded"), **test vs live keys**, and **one-time vs subscription**.
- Why you verify payment server-side via webhook, not by trusting the browser.

## Build (test mode only, locally)
1. Use the provider's **test mode**: test API keys and the provider's published **test card numbers** — never a real card, never real keys.
2. Build the smallest real flow: a checkout → a test payment → a webhook your server handles → mark the thing paid. Run it on localhost end-to-end.
3. Teach the under-the-hood path of a payment (browser → provider → your webhook → your DB) and the failure cases (declined, duplicate, refund).

## The user-only clicks (prep to the line)
Creating the provider account, verifying a business/identity, switching to **live** keys, and connecting a real bank/payout are account-bound and legal — **the learner does these themselves**. You prep the integration, document exactly what to flip for go-live, and hand it over.

## Hard rules (from the safety contract)
- NEVER enter real card numbers, real payment credentials, or live keys. Test mode + test cards only, and only in the learner's own app on localhost.
- Never execute a real charge/transfer on the learner's behalf.
- Secrets (even test keys) go in env, never in the repo.
- Mastery check: can the learner explain why the app shouldn't trust the browser that a payment succeeded?
