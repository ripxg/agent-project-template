# Universal Agent Standard (UAS)

**Version**: 1.0.0  
**Project**: [PROJECT_NAME]  
**Last Updated**: [AUTO_GENERATED]

> **For AI Agents**: This document defines mandatory protocols for multi-agent collaboration. Read completely before starting work.

---

## Quick Reference

**Before ANY work**:
- ✅ Register in `docs/agents/manifest.md`
- ✅ Check for handoffs in `docs/agents/handoffs/`
- ✅ Review `docs/PROJECT_POLICY.md` for project specifics

**During work**:
- ✅ Log significant actions in `docs/agents/activity.md`
- ✅ Acquire file locks in `docs/agents/locks.md`
- ✅ Update task ownership in task files

**When complete**:
- ✅ Create handoff if needed
- ✅ Release all locks
- ✅ Update manifest status

---

## 1. Agent Registration (MANDATORY)

### Register Before First Action

```markdown
# Edit docs/agents/manifest.md

| [agent-type]-[YYYYMMDD]-[HHMM] | [type] | active | [timestamp] | none | [capabilities] |
```

**Example**:
```markdown
| claude-20250111-1430 | claude | active | 2025-01-11T14:30:00Z | none | planning,research,docs,web-search |
```

**Standard Agent Types**:
- `claude` - Planning, research, architecture, documentation
- `cursor` - Implementation, testing, debugging, refactoring
- `copilot` - Code completion, suggestions

### Session Management

**Start**: Register → Log session start → Check handoffs  
**Active**: Update manifest every 15min → Log actions → Maintain locks  
**End**: Complete handoffs → Release locks → Set status offline

---

## 2. Activity Logging (MANDATORY)

### Log All Significant Actions

**Location**: `docs/agents/activity.md`

**Format**:
```markdown
### [HH:MM:SS] - [agent-id]
- **Action**: [action-type]
- **Target**: [task/file/pbi]
- **Details**: [description]
- **Related**: [links]
```

**Always Log**:
- Session start/end
- Task claims/releases
- Status changes
- Handoffs
- File modifications (bulk)
- Conflicts
- Blockers

---

## 3. Task Ownership (MANDATORY)

### One Owner Per Task

**Rules**:
1. Only ONE agent owns a task at any time
2. Check manifest before claiming
3. Update task status history with agent-id
4. Release ownership on completion or handoff

**Claim Process**:
```markdown
1. Verify task status: Agreed or ReadyForHandoff
2. Check manifest: No other owner
3. Update task file status history
4. Update manifest current task
5. Log claim in activity
```

---

## 4. File Locking (MANDATORY)

### Prevent Simultaneous Modifications

**Before modifying ANY file**:

```markdown
1. Check docs/agents/locks.md
2. If unlocked, add entry:
   | [file] | [agent-id] | [timestamp] | [task] | [reason] |
3. Commit locks.md
4. Make changes
5. Commit changes
6. Remove lock entry
7. Commit unlock
```

**If Locked**: Wait, coordinate via activity log, or choose different task

**Auto-Release**: After 1 hour or on session end

---

## 5. Handoff Protocol (MANDATORY)

### When to Create Handoff

- Task type changes (planning → implementation → testing)
- Capability limitation encountered
- Task reassigned to different agent
- Session ending with incomplete work

### Handoff Process

**Initiating Agent**:
```markdown
1. Create docs/agents/handoffs/[task]-[from]-to-[to].md
2. Use template from docs/agents/handoffs/_TEMPLATE.md
3. Document: context, decisions, next steps, blockers
4. Update task status: ReadyForHandoff
5. Log handoff in activity
6. Update manifest: task=none, status=idle
7. Release all locks
```

**Receiving Agent**:
```markdown
1. Review handoff document thoroughly
2. Log acceptance in activity
3. Update task status: InProgress
4. Update manifest: task=[task-id]
5. Claim ownership
```

---

## 6. Capability-Based Routing

### Assign Tasks to Best Agent

| Task Type | Preferred | Fallback |
|-----------|-----------|----------|
| Planning/PRD | claude | human |
| Architecture | claude | human |
| Research | claude | human |
| Implementation | cursor | claude |
| Testing | cursor | claude |
| Debugging | cursor | claude |
| Documentation | claude | cursor |
| Code Review | claude, cursor | human |

**See**: `docs/agents/config/[agent-type].md` for detailed capabilities

---

## 7. Status Synchronization

### Keep Status Consistent

**Update Both Locations**:
1. Task file status history
2. Task index (e.g., `docs/delivery/[pbi]/tasks.md`)

**Include Agent ID**:
```markdown
| [timestamp] | Status Change | [from] | [to] | [agent-id]: [details] | [user] |
```

**Verify Before Work**:
- Task file status = Task index status
- If mismatch, reconcile before proceeding

---

## 8. Conflict Resolution

### When Conflicts Occur

**Status Conflicts**: Last write wins (latest timestamp)  
**File Conflicts**: Standard git resolution  
**Task Claims**: Earlier timestamp wins  

**Always**:
1. Log conflict in activity
2. Notify user
3. Document resolution
4. Update process to prevent recurrence

---

## 9. Quality Standards

### All Agents Must

- Read existing code/docs before changes
- Follow project conventions and patterns
- Test before committing
- Document changes appropriately
- Clean up (remove dead code)
- Respect task scope (no gold-plating)

### Communication

**With Users**: Clear, direct, ask when uncertain  
**With Agents**: Via activity log, structured, specific  
**Style**: Professional, helpful, honest

---

## 10. Pre-Action Checklist

**Before ANY work**:
- [ ] Registered in manifest?
- [ ] Session ID current?
- [ ] Task available or handoff ready?
- [ ] Files unlocked?
- [ ] Intent logged?
- [ ] Required capabilities?

**Before ANY commit**:
- [ ] Changes within task scope?
- [ ] Status updated?
- [ ] Activity logged?
- [ ] Locks released?
- [ ] No conflicts?
- [ ] Tests pass (if code)?

---

## Integration with Project

**Precedence** (highest to lowest):
1. Safety & Ethics
2. Universal Agent Standard (this document)
3. PROJECT_POLICY.md (project-specific rules)
4. Agent-specific config (preferences)

**Conflicts**: Higher precedence wins

**Extensions**: Projects may add to UAS but not contradict core principles

---

## File Locations

```
project-root/
├── AGENTS.md (this file)
├── docs/
│   ├── PROJECT_POLICY.md
│   ├── agents/
│   │   ├── manifest.md
│   │   ├── activity.md
│   │   ├── locks.md
│   │   ├── config/
│   │   │   ├── claude.md
│   │   │   └── cursor.md
│   │   └── handoffs/
│   │       └── _TEMPLATE.md
│   └── delivery/
│       └── [PBI-ID]/
│           ├── prd.md
│           ├── tasks.md
│           └── [task-files].md
└── scripts/
    └── agent-helpers.sh
```

---

## Quick Commands

**Register**:
```bash
source scripts/agent-helpers.sh
agent_register [type] "[capabilities]"
```

**Log Activity**:
```bash
log_activity [agent-id] [action] [target] "[details]"
```

**Lock File**:
```bash
lock_file [file] [agent-id] [task] "[reason]"
```

**Unlock File**:
```bash
unlock_file [file]
```

---

## Emergency Procedures

**Agent Interrupted**: Work left in InProgress, locks timeout after 1hr  
**Corrupted State**: Stop, log with CRITICAL marker, notify user  
**Lock Deadlock**: Newest waiter backs off, user notified if >30min

---

## Version & Updates

**Current Version**: 1.0.0

**Updates**: Proposed via GitHub issue → User approval → Document updated → Agents notified

---

**Remember**: This is the foundation for collaboration. When in doubt, over-communicate via activity log and ask the user.

For detailed information, see:
- Agent-specific configs: `docs/agents/config/`
- Project-specific rules: `docs/PROJECT_POLICY.md`
- Setup guide: `docs/IMPLEMENTATION_GUIDE.md`
