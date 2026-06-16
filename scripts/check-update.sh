#!/usr/bin/env bash
# Darkside update checker — runs once per day.
# Writes ~/.darkside/.update-available if a newer version is released.
# Safe to run on every prompt: exits immediately if already checked today.

set -euo pipefail

DARKSIDE_HOME="$HOME/.darkside"
VERSION_FILE="$DARKSIDE_HOME/VERSION"
LAST_CHECK_FILE="$DARKSIDE_HOME/.last-check"
UPDATE_FILE="$DARKSIDE_HOME/.update-available"
REPO="LeoGodde/darkside"

# Nothing to check if not installed
[ -f "$VERSION_FILE" ] || exit 0

# Already checked today — skip
TODAY="$(date +%Y-%m-%d)"
if [ -f "$LAST_CHECK_FILE" ] && [ "$(cat "$LAST_CHECK_FILE")" = "$TODAY" ]; then
  exit 0
fi

# Record today's check (even if the API call fails, don't hammer it)
echo "$TODAY" > "$LAST_CHECK_FILE"

# Fetch latest release tag from GitHub API
LATEST="$(curl -sf --max-time 5 \
  "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"tag_name"' \
  | sed 's/.*"v\{0,1\}\([^"]*\)".*/\1/')" || exit 0

[ -z "$LATEST" ] && exit 0

INSTALLED="$(cat "$VERSION_FILE")"

# Write sentinel if update is available
if [ "$INSTALLED" != "$LATEST" ]; then
  echo "$LATEST" > "$UPDATE_FILE"
fi
