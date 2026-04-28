# Design: `darkside` Plugin — `/inquisitor` Skill

**Date:** 2026-04-28
**Status:** Approved

---

## Overview

`/inquisitor` performs a deep code inspection using three sith-agents (engineer, security, tdd). It accepts a file path, folder/feature path, or PR number, automatically locates related tests, and produces a structured report with verdicts from each agent, an imperial risk assessment, and a final judgment level.

---

## Prerequisites

Check that `.darkside/sith-agents/` contains:
- `engineer.md`
- `security.md`
- `tdd.md`

If any are missing, say:
> "Os seguintes sith-agents estão faltando: [list]. Rode `/explore` primeiro para gerá-los."

Stop until all are present.

---

## Input

Ask the user:
> "O que devo inspecionar? Informe um arquivo, pasta ou número de PR."

### Path (file or folder)
Read all source files at the given path. If a folder, read all relevant source files recursively (skip `node_modules`, `.git`, `dist`, `build`, `vendor`).

### PR
1. Attempt: `gh pr diff <number>`
2. If `gh` is unavailable or fails: say "Não consegui acessar o PR via `gh`. Por favor cole o diff aqui." and wait for the user to paste it.

### Auto-finding tests
After collecting the target, automatically search for related test files:
- Files matching `*.spec.*` or `*.test.*` with the same base name
- Files inside `__tests__/` directories adjacent to the target
- Files inside `tests/` or `test/` directories mirroring the target path

Include found test files in the analysis. If none are found, note "No tests found" in the report.

---

## Filename Generation

Derive from the target:
- File: use the filename without extension and path → kebab-case
- Folder: use the folder name → kebab-case
- PR: use `pr-<number>`

Prepend `YYYY-MM-DD-`, append `-report.md`.

Examples:
- `src/auth/login.service.ts` → `2026-04-28-login-service-report.md`
- `src/auth/` → `2026-04-28-auth-report.md`
- PR #42 → `2026-04-28-pr-42-report.md`

---

## Analysis

Read all three sith-agent files in full before starting. Conduct each analysis adopting the corresponding agent's persona.

### Engineering Analysis (engineer.md)

Inspect for:
- Adherence to project architecture and layer boundaries
- SOLID principles and design pattern usage
- Code complexity, readability, and maintainability
- Naming consistency with project conventions
- Dead code, duplication, over-engineering
- Missing abstractions or premature abstractions

### Security Analysis (security.md)

Inspect for:
- Injection vulnerabilities (SQL, NoSQL, command, template)
- Authentication and authorization gaps
- Insecure direct object references
- Missing input validation and sanitization
- Secrets or sensitive data exposure
- Trust boundary violations
- OWASP Top 10 coverage

### Test Coverage Analysis (tdd.md)

Inspect for:
- Existence and quality of unit tests
- Integration test coverage
- Edge cases and error paths tested
- Test isolation (mocking boundaries)
- False positives (tests that always pass)
- Missing tests for critical behaviors

---

## Report Structure

**Path:** `.darkside/the-grand-inquisitor/YYYY-MM-DD-<name>-report.md`

Create directory if it does not exist.

```markdown
# Inquisitor Report: [target]

**Date:** YYYY-MM-DD
**Target:** [exact path or PR reference]
**Tests found:** [list of test files, or "None found"]

---

## Engineering Verdict

### Summary
[2-4 sentence overview. Score: Approved / Needs Work / Critical]

### Details
| Location | Issue | Severity |
|----------|-------|----------|
| `file.ts:42` | [description] | High / Medium / Low |

---

## Security Verdict

### Summary
[2-4 sentence overview. Score: Approved / Needs Work / Critical]

### Details
| Location | Vulnerability | Severity |
|----------|--------------|----------|
| `file.ts:87` | [description] | Critical / High / Medium / Low |

---

## Test Coverage Verdict

### Summary
[2-4 sentence overview. Estimated coverage: High / Medium / Low / None]

### Details
| Missing Coverage | Description | Priority |
|-----------------|-------------|----------|
| `service.ts:critical-method` | [what is not tested] | High / Medium / Low |

---

## Imperial Risk Assessment

[Paragraph synthesizing findings across all three verdicts. Highlight compounding risks — e.g., an untested security-critical path is more dangerous than either issue alone.]

---

## Final Judgment

**Level:** [Crítico | Alto Risco | Médio Risco | Baixo Risco]

**Rationale:** [1-3 sentences explaining why this level was assigned]

**Required Actions:**
- [ ] [specific action to address the most critical finding]
- [ ] [next action]
- [ ] [...]

**To reach Baixo Risco, the following must be resolved:**
- [list of blockers]
```

---

## Judgment Level Criteria

| Level | Criteria |
|-------|----------|
| **Crítico** | One or more critical security vulnerabilities, or complete absence of tests on security-critical paths, or severe architectural violations that break the system |
| **Alto Risco** | High-severity security issues, significant test gaps on important behaviors, or major architectural boundary violations |
| **Médio Risco** | Moderate issues across verdicts, some test coverage but with meaningful gaps, design issues that create technical debt |
| **Baixo Risco** | Minor issues only, good test coverage, no security vulnerabilities, clean architecture — code is acceptable for production |

---

## Integration

- Reads: `.darkside/sith-agents/engineer.md`, `security.md`, `tdd.md`
- Reads: `.darkside/holocrons/tech.md` (if available, for project context)
- Writes: `.darkside/the-grand-inquisitor/YYYY-MM-DD-<name>-report.md`
