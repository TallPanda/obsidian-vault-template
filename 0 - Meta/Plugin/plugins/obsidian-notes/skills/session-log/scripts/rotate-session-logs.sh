#!/bin/bash
# rotate-session-logs.sh <current-stem>
# Moves session logs older than 24 hours to 1 - Inbox/Logs/Old/
# Skips the file matching <current-stem>-session.md
# Usage: called automatically by the session-log skill
VAULT="$(cd "$(dirname "$0")/../../../../../../.." && pwd)"
LOG_DIR="$VAULT/1 - Inbox/Logs"
OLD_DIR="$LOG_DIR/Old"
CURRENT_STEM="$1"
THRESHOLD=86400  # 24 hours in seconds

if [[ "$(uname)" == "Darwin" ]]; then
    stat_mtime() { stat -f %m "$1"; }
else
    stat_mtime() { stat -c %Y "$1"; }
fi

mkdir -p "$OLD_DIR"
[ -d "$LOG_DIR" ] || exit 0

for f in "$LOG_DIR"/*.md; do
    [ -f "$f" ] || continue
    stem="${f##*/}"
    stem="${stem%-session.md}"
    [ "$stem" = "$CURRENT_STEM" ] && continue
    age=$(( $(date +%s) - $(stat_mtime "$f") ))
    if [ "$age" -gt "$THRESHOLD" ]; then
        mv "$f" "$OLD_DIR/" || { echo "Warning: could not move $f" >&2; continue; }
    fi
done
