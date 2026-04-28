# Design: `/explore` Update — Sith Agents Generation

**Date:** 2026-04-27
**Status:** Approved

---

## Overview

The `/explore` skill is updated to generate 6 specialist agent files after the user confirms the `tech.md` holocron. Each agent receives a full, project-specific system prompt in English derived entirely from the confirmed `tech.md` — no fixed templates. Agents are saved in `.darkside/sith-agents/`.

---

## Updated Flow

```
/explore invoked
    │
    ▼
Step 1: Deep project scan (unchanged)
    │
    ▼
Step 2: Write .darkside/holocrons/tech.md (unchanged)
    │
    ▼
Step 3: Notify user → wait for confirmation (unchanged)
    │
    ▼ (user confirms)
Step 4: Read tech.md → generate 6 agent files in .darkside/sith-agents/
```

Steps 1–3 are unchanged from the current `/explore` implementation.

---

## Step 4: Agent Generation

### Trigger

User confirms the `tech.md` holocron.

### Process

Claude reads `.darkside/holocrons/tech.md` in full and generates one system prompt per agent, customized to the project. Agents are written to `.darkside/sith-agents/` with no user notification.

### Agents

| File | Specialist | Focus |
|------|-----------|-------|
| `tdd.md` | TDD Specialist | Test strategy, coverage, red-green-refactor cycle, test design |
| `engineer.md` | Software Engineer | Technical quality, design decisions, trade-offs, best practices |
| `coder.md` | Coder | Clean implementation, project conventions, naming, patterns |
| `security.md` | Security Specialist | Vulnerabilities, authentication, input validation, OWASP |
| `reviewer.md` | Code Reviewer | Review feedback, consistency, standards enforcement |
| `architect.md` | Software Architect | Structure, modules, contracts, scalability, dependencies |

### System Prompt Structure

Each agent file contains a single system prompt with the following sections, in order:

1. **Identity** — who this agent is and their role in this specific project
2. **Project context** — stack, architecture, frameworks, and patterns extracted from `tech.md`
3. **Responsibilities** — what this agent does, specific to this project's structure
4. **Rules** — mandatory behaviors, hard constraints, what this agent never does
5. **Output** — what this agent produces and how it communicates

All content is written in English. Tone is direct, authoritative, and precise. No filler. No generic advice that ignores the project context.

### Example (NestJS + TypeORM project)

```markdown
You are a TDD specialist for a NestJS application using TypeORM and PostgreSQL,
with Jest as the test framework.

Your job is to ensure every feature begins with a failing test. You write unit
tests targeting services and use-cases using Jest mocks for external dependencies.
You write integration tests targeting repositories using a real test database
configured via TypeORM test datasource.

Responsibilities:
- Define the test strategy before any implementation begins
- Write the first failing test for every new behavior
- Identify which layer each test belongs to: unit, integration, or e2e
- Flag any code written without a corresponding test

Rules:
- Never write implementation before the failing test exists
- Never mock what you own; mock only external boundaries (HTTP clients, third-party SDKs)
- Tests must be deterministic — no random data, no time-dependent assertions without mocking
- Each test covers one behavior; no omnibus tests

Output: failing test files ready to run, test strategy notes, coverage gaps identified.
```

---

## File Locations

- Reads: `.darkside/holocrons/tech.md`
- Writes: `.darkside/sith-agents/tdd.md`
- Writes: `.darkside/sith-agents/engineer.md`
- Writes: `.darkside/sith-agents/coder.md`
- Writes: `.darkside/sith-agents/security.md`
- Writes: `.darkside/sith-agents/reviewer.md`
- Writes: `.darkside/sith-agents/architect.md`

Existing files are overwritten on re-run.

---

## Behavior on Re-run

If `/explore` is run again on the same project, all sith-agents are regenerated from the new `tech.md`. No diff is shown — files are silently overwritten.

---

## No Notification

After writing the agent files, the skill does not notify the user. The agents are available silently for use.
