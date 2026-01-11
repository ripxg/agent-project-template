# [PROJECT_NAME]

> **AI-Ready Project Template** - Multi-agent collaboration enabled

---

## Quick Start

```bash
# Clone this template for new projects
git clone [TEMPLATE_REPO_URL] my-new-project
cd my-new-project

# Update project name
./scripts/setup-project.sh "My New Project"

# Initialize git (if needed)
git init
git add .
git commit -m "Initial commit from template"
```

---

## AI Agent Collaboration

This project uses standardized multi-agent collaboration protocols.

### For AI Agents

**Before starting work**, read these in order:
1. **[AGENTS.md](./AGENTS.md)** - Universal Agent Standard (MANDATORY)
2. **[docs/PROJECT_POLICY.md](./docs/PROJECT_POLICY.md)** - Project-specific rules
3. **[docs/agents/config/[your-type].md](./docs/agents/config/)** - Your agent configuration

**Quick checklist**:
- [ ] Registered in [manifest](./docs/agents/manifest.md)
- [ ] Checked for [handoffs](./docs/agents/handoffs/)
- [ ] Know where to [log activity](./docs/agents/activity.md)
- [ ] Understand [file locking](./docs/agents/locks.md)

### For Humans

**Managing AI work**:
- **Manifest**: See who's working on what → `docs/agents/manifest.md`
- **Activity**: Review what's been done → `docs/agents/activity.md`
- **Handoffs**: Check work transfers → `docs/agents/handoffs/`
- **Locks**: See file ownership → `docs/agents/locks.md`

**Assigning work**:
1. Create PBI in `docs/delivery/backlog.md`
2. Break into tasks in `docs/delivery/[PBI-ID]/tasks.md`
3. Let agents claim based on capability routing

---

## Project Structure

```
project-root/
├── AGENTS.md                    # Universal Agent Standard
├── README.md                    # This file
├── docs/
│   ├── PROJECT_POLICY.md       # Project-specific rules
│   ├── IMPLEMENTATION_GUIDE.md # Setup and usage guide
│   ├── agents/                 # Agent coordination
│   │   ├── manifest.md        # Who's working
│   │   ├── activity.md        # What's been done
│   │   ├── locks.md           # File ownership
│   │   ├── config/            # Agent configurations
│   │   │   ├── claude.md
│   │   │   └── cursor.md
│   │   ├── handoffs/          # Work transfers
│   │   │   └── _TEMPLATE.md
│   │   └── archive/           # Old logs
│   └── delivery/              # Your work
│       └── backlog.md         # Product backlog
├── scripts/
│   ├── setup-project.sh       # Project initialization
│   └── agent-helpers.sh       # Agent utilities
└── .github/
    └── workflows/
        └── agent-checks.yml   # Automated checks
```

---

## Getting Started

### For New Projects

1. **Set up project**:
   ```bash
   ./scripts/setup-project.sh "Your Project Name"
   ```

2. **Create first PBI**:
   - Edit `docs/delivery/backlog.md`
   - Add PBI with user story and acceptance criteria

3. **Start first task**:
   - Agent reads AGENTS.md
   - Agent registers in manifest
   - Agent claims task
   - Work begins!

### For Existing Projects

See [docs/IMPLEMENTATION_GUIDE.md](./docs/IMPLEMENTATION_GUIDE.md) for integration steps.

---

## Documentation

- **[AGENTS.md](./AGENTS.md)** - Universal collaboration rules
- **[docs/PROJECT_POLICY.md](./docs/PROJECT_POLICY.md)** - Project workflow
- **[docs/IMPLEMENTATION_GUIDE.md](./docs/IMPLEMENTATION_GUIDE.md)** - Setup guide
- **[docs/agents/config/](./docs/agents/config/)** - Agent capabilities

---

## Helper Scripts

**Agent registration**:
```bash
source scripts/agent-helpers.sh
agent_register claude "planning,research,docs"
```

**Activity logging**:
```bash
log_activity claude-20250111-1430 task-claimed PBI-1-1 "Starting architecture design"
```

**File locking**:
```bash
lock_file src/api/users.ts claude-20250111-1430 PBI-1-2 "Implementing user endpoints"
unlock_file src/api/users.ts
```

---

## Maintenance

**Daily**: Check manifest for stale sessions, review activity log  
**Weekly**: Archive completed handoffs, check lock patterns  
**Monthly**: Archive old activity logs, update templates  

See [docs/IMPLEMENTATION_GUIDE.md](./docs/IMPLEMENTATION_GUIDE.md) for details.

---

## Contributing

1. Follow AGENTS.md protocols
2. Document all work in activity log
3. Create handoffs for task transfers
4. Keep manifest current
5. Release locks promptly

---

## License

[YOUR_LICENSE]

---

## Support

- **Issues**: Create GitHub issue
- **Questions**: See [docs/IMPLEMENTATION_GUIDE.md](./docs/IMPLEMENTATION_GUIDE.md)
- **Improvements**: Document in activity log, discuss with team

---

**Template Version**: 1.0.0  
**Last Updated**: [AUTO_GENERATED]
