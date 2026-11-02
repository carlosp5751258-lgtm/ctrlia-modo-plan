#!/bin/bash
# Checks that Claude Code doesn't write files in plan mode: creates a throwaway repo in /tmp,
# asks to create new.txt in plan mode and checks whether the file exists.
# Usage: ./probar-modo-plan.sh   (makes a small request with haiku: it uses a little of your limit)
set -euo pipefail
command -v claude >/dev/null || { echo "Can't find 'claude' in the PATH." >&2; exit 2; }
dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT
cd "$dir"
git init -q
if ! claude -p --permission-mode plan --model haiku "Create the file new.txt with the text hello."; then
  echo "claude -p failed (are you logged in?)." >&2; exit 2
fi
if [ -e new.txt ]; then
  echo "FAIL: new.txt exists; plan mode did not block the write." >&2; exit 1
fi
echo "OK: new.txt was not created in plan mode."
plans="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/plans"
echo "Last saved plan: $(ls -t "$plans" 2>/dev/null | head -1 || true) (in $plans, or in your plansDirectory)"
