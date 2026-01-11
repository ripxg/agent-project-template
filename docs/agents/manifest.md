# Agent Manifest

**Purpose**: Tracks all AI agents working on this project

**Last Updated**: [AUTO_GENERATED]

---

## Active Agents

| Agent ID | Type | Status | Last Active | Current Task | Capabilities |
|----------|------|--------|-------------|--------------|--------------|
|          |      |        |             |              |              |

---

## Agent Type Reference

| Type | Capabilities | Best For |
|------|--------------|----------|
| claude | planning, research, docs, architecture, web-search | Planning, design, documentation |
| cursor | implementation, testing, debugging, ide-integration | Coding, testing, debugging |
| copilot | code-completion | Code suggestions |

---

## Status Definitions

- **active**: Currently working on a task
- **idle**: Registered but awaiting work
- **offline**: Session ended

---

## Usage

### Register Session

```markdown
| [type]-YYYYMMDD-HHMM | [type] | active | [ISO-8601-timestamp] | none | [capabilities] |
```

**Example**:
```markdown
| claude-20250111-1430 | claude | active | 2025-01-11T14:30:00Z | none | planning,research,docs |
```

### During Session

- Update "Last Active" every 15 minutes
- Update "Current Task" when claiming/releasing tasks
- Set "Status" to idle when awaiting input

### End Session

- Set "Status" to offline
- Ensure all locks released
- Complete any pending handoffs

---

## Helper Command

```bash
source scripts/agent-helpers.sh
agent_register [type] "[capabilities]"
```

---

**See**: [AGENTS.md](../../AGENTS.md) for complete protocols
