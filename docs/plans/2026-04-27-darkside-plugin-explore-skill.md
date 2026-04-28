# Darkside Plugin — `/explore` Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create the `darkside` Claude Code plugin with a `/explore` skill that performs a deep project analysis and saves the result to `.darkside/holocrons/tech.md`.

**Architecture:** A Claude Code plugin composed of static files — a plugin manifest, a CLAUDE.md context file, and a skill markdown file. No runtime code. The skill instructs Claude to scan the project, synthesize findings, write the holocron file, and wait for user confirmation.

**Tech Stack:** Markdown, JSON, Bash (git only)

---

## File Map

| File | Action | Purpose |
|------|--------|---------|
| `package.json` | Create | npm metadata required for plugin installation |
| `.claude-plugin/plugin.json` | Create | Claude Code plugin manifest |
| `CLAUDE.md` | Create | Context injected into Claude when plugin is active |
| `skills/explore/SKILL.md` | Create | Skill instruction for `/explore` |
| `README.md` | Create | Installation and usage guide for teammates |

---

## Task 1: Initialize git repository and package.json

**Files:**
- Create: `package.json`

- [ ] **Step 1: Initialize git repository**

Run from `/Users/leogodde/PROJECTS/darkside`:
```bash
git init
git branch -M main
```
Expected: `Initialized empty Git repository in .../darkside/.git/`

- [ ] **Step 2: Create `.gitignore`**

Create file `.gitignore` with content:
```
.DS_Store
node_modules/
```

- [ ] **Step 3: Create `package.json`**

Create file `package.json` with content:
```json
{
  "name": "darkside",
  "version": "1.0.0",
  "description": "Internal development toolkit — Claude Code plugin",
  "license": "UNLICENSED",
  "private": true
}
```

- [ ] **Step 4: Verify file exists and is valid JSON**

Run:
```bash
cat package.json | python3 -m json.tool
```
Expected: prints formatted JSON without errors.

- [ ] **Step 5: Commit**

```bash
git add package.json .gitignore
git commit -m "chore: initialize darkside plugin project"
```

---

## Task 2: Create plugin manifest

**Files:**
- Create: `.claude-plugin/plugin.json`

- [ ] **Step 1: Create `.claude-plugin/` directory and `plugin.json`**

Create file `.claude-plugin/plugin.json` with content:
```json
{
  "name": "darkside",
  "description": "Internal development toolkit — skills for standardized team workflows",
  "version": "1.0.0",
  "license": "UNLICENSED"
}
```

- [ ] **Step 2: Verify file is valid JSON**

Run:
```bash
cat .claude-plugin/plugin.json | python3 -m json.tool
```
Expected: prints formatted JSON without errors.

- [ ] **Step 3: Commit**

```bash
git add .claude-plugin/plugin.json
git commit -m "feat: add Claude Code plugin manifest"
```

---

## Task 3: Create CLAUDE.md

**Files:**
- Create: `CLAUDE.md`

- [ ] **Step 1: Create `CLAUDE.md`**

Create file `CLAUDE.md` with content:
```markdown
# Darkside Plugin

This plugin provides skills for standardized team development workflows.

## Available Skills

- **explore** — Deep project analysis. Scans technology, architecture, packages,
  folder structure, and conventions. Saves findings to `.darkside/holocrons/tech.md`.
  Invoke with: `/explore`

## Holocrons

Holocrons are knowledge files stored in `.darkside/holocrons/`. They are written by
darkside skills and used as context for subsequent operations.

- `tech.md` — project technology overview, written by `/explore`
```

- [ ] **Step 2: Commit**

```bash
git add CLAUDE.md
git commit -m "feat: add CLAUDE.md with plugin context"
```

---

## Task 4: Create the `/explore` skill

**Files:**
- Create: `skills/explore/SKILL.md`

This is the core of the plugin. The SKILL.md must contain complete instructions so Claude performs the analysis correctly every time.

- [ ] **Step 1: Create `skills/explore/SKILL.md`**

Create file `skills/explore/SKILL.md` with content:
```markdown
---
name: explore
description: Deep project exploration — analyzes technology, architecture, packages, structure and organization, then saves findings to .darkside/holocrons/tech.md
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
```

- [ ] **Step 2: Verify the frontmatter is valid**

Check that `skills/explore/SKILL.md` starts with `---`, contains `name:` and `description:` fields, and closes with `---`.

Run:
```bash
head -5 skills/explore/SKILL.md
```
Expected output:
```
---
name: explore
description: Deep project exploration — analyzes technology, architecture, packages, structure and organization, then saves findings to .darkside/holocrons/tech.md
---
```

- [ ] **Step 3: Commit**

```bash
git add skills/explore/SKILL.md
git commit -m "feat: add /explore skill"
```

---

## Task 5: Create README

**Files:**
- Create: `README.md`

- [ ] **Step 1: Create `README.md`**

Create file `README.md` with content:
```markdown
# darkside

Internal Claude Code plugin — standardized development workflows for the team.

## Installation

```bash
claude plugin install <repo-url>
```

After installation, the skills are available in every Claude Code session.

## Skills

### `/explore`

Deep analysis of any project. Scans technology stack, architecture, packages,
folder structure, and code conventions.

**Output:** `.darkside/holocrons/tech.md` — a structured knowledge file used
by subsequent darkside skills and available for manual review.

**Usage:** Type `/explore` in Claude Code.

## Holocrons

Holocrons are knowledge files stored in `.darkside/holocrons/` at the root of each project.
They are created by darkside skills and serve as persistent context for future operations.

| File | Created by | Content |
|------|-----------|---------|
| `tech.md` | `/explore` | Technology stack, architecture, folder structure, conventions |

## Contributing

Add new skills under `skills/<skill-name>/SKILL.md`.
Update `CLAUDE.md` to list the new skill.
Bump the version in `package.json` and `.claude-plugin/plugin.json`.
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "docs: add README with installation and usage guide"
```

---

## Task 6: Verify plugin structure

- [ ] **Step 1: Check all required files exist**

Run:
```bash
find . -not -path './.git/*' -not -path './node_modules/*' | sort
```

Expected output includes:
```
./.claude-plugin/plugin.json
./CLAUDE.md
./README.md
./docs/plans/2026-04-27-darkside-plugin-explore-skill.md
./docs/specs/2026-04-27-explore-skill-design.md
./package.json
./skills/explore/SKILL.md
```

- [ ] **Step 2: Verify git log**

Run:
```bash
git log --oneline
```

Expected: 5 commits visible (init, manifest, CLAUDE.md, skill, README).

- [ ] **Step 3: Verify plugin is recognized by Claude Code**

Run:
```bash
claude plugin list
```

Expected: `darkside` appears in the list if installed, or confirm files are correct for future installation via `claude plugin install`.

---

## Self-Review

**Spec coverage check:**

| Spec requirement | Covered by |
|-----------------|------------|
| Plugin structure with `.claude-plugin/plugin.json` | Task 2 |
| `CLAUDE.md` context injection | Task 3 |
| `/explore` skill with deep scan (step C) | Task 4 - Step 1 |
| Output to `.darkside/holocrons/tech.md` | Task 4 - Step 3 |
| English, plain and direct | Explicit in SKILL.md Step 3 |
| Notify user + wait for confirmation | Task 4 - Step 4 |
| README for teammates | Task 5 |

All requirements covered. No placeholders. No TODOs.
