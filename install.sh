#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"

mkdir -p "$COMMANDS_DIR"

echo "Installing Darkside skills to $COMMANDS_DIR..."

for skill_dir in "$PLUGIN_DIR/skills"/*/; do
  skill_name="$(basename "$skill_dir")"

  # Skip shared/internal files (prefixed with _)
  if [[ "$skill_name" == _* ]]; then
    continue
  fi

  src="$skill_dir/SKILL.md"

  if [[ ! -f "$src" ]]; then
    echo "  ⚠ Skipping $skill_name — SKILL.md not found"
    continue
  fi

  # Avoid overwriting /guide from another plugin
  if [[ "$skill_name" == "guide" ]]; then
    dest="$COMMANDS_DIR/darkside-guide.md"
    final_name="darkside-guide"
  else
    dest="$COMMANDS_DIR/${skill_name}.md"
    final_name="$skill_name"
  fi

  cp "$src" "$dest"

  # Ensure the name: field in frontmatter matches the file name
  if grep -q "^name:" "$dest"; then
    sed -i.bak "s/^name:.*/name: $final_name/" "$dest" && rm -f "${dest}.bak"
  fi

  echo "  ✔ /$final_name"
done

echo ""
echo "Done. Open Claude Code and type /darkside to verify."
