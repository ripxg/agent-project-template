# Agent Instructions

**For AI Agents**: Read this document completely when starting work on this project.

---

## First Things First: Is This a New Project?

**Check**: Does `docs/delivery/` contain any PRD or task files?

### If NO (New Project) → Start Here

This is a fresh project. Your first job is to help the human turn their idea into an actionable plan.

**Step 1: Read the Human's Idea**
- Open `MY_IDEA.md` at the project root
- Understand what they want to build

**Step 2: Ask Clarifying Questions**

Before creating any plans, ask the human questions to fill gaps. Consider:

- **Scope**: What's the minimum viable version? What can wait for later?
- **Users**: Who specifically will use this? What's their skill level?
- **Technical**: Any technology preferences or constraints?
- **Integration**: Does this need to connect to other systems?
- **Data**: What information does it need to store or process?
- **Success**: How will they test if it's working?

Ask 3-5 focused questions. Don't overwhelm them.

**Step 3: Create the PRD**

Once you have clarity, create the project structure:

1. Create `docs/delivery/1/prd.md` with:
   ```markdown
   # PRD: [Project Name]

   ## Overview
   [Clear description of what this project does]

   ## Problem Statement
   [What problem it solves and for whom]

   ## Goals
   [What success looks like - measurable if possible]

   ## Scope
   ### In Scope (MVP)
   - [Feature 1]
   - [Feature 2]

   ### Out of Scope (Future)
   - [Deferred feature 1]

   ## Technical Approach
   [High-level architecture decisions]

   ## Open Questions
   [Anything still unresolved]
   ```

2. Create `docs/delivery/1/tasks.md`:
   ```markdown
   # Tasks for PRD 1

   | ID | Task | Status | Description |
   |----|------|--------|-------------|
   | 1-1 | [Task name] | Proposed | [What needs to be done] |
   | 1-2 | [Task name] | Proposed | [What needs to be done] |
   ```

3. Update `docs/delivery/backlog.md` with the PBI entry

**Step 4: Get Human Approval**

Present the PRD and task list to the human. Wait for their approval before implementing.

---

### If YES (Existing Project) → Continue Work

The project has an established structure. Follow these steps:

1. **Register yourself** in `docs/agents/manifest.md`
2. **Check for handoffs** in `docs/agents/handoffs/`
3. **Review current work** in `docs/delivery/`
4. **Claim a task** and start working

---

## Agent Registration

Before doing any work, register in `docs/agents/manifest.md`:

```markdown
| Agent ID | Type | Status | Current Task | Last Active |
|----------|------|--------|--------------|-------------|
| claude-20250114-1430 | claude | active | 1-1 | 2025-01-14 14:30 |
```

**Agent ID format**: `[type]-[YYYYMMDD]-[HHMM]`

**Update your status**:
- When starting: `active`
- When done for now: `idle`
- When leaving: `offline`

---

## Working on Tasks

### Claiming a Task

1. Check `docs/delivery/[PBI]/tasks.md` for available tasks
2. Verify no other agent owns it (check manifest)
3. Update task status to `InProgress`
4. Update your manifest entry with the task ID
5. Log the claim in `docs/agents/activity.md`

### Task Statuses

| Status | Meaning |
|--------|---------|
| Proposed | Defined, needs human approval |
| Agreed | Approved, ready to work on |
| InProgress | Someone is actively working on it |
| Review | Done, waiting for human to verify |
| Done | Human approved it |
| Blocked | Can't proceed, needs help |

### Completing a Task

1. Finish the work
2. Update task status to `Review`
3. Update manifest (set task to "none")
4. Log completion in activity
5. Wait for human approval → then mark `Done`

---

## Working with Multiple Agents

### Handoffs

When you need to pass work to another agent (or another agent type):

1. Create `docs/agents/handoffs/[task]-to-[agent-type].md`:
   ```markdown
   # Handoff: [Task ID]

   ## Context
   [What this task is about]

   ## What's Done
   [Work completed so far]

   ## What's Next
   [Remaining work for receiving agent]

   ## Important Notes
   [Blockers, decisions made, gotchas]
   ```

2. Update task status to `ReadyForHandoff`
3. Log the handoff in activity
4. Update manifest (your task = none)

### Receiving a Handoff

1. Read the handoff document completely
2. Claim the task (update manifest and task status)
3. Log acceptance in activity
4. Continue the work

---

## Activity Logging

Log significant actions in `docs/agents/activity.md`:

```markdown
## 2025-01-14

### 14:30 - claude-20250114-1430
- **Action**: Claimed task 1-1
- **Details**: Starting implementation of user authentication
```

**Log these events**:
- Session start/end
- Task claimed/completed
- Handoffs created/accepted
- Blockers encountered
- Significant decisions

---

## Key Principles

1. **Human Authority**: The human approves all plans and major decisions
2. **One Task at a Time**: Focus on completing tasks, don't juggle
3. **Stay in Scope**: Only do what the task requires
4. **Document Changes**: Keep activity log current
5. **Ask When Unsure**: Better to clarify than assume

---

## File Locations

```
project/
├── MY_IDEA.md              # Human's initial idea
├── AGENTS.md               # This file
├── docs/
│   ├── agents/
│   │   ├── manifest.md     # Who's working on what
│   │   ├── activity.md     # Work log
│   │   └── handoffs/       # Work transfers
│   └── delivery/
│       ├── backlog.md      # All PBIs
│       └── [PBI-ID]/
│           ├── prd.md      # Requirements
│           └── tasks.md    # Task list
```

---

## Quick Reference

**New project?** → Read MY_IDEA.md → Ask questions → Create PRD → Get approval

**Existing project?** → Register → Check handoffs → Claim task → Work → Log

**Need help?** → Ask the human
