# `/inquisitor` Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a `/inquisitor` skill that performs a deep code inspection using three sith-agents (engineer, security, tdd) and produces a structured report with verdicts and a final judgment level.

**Architecture:** A single `SKILL.md` with complete instructions covering prerequisites, input collection (file/folder/PR), automatic test discovery, three-agent analysis, and report generation in `.darkside/the-grand-inquisitor/`. `CLAUDE.md` is updated to list the new skill.

**Tech Stack:** Markdown only

---

## File Map

| File | Action | Purpose |
|------|--------|---------|
| `skills/inquisitor/SKILL.md` | Create | Full skill instruction for `/inquisitor` |
| `CLAUDE.md` | Modify | Add `/inquisitor` to available skills and storage section |

---

## Task 1: Create the `/inquisitor` skill

**Files:**
- Create: `skills/inquisitor/SKILL.md`

- [ ] **Step 1: Create `skills/inquisitor/SKILL.md`**

Create the file with this exact content:

```markdown
---
name: inquisitor
description: Deep code inspection using engineer, security, and tdd sith-agents. Accepts a file path, folder, or PR. Auto-discovers related tests. Produces a structured report with Engineering, Security, and Test Coverage verdicts plus a Final Judgment level in .darkside/the-grand-inquisitor/.
---

# The Grand Inquisitor

Perform a deep code inspection using three sith-agents. Follow each step in order.

---

## Step 1: Prerequisites

Check that `.darkside/sith-agents/` contains all of the following:
- `engineer.md`
- `security.md`
- `tdd.md`

If any are missing, say:
> "Os seguintes sith-agents estão faltando: [list]. Rode `/explore` primeiro para gerá-los."

Stop. Do not continue until all three are present.

If `.darkside/holocrons/tech.md` exists, read it now and use it as project context throughout the inspection.

---

## Step 2: Collect target

Ask:
> "O que devo inspecionar? Informe um arquivo, pasta ou número de PR."

Wait for the user's answer. Then:

**If the input is a file path or folder path:**
- Read all source files at the given path
- If a folder: read all relevant source files recursively, skipping `node_modules`, `.git`, `dist`, `build`, `vendor`

**If the input is a PR number (e.g., `#42` or `42`):**
1. Attempt to run: `gh pr diff <number>`
2. If `gh` is unavailable or the command fails: say "Não consegui acessar o PR via `gh`. Por favor cole o diff aqui." and wait for the user to paste the diff

---

## Step 3: Auto-discover tests

After collecting the target, automatically search for related test files using these patterns:

1. Files with the same base name matching `*.spec.*` or `*.test.*` anywhere in the project
2. Files inside `__tests__/` directories adjacent to or above the target path
3. Files inside `tests/` or `test/` directories that mirror the target path structure

Read all found test files. Note them for the report.

If no test files are found: record "None found" — do not stop.

---

## Step 4: Derive filename

Generate the report filename from the target:

- **File:** use the filename without extension and directory → kebab-case
- **Folder:** use the folder name → kebab-case
- **PR:** use `pr-<number>`

Prepend `YYYY-MM-DD-`, append `-report.md`.

Examples:
- `src/auth/login.service.ts` → `2026-04-28-login-service-report.md`
- `src/auth/` → `2026-04-28-auth-report.md`
- PR #42 → `2026-04-28-pr-42-report.md`

Create `.darkside/the-grand-inquisitor/` if it does not exist.

Create the report file immediately with empty sections (see Report Structure below) — do this silently.

---

## Step 5: Engineering analysis

Read `.darkside/sith-agents/engineer.md` in full and act as the Engineer.

Inspect the target code for:
- Adherence to project architecture and layer boundaries
- SOLID principles and design pattern usage
- Code complexity, readability, and maintainability
- Naming consistency with project conventions
- Dead code, duplication, over-engineering
- Missing abstractions or premature abstractions

For every issue found: record the exact file and line number.

Assign a summary score: **Approved**, **Needs Work**, or **Critical**.

---

## Step 6: Security analysis

Read `.darkside/sith-agents/security.md` in full and act as the Security Specialist.

Inspect the target code for:
- Injection vulnerabilities (SQL, NoSQL, command, template)
- Authentication and authorization gaps
- Insecure direct object references
- Missing input validation and sanitization
- Secrets or sensitive data exposure in code or logs
- Trust boundary violations
- OWASP Top 10 coverage

For every vulnerability found: record the exact file and line number and severity (Critical / High / Medium / Low).

Assign a summary score: **Approved**, **Needs Work**, or **Critical**.

---

## Step 7: Test coverage analysis

Read `.darkside/sith-agents/tdd.md` in full and act as the TDD Specialist.

Inspect the target code and the discovered test files for:
- Existence and quality of unit tests for each public behavior
- Integration test coverage for external boundaries
- Edge cases and error paths covered
- Test isolation (proper mocking of external dependencies)
- False positives (tests that always pass regardless of implementation)
- Missing tests for critical or security-sensitive behaviors

Estimate coverage level: **High**, **Medium**, **Low**, or **None**.

---

## Step 8: Write report

Write the completed report to `.darkside/the-grand-inquisitor/[filename]` using this exact structure:

```markdown
# Inquisitor Report: [target]

**Date:** YYYY-MM-DD
**Target:** [exact path or PR reference]
**Tests found:** [comma-separated list of test files, or "None found"]

---

## Engineering Verdict

### Summary
[2-4 sentences. Score: Approved / Needs Work / Critical]

### Details
| Location | Issue | Severity |
|----------|-------|----------|
| `file.ts:42` | [description] | High / Medium / Low |

---

## Security Verdict

### Summary
[2-4 sentences. Score: Approved / Needs Work / Critical]

### Details
| Location | Vulnerability | Severity |
|----------|--------------|----------|
| `file.ts:87` | [description] | Critical / High / Medium / Low |

---

## Test Coverage Verdict

### Summary
[2-4 sentences. Estimated coverage: High / Medium / Low / None]

### Details
| Missing Coverage | Description | Priority |
|-----------------|-------------|----------|
| `service.ts:methodName` | [what is not tested] | High / Medium / Low |

---

## Imperial Risk Assessment

[One paragraph synthesizing findings across all three verdicts. Highlight compounding risks — e.g., an untested security-critical path is more dangerous than either issue in isolation.]

---

## Final Judgment

**Level:** [Crítico | Alto Risco | Médio Risco | Baixo Risco]

**Rationale:** [1-3 sentences explaining why this level was assigned based on the combined verdicts]

**Required Actions:**
- [ ] [most critical action — address the highest severity finding first]
- [ ] [next action]
- [ ] [continue until all blocking issues are listed]

**To reach Baixo Risco, the following must be resolved:**
- [list every issue that prevents reaching Baixo Risco]
```

---

## Judgment Level Criteria

Apply these criteria to assign the Final Judgment level:

| Level | Criteria |
|-------|----------|
| **Crítico** | Any Critical-severity security vulnerability, OR complete absence of tests on security-critical paths, OR severe architectural violations that break system integrity |
| **Alto Risco** | High-severity security issues without mitigations, OR significant test gaps on important behaviors, OR major architectural boundary violations |
| **Médio Risco** | Moderate issues across verdicts, partial test coverage with meaningful gaps, design issues creating technical debt but no immediate risk |
| **Baixo Risco** | Minor issues only, good test coverage on critical paths, no security vulnerabilities, clean architecture — acceptable for production |

---

## Step 9: Notify user

After writing the report, say:
> "Inspeção concluída. Relatório salvo em `.darkside/the-grand-inquisitor/[filename]`. Julgamento final: **[level]**."

---

## Rules

- Read all three sith-agent files before starting any analysis — never skip an agent
- Record exact file and line numbers for every finding — never write vague locations
- If the Details table has no findings for a verdict, write "No issues found" in the table
- The report file is created silently in Step 4 and filled in Step 8
- All messages to the user are in Brazilian Portuguese
- Never modify source files during inspection — this skill is read-only
```

- [ ] **Step 2: Verify frontmatter**

Run:
```bash
head -5 skills/inquisitor/SKILL.md
```

Expected:
```
---
name: inquisitor
description: Deep code inspection using engineer, security, and tdd sith-agents. Accepts a file path, folder, or PR. Auto-discovers related tests. Produces a structured report with Engineering, Security, and Test Coverage verdicts plus a Final Judgment level in .darkside/the-grand-inquisitor/.
---
```

- [ ] **Step 3: Verify all 9 steps exist**

Run:
```bash
grep -n "^## Step" skills/inquisitor/SKILL.md
```

Expected output contains Steps 1 through 9.

---

## Task 2: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Replace CLAUDE.md with updated content**

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

- **sith-agents** — Edit existing sith-agent system prompts. Lists available agents,
  asks which one to modify and what change to make, confirms, and applies.
  Invoke with: `/sith-agents`

- **order66** — Full development orchestration. Spec (engineer + security), plan,
  tasks, TDD, code, and review cycle. Saves to `.darkside/imperial-orders/`.
  Creates fallen-order report on repeated review failure.
  Invoke with: `/order66`

- **inquisitor** — Deep code inspection using engineer, security, and tdd agents.
  Accepts a file, folder, or PR. Auto-discovers tests. Produces a report with
  Engineering, Security, and Test Coverage verdicts plus a Final Judgment level
  (Crítico / Alto Risco / Médio Risco / Baixo Risco).
  Invoke with: `/inquisitor`

## Storage

### Holocrons — `.darkside/holocrons/`

Knowledge files about the project itself. Written once, updated when the project changes.

- `tech.md` — technology stack, architecture, folder structure and conventions. Written by `/explore`.

### Holomaps — `.darkside/holomaps/`

Discovery documents for specific tasks. One file per task, written by `/quest`.

- `YYYY-MM-DD-<task-name>.md` — full discovery for a development task.

### Sith Agents — `.darkside/sith-agents/`

Specialist agent system prompts generated by `/explore`. Fully customized to the project.
Editable via `/sith-agents`.

- 🧪 `tdd.md` — TDD specialist: test strategy, red-green-refactor, coverage
- ⚙️ `engineer.md` — Software engineer: design decisions, trade-offs, architecture fit
- 💻 `coder.md` — Coder: clean implementation, project conventions, naming
- 🔒 `security.md` — Security specialist: OWASP, input validation, auth, secrets
- 🔍 `reviewer.md` — Code reviewer: correctness, consistency, standards enforcement
- 🏛️ `architect.md` — Software architect: structure, module boundaries, scalability

### Imperial Orders — `.darkside/imperial-orders/`

Full development lifecycle documents written by `/order66`.

- `YYYY-MM-DD-<feature-name>-order.md` — spec + plan + tasks for a feature
- `fallen-orders/YYYY-MM-DD-<feature-name>-fallen-order.md` — failure report after 2 rejected reviews

### The Grand Inquisitor — `.darkside/the-grand-inquisitor/`

Deep inspection reports written by `/inquisitor`.

- `YYYY-MM-DD-<target-name>-report.md` — engineering + security + test coverage verdicts and final judgment
```

---

## Task 3: Verify structure

- [ ] **Step 1: Confirm all skill files exist**

Run:
```bash
find /Users/leogodde/PROJECTS/darkside/skills -name "SKILL.md" | sort
```

Expected:
```
/Users/leogodde/PROJECTS/darkside/skills/explore/SKILL.md
/Users/leogodde/PROJECTS/darkside/skills/inquisitor/SKILL.md
/Users/leogodde/PROJECTS/darkside/skills/order66/SKILL.md
/Users/leogodde/PROJECTS/darkside/skills/quest/SKILL.md
/Users/leogodde/PROJECTS/darkside/skills/sith-agents/SKILL.md
```

---

## Self-Review

**Spec coverage:**

| Requirement | Task |
|-------------|------|
| Check 3 sith-agents, warn if missing | Task 1 — Step 1 |
| Read tech.md if available | Task 1 — Step 1 |
| Ask user for target (file/folder/PR) | Task 1 — Step 2 |
| PR: try `gh pr diff`, fallback to paste | Task 1 — Step 2 |
| Auto-discover tests (3 patterns) | Task 1 — Step 3 |
| Filename: `YYYY-MM-DD-name-report.md` | Task 1 — Step 4 |
| Report created silently | Task 1 — Step 4 |
| Engineering analysis with engineer.md persona | Task 1 — Step 5 |
| Security analysis with security.md persona | Task 1 — Step 6 |
| Test coverage analysis with tdd.md persona | Task 1 — Step 7 |
| Hybrid report: summary + details with file:line | Task 1 — Step 8 |
| Imperial Risk Assessment crosses all 3 verdicts | Task 1 — Step 8 |
| Final Judgment: 4 levels with criteria table | Task 1 — Step 8 + Judgment Level Criteria |
| Required Actions + what to fix to reach Baixo Risco | Task 1 — Step 8 |
| Notify user with level after writing | Task 1 — Step 9 |
| All messages in Brazilian Portuguese | Task 1 — Rules |
| Skill is read-only — never modifies source files | Task 1 — Rules |
| CLAUDE.md updated with `/inquisitor` and storage | Task 2 |

All requirements covered. No placeholders. No TODOs.
