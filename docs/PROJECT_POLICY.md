# Project Policy

**For AI Agents**: Project-specific rules that extend AGENTS.md. Read completely before starting work.

---

## 1. Actors and Roles

| Actor | Role | Authority |
|-------|------|-----------|
| **Human** | Product owner | Defines requirements, final accountability, can approve any work |
| **Planning Agent** | Architect | Creates PRDs, designs solutions, approves implementation approaches |
| **Worker Agent** | Implementer | Executes tasks per PRD, writes code, creates tests |
| **Review Agent** | Oversight | Reviews code quality, approves completed work, ensures standards |

**Key principle**: Worker agents require oversight approval (planning or review agent) before tasks move to Done. Human approval is required for PRD scope and final acceptance, but not for every task.

---

## 2. Agent Capabilities and Routing

| Task Type | Primary Agent | Can Approve | Fallback |
|-----------|---------------|-------------|----------|
| PRD creation | Planning (claude) | Human | Human |
| Architecture | Planning (claude) | Human | Human |
| Research | Planning (claude) | Self | Human |
| Implementation | Worker (cursor) | Review agent | Planning agent |
| Testing | Worker (cursor) | Review agent | Planning agent |
| Code review | Review (claude) | Self | Human |
| Documentation | Planning (claude) | Review agent | Human |

**Parallel work**: Multiple agents CAN work simultaneously on different PBIs. Each PBI should have only one agent actively working on it at a time.

---

## 3. PBI and Task Structure

### 3.1 File Locations

```
docs/delivery/
├── backlog.md                    # Master list of all PBIs
└── [PBI-ID]/
    ├── prd.md                    # Requirements for this PBI
    ├── tasks.md                  # Task index
    └── [PBI-ID]-[task-num].md    # Individual task files
```

### 3.2 PBI Workflow

```
Proposed → Agreed → InProgress → InReview → Done
                                    ↓
                                Rejected → InProgress
```

| Status | Meaning | Who Transitions |
|--------|---------|-----------------|
| Proposed | Created, awaiting approval | Agent creates |
| Agreed | Human approved scope | Human approves |
| InProgress | Active development | Agent claims |
| InReview | All tasks complete | Agent submits |
| Done | Accepted | Human approves |

### 3.3 Task Workflow

```
Proposed → Agreed → InProgress → ReadyForHandoff → Review → Done
                        ↓                            ↓
                    Blocked                      Rejected
```

| Status | Meaning | Who Transitions |
|--------|---------|-----------------|
| Proposed | Defined, needs approval | Agent proposes |
| Agreed | Approved for work | Planning agent or human |
| InProgress | Agent actively working | Worker agent |
| ReadyForHandoff | Needs different agent type | Current agent |
| Review | Complete, awaiting verification | Worker agent submits |
| Done | Verified and accepted | Review agent or human |
| Blocked | Cannot proceed | Any agent |

---

## 4. Core Rules

### 4.1 Task-Driven Development
- No code changes without an approved task
- No task without an associated PBI
- Changes outside task scope are PROHIBITED

### 4.2 Scope Control

**Prohibited behaviors:**
- Gold plating (adding unrequested features)
- Scope creep (expanding task boundaries)
- Creating files outside defined structures

**Required behavior:**
- Improvements discovered during work → propose as new task
- Scope questions → pause and ask before proceeding

### 4.3 Status Synchronization

Task status must match in BOTH:
1. Individual task file (`docs/delivery/[PBI]/[task].md`)
2. Task index (`docs/delivery/[PBI]/tasks.md`)

If mismatch found, reconcile before proceeding.

---

## 5. Multi-Agent Coordination

### 5.1 Claiming Tasks

1. Check task status is `Agreed` or `ReadyForHandoff`
2. Verify no other agent owns it (check manifest)
3. Update task status to `InProgress`
4. Update manifest with task ID
5. Log claim in activity

### 5.2 Parallel Work Rules

- Multiple agents CAN work on different PBIs simultaneously
- Only ONE agent per PBI at a time (unless human approves parallel)
- Check manifest before claiming any task
- Coordinate via activity log if questions arise

### 5.3 Handoff Protocol

When task requires different agent capabilities:

1. Complete your portion of work
2. Update task status to `ReadyForHandoff`
3. Create handoff document in `docs/agents/handoffs/`
4. Update manifest (your task = none)
5. Log handoff in activity

Receiving agent:
1. Review handoff document
2. Claim task (update manifest and status to InProgress)
3. Log acceptance
4. Continue work

### 5.4 Approval Flow

```
Worker completes task
        ↓
Worker sets status: Review
        ↓
Review agent examines work
        ↓
    ┌───┴───┐
Approved    Rejected
    ↓           ↓
  Done      InProgress (with feedback)
```

---

## 6. Task File Structure

```markdown
# [Task-ID] [Task-Name]

## Description
[What this task accomplishes]

## Status
[Current status]

## Requirements
[Specific requirements]

## Implementation Plan
[Approach - filled by planning/worker agent]

## Test Plan
[How to verify - proportional to complexity]

## Files Modified
| File | Action | Description |
|------|--------|-------------|

## Status History
| Timestamp | From | To | Agent | Notes |
|-----------|------|-----|-------|-------|
```

---

## 7. Quality Standards

- Read existing code before making changes
- Follow existing patterns in the codebase
- Test changes before marking Review
- Clean up (remove dead code, unused imports)
- Respect task scope - no extras

---

## 8. Change Management

```
Request received
      ↓
Existing task? ──No──→ Create PBI + task first
      ↓ Yes                    ↓
Within scope? ←────────────────┘
      ↓ Yes      ↓ No
Proceed      Discuss: expand task OR create new task
```

**Rule**: Never implement changes without identifying the linked PBI/Task first.

---

## 9. Exception Handling

### 9.1 Scope Disagreements

1. State concern explicitly with task reference
2. Propose options: expand current task OR create new task
3. Wait for planning agent or human decision

### 9.2 Blockers

1. Update task status to `Blocked`
2. Document blocker in task file
3. Log in activity with details
4. Consider: Can blocker be addressed as separate task?

### 9.3 Conflicts

- Status conflicts: Latest timestamp wins
- Task claim conflicts: Earlier timestamp wins
- File conflicts: Coordinate via activity log, escalate to human if needed

---

## Quick Reference

**Starting work**: Register → Check handoffs → Claim task → Log → Work within scope

**Completing work**: Verify requirements → Update status to Review → Log → Await approval

**Handing off**: Document context → Set ReadyForHandoff → Create handoff file → Log

**Need approval**: Worker → Review agent. PRD scope → Human.

---

**See**: [AGENTS.md](../AGENTS.md) for registration, handoffs, and activity logging details
