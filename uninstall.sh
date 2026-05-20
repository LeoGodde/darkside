#!/usr/bin/env bash
set -euo pipefail

COMMANDS_DIR="$HOME/.claude/commands"

SKILLS=(darkside explore quest sith-agents order66 inquisitor war-room interrogate darkside-guide)

echo "Removing Darkside skills from $COMMANDS_DIR..."

for skill_name in "${SKILLS[@]}"; do
  dest="$COMMANDS_DIR/${skill_name}.md"
  if [[ -f "$dest" ]]; then
    rm "$dest"
    echo "  ✔ removed /$skill_name"
  fi
done

echo ""
echo "Done."
