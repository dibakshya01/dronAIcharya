# dronAIcharya state schema

dronAIcharya keeps two kinds of state. Both carry a `schemaVersion` so a future change can migrate cleanly instead of corrupting a learner.

## 1. Per-project journey — `./.dronacharya/` (in the learner's project)

Gitignored by default. Holds the current build+learn journey for *this* project. Never stores secrets.

### `progress.json`
```json
{
  "schemaVersion": 1,
  "persona": "vanilla",            // vanilla | strict | witty | deadpan
  "cadence": "balanced",           // thorough | balanced | fast
  "track": "vibecoding",           // vibecoding | python | cs-from-scratch | cyber-ai-security
  "level": "never-coded",          // never-coded | some | confident
  "idea": "a habit-tracker web app",
  "module": "m2-prompting",        // current module id in the track syllabus
  "lessonIndex": 3,                 // 0-based lesson within the module
  "buildMilestone": "data-model",  // current SDLC milestone label
  "flags": {
    "teachingMode": true,          // master switch the hooks read
    "paused": false,               // learner pressed pause → hooks go quiet
    "eli5Default": false,          // explain everything ELI5 by default
    "stopNudge": true,             // allow the conservative Stop nudge
    "purpleSparrow": false         // purple-sparrow backend wired in
  }
}
```

### `learning-plan.md`
The human-readable, learner-approved combined BUILD + LEARN plan (what we'll build, which concepts we'll learn and where, each tagged teach / deep-dive-available / skippable).

### `journal.md`
Append-only log: after each meaningful concept or decision, one short entry — what was learned, what was decided and why (ADR-lite), key under-the-hood notes. **Never** write secrets or raw fetched web content here (see `injection-safety.md`).

## 2. Global learner profile — `${CLAUDE_PLUGIN_DATA}/profile.json`

Survives across projects and plugin updates (that's why mastery lives here, not in the per-project journey). Created lazily.

```json
{
  "schemaVersion": 1,
  "mastery": { "how-an-llm-predicts": 0.9, "recursion": 0.4 },  // concept id → 0..1
  "tracksTouched": ["vibecoding"],
  "lastPersona": "witty",
  "lastCadence": "balanced"
}
```

## Reading from hooks
Hook scripts read only `progress.json` and only the fields they need (`flags.teachingMode`, `flags.paused`, `flags.stopNudge`, `persona`, `track`, `cadence`). They tolerate a missing file, a missing `jq`, and malformed JSON — always failing open (no output, exit 0).

## Migration
On load, the orchestrator compares `schemaVersion` to the current version. If older, it migrates field-by-field (adding new fields with defaults, renaming as documented here) and rewrites the file. It never deletes unknown fields. If newer (a downgrade), it reads conservatively and warns.

## Recovery (lost journey)
If the global profile indicates an active journey but `./.dronacharya/progress.json` is not found in the current directory (e.g. Claude Code was launched from a different folder), the orchestrator says so plainly and offers to (a) point it at the right folder, or (b) re-initialize here — rather than silently losing the journey.
