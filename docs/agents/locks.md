# File Locks

**Purpose**: Prevent simultaneous file modifications

**Timeout**: 1 hour (auto-released)

---

## Active Locks

| File Path | Locked By | Locked At | Task ID | Reason |
|-----------|-----------|-----------|---------|--------|
|           |           |           |         |        |

---

## Usage

### Acquire Lock

```markdown
1. Check for existing lock: grep "[file-path]" docs/agents/locks.md
2. If unlocked, add entry:
   | [file-path] | [agent-id] | [ISO-8601-timestamp] | [task-id] | [reason] |
3. Commit locks.md
4. Make changes
5. Release lock (see below)
```

### Release Lock

```markdown
1. Commit your changes
2. Remove lock entry from table above
3. Commit locks.md unlock
```

### If File Locked

**Options**:
- Wait for release (typical: 15-45 min)
- Coordinate via activity log
- Choose different task
- Request override (emergency only, requires user approval)

---

## Lock Guidelines

**Always Lock**:
- Source code files
- Shared configuration
- Database migrations
- Shared documentation

**Never Lock**:
- Your agent-specific logs
- Task files you own
- Read-only operations

---

## Helper Commands

```bash
source scripts/agent-helpers.sh
lock_file [file] [agent-id] [task] "[reason]"
unlock_file [file]
show_locks
```

---

## Automatic Management

- **Stale locks**: Released after 1 hour
- **Session end**: All agent locks auto-released
- **Conflicts**: First commit wins (earlier timestamp)

---

**See**: [AGENTS.md](../../AGENTS.md) for complete protocols
