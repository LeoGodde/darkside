# Design: `darkside` Plugin — `/explore` Skill

**Date:** 2026-04-27
**Status:** Approved

---

## Overview

`darkside` is a Claude Code plugin for internal company use. It provides skills that guide Claude through standardized workflows. The first skill is `/explore`, which performs a deep analysis of any project and saves the result as a structured knowledge file (a "holocron") at `.darkside/holocrons/tech.md`.

---

## Plugin Structure

```
darkside/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (name, version, author)
├── skills/
│   └── explore/
│       └── SKILL.md         # Skill instructions for /explore
├── CLAUDE.md                # Context injected automatically into Claude
├── package.json             # npm metadata (required for installation)
└── README.md                # Documentation for teammates
```

The plugin is installed via `claude plugin install <git-repo>` and becomes available in any project.

---

## Skill: `/explore`

### Trigger

User calls `/explore` in any project directory.

### Behavior

The skill is **read-only with respect to the project** — it never modifies source code. It only reads project files and writes the holocron.

### Execution Steps

1. **Deep scan** — reads the following sources:
   - `package.json`, `composer.json`, `pyproject.toml`, `Cargo.toml`, or equivalent dependency manifests
   - `README.md` and any top-level documentation files
   - Folder structure (top 3 levels)
   - Configuration files: `docker-compose.yml`, `.env.example`, `Dockerfile`, CI/CD configs (`.github/workflows/`, `Jenkinsfile`, etc.)
   - Main entry points and key source files to identify architecture patterns and conventions

2. **Synthesis** — organizes findings into the sections defined below

3. **Write holocron** — creates or overwrites `.darkside/holocrons/tech.md` with the synthesized content in English, plain and direct

4. **Notify user** — informs that the file was created and asks for confirmation before any next step

### Output File

Path: `.darkside/holocrons/tech.md`

```markdown
# Project Tech Overview

## Stack
Primary language(s), runtime(s), and framework(s).

## Dependencies
Key packages and their purpose. Grouped by: production, development, infrastructure.

## Architecture
High-level pattern (e.g., MVC, layered, microservices, monorepo). Main layers and their responsibilities.

## Folder Structure
Annotated top-level directory tree explaining the role of each folder.

## Conventions & Patterns
Naming conventions, code style, patterns observed in the codebase (e.g., repository pattern, hooks, decorators).

## Config & Infrastructure
Environment variables, Docker setup, CI/CD pipeline, deployment targets if identifiable.
```

- Written in English, simple and direct
- Designed to be read by future darkside skills as context
- Always overwritten on re-run

### Completion

The skill ends with a message to the user:

> "Holocron created at `.darkside/holocrons/tech.md`. Please review it and confirm it looks correct before we proceed."

Claude waits for user confirmation before taking any further action.

---

## Distribution

Teammates install the plugin by running:

```
claude plugin install <git-repo-url>
```

No additional setup required.

---

## Future Skills

This spec covers only `/explore`. The `.darkside/holocrons/tech.md` file it produces is intentionally structured to serve as input for future skills (e.g., scaffolding, code generation, onboarding guides).
