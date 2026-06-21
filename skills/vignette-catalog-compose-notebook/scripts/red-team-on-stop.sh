#!/usr/bin/env bash
# Stop hook (async): on turn-end, red-team any changed notebook WITHOUT waiting for
# the ~2-min review. The expensive reviewer runs detached; its verdict lands in a
# cache file and is enforced on a LATER turn-end. This keeps the harness block
# (enforcement at a checkpoint) but moves the slow review off the critical path - no
# dead wait while you compose.
#
# Flow per changed notebook (keyed by content hash, so a fix earns a fresh review):
#   first sight    -> launch the review detached, let this stop pass
#   still running  -> let this stop pass
#   verdict ready  -> if it FLAGged, block the stop with the flags; mark seen either way
#
# Wire from a catalog's .claude/settings.json, or ship it as a plugin Stop hook:
#   "command": "bash .../scripts/red-team-on-stop.sh 2>/dev/null || true"
set -uo pipefail
[ -n "${RED_TEAM_RUNNING:-}" ] && exit 0       # don't fire inside our own reviewer
cat >/dev/null 2>&1 || true                     # drain the Stop-hook stdin payload

DIR="$(cd "$(dirname "$0")" && pwd)"
RT="$DIR/red-team-notebook.sh"
CACHE=".claude/.red-team-cache"
mkdir -p "$CACHE" 2>/dev/null || exit 0

block=""
for nb in $({ git ls-files --others --exclude-standard 'notebooks/*.py' 2>/dev/null; \
              git diff --name-only 'notebooks/*.py' 2>/dev/null; } | sort -u); do
  [ -f "$nb" ] || continue
  h="$(sha256sum "$nb" | cut -d' ' -f1)"
  key="$CACHE/${nb//\//_}.$h"
  [ -f "$key.seen" ] && continue                # already surfaced this content
  if [ -f "$key.verdict" ]; then               # review finished -> enforce
    touch "$key.seen"
    grep -q FLAG "$key.verdict" && block="$block"$'\n'"## $nb"$'\n'"$(cat "$key.verdict")"
  elif [ -f "$key.running" ]; then             # ponytail: a crashed review leaves .running and is skipped forever - rare, re-touch the file to retry
    continue
  else                                         # first sight -> launch detached, let this stop pass
    touch "$key.running"
    RED_TEAM_RUNNING=1 RT="$RT" NB="$nb" KEY="$key" python3 -c 'import os, subprocess; cmd = "bash \"$RT\" \"$NB\" >\"$KEY.verdict.tmp\" 2>/dev/null; mv \"$KEY.verdict.tmp\" \"$KEY.verdict\"; mv -f \"$KEY.running\" \"$KEY.done\""; subprocess.Popen(["bash", "-c", cmd], stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True, env=os.environ.copy())' >/dev/null 2>&1 || true
  fi
done

[ -z "$block" ] && exit 0
python3 -c 'import json,sys; print(json.dumps({"decision":"block","reason":"Red-team (research-method.md) flagged the notebook(s); address each or explicitly justify before finishing:\n"+sys.argv[1]}))' "$block"
