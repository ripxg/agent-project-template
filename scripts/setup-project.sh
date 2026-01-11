#!/bin/bash
# setup-project.sh
# Initialize a new project from this template

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Multi-Agent Project Setup            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Get project name
if [ -z "$1" ]; then
  echo -n "Enter project name: "
  read PROJECT_NAME
else
  PROJECT_NAME="$1"
fi

echo ""
echo -e "${YELLOW}Setting up: $PROJECT_NAME${NC}"
echo ""

# Update README.md
echo -e "${GREEN}→${NC} Updating README.md..."
sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" README.md
rm README.md.bak

# Update AGENTS.md
echo -e "${GREEN}→${NC} Updating AGENTS.md..."
sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" AGENTS.md
sed -i.bak "s/\[AUTO_GENERATED\]/$(date -I)/g" AGENTS.md
rm AGENTS.md.bak

# Update manifest
echo -e "${GREEN}→${NC} Updating manifest..."
sed -i.bak "s/\[AUTO_GENERATED\]/$(date -I)/g" docs/agents/manifest.md
rm docs/agents/manifest.md.bak

# Update activity log with current date
echo -e "${GREEN}→${NC} Updating activity log..."
CURRENT_DATE="## $(date +%Y-%m-%d)"
sed -i.bak "s/\[Current Date\]/$CURRENT_DATE/g" docs/agents/activity.md
rm docs/agents/activity.md.bak

# Create initial backlog
echo -e "${GREEN}→${NC} Creating product backlog..."
cat > docs/delivery/backlog.md << 'EOF'
# Product Backlog

**Project**: [PROJECT_NAME]  
**Last Updated**: [AUTO_GENERATED]

---

## Active PBIs

| ID | Actor | User Story | Status | Conditions of Satisfaction (CoS) |
|----|-------|------------|--------|-----------------------------------|
|    |       |            |        |                                   |

---

## PBI Status Definitions

- **Proposed**: Suggested but not yet approved
- **Agreed**: Approved and ready for implementation
- **InProgress**: Being actively worked on
- **InReview**: Implementation complete, awaiting review
- **Done**: Completed and accepted
- **Rejected**: Rejected, requires rework or deprioritization

---

## PBI Workflow

1. Create PBI with clear user story and acceptance criteria
2. Move to Agreed when approved
3. Create detailed PBI document in `docs/delivery/[PBI-ID]/prd.md`
4. Break into tasks in `docs/delivery/[PBI-ID]/tasks.md`
5. Work progresses (InProgress)
6. Submit for review (InReview)
7. Complete (Done) or rework (Rejected)

---

## Creating a New PBI

1. Add row to table above with unique ID
2. Create directory: `mkdir -p docs/delivery/[PBI-ID]`
3. Create PRD: `docs/delivery/[PBI-ID]/prd.md`
4. Create tasks list: `docs/delivery/[PBI-ID]/tasks.md`
5. Agent can claim planning task

---

**See**: [PROJECT_POLICY.md](../PROJECT_POLICY.md) for complete workflow
EOF

sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" docs/delivery/backlog.md
sed -i.bak "s/\[AUTO_GENERATED\]/$(date -I)/g" docs/delivery/backlog.md
rm docs/delivery/backlog.md.bak

# Create PROJECT_POLICY.md
echo -e "${GREEN}→${NC} Creating PROJECT_POLICY.md..."
cat > docs/PROJECT_POLICY.md << 'EOF'
# Project Policy

**Project**: [PROJECT_NAME]  
**Version**: 1.0.0  
**Last Updated**: [AUTO_GENERATED]

> This document defines project-specific rules that build on the Universal Agent Standard (AGENTS.md)

---

## 1. Introduction

### 1.1 Actors

- **User**: Individual responsible for requirements, approval, accountability
- **AI_Agent**: Delegate executing user instructions per PBIs and tasks

### 1.2 Multi-Agent Coordination

All agents MUST follow [AGENTS.md](../AGENTS.md) - Universal Agent Standard.

**Core Requirements**:
1. Register in manifest before any work
2. Log significant actions in activity log
3. Respect task ownership (one agent per task)
4. Use formal handoff protocols
5. Acquire file locks before modifications

**Precedence**: AGENTS.md > PROJECT_POLICY.md > Agent config

---

## 2. Fundamental Principles

1. **Task-Driven Development**: No code changes without approved task
2. **PBI Association**: No task without associated PBI
3. **User Authority**: User decides scope and design
4. **User Responsibility**: User accountable for all changes
5. **No Unapproved Changes**: Changes outside task scope PROHIBITED
6. **Status Sync**: Task status must match in file and index
7. **No Uncontrolled Files**: Files only per defined structures
8. **Package Research**: Research and document external packages
9. **Task Granularity**: Tasks as small as practical
10. **DRY**: Define information once, reference elsewhere

---

## 3. PBI Management

### 3.1 Location

`docs/delivery/backlog.md`

### 3.2 PBI Workflow

**Statuses**: Proposed → Agreed → InProgress → InReview → Done | Rejected

**PBI Structure**:
- PBI entry in backlog.md
- Detailed PRD: `docs/delivery/[PBI-ID]/prd.md`
- Tasks list: `docs/delivery/[PBI-ID]/tasks.md`
- Individual task files: `docs/delivery/[PBI-ID]/[PBI-ID]-[TASK-ID].md`

---

## 4. Task Management

### 4.1 Task Workflow

**Statuses**: Proposed → Agreed → InProgress → Review → Done | Blocked

**One InProgress per PBI**: Only one task per PBI in InProgress at a time

### 4.2 Task Files

- Task list: `docs/delivery/[PBI-ID]/tasks.md`
- Task details: `docs/delivery/[PBI-ID]/[PBI-ID]-[TASK-ID].md`

### 4.3 Required Sections

Each task file must include:
- Description
- Status History
- Requirements
- Implementation Plan
- Test Plan
- Verification
- Files Modified

---

## 5. Testing Requirements

### 5.1 Test Approach

- **Unit Tests**: Individual functions/methods in isolation
- **Integration Tests**: Component interactions
- **E2E Tests**: Critical user paths

### 5.2 Coverage Goals

- Unit tests: >80% for new code
- Integration tests: All API endpoints
- E2E tests: All critical user workflows

### 5.3 Test Plans

Every implementation task MUST include test plan proportional to complexity.

---

## 6. Agent Routing

| Task Type | Preferred Agent | Fallback |
|-----------|----------------|----------|
| Planning/PRD | claude | human |
| Architecture | claude | human |
| Research | claude | human |
| Implementation | cursor | claude |
| Testing | cursor | claude |
| Debugging | cursor | claude |
| Documentation | claude | cursor |
| Code Review | claude, cursor | human |

**See**: `docs/agents/config/` for detailed agent capabilities

---

## 7. Change Management

1. Conversation about code changes must identify linked PBI/Task
2. All changes associated with specific task
3. No changes outside task scope
4. Scope creep identified, rolled back, addressed in new task
5. User asks for change without task → discuss before work

---

## 8. Quality Standards

### 8.1 All Work Must

- Read existing code/docs before changes
- Follow project conventions
- Test before committing
- Document changes
- Clean up (remove dead code)
- Respect scope

### 8.2 Code Standards

- Self-documenting code preferred over comments
- Named constants for magic values
- Consistent naming conventions
- Proper error handling
- Appropriate logging
- Resource cleanup

---

## 9. Git Conventions

### 9.1 Commit Messages

```
[task-id] [description]

[optional body]
```

### 9.2 Commit Types

- feat: New feature
- fix: Bug fix
- docs: Documentation
- refactor: Code restructuring
- test: Tests
- chore: Maintenance

---

## 10. Documentation

### 10.1 Technical Documentation

APIs and interfaces require documentation:
- API usage examples
- Interface contracts
- Integration guidelines
- Configuration options
- Error handling

**Location**: `docs/technical/` or inline

---

**For complete agent protocols**, see [AGENTS.md](../AGENTS.md)
EOF

sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" docs/PROJECT_POLICY.md
sed -i.bak "s/\[AUTO_GENERATED\]/$(date -I)/g" docs/PROJECT_POLICY.md
rm docs/PROJECT_POLICY.md.bak

# Make scripts executable
echo -e "${GREEN}→${NC} Making scripts executable..."
chmod +x scripts/*.sh

# Initialize git if not already initialized
if [ ! -d .git ]; then
  echo -e "${GREEN}→${NC} Initializing git repository..."
  git init -q
  
  # Create .gitignore
  cat > .gitignore << 'EOF'
# Dependencies
node_modules/
vendor/

# Environment
.env
.env.local

# Build outputs
dist/
build/
*.log

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Archives (optional - keep recent)
# docs/agents/archive/
EOF

  git add .
  git commit -m "Initial commit from multi-agent template" -q
fi

echo ""
echo -e "${GREEN}✓ Project setup complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "  1. Review and customize docs/PROJECT_POLICY.md"
echo "  2. Create your first PBI in docs/delivery/backlog.md"
echo "  3. Have an AI agent register and start work:"
echo ""
echo "     source scripts/agent-helpers.sh"
echo "     agent_register [type] \"[capabilities]\""
echo ""
echo -e "${YELLOW}For AI Agents: Read AGENTS.md before starting work${NC}"
echo ""
