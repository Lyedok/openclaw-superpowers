---
name: agent-self-recovery
description: Detects when the agent is stuck in a loop and escapes systematically. Use when you notice repeated failures or loss of direction.
---

# Agent Self-Recovery

## Signs You're Stuck

- Tried the same approach 3+ times with the same result
- Making changes that feel random rather than targeted
- Lost track of the original goal
- Taking longer than expected on a 'simple' step

## Recovery Protocol

### Step 1: Stop
Stop making changes. No more quick tries.

### Step 2: Write Down What's Happening
In memory, write:
- What were you trying to do?
- What have you tried?
- What result are you getting?
- What would success look like?

### Step 3: Name the Loop
- 'Loop: trying the same fix with minor variations'
- 'Loop: each fix reveals a new dependency'
- 'Loop: unclear what the actual error is'

### Step 4: Break the Loop

If unclear about the error: use systematic-debugging first.
If tried multiple approaches: re-read the original requirement.
If genuinely blocked: document clearly, ask the user.
If context too large: use context-window-management.
If truly lost: use task-handoff, ask user to redirect.

### Step 5: Resume with a New Approach
Choose a genuinely different approach - not a variation of the failed one.
