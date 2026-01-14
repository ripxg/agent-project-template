# Project Policy

Rules for working on this project. Read after AGENTS.md.

---

## Core Rules

1. **Human Approves Everything** - Get approval before implementing major features or changes
2. **One Task at a Time** - Complete tasks before starting new ones
3. **Stay in Scope** - Only do what the task requires, no extras
4. **Document Your Work** - Keep the activity log updated

---

## Task Workflow

```
Proposed → Agreed → InProgress → Review → Done
```

| Status | Meaning | Who Does This |
|--------|---------|---------------|
| Proposed | Task defined, needs approval | Agent proposes |
| Agreed | Approved, ready to work | Human approves |
| InProgress | Being worked on | Agent claims |
| Review | Work done, needs verification | Agent submits |
| Done | Verified and accepted | Human approves |

---

## Working on Tasks

### Before Starting
- Check the task is `Agreed` status
- Check no other agent is working on it (see manifest)

### While Working
- Keep the activity log updated
- Ask the human if requirements are unclear
- Stay within task scope

### When Done
- Update task status to `Review`
- Update manifest (set your task to "none")
- Log completion in activity

---

## Quality Standards

- Read existing code before making changes
- Follow existing patterns in the codebase
- Test your changes work
- Clean up any mess you make

---

## When Uncertain

Ask the human. It's always better to clarify than to assume.

---

**See**: [AGENTS.md](../AGENTS.md) for detailed agent instructions
