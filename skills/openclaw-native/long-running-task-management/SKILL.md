---
name: long-running-task-management
description: Breaks multi-hour tasks into checkpointed stages with resume capability. Use when a task is expected to take more than 30 minutes or multiple sessions.
---

# Long-Running Task Management

## When to Use

- Task estimated at more than 30 minutes
- Task will span multiple sessions
- Task modifies many files across multiple directories

## Task File Format

Create tasks/YYYY-MM-DD-task-name.md:

```
# Task: [name]
Created: YYYY-MM-DD HH:MM
Status: IN_PROGRESS

## Goal
[one sentence]

## Steps
[ ] 1. ...
[ ] 2. ... [CHECKPOINT]
[ ] 3. ...

## Checkpoint State
[Updated at each checkpoint]

## Blockers
[Anything blocking progress]
```

## At Each Checkpoint

1. Complete the step
2. Run tests/verification
3. Update the task file (mark steps done, write checkpoint state)
4. Update memory/YYYY-MM-DD.md
5. Commit progress to git if applicable

## Resume After Interruption

1. Read the task file
2. Read Checkpoint State
3. Read recent memory entries
4. Continue from the next incomplete step - do NOT start over

## Completion

1. Update task file status to COMPLETE
2. Run full verification
3. Update memory
4. Move task file to tasks/completed/
