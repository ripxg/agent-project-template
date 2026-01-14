# Agent Project Template

A simple template for working with AI agents on software projects.

---

## Getting Started (3 Steps)

### Step 1: Clone this template

```bash
git clone [this-repo-url] my-project
cd my-project
```

### Step 2: Describe your idea

Edit the `MY_IDEA.md` file and fill in the sections. Don't worry about being perfect - just describe what you want to build in plain language.

### Step 3: Start your AI agent

Open your preferred AI agent (Claude, Cursor, etc.) and point it to this project. Tell it:

> "Read AGENTS.md and help me get started"

The agent will:
1. Ask you clarifying questions about your idea
2. Create a proper project plan (PRD) from your description
3. Break it down into actionable tasks
4. Start working on implementation

---

## How It Works

**For You (Human)**:
- Write your idea in `MY_IDEA.md`
- Review and approve what the agent proposes
- The agent handles the technical structure

**For AI Agents**:
- Read `AGENTS.md` for protocols
- Detect if this is a new project (no `docs/delivery/` content)
- Guide the human through PRD creation
- Coordinate with other agents via `docs/agents/`

---

## Project Structure

```
my-project/
├── README.md           # You are here
├── MY_IDEA.md          # Your project description (edit this!)
├── AGENTS.md           # Instructions for AI agents
└── docs/
    ├── agents/         # Agent coordination
    │   ├── manifest.md # Who's working on what
    │   ├── activity.md # Work log
    │   └── handoffs/   # Work transfers between agents
    └── delivery/       # Created by agents
        └── backlog.md  # Product backlog
```

---

## Multiple Agents

This template supports multiple AI agents working together:
- Each agent registers in `docs/agents/manifest.md`
- Agents hand off work via `docs/agents/handoffs/`
- Activity is logged for transparency

---

## Questions?

Just ask your AI agent - it knows how to use this template!
