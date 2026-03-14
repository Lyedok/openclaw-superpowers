#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCLAW_DIR="${OPENCLAW_HOME:-$HOME/.openclaw}"
INSTALL_TARGET="$OPENCLAW_DIR/extensions/superpowers"
echo "Installing openclaw-superpowers..."
if [ ! -d "$OPENCLAW_DIR" ]; then
  echo "OpenClaw not found at $OPENCLAW_DIR"
  exit 1
fi
mkdir -p "$OPENCLAW_DIR/extensions"
rm -rf "$INSTALL_TARGET"
ln -s "$REPO_DIR/skills" "$INSTALL_TARGET"
echo "openclaw-superpowers installed. Restart OpenClaw to activate."
