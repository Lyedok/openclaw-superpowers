#!/usr/bin/env bash
SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../skills" && pwd)"
PASS=0; FAIL=0
for skill_dir in "$SKILLS_DIR"/**/*; do
  if [ -d "$skill_dir" ]; then
    if [ ! -f "$skill_dir/SKILL.md" ]; then
      echo "FAIL: $(basename $skill_dir) missing SKILL.md"; FAIL=$((FAIL+1))
    else
      echo "PASS: $(basename $skill_dir)"; PASS=$((PASS+1))
    fi
  fi
done
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ]
