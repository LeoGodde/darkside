#!/usr/bin/env bash
# Darkside — remote installer (curl-based)
# Usage: curl -fsSL https://raw.githubusercontent.com/LeoGodde/darkside/main/install-remote.sh | bash
set -euo pipefail

REPO="LeoGodde/darkside"
COMMANDS_DIR="$HOME/.claude/commands"
DARKSIDE_HOME="$HOME/.darkside"
TMP_DIR="$(mktemp -d)"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "Fetching latest Darkside release..."

# Get latest release tag
TAG="$(curl -sf "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"tag_name"' \
  | sed 's/.*"\(v\{0,1\}[^"]*\)".*/\1/')"

if [ -z "$TAG" ]; then
  echo "❌ Could not fetch latest release. Check your connection or visit:"
  echo "   https://github.com/$REPO/releases"
  exit 1
fi

VERSION="${TAG#v}"
echo "Installing Darkside $TAG..."

# Download and extract release tarball
curl -sfL "https://github.com/$REPO/archive/refs/tags/$TAG.tar.gz" \
  | tar -xz -C "$TMP_DIR"

EXTRACTED="$TMP_DIR/darkside-$VERSION"
[ -d "$EXTRACTED" ] || EXTRACTED="$(ls -d "$TMP_DIR"/darkside-* | head -1)"

mkdir -p "$COMMANDS_DIR"
mkdir -p "$DARKSIDE_HOME"

# Install skills
echo "Installing skills to $COMMANDS_DIR..."
for skill_dir in "$EXTRACTED/skills"/*/; do
  skill_name="$(basename "$skill_dir")"
  [[ "$skill_name" == _* ]] && continue

  src="$skill_dir/SKILL.md"
  [ -f "$src" ] || continue

  if [[ "$skill_name" == "guide" ]]; then
    dest="$COMMANDS_DIR/darkside-guide.md"
    final_name="darkside-guide"
  else
    dest="$COMMANDS_DIR/${skill_name}.md"
    final_name="$skill_name"
  fi

  cp "$src" "$dest"
  if grep -q "^name:" "$dest"; then
    sed -i.bak "s/^name:.*/name: $final_name/" "$dest" && rm -f "${dest}.bak"
  fi
  echo "  ✔ /$final_name"
done

# Save version
echo "$VERSION" > "$DARKSIDE_HOME/VERSION"
echo ""
echo "Version $VERSION saved to $DARKSIDE_HOME/VERSION"

# Install update checker
cp "$EXTRACTED/scripts/check-update.sh" "$DARKSIDE_HOME/check-update.sh"
chmod +x "$DARKSIDE_HOME/check-update.sh"
echo "Update checker installed at $DARKSIDE_HOME/check-update.sh"

# Add UserPromptSubmit hook to Claude Code settings.json
_add_hook() {
  local settings="$HOME/.claude/settings.json"
  local hook_cmd="[ -f \$HOME/.darkside/check-update.sh ] && bash \$HOME/.darkside/check-update.sh 2>/dev/null || true"

  [ -f "$settings" ] || echo '{}' > "$settings"

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
echo "✅ Darkside $VERSION installed. Open Claude Code and type /darkside to verify."
echo ""
echo "To update in the future:"
echo "  curl -fsSL https://raw.githubusercontent.com/$REPO/main/install-remote.sh | bash"
