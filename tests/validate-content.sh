#!/usr/bin/env bash
# dronAIcharya content validation: checks skill/agent frontmatter and every MCQ bank
# against the schema rules in tests/mcq.schema.json. Uses only python3 stdlib (no pip installs).
# Run from the plugin root:  bash tests/validate-content.sh
set -u
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

python3 - "$ROOT" <<'PY'
import json, os, re, sys, glob

root = sys.argv[1]
errors = []
checked = {"skills": 0, "agents": 0, "mcq_banks": 0, "mcq_items": 0}

# Golden-answer lock: id -> correct option TEXT (human-verified). Guards against a reshuffle/edit
# silently corrupting which option is marked correct (a range check alone can't catch that).
GOLDEN = {}
try:
    with open(os.path.join(root, "tests", "mcq-answers.golden.json"), encoding="utf-8") as f:
        GOLDEN = json.load(f).get("answers", {})
except Exception as e:
    errors.append(f"tests/mcq-answers.golden.json: could not load golden answers ({e})")

def frontmatter(path):
    with open(path, encoding="utf-8") as f:
        text = f.read()
    if not text.startswith("---"):
        return None, "frontmatter must start on line 1 with ---"
    # split off the frontmatter block
    m = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not m:
        return None, "no closing --- for frontmatter"
    block = m.group(1)
    keys = {}
    for line in block.splitlines():
        mm = re.match(r"^([A-Za-z0-9_-]+)\s*:\s*(.*)$", line)
        if mm:
            keys[mm.group(1)] = mm.group(2).strip()
    return keys, None

# --- skills ---
for skill in sorted(glob.glob(os.path.join(root, "skills", "*", "SKILL.md"))):
    checked["skills"] += 1
    rel = os.path.relpath(skill, root)
    keys, err = frontmatter(skill)
    if err:
        errors.append(f"{rel}: {err}"); continue
    if "name" not in keys:
        errors.append(f"{rel}: missing 'name' in frontmatter")
    if "description" not in keys or len(keys.get("description", "")) < 10:
        errors.append(f"{rel}: missing or too-short 'description'")
    folder = os.path.basename(os.path.dirname(skill))
    if keys.get("name") and keys["name"] != folder:
        errors.append(f"{rel}: name '{keys['name']}' != folder '{folder}' (command would mismatch)")

# --- agents ---
for agent in sorted(glob.glob(os.path.join(root, "agents", "*.md"))):
    checked["agents"] += 1
    rel = os.path.relpath(agent, root)
    keys, err = frontmatter(agent)
    if err:
        errors.append(f"{rel}: {err}"); continue
    for req in ("name", "description"):
        if req not in keys:
            errors.append(f"{rel}: missing '{req}' in frontmatter")
    if ":" in keys.get("name", ""):
        errors.append(f"{rel}: agent name must not contain ':'")

# --- MCQ banks ---
LEVELS = {"all", "never-coded", "some", "confident"}
for bank in sorted(glob.glob(os.path.join(root, "tracks", "*", "mcq", "*.json"))):
    checked["mcq_banks"] += 1
    rel = os.path.relpath(bank, root)
    try:
        with open(bank, encoding="utf-8") as f:
            data = json.load(f)
    except Exception as e:
        errors.append(f"{rel}: invalid JSON ({e})"); continue
    if not isinstance(data, dict) or "module" not in data or "items" not in data:
        errors.append(f"{rel}: must be an object with 'module' and 'items'"); continue
    items = data["items"]
    if not isinstance(items, list) or not items:
        errors.append(f"{rel}: 'items' must be a non-empty array"); continue
    seen_ids = set()
    for i, it in enumerate(items):
        checked["mcq_items"] += 1
        loc = f"{rel} item[{i}]"
        if not isinstance(it, dict):
            errors.append(f"{loc}: not an object"); continue
        for req in ("id", "concept", "type", "q"):
            if req not in it:
                errors.append(f"{loc}: missing '{req}'")
        iid = it.get("id")
        if iid in seen_ids:
            errors.append(f"{loc}: duplicate id '{iid}'")
        seen_ids.add(iid)
        if it.get("level", "all") not in LEVELS:
            errors.append(f"{loc}: level '{it.get('level')}' not in {sorted(LEVELS)}")
        t = it.get("type")
        if t == "mcq":
            opts = it.get("options")
            if not isinstance(opts, list) or not (3 <= len(opts) <= 5):
                errors.append(f"{loc}: mcq needs 3-5 'options'")
            ans = it.get("answer")
            if not isinstance(ans, int) or isinstance(ans, bool):
                errors.append(f"{loc}: mcq needs integer 'answer'")
            elif isinstance(opts, list) and not (0 <= ans < len(opts)):
                errors.append(f"{loc}: answer {ans} out of range for {len(opts)} options")
            # golden-answer regression lock
            if isinstance(opts, list) and isinstance(ans, int) and not isinstance(ans, bool) and 0 <= ans < len(opts):
                g = GOLDEN.get(iid)
                if g is not None and opts[ans] != g:
                    errors.append(f"{loc}: marked answer changed from the golden lock (expected {g!r}, got {opts[ans]!r}) — an edit/reshuffle may have corrupted the correct answer")
        elif t == "short":
            rub = it.get("rubric")
            if not isinstance(rub, list) or not rub:
                errors.append(f"{loc}: short needs a non-empty 'rubric' array")
        else:
            errors.append(f"{loc}: type must be 'mcq' or 'short' (got {t!r})")

# --- schema file itself is valid JSON ---
schema_path = os.path.join(root, "tests", "mcq.schema.json")
try:
    with open(schema_path, encoding="utf-8") as f:
        json.load(f)
except Exception as e:
    errors.append(f"tests/mcq.schema.json: invalid JSON ({e})")

# --- hooks.json valid + referenced scripts exist and are executable ---
# This guards the ENTIRE guardrail layer: a broken hooks.json silently disables every hook,
# and `claude plugin validate` does not parse it, so nothing else would catch it.
hooks_path = os.path.join(root, "hooks", "hooks.json")
try:
    with open(hooks_path, encoding="utf-8") as f:
        hooks = json.load(f)
    cmds = re.findall(r"scripts/[A-Za-z0-9._-]+\.sh", json.dumps(hooks))
    if not cmds:
        errors.append("hooks/hooks.json: no scripts/*.sh commands found (guardrail wiring missing?)")
    for rel in sorted(set(cmds)):
        p = os.path.join(root, rel)
        if not os.path.isfile(p):
            errors.append(f"hooks/hooks.json references {rel}, which does not exist")
        elif not os.access(p, os.X_OK):
            errors.append(f"hooks/hooks.json references {rel}, which is not executable (chmod +x)")
except Exception as e:
    errors.append(f"hooks/hooks.json: invalid or unreadable ({e})")

# Minimum-count guards: a validator that treats "0 items checked" as success is no guard at all.
mins = {"skills": 18, "agents": 7, "mcq_banks": 39, "mcq_items": 190}
for k, v in mins.items():
    if checked[k] < v:
        errors.append(f"too few {k}: found {checked[k]}, expected >= {v} (content missing, or ROOT wrong?)")
if GOLDEN:
    golden_checked = sum(1 for _ in GOLDEN)
    if golden_checked < 150:
        errors.append(f"golden lock has only {golden_checked} answers; expected >= 150")

print(f"Checked: {checked['skills']} skills, {checked['agents']} agents, "
      f"{checked['mcq_banks']} MCQ banks ({checked['mcq_items']} items); golden answers: {len(GOLDEN)}.")
if errors:
    print(f"\n\033[31m{len(errors)} problem(s):\033[0m")
    for e in errors:
        print("  - " + e)
    sys.exit(1)
print("\033[32mAll content checks passed.\033[0m")
PY
