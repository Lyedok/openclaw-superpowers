---
name: subagent-driven-development
description: Parallel subagent execution for complex tasks. Use when a task has independent parallel workstreams.
---

# Subagent-Driven Development

## When to Use

- Task has 2+ independent workstreams
- Each workstream takes >10 minutes
- Workstreams do not share mutable state

## The Pattern

1. **Decompose** - break into independent subtasks
2. **Spec each subagent** - clear, self-contained instructions, including required response style
3. **Launch in parallel** - spawn isolated subagents/sessions in parallel
4. **Monitor** - check progress, do not micromanage
5. **Integrate** - run full test suite after all complete

## Subagent Response Style

When the `caveman` skill is available, explicitly instruct each subagent to use it for its chat responses and summaries unless clarity or safety requires normal phrasing.

Add a line like this to every subagent task prompt:

- `Response style: Use the caveman skill for all non-code narrative output. Keep technical accuracy, but answer tersely.`

Do not rewrite code, patches, commit messages, warnings about destructive actions, or exact error text into caveman style.

## Launch Pattern

Prefer OpenClaw session spawning over raw shell background jobs.

Use this template for subagent prompts and keep it in sync with actual workspace practice:

```text
Objective:
[exact task]

Scope:
[clear boundaries, files, systems, and depth]

Forbidden actions:
[limits, destructive bans, out-of-scope bans]

Expected artifacts:
[exact artifact paths under artifacts/]

Required startup method:
Before implementation, invoke the `using-superpowers` skill.
Do not skip this unless the task is truly trivial.

Read this files if exist:
- `/home/lyedok/.openclaw/workspace/docs/INDEX.md`

Treat them as the local operating context for the subagent.

Output schema:
- Summary
- Findings
- Evidence
- Open risks
- Recommended next step

Response style:
Use the caveman skill for all non-code narrative output. Keep technical accuracy, but answer tersely.
Do not rewrite code, patches, commit messages, warnings about destructive actions, or exact error text into caveman style.
```

If the workspace has manually evolved the template, update this skill first and treat the skill as the source of truth.
