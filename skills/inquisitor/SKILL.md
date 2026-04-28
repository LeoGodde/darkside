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

## Step 10: Offer TODO annotations (local code only)

If the target was a **file or folder path** (not a PR), ask:
> "Deseja que eu adicione comentários `// TODO` nos locais com problemas identificados?"

- If the user confirms: for each finding in the report that has an exact `file:line` location, insert a `// TODO:` comment on the line immediately above the identified line with a brief description of the required change.

  Format: `// TODO: [one sentence describing the fix needed]`

  Example:
  ```ts
  // TODO: validate input before passing to query builder to prevent SQL injection
  const result = await db.query(`SELECT * FROM users WHERE id = ${userId}`)
  ```

  After inserting all TODOs, say:
  > "Comentários TODO adicionados em [N] locais. Revise antes de commitar."

- If the user declines: stop without modifying any file.

**Do not offer TODO annotations for PR inspections** — the diff is not a local file and cannot be edited.

---

## Rules

- Read all three sith-agent files before starting any analysis — never skip an agent
- Record exact file and line numbers for every finding — never write vague locations
- If the Details table has no findings for a verdict, write "No issues found" in the table
- The report file is created silently in Step 4 and filled in Step 8
- All messages to the user are in Brazilian Portuguese
- Source files are read-only during inspection — the only exception is Step 10 TODO annotations, applied only with explicit user confirmation
