#!/usr/bin/env bash
OPENCLAW_DIR="${OPENCLAW_HOME:-$HOME/.openclaw}"
INSTALL_TARGET="$OPENCLAW_DIR/extensions/superpowers"
if [ -L "$INSTALL_TARGET" ] || [ -d "$INSTALL_TARGET" ]; then
  rm -rf "$INSTALL_TARGET"
  echo "openclaw-superpowers removed."
else
  echo "Nothing to uninstall."
fi
