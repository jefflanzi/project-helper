#!/usr/bin/env bash
# SessionStart hook: put the project's current state in front of the agent.
#
# Ships with the project-helper plugin, so it runs in every session where the
# plugin is enabled. It self-gates: projects without a STATE.md get nothing,
# so it is silent everywhere except project-helper-managed projects.
#
# That is all it does. Judging whether a document has drifted is a reading
# task, and the rules for it live in AGENTS.md where they stay in context.
#
# SessionStart adds plain stdout straight to context. Always exits 0.

set -uo pipefail
ROOT="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$ROOT/STATE.md" ] || exit 0
echo "=== STATE.md — where this project left off ==="
cat "$ROOT/STATE.md"
exit 0
