---
name: explore
description: Deep exploration of the project — analyzes technology, architecture, packages, structure, and organization. Saves the results in .darkside/holocrons/tech.md and generates the prompts of the specialist agents in .darkside/sith-agents/.
---

# Project Exploration

Perform a comprehensive analysis of the current project. Follow each step in order. Do not skip steps. Do not ask for confirmation between steps until Step 4.

**Follow Shared Rules** from `skills/_shared-rules.md`.

## Step 1: Scan the project

Read and collect information from all that exist:

**Dependency manifests:** `package.json`, `composer.json`, `pyproject.toml`, `setup.py`, `setup.cfg`, `Cargo.toml`, `go.mod`, `Gemfile`, `pom.xml`, `build.gradle`

**Documentation:** `README.md`, any `.md` at root

**Config/infra:** `docker-compose.yml`, `Dockerfile`, `.env.example`, `.github/workflows/`, `Jenkinsfile`, `vercel.json`, `netlify.toml`, `render.yaml`, `fly.toml`, `tsconfig.json`, `.eslintrc*`, `prettier.config.*`, `.editorconfig`

**Folder structure:** top 3 levels (skip `node_modules`, `.git`, `vendor`, `dist`, `build`)

**Source code:** main entry points (`index.js`, `main.ts`, `app.ts`, `app.py`, `main.go`, etc.), a representative sample from each layer, barrel files revealing module structure

**Test files:** scan for `*.spec.*`, `*.test.*`, and directories named `__tests__/`, `tests/`, `test/`, `spec/`. Read up to 5 representative files spread across different layers or modules.

## Step 2: Synthesize findings

Organize into seven sections:

**Stack** — language(s), runtime, main framework(s), secondary frameworks

**Dependencies** — key packages grouped as Production / Development / Infrastructure

**Architecture** — high-level pattern, main layers and responsibilities (3-6 bullets)

**Folder Structure** — annotated directory tree (top 2-3 levels), one line per folder

**Conventions & Patterns** — naming, code style rules, recurring design patterns

**Config & Infrastructure** — env vars, Docker setup, CI/CD summary, deployment targets

**Testing Conventions** — test framework(s), description language (e.g., English, Portuguese), structural pattern (AAA, Given-When-Then, etc.), file naming conventions, suite/case naming conventions. If no tests found, write "No tests found".

## Step 3: Create the holocron

Create or overwrite `.darkside/holocrons/tech.md` with the exact structure:

```markdown
# Project Tech Overview

## Stack

## Dependencies

## Architecture

## Folder Structure

## Conventions & Patterns

## Config & Infrastructure

## Testing Conventions
```

## Step 4: Notify the user

> "Holocron created in `.darkside/holocrons/tech.md`. Review and confirm to proceed."

Wait for confirmation.

## Step 5: Generate sith agents

Read `tech.md`. Write one system prompt per agent into `.darkside/sith-agents/`. Overwrite existing files silently. Write all 5 without asking.

Each agent follows this template — customize entirely based on the project:

```
**Identity** — role + project stack
**Project context** — relevant layers, tools, patterns from tech.md
**Responsibilities** — 4-5 key duties
**Rules** — 3-4 strict constraints
**Output** — what the agent produces
```

### Agents to generate:

| File | Role | Focus |
|------|------|-------|
| `tdd.md` | TDD specialist | test strategy, red-green-refactor, coverage — **must enforce the Testing Conventions from `tech.md`**: same language for descriptions, same structural pattern, same naming conventions |
| `engineer.md` | Software engineer | design decisions, trade-offs, architecture fit |
| `coder.md` | Coder | clean implementation, conventions, naming |
| `security.md` | Security specialist | OWASP, input validation, auth, secrets |
| `reviewer.md` | Code reviewer | correctness, consistency, standards |
