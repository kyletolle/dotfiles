#!/bin/bash
# Stop hook: copy the last turn as raw markdown to the clipboard.
# Always on; launch with CLAUDE_TURN_AUTOCOPY=0 to opt a session out.
if [ "$CLAUDE_TURN_AUTOCOPY" = "0" ]; then
  exit 0
fi

transcript=$(jq -r '.transcript_path // empty')
if [ -z "$transcript" ] || [ ! -f "$transcript" ]; then
  exit 0
fi

# The transcript is written asynchronously and can lag the turn's end.
sleep 0.5

"$HOME/bin/claude-turn" -s "$transcript" 2>/dev/null || true
