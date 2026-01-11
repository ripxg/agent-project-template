# Cursor Agent Configuration

**Type**: cursor  
**Strengths**: Implementation, testing, debugging, refactoring  
**Last Updated**: [AUTO_GENERATED]

---

## Core Capabilities

**What Cursor Does Best**:
- ✅ Implementation (writing production code)
- ✅ Testing (unit tests, integration tests, test execution)
- ✅ Debugging (breakpoints, inspection, local testing)
- ✅ Refactoring (code restructuring with IDE support)
- ✅ IDE Integration (direct file access, git, terminal)

**What Cursor Should Avoid**:
- ❌ Web research (use Claude)
- ❌ High-level architecture design (use Claude)
- ❌ Long-form documentation (use Claude)
- ❌ Strategic planning (use Claude)

---

## Optimal Task Assignment

### Cursor Should Handle

**Implementation**: Production code, services, controllers, models, APIs  
**Testing**: Unit tests, integration tests, test execution, test fixtures  
**Debugging**: Bug investigation, performance profiling, error reproduction  
**Refactoring**: Code restructuring, pattern implementation, cleanup

### Typical Workflow

```
1. Claude creates architecture → 2. Claude hands off to Cursor
                               → 3. Cursor reviews handoff
                               → 4. Cursor implements feature
                               → 5. Cursor writes & runs tests
                               → 6. Cursor hands back to Claude
                               → 7. Claude reviews & documents
```

---

## Session Management

### Start
```bash
# Register
source scripts/agent-helpers.sh
agent_register cursor "implementation,testing,debugging,refactoring,ide-integration"

# Log
log_activity cursor-[session] session-start N/A "Starting session for [purpose]"

# Check handoffs
ls docs/agents/handoffs/*-to-cursor.md
```

### During
- Update manifest every 15 min (automate if possible)
- Log significant actions
- Maintain file locks
- Commit frequently

### End
```bash
# Before closing Cursor
1. Commit all pending changes
2. Release all locks
3. Update manifest: offline
4. Log session end
```

---

## Handoff Best Practices

### Accepting Handoffs from Claude

**Review Process**:
1. Read handoff document completely
2. Review architecture documentation
3. Check dependencies are available
4. Verify environment setup
5. Note any questions
6. Log acceptance

**Before Starting**:
- [ ] Understand architectural decisions
- [ ] Implementation plan clear
- [ ] Dependencies available
- [ ] Environment configured
- [ ] Test approach understood

### Creating Handoffs to Claude

**For Code Review**:
```markdown
# Include in handoff
- All files created/modified
- Implementation decisions made
- Deviations from architecture (with reasons)
- Test coverage summary
- Known issues or limitations
- Areas needing review
```

**Handoff Checklist**:
- [ ] All code committed and pushed
- [ ] All tests passing
- [ ] Implementation decisions documented
- [ ] Deviations explained
- [ ] Files listed
- [ ] Review needs identified

---

## Implementation Workflow

### Before Coding

1. **Review Architecture**: Read design docs thoroughly
2. **Check Patterns**: Review existing code for patterns
3. **Plan Approach**: Break down into small steps
4. **Acquire Locks**: Lock files you'll modify

### During Implementation

1. **Follow Architecture**: Stick to design unless issue found
2. **Match Patterns**: Use existing code style
3. **Test as You Go**: Write/run tests incrementally
4. **Commit Frequently**: Small, atomic commits
5. **Document Decisions**: If deviating, document why

### After Implementation

1. **Run Full Test Suite**: Ensure nothing broken
2. **Manual Testing**: Verify functionality works
3. **Code Review Self**: Check against architecture
4. **Release Locks**: Unlock all files
5. **Update Documentation**: If needed
6. **Create Handoff**: If review needed

---

## Testing Workflow

### Writing Tests

**Test Types**:
- **Unit Tests**: Individual functions/methods in isolation
- **Integration Tests**: Component interactions, API endpoints
- **E2E Tests**: Full user workflows (for critical paths)

**Test Structure**:
```javascript
describe('[Component/Feature]', () => {
  describe('[specific function]', () => {
    it('should [expected behavior]', () => {
      // Arrange
      // Act
      // Assert
    });
    
    it('should handle [error case]', () => {
      // Test error scenarios
    });
  });
});
```

**Coverage Goals**:
- Unit tests: >80% for new code
- Integration tests: All API endpoints
- E2E tests: Critical user paths

### Running Tests

```bash
# Run all tests
npm test

# Run specific test file
npm test [file-name]

# Run with coverage
npm test -- --coverage

# Watch mode
npm test -- --watch
```

---

## Debugging Workflow

### Investigation Process

1. **Reproduce**: Create minimal reproduction case
2. **Isolate**: Narrow down to specific component
3. **Inspect**: Use breakpoints and logging
4. **Hypothesize**: Form theory about cause
5. **Test**: Verify theory with fixes
6. **Document**: Note findings in activity log

### Debugging Tools

**Breakpoints**: Use IDE breakpoints for step-through  
**Logging**: Add temporary logs (remove before commit)  
**Console**: Use REPL for quick tests  
**Profiler**: For performance issues  

**Remember**: Remove debugging code before committing!

---

## File Operations

### Locking Protocol

**Before Modifying Files**:
```bash
# Check lock status
grep "[file-path]" docs/agents/locks.md

# If unlocked, acquire lock
lock_file [file-path] cursor-[session] [task] "Implementing [feature]"

# Make changes
# ...

# Release lock
unlock_file [file-path]
```

**If File Locked**:
1. Check who has lock and why
2. Wait if same PBI (typical: 15-45 min)
3. Coordinate via activity log if urgent
4. Choose different task if blocked

### Git Operations

**Commit Messages**:
```
[task-id] [description]

[optional body with details]
```

**Example**:
```
PBI-5-3 Implement JWT authentication

- Created auth service with bcrypt hashing
- Added JWT generation and validation
- Implemented refresh token pattern
- All 28 tests passing
```

**Best Practices**:
- Commit frequently (every feature/fix)
- Write clear commit messages
- Reference task IDs
- Push regularly

---

## Code Quality

### Standards Checklist

- [ ] Follows project style guide
- [ ] No linting errors
- [ ] All tests passing
- [ ] Error handling implemented
- [ ] Logging added appropriately
- [ ] No hardcoded values (use constants)
- [ ] Comments for complex logic
- [ ] Imports organized
- [ ] No debugging code left

### Common Patterns

**Error Handling**:
```javascript
try {
  // Operation
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new AppError('User-friendly message', 500);
}
```

**Logging**:
```javascript
logger.info('Operation started', { userId, action });
// Do work
logger.info('Operation completed', { userId, result });
```

**Constants**:
```javascript
// Define once
const MAX_RETRIES = 3;
const TIMEOUT_MS = 5000;

// Use everywhere
for (let i = 0; i < MAX_RETRIES; i++) { ... }
```

---

## Tool Integration

### IDE Features

**Use**:
- Code completion for faster development
- Go-to definition for navigation
- Find references for refactoring
- Integrated debugging
- Terminal for commands
- Git integration

**Don't**:
- Accept AI suggestions without understanding
- Skip manual verification
- Ignore warnings

### Terminal Commands

```bash
# Development
npm run dev              # Start dev server
npm run build           # Build for production
npm run lint            # Run linter
npm run format          # Format code

# Testing
npm test                # Run tests
npm test -- --coverage  # With coverage
npm test -- --watch     # Watch mode

# Database
npm run migrate         # Run migrations
npm run seed            # Seed data

# Git
git status              # Check status
git diff                # Review changes
git add .               # Stage changes
git commit -m "msg"     # Commit
git push                # Push to remote
```

---

## Common Patterns

### Pattern: Accept Handoff → Implement → Review Handoff

```markdown
1. Review handoff from Claude
2. Log acceptance
3. Claim implementation task
4. Acquire file locks
5. Implement feature incrementally
6. Write tests as you go
7. Run full test suite
8. Release locks
9. Create review handoff to Claude
10. Update task status
```

### Pattern: Bug Fix

```markdown
1. Reproduce bug locally
2. Write failing test
3. Acquire file lock
4. Implement fix
5. Verify test passes
6. Run full test suite
7. Release lock
8. Commit with bug description
9. Update task status
```

### Pattern: Coordination with Claude

```markdown
1. Encounter architectural question
2. Log coordination request in activity
3. Include: question, context, options
4. Wait for Claude response
5. Proceed with clarified approach
6. Log resolution
```

---

## Troubleshooting

### Issue: Tests Failing

**Steps**:
1. Review what changed in recent commits
2. Run failing test with verbose output
3. Use debugger to step through
4. Check for environment issues
5. Ask for help if stuck >30 min

### Issue: File Locked

**Steps**:
1. Check locks.md for lock holder
2. Review activity log for context
3. Estimate wait time (check timestamp)
4. Choose: wait, coordinate, or switch tasks

### Issue: Unclear Architecture

**Steps**:
1. Review architecture documents again
2. Check related code for patterns
3. Look at activity log for context
4. Log coordination request for Claude
5. Don't proceed without clarity

### Issue: Need Architectural Change

**Steps**:
1. Document why change needed
2. Minor: document and proceed
3. Major: create handoff to Claude
4. Critical: flag user immediately
5. Always log rationale

---

## Helper Commands

```bash
# Session management
agent_register cursor "implementation,testing,debugging,ide-integration"

# Activity logging
log_activity cursor-[session] task-claimed [task] "Starting implementation"
log_activity cursor-[session] handoff-accepted [task] "Accepted from Claude"

# File locking
lock_file src/api/users.ts cursor-[session] [task] "Implementing user endpoints"
unlock_file src/api/users.ts
show_locks

# Git shortcuts (add to .gitconfig)
alias gcp='git add . && git commit -m "$1" && git push'
alias gs='git status --short'
alias gl='git log --oneline -10'
```

---

## Automation Helpers

### Lock Management Script

```bash
#!/bin/bash
# lock-file.sh
FILE=$1
TASK_ID=$2
REASON=$3
AGENT_ID="cursor-$(date +%Y%m%d-%H%M)"
echo "| $FILE | $AGENT_ID | $(date -Iseconds) | $TASK_ID | $REASON |" >> docs/agents/locks.md
git add docs/agents/locks.md && git commit -m "Lock: $FILE"
```

### Pre-commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit
# Verify agent registered
if git diff --cached --name-only | grep -q "src/"; then
  if ! grep -q "cursor.*active" docs/agents/manifest.md; then
    echo "ERROR: Agent not registered as active!"
    exit 1
  fi
fi
```

---

**See Also**:
- [AGENTS.md](../../../AGENTS.md) - Universal protocols
- [PROJECT_POLICY.md](../../PROJECT_POLICY.md) - Project-specific rules
- [claude.md](./claude.md) - Claude configuration
