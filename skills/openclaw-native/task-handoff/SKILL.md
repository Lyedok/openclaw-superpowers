---
name: task-handoff
description: Gracefully hands off incomplete tasks across agent restarts. Use when work must be paused mid-task.
---

# Task Handoff

## Pre-Handoff Checklist

- [ ] Current state is stable (no half-written files, no broken tests)
- [ ] All changed files are saved
- [ ] Tests have been run
- [ ] Handoff document is written
- [ ] Memory is updated

## Handoff Document Format

Save to tasks/handoff-[task-name]-[timestamp].md:

```
# Handoff: [task name]
Written: YYYY-MM-DD HH:MM
Reason: [why stopping]

## Current State
[1-3 sentences: exactly where things are]

## What's Done
- [step] done

## What's Next
- [next step] - specific instructions

## Important Context
- [anything non-obvious from the code]
- [decisions made and why]

## Files Modified
- path/to/file - [what changed]

## Tests
- Last run: YYYY-MM-DD HH:MM
- Status: PASSING / FAILING

## Blockers
- [anything blocking]
```

## Picking Up a Handoff

1. Read the handoff document completely before touching any code
2. Run the tests to confirm current state
3. Start from 'What's Next' - do not redo completed steps
4. Delete the handoff file when task is complete
