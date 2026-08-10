#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"
DARKSIDE_HOME="$HOME/.darkside"

mkdir -p "$COMMANDS_DIR"
mkdir -p "$DARKSIDE_HOME"

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

# Save installed version
if [ -f "$PLUGIN_DIR/VERSION" ]; then
  cp "$PLUGIN_DIR/VERSION" "$DARKSIDE_HOME/VERSION"
  VERSION="$(cat "$PLUGIN_DIR/VERSION")"
  echo ""
  echo "Version $VERSION saved to $DARKSIDE_HOME/VERSION"
fi

# Install update checker
cp "$PLUGIN_DIR/scripts/check-update.sh" "$DARKSIDE_HOME/check-update.sh"
chmod +x "$DARKSIDE_HOME/check-update.sh"
echo "Update checker installed at $DARKSIDE_HOME/check-update.sh"

# Add UserPromptSubmit hook to Claude Code settings.json
_add_hook() {
  local settings="$HOME/.claude/settings.json"
  local hook_cmd="[ -f \$HOME/.darkside/check-update.sh ] && bash \$HOME/.darkside/check-update.sh 2>/dev/null || true"

  # Create settings.json if it doesn't exist
  if [ ! -f "$settings" ]; then
    echo '{}' > "$settings"
  fi

  # Check if hook already registered
  if grep -q "check-update.sh" "$settings" 2>/dev/null; then
    echo "Update hook already registered in settings.json"
    return
  fi

  python3 - "$settings" "$hook_cmd" <<'EOF'
import sys, json

settings_path = sys.argv[1]
hook_cmd = sys.argv[2]

with open(settings_path) as f:
  data = json.load(f)

hook_entry = {"type": "command", "command": hook_cmd}
hooks = data.setdefault("hooks", {})
submit_hooks = hooks.setdefault("UserPromptSubmit", [])

# Find or create the catch-all matcher entry
for entry in submit_hooks:
  if entry.get("matcher") == "":
    entry.setdefault("hooks", []).append(hook_entry)
    break
else:
  submit_hooks.append({"matcher": "", "hooks": [hook_entry]})

with open(settings_path, "w") as f:
  json.dump(data, f, indent=2)
  f.write("\n")
EOF

  echo "Update hook registered in $settings"
}

_add_hook

echo ""
echo "Done. Open Claude Code and type /darkside to verify."
echo ""
echo "⚠ If you have existing projects using Darkside, run /explore in each one"
echo "  to regenerate the sith-agents with the latest agent definitions."
