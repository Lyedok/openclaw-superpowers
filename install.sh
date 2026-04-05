#!/usr/bin/env bash
set -euo pipefail
trap 'echo "ERROR at line $LINENO"' ERR
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCLAW_DIR="${OPENCLAW_HOME:-$HOME/.openclaw}"
INSTALL_TARGET="$OPENCLAW_DIR/superpowers"
STATE_DIR="$OPENCLAW_DIR/skill-state"

echo "Installing openclaw-superpowers..."

if [ ! -d "$OPENCLAW_DIR" ]; then
  echo "OpenClaw not found at $OPENCLAW_DIR"
  exit 1
fi

# --- Symlink ---
mkdir -p "$(dirname "$INSTALL_TARGET")"
ln -sfn "$REPO_DIR/skills/" "$INSTALL_TARGET"

# --- Helper: register a stateful skill (create state dir + empty stub) ---
register_stateful_skill() {
  local skill_name="$1"
  local state_skill_dir="$STATE_DIR/$skill_name"
  mkdir -p "$state_skill_dir"
  if [ ! -f "$state_skill_dir/state.yaml" ]; then
    echo "# Runtime state for $skill_name — managed by openclaw-superpowers" > "$state_skill_dir/state.yaml"
    echo "  + state dir: $skill_name"
  else
    echo "  ~ state dir already exists, preserving: $skill_name"
  fi
}

# --- Helper: register a cron job (idempotent: remove then add) ---
register_cron_skill() {
  local skill_name="$1"
  local cron_expr="$2"

  if ! openclaw cron add \
      --name "$skill_name" \
      --cron "$cron_expr" \
      --session isolated \
      --message "Execute skill $skill_name" \
      --no-deliver \
      --disabled
  then
    echo "ERROR: failed to register cron for $skill_name ($cron_expr)" >&2
    exit 1
  fi

  echo "  + cron: $skill_name ($cron_expr)"
  CRON_COUNT=$((CRON_COUNT + 1))
}

# --- Scan openclaw-native skills for stateful/cron fields ---
mkdir -p "$STATE_DIR"
STATEFUL_COUNT=0
CRON_COUNT=0

for skill_file in "$REPO_DIR/skills/openclaw-native"/*/SKILL.md; do
  [ -f "$skill_file" ] || continue
  skill_name="$(basename "$(dirname "$skill_file")")"

  fm_stateful="$(
    awk '
      BEGIN { in_fm=0 }
      NR==1 && /^---$/ { in_fm=1; next }
      in_fm && /^---$/ { exit }
      in_fm && /^stateful:/ {
        sub(/^stateful:[[:space:]]*/, "", $0)
        gsub(/[[:space:]]/, "", $0)
        print
      }
    ' "$skill_file"
  )"

  fm_cron="$(
    awk '
      BEGIN { in_fm=0 }
      NR==1 && /^---$/ { in_fm=1; next }
      in_fm && /^---$/ { exit }
      in_fm && /^cron:/ {
        sub(/^cron:[[:space:]]*/, "", $0)
        gsub(/"/, "", $0)
        print
      }
    ' "$skill_file"
  )"

  if [ "$fm_stateful" = "true" ]; then
    register_stateful_skill "$skill_name"
    STATEFUL_COUNT=$((STATEFUL_COUNT + 1))
  fi

  if [ -n "$fm_cron" ]; then
    register_cron_skill "$skill_name" "$fm_cron"
  fi
done


openclaw config set skills.load.extraDirs "[\"$INSTALL_TARGET/skills\"]" --strict-json

openclaw gateway restart

echo ""
echo "openclaw-superpowers installed."
echo "  Skills symlinked to: $INSTALL_TARGET"
echo "  State directories:   $STATEFUL_COUNT created/preserved at $STATE_DIR"
echo "  Cron jobs registered: $CRON_COUNT"
echo ""
