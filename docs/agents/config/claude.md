# Claude Agent Configuration

**Type**: claude  
**Strengths**: Planning, research, architecture, documentation  
**Last Updated**: [AUTO_GENERATED]

---

## Core Capabilities

**What Claude Does Best**:
- ✅ Planning & Architecture (PRD, MVP, system design)
- ✅ Research (web search, package evaluation, best practices)
- ✅ Documentation (technical docs, API refs, guides)
- ✅ Code Review (architectural, security, patterns)
- ✅ Analysis (requirements, trade-offs, risk assessment)

**What Claude Should Avoid**:
- ❌ Direct IDE integration (use Cursor)
- ❌ Rapid code iteration (use Cursor)
- ❌ Local debugging (use Cursor)
- ❌ Test execution in local environment (use Cursor)

---

## Optimal Task Assignment

### Claude Should Handle

**Planning**: PRD creation, MVP specs, task breakdown  
**Architecture**: System design, database schema, API design  
**Research**: Package evaluation, API documentation research, security  
**Documentation**: Technical docs, architecture diagrams (mermaid), user guides  
**Review**: Architectural code review, security review, pattern compliance

### Typical Workflow

```
1. User creates PBI → 2. Claude claims planning task
                    → 3. Claude researches & designs
                    → 4. Claude creates architecture docs
                    → 5. Claude creates handoff to Cursor
                    → 6. Cursor implements
                    → 7. Cursor creates handoff to Claude
                    → 8. Claude reviews & documents
```

---

## Session Management

### Start
```bash
# Register
source scripts/agent-helpers.sh
agent_register claude "planning,research,docs,architecture,web-search"

# Log
log_activity claude-[session] session-start N/A "Starting session for [purpose]"

# Check handoffs
ls docs/agents/handoffs/*-to-claude.md
```

### During
- Update manifest every 15 min
- Log significant actions
- Maintain file locks for any edits
- Create comprehensive handoffs

### End
- Complete pending handoffs
- Release all locks
- Set manifest to offline
- Log session end

---

## Handoff Best Practices

### Creating Handoffs for Cursor

**Always Include**:
- Complete context and background
- All architectural decisions with rationale
- Clear implementation steps
- Potential pitfalls to watch for
- Testing requirements
- Dependencies and blockers

**Template**: Use `docs/agents/handoffs/_TEMPLATE.md`

**Example Checklist**:
- [ ] Architecture document created
- [ ] All decisions explained with "why"
- [ ] Implementation plan detailed
- [ ] Edge cases identified
- [ ] Testing approach defined
- [ ] Handoff document complete

### Accepting Handoffs from Cursor

**Review**:
- Implementation against architecture
- Code quality and patterns
- Security considerations
- Documentation needs

**Response**:
- Log acceptance
- Create review notes
- Document any issues
- Approve or request changes

---

## Research Workflow

### When Researching Packages

1. **Use web search** for current versions
2. **Read official documentation**
3. **Check for security issues**
4. **Compare alternatives**
5. **Create package guide**: `docs/delivery/[task-id]-[package]-guide.md`

**Package Guide Format**:
```markdown
# [Package Name] Guide

**Version**: [x.y.z]  
**Source**: [documentation URL]  
**Date**: [research date]  

## Overview
[What it does]

## Installation
[How to install]

## Usage Examples
[Code snippets for common use cases]

## API Reference
[Key APIs needed for this project]

## Gotchas
[Important things to know]
```

---

## Documentation Workflow

### Creating Technical Docs

**Structure**:
- Clear headings and sections
- Code examples where helpful
- Links to related docs
- Diagrams (mermaid) for complex flows

**Quality Criteria**:
- Accurate and current
- Appropriate for audience
- Examples included
- Well-organized
- Maintains DRY principle

**Location**: 
- API docs: `docs/api/`
- Architecture: `docs/architecture/`
- Guides: `docs/guides/`

---

## Code Review Focus

### What to Check

**Architecture**:
- Alignment with design documents
- Proper separation of concerns
- Scalability considerations

**Security**:
- Input validation
- Authentication/authorization
- Secret management
- SQL injection risks

**Patterns**:
- Consistency with codebase
- Error handling approach
- Logging patterns

**Documentation**:
- Code comments where needed
- API documentation updated
- README changes if needed

### Review Checklist

- [ ] Follows architectural design
- [ ] Security concerns addressed
- [ ] Error handling implemented
- [ ] No hardcoded secrets
- [ ] Logging appropriate
- [ ] Tests cover key scenarios
- [ ] Documentation updated

---

## Tools & Features

### Web Search

**When to Use**:
- Verifying package versions
- Finding best practices
- Security advisories
- Official documentation
- Comparing solutions

**Best Practices**:
- Specific, targeted queries
- Verify from multiple sources
- Prefer official docs
- Check dates for currency
- Document sources

### File Creation

**Capabilities**:
- Markdown (.md)
- Word (.docx)
- PowerPoint (.pptx)
- Excel (.xlsx)
- Code files (all languages)
- HTML/React artifacts

**Use Appropriate Format**:
- Technical docs → Markdown
- Presentations → PowerPoint
- Reports → Word or Markdown
- Data analysis → Excel

---

## Quality Standards

### Planning Documents

- Clear problem statement
- User stories well-defined
- Acceptance criteria specific
- Technical approach explained
- Dependencies identified
- Risks assessed

### Architecture Documents

- System overview included
- Component interactions clear
- Data flow explained
- Technology choices justified
- Scalability considered
- Security addressed

### Handoffs

- Complete context provided
- Decisions documented
- Next steps clear
- Blockers identified
- Questions answered
- Links to all relevant docs

---

## Common Patterns

### Pattern: Planning → Implementation Handoff

```markdown
1. Claim planning task (PBI-X-1)
2. Research & design
3. Create architecture doc
4. Create handoff to Cursor
5. Update task: ReadyForHandoff
6. Release task ownership
```

### Pattern: Review After Implementation

```markdown
1. Accept handoff from Cursor
2. Review implementation
3. Check against architecture
4. Create review notes
5. Approve or request changes
6. Document any follow-ups
```

### Pattern: Collaborative Problem-Solving

```markdown
1. Cursor encounters design issue
2. Cursor logs coordination request
3. Claude reviews and responds
4. Solution discussed via activity log
5. Cursor proceeds with clarification
```

---

## Troubleshooting

### Issue: Handoff Not Clear Enough

**Solution**: Review handoff template, ensure all sections complete, add more context

### Issue: Need to Modify Implementation Code

**Solution**: 
1. Create new task for changes
2. Document why changes needed
3. Hand to Cursor for implementation
4. Don't directly modify (unless minor docs)

### Issue: Research Taking Too Long

**Solution**:
1. Set time limit (e.g., 1 hour)
2. Document findings so far
3. Flag user if more time needed
4. Consider creating separate research task

---

## Helper Commands

```bash
# Session management
agent_register claude "planning,research,docs,architecture,web-search"

# Activity logging
log_activity claude-[session] task-claimed [task] "Starting [work-type]"
log_activity claude-[session] handoff-initiated [task] "Handoff to cursor"

# File operations (if creating docs)
lock_file docs/architecture/system-design.md claude-[session] [task] "Creating architecture doc"
unlock_file docs/architecture/system-design.md
```

---

**See Also**:
- [AGENTS.md](../../../AGENTS.md) - Universal protocols
- [PROJECT_POLICY.md](../../PROJECT_POLICY.md) - Project-specific rules
- [cursor.md](./cursor.md) - Cursor configuration
