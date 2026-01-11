# Agent Activity Log

**Purpose**: Chronological record of all agent actions

**Retention**: 90 days (archived monthly to `archive/`)

---

## [Current Date]

### [HH:MM:SS] - [agent-id]
- **Action**: session-start
- **Target**: N/A
- **Details**: Session started for [purpose]
- **Related**: docs/agents/manifest.md

---

## Log Entry Template

```markdown
### [HH:MM:SS] - [agent-id]
- **Action**: [action-type]
- **Target**: [task-id or file-path]
- **Details**: [description]
- **Related**: [links]
```

---

## Action Types

**Session**: session-start, session-end, status-change  
**Task**: task-claimed, task-released, task-status-change, task-completed  
**Handoff**: handoff-initiated, handoff-accepted, handoff-rejected  
**File**: file-created, file-modified, lock-acquired, lock-released, lock-conflict  
**Other**: conflict-detected, conflict-resolved, error-encountered, blocker-identified

---

## When to Log

**Always**:
- Session start/end
- Task ownership changes
- Status changes
- Handoff operations
- File locks
- Conflicts
- Blockers

**Sometimes**:
- Significant file changes
- Important decisions
- Deviations from plan

**Never**:
- Reading files
- Minor formatting
- Routine operations

---

## Helper Command

```bash
source scripts/agent-helpers.sh
log_activity [agent-id] [action] [target] "[details]"
```

---

## Maintenance

**Monthly**: Archive entries >90 days old to `archive/activity-YYYY-MM.md`

---

**See**: [AGENTS.md](../../AGENTS.md) for complete protocols
