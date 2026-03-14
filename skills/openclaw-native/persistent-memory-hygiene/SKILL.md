---
name: persistent-memory-hygiene
description: Keeps OpenClaw's memory store clean, structured, and useful. Use at session end and during periodic maintenance.
---

# Persistent Memory Hygiene

## Memory Structure

```
memory/
  YYYY-MM-DD.md    # Daily notes - raw, comprehensive
MEMORY.md          # Long-term - curated, distilled
```

## When to Write

Write to memory/YYYY-MM-DD.md when:
- Completing a significant task
- Making a decision with reasoning
- Encountering a notable error and its fix
- At checkpoints on long tasks

Write to MEMORY.md when:
- Something is worth remembering across months
- A user preference has been established
- A pattern has been confirmed

## Session Closing Routine

```
## [HH:MM] Session End
- Completed: [what was finished]
- In progress: [what was started]
- Next: [what to do next session]
- Decisions: [choices made and why]
```

## Hygiene Rules

- Daily files: write raw, append-only, never edit old entries
- MEMORY.md: review periodically, remove stale entries, keep under 500 lines
