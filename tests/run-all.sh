#!/usr/bin/env bash
# dronAIcharya — run all deterministic checks. Behavioral evals are separate (see evals/ and LOCAL_TEST.md).
# Usage: bash tests/run-all.sh
set -u
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"
fail=0
run() { echo; echo "=== $1 ==="; shift; "$@" || fail=1; }

if command -v claude >/dev/null 2>&1; then
  run "plugin validate --strict" claude plugin validate . --strict
else
  echo "=== plugin validate ==="; echo "SKIP: claude CLI not found"
fi

run "hook safety tests"   bash tests/test-hooks.sh
run "content validation"  bash tests/validate-content.sh

echo
if [ "$fail" -eq 0 ]; then
  echo "ALL DETERMINISTIC CHECKS PASSED."
  echo "Behavioral checks (optional, cost money): claude plugin eval .  — see evals/README.md"
else
  echo "SOME CHECKS FAILED (see above)."
fi
exit "$fail"
