#!/usr/bin/env bash
# Stop hook: after a turn ends, decide *when* to ask the model whether the
# working documents deserve a micro-update. Whether anything is worth
# recording stays the model's judgment — this script only paces the question.
#
# Self-gates on STATE.md, like session-start.sh: silent outside
# project-helper-managed projects. Self-throttles per session: a nudge fires
# only once PROJECT_HELPER_CHECKPOINT_TURNS assistant turns (default 10) AND
# PROJECT_HELPER_CHECKPOINT_MINUTES minutes (default 15) have passed since the
# last nudge or session start. PROJECT_HELPER_CHECKPOINT=off disables it.
#
# A nudge is {"decision":"block","reason":...} on stdout: Claude Code hands
# the reason to the model and the turn continues. Every other path exits 0
# with no output, letting the turn end normally.

set -uo pipefail

ROOT="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$ROOT/STATE.md" ] || exit 0
[ "${PROJECT_HELPER_CHECKPOINT:-on}" = "off" ] && exit 0

INPUT="$(cat)"
# Never nudge a continuation that a Stop hook already caused.
case "$INPUT" in *'"stop_hook_active":true'*) exit 0 ;; esac

SESSION="$(printf '%s' "$INPUT" | sed -n 's/.*"session_id":"\([^"]*\)".*/\1/p')"
[ -n "$SESSION" ] || exit 0

TURNS="${PROJECT_HELPER_CHECKPOINT_TURNS:-10}"
MINUTES="${PROJECT_HELPER_CHECKPOINT_MINUTES:-15}"
MARKER="${TMPDIR:-/tmp}/project-helper-checkpoint-$SESSION"
NOW="$(date +%s)"

COUNT=""; SINCE=""
[ -f "$MARKER" ] && read -r COUNT SINCE < "$MARKER" 2>/dev/null
case "$COUNT" in '' | *[!0-9]*) COUNT=0; SINCE="$NOW" ;; esac
case "$SINCE" in '' | *[!0-9]*) SINCE="$NOW" ;; esac
COUNT=$((COUNT + 1))

if [ "$COUNT" -lt "$TURNS" ] || [ $(((NOW - SINCE) / 60)) -lt "$MINUTES" ]; then
  printf '%s %s\n' "$COUNT" "$SINCE" > "$MARKER"
  exit 0
fi

# Reset before nudging so the continuation this causes can never re-fire.
printf '0 %s\n' "$NOW" > "$MARKER"

REASON="Automatic checkpoint nudge (project-helper; throttled, not a user message). If this session has settled a decision, changed direction, ruled something out, or completed a milestone that STATE.md or LOG.md does not yet reflect, record it now with the smallest edit that captures it — a few lines in the owning file, not a handoff and not a full STATE.md rewrite. If nothing that durable has happened, or you are mid-task, make no edits and end your reply normally. Only mention this check if you recorded something."

printf '{"decision":"block","reason":"%s"}\n' "$REASON"
exit 0
