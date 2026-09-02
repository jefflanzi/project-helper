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
echo "=== end STATE.md — claims, not ground truth: the last session may not have recorded everything. Spot-check against the project (the files it names; git status if there is git) before relying on it, and correct STATE.md where it is stale. ==="

# Once per plugin release per project, nudge toward update-project. Silent the
# first time a project is seen — a fresh scaffold is current by definition —
# and silent again until the installed version next changes. The marker lives
# in the plugin's data dir, never in the project.
VERSION="$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "${CLAUDE_PLUGIN_ROOT:-/nonexistent}/.claude-plugin/plugin.json" 2>/dev/null)"
if [ -n "$VERSION" ]; then
  DATA_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.claude/project-helper-data}"
  mkdir -p "$DATA_DIR" 2>/dev/null
  MARKER="$DATA_DIR/seen-$(printf '%s' "$ROOT" | cksum | cut -d' ' -f1)"
  LAST="$(cat "$MARKER" 2>/dev/null || true)"
  if [ -z "$LAST" ]; then
    printf '%s\n' "$VERSION" > "$MARKER" 2>/dev/null
  elif [ "$LAST" != "$VERSION" ]; then
    echo "=== project-helper updated ($LAST -> $VERSION) since this project's conventions were last checked: /project-helper:update-project ports template changes forward. Mention this to the user once; do not run it uninvited. ==="
    printf '%s\n' "$VERSION" > "$MARKER" 2>/dev/null
  fi
fi
exit 0
