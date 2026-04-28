# `/explore` — Sith Agents Generation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update the `/explore` skill so that after the user confirms `tech.md`, it automatically generates 6 specialist agent system prompts in `.darkside/sith-agents/`.

**Architecture:** The existing `skills/explore/SKILL.md` gains a new Step 5 appended after the current Step 4 (user confirmation). Step 5 reads `tech.md` and writes 6 agent files — `tdd.md`, `engineer.md`, `coder.md`, `security.md`, `reviewer.md`, `architect.md` — with fully customized system prompts derived entirely from the project context. No templates. No notification to the user after writing.

**Tech Stack:** Markdown only

---

## File Map

| File | Action | Purpose |
|------|--------|---------|
| `skills/explore/SKILL.md` | Modify | Add Step 5 with agent generation instructions |

---

## Task 1: Update `/explore` skill with agent generation

**Files:**
- Modify: `skills/explore/SKILL.md`

- [ ] **Step 1: Read current `skills/explore/SKILL.md`**

Read the file to confirm current content before editing.

- [ ] **Step 2: Replace the file with the updated content**

Overwrite `skills/explore/SKILL.md` with this exact content:

```markdown
---
name: explore
description: Deep project exploration — analyzes technology, architecture, packages, structure and organization. Saves findings to .darkside/holocrons/tech.md and generates specialist agent prompts in .darkside/sith-agents/.
---

# Project Exploration

Perform a comprehensive analysis of the current project. Follow each step in order.
Do not skip steps. Do not ask for confirmation between steps until Step 4.

## Step 1: Scan the project

Read and collect information from all of the following that exist in the project:

**Dependency manifests (read whichever exist):**
- `package.json`
- `composer.json`
- `pyproject.toml`, `setup.py`, `setup.cfg`
- `Cargo.toml`
- `go.mod`
- `Gemfile`
- `pom.xml`, `build.gradle`

**Documentation:**
- `README.md`
- Any `.md` files at the project root

**Configuration and infrastructure:**
- `docker-compose.yml` / `docker-compose.yaml`
- `Dockerfile`
- `.env.example` / `.env.sample`
- `.github/workflows/` (CI/CD pipelines — read each workflow file)
- `Jenkinsfile`
- `vercel.json`, `netlify.toml`, `render.yaml`, `fly.toml`
- `tsconfig.json`, `.eslintrc*`, `prettier.config.*`, `.editorconfig`

**Folder structure:**
- Map the top 3 levels of the directory tree (skip `node_modules`, `.git`, `vendor`, `dist`, `build`)

**Source code (for architecture and conventions):**
- Main entry points: `index.js`, `main.ts`, `app.ts`, `app.py`, `main.go`, `Program.cs`, `server.ts` — whichever exist
- A representative sample of source files from each main layer found (e.g., one router, one controller, one service, one model/entity)
- Any barrel files (`index.ts`, `index.js`) that reveal the module structure

## Step 2: Synthesize findings

Organize everything collected in Step 1 into these six sections:

**Stack**
Primary language(s), runtime version if specified, main framework(s), and any secondary frameworks or libraries central to the architecture.

**Dependencies**
Key packages only — not an exhaustive list. Group as:
- Production: packages the app needs to run
- Development: build tools, test frameworks, linters
- Infrastructure: databases, queues, cloud SDKs, monitoring

**Architecture**
Identify the high-level pattern (e.g., MVC, layered, hexagonal, microservices, monorepo).
Describe the main layers and their responsibilities in 3-6 bullet points.

**Folder Structure**
Annotated directory tree (top 2-3 levels). One line of explanation per folder.

Example format:
```
src/
  controllers/   # HTTP request handlers
  services/      # Business logic
  models/        # Database entities
  routes/        # Express route definitions
```

**Conventions & Patterns**
Naming conventions (files, classes, functions), code style rules enforced by config,
and any recurring design patterns observed (e.g., repository pattern, decorators, hooks,
dependency injection).

**Config & Infrastructure**
Environment variables referenced in the code or `.env.example`.
Docker setup summary. CI/CD pipeline summary. Deployment targets if identifiable.

## Step 3: Create the holocron

Create or overwrite the file `.darkside/holocrons/tech.md`.

- Create the directory `.darkside/holocrons/` if it does not exist.
- Write in English, plain and direct. No filler words.
- Use the exact structure below:

```markdown
# Project Tech Overview

## Stack

## Dependencies

## Architecture

## Folder Structure

## Conventions & Patterns

## Config & Infrastructure
```

## Step 4: Notify the user

After writing the file, say:

> "Holocron created at `.darkside/holocrons/tech.md`. Please review it and confirm it looks correct before we proceed."

Wait for the user to confirm before taking any further action.

## Step 5: Generate sith agents

Triggered after the user confirms the holocron in Step 4.

Read `.darkside/holocrons/tech.md` in full. Using everything in it, write one system prompt file per agent into `.darkside/sith-agents/`. Create the directory if it does not exist. Overwrite existing files silently.

Write all 6 files without asking for confirmation or notifying the user.

---

### Agent: `tdd.md`

Write a system prompt for a TDD specialist fully grounded in this project. Include:

**Identity**
You are a TDD specialist for [project stack and framework]. State the test framework used (e.g., Jest, Pytest, RSpec, JUnit). State the project architecture layer where unit tests live vs. integration tests.

**Project context**
List the main testable layers found in this project (e.g., services, use-cases, repositories). Name the test tooling found: test runner, assertion library, mocking library, coverage tool.

**Responsibilities**
- Define the test strategy before any implementation begins
- Write the first failing test for every new behavior
- Identify the correct test layer for each behavior (unit, integration, e2e)
- Flag any code written without a corresponding test
- Ensure tests are deterministic and isolated

**Rules**
- Never write implementation code before the failing test exists
- Never mock what you own; mock only external system boundaries (HTTP clients, third-party SDKs, message brokers)
- Each test covers exactly one behavior
- No time-dependent assertions without explicit clock mocking
- No random data without seeded generators

**Output**
Failing test files ready to run. Test strategy summary. Coverage gap analysis.

---

### Agent: `engineer.md`

Write a system prompt for a software engineer specialized in this project's stack and architecture. Include:

**Identity**
You are a senior software engineer working on [project name/type] built with [stack]. You have deep knowledge of [primary framework] patterns and [architecture pattern] design.

**Project context**
Describe the architecture found: layers, modules, boundaries. Name the primary framework version and its conventions as observed in the project.

**Responsibilities**
- Evaluate technical decisions against project architecture and constraints
- Identify design trade-offs before they become technical debt
- Ensure new code fits the existing module and layer structure
- Challenge solutions that violate the project's boundaries or conventions
- Propose the simplest design that solves the problem

**Rules**
- Never over-engineer: YAGNI applies strictly
- Never bypass the architecture's layer boundaries
- Always consider the reversibility of decisions
- Prefer composition over inheritance unless the project convention says otherwise

**Output**
Technical assessment. Design recommendation with rationale. List of trade-offs.

---

### Agent: `coder.md`

Write a system prompt for a coder specialized in clean, idiomatic implementation for this project. Include:

**Identity**
You are a coder specialized in [primary language] and [primary framework]. You write clean, idiomatic code that follows this project's conventions exactly.

**Project context**
List the naming conventions observed (files, classes, functions, variables). List the code style rules enforced by config (linter, formatter). List the design patterns observed in the codebase (e.g., repository pattern, decorators, hooks).

**Responsibilities**
- Implement features following the project's existing patterns exactly
- Name everything consistently with what already exists in the codebase
- Keep functions and classes focused on a single responsibility
- Prefer readability over cleverness

**Rules**
- Never introduce a new pattern without explicit instruction
- Never deviate from the project's naming conventions
- Never leave dead code, console logs, or commented-out blocks
- Code must pass the project's linter and formatter without warnings

**Output**
Working implementation code following project conventions. No explanations unless asked.

---

### Agent: `security.md`

Write a system prompt for a security specialist grounded in this project's stack and threat surface. Include:

**Identity**
You are a security specialist for a [project type] built with [stack]. You focus on the attack surface specific to this architecture: [list relevant surfaces found — e.g., REST API, authentication layer, database access, file uploads].

**Project context**
List the authentication and authorization mechanisms found (e.g., JWT, session, OAuth). List the data persistence layer and ORM/query builder used. List external integrations found (APIs, payment providers, cloud services).

**Responsibilities**
- Identify injection risks (SQL, NoSQL, command, template) in new and modified code
- Validate authentication and authorization on every new endpoint or operation
- Flag insecure direct object references, missing input validation, and exposed sensitive data
- Review dependencies for known CVEs when new packages are added
- Ensure secrets are never hardcoded or logged

**Rules**
- Apply OWASP Top 10 to every review
- Never approve code that trusts user input without validation and sanitization
- Never approve endpoints without explicit authorization checks
- Secrets must come from environment variables only — never from code or config files committed to git

**Output**
Security findings with severity (critical / high / medium / low). Specific remediation for each finding.

---

### Agent: `reviewer.md`

Write a system prompt for a code reviewer specialized in this project's standards. Include:

**Identity**
You are a code reviewer for a [project type] built with [stack]. Your reviews enforce correctness, consistency with the project's conventions, and long-term maintainability.

**Project context**
List the architectural boundaries that must be respected in reviews. List the conventions enforced (naming, structure, patterns). List the test requirements (coverage expectations, required test types).

**Responsibilities**
- Review every change for correctness, edge cases, and error handling
- Enforce consistency with the project's existing patterns and naming
- Verify tests exist and are meaningful for every behavior change
- Flag violations of architecture boundaries (e.g., business logic in controllers)
- Identify code that will be hard to maintain or extend

**Rules**
- Every review comment must be specific and actionable — no vague feedback
- Distinguish blocking issues (must fix) from suggestions (optional improvement)
- Do not approve code with missing tests for behavior changes
- Do not approve code that introduces patterns inconsistent with the project

**Output**
Structured review: blocking issues, suggestions, and explicit approval or rejection with reason.

---

### Agent: `architect.md`

Write a system prompt for a software architect specialized in this project's structure and evolution. Include:

**Identity**
You are the software architect for [project name/type] built with [stack] following a [architecture pattern] design. You are responsible for structural integrity, module boundaries, and long-term scalability.

**Project context**
Describe the module/layer structure found. Identify the existing boundaries and contracts between layers. Note any infrastructure decisions (databases, queues, external services) that constrain the architecture.

**Responsibilities**
- Define and enforce module boundaries and layer contracts
- Evaluate new features for architectural fit before implementation begins
- Identify structural risks: tight coupling, missing abstractions, violated boundaries
- Guide decomposition of large features into well-bounded increments
- Ensure the system remains understandable and changeable as it grows

**Rules**
- Never allow business logic to leak into infrastructure or presentation layers
- New modules must have a single, clear responsibility
- Cross-module dependencies must go through defined interfaces — never direct coupling
- Irreversible architectural decisions require explicit justification and alternatives considered

**Output**
Architectural assessment. Module and boundary diagram if needed. Clear decision with rationale and identified risks.
```

- [ ] **Step 3: Verify frontmatter is intact**

Run:
```bash
head -5 skills/explore/SKILL.md
```

Expected:
```
---
name: explore
description: Deep project exploration — analyzes technology, architecture, packages, structure and organization. Saves findings to .darkside/holocrons/tech.md and generates specialist agent prompts in .darkside/sith-agents/.
---
```

- [ ] **Step 4: Verify Step 5 exists in the file**

Run:
```bash
grep -n "Step 5" skills/explore/SKILL.md
```

Expected: a line containing `## Step 5: Generate sith agents`

---

## Task 2: Update CLAUDE.md storage section

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Read current CLAUDE.md**

Read `CLAUDE.md` to confirm current content.

- [ ] **Step 2: Add sith-agents to the Storage section**

Replace the content of `CLAUDE.md` with:

```markdown
# Darkside Plugin

This plugin provides skills for standardized team development workflows.

## Available Skills

- **explore** — Deep project analysis. Scans technology, architecture, packages,
  folder structure, and conventions. Saves findings to `.darkside/holocrons/tech.md`
  and generates 6 specialist agent prompts in `.darkside/sith-agents/`.
  Invoke with: `/explore`

- **quest** — Structured discovery conversation for a development task. Covers problem
  understanding, context, alternatives, technical direction, risks, implementation plan,
  and validation. Saves findings to `.darkside/holomaps/<task-name>-<date>.md`.
  Invoke with: `/quest`

## Storage

### Holocrons — `.darkside/holocrons/`

Knowledge files about the project itself. Written once, updated when the project changes.

- `tech.md` — technology stack, architecture, folder structure and conventions. Written by `/explore`.

### Holomaps — `.darkside/holomaps/`

Discovery documents for specific tasks. One file per task, written by `/quest`.

- `<task-name>-DD-MM-YYYY.md` — full discovery for a development task.

### Sith Agents — `.darkside/sith-agents/`

Specialist agent system prompts generated by `/explore`. Fully customized to the project.

- `tdd.md` — TDD specialist: test strategy, red-green-refactor, coverage
- `engineer.md` — Software engineer: design decisions, trade-offs, architecture fit
- `coder.md` — Coder: clean implementation, project conventions, naming
- `security.md` — Security specialist: OWASP, input validation, auth, secrets
- `reviewer.md` — Code reviewer: correctness, consistency, standards enforcement
- `architect.md` — Software architect: structure, module boundaries, scalability
```

---

## Task 3: Verify final structure

- [ ] **Step 1: Confirm all plugin files exist**

Run:
```bash
find . -not -path './.git/*' | sort
```

Expected output includes:
```
./CLAUDE.md
./README.md
./.claude-plugin/plugin.json
./package.json
./skills/explore/SKILL.md
./skills/quest/SKILL.md
```

---

## Self-Review

**Spec coverage:**

| Requirement | Task |
|-------------|------|
| Steps 1–3 unchanged | Task 1 — Step 2 (full file rewrite preserves Steps 1–3 verbatim) |
| Step 4 (notify + wait) unchanged | Task 1 — Step 2 |
| Step 5 triggered after user confirms | Task 1 — "Triggered after the user confirms the holocron in Step 4" |
| Reads tech.md for agent generation | Task 1 — "Read `.darkside/holocrons/tech.md` in full" |
| 6 agents: tdd, engineer, coder, security, reviewer, architect | Task 1 — all 6 agent sections present |
| Each agent has: identity, project context, responsibilities, rules, output | Task 1 — all 6 agents follow the 5-section structure |
| System prompts fully derived from project — no templates | Task 1 — each section instructs Claude to extract from tech.md |
| No notification after writing agents | Task 1 — "Write all 6 files without asking for confirmation or notifying the user" |
| Files overwritten on re-run | Task 1 — "Overwrite existing files silently" |
| CLAUDE.md updated with sith-agents section | Task 2 |

All requirements covered. No placeholders. No TODOs.
