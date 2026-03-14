---
name: context-window-management
description: Prevents context overflow on long-running OpenClaw sessions. Use when approaching context limits.
---

# Context Window Management

## Warning Signs

- Session running for many hours
- Responses getting slower or less coherent
- Carrying context about completed tasks no longer relevant
- Large code blocks in context not being actively used

## Reduction Strategies

### Summarize Completed Work
Replace detailed context about finished tasks with short summaries.

### Externalize Reference Material
Move large docs/schemas to files. Reference them by filename rather than including in context.

### Clean Session Restart
Write comprehensive handoff document, start fresh session, load only what's needed.

## What to Keep in Context

- Current task objective
- Current step being executed
- Relevant code being modified (just the parts in scope)
- Recent error messages if debugging

## What to Offload

- Completed task details (summarize to memory)
- Full file contents of files not currently being edited
- Conversation history from different topics hours ago
- Reference docs that can be re-read on demand
