---
name: inquisitor
description: Inspeção profunda de código usando os sith-agents engineer, security e tdd. Aceita caminho de arquivo, pasta ou PR. Descobre testes automaticamente. Gera relatório estruturado com veredictos de Engenharia, Segurança e Cobertura de Testes, além do Julgamento Final em .darkside/the-grand-inquisitor/.
---

# The Grand Inquisitor

Perform a deep code inspection using three sith-agents. Follow each step in order.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Step 1: Prerequisites

Check that `.darkside/sith-agents/` contains: `engineer.md`, `security.md`, `tdd.md`.

If any missing:
> "Os seguintes sith-agents estão faltando: [list]. Rode `/explore` primeiro para gerá-los."

Stop until all three are present.

If `.darkside/holocrons/tech.md` exists, read it as project context.

---

## Step 2: Collect target

> "O que devo inspecionar? Informe um arquivo, pasta ou número de PR."

**File/folder:** read all source files (skip `node_modules`, `.git`, `dist`, `build`, `vendor`).

**PR number:** run `gh pr diff <number>`. If unavailable, ask user to paste diff.

---

## Step 3: Auto-discover tests

Search for related test files: `*.spec.*`, `*.test.*`, `__tests__/`, `tests/`, `test/` directories. Read all found. If none: record "None found".

---

## Step 4: Derive filename

- **File:** filename without extension → kebab-case
- **Folder:** folder name → kebab-case
- **PR:** `pr-<number>`

Prepend `YYYY-MM-DD-`, append `-report.md`. Create `.darkside/the-grand-inquisitor/` and the report file with empty sections silently.

---

## Step 5: Engineering analysis

Read `engineer.md` and act as the Engineer. Inspect for:
- Architecture and layer boundary adherence
- SOLID principles and design patterns
- Complexity, readability, maintainability
- Naming consistency, dead code, duplication

Record exact file:line for every issue. Score: **Approved** / **Needs Work** / **Critical**.

---

## Step 6: Security analysis

Read `security.md` and act as the Security Specialist. Inspect for:
- Injection vulnerabilities (SQL, NoSQL, command, template)
- Auth gaps, insecure direct object references
- Missing input validation, secrets exposure
- OWASP Top 10 coverage

Record exact file:line and severity (Critical/High/Medium/Low). Score: **Approved** / **Needs Work** / **Critical**.

---

## Step 7: Test coverage analysis

Read `tdd.md` and act as the TDD Specialist. Inspect for:
- Unit test existence and quality for public behaviors
- Integration test coverage for external boundaries
- Edge cases, error paths, test isolation
- False positives, missing tests for critical behaviors

Estimate coverage: **High** / **Medium** / **Low** / **None**.

---

## Step 8: Write report

Write to `.darkside/the-grand-inquisitor/[filename]`:

```markdown
# Inquisitor Report: [target]

**Date:** YYYY-MM-DD
**Target:** [exact path or PR]
**Tests found:** [list or "None found"]

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
[2-4 sentences. Coverage: High / Medium / Low / None]

### Details
| Missing Coverage | Description | Priority |
|-----------------|-------------|----------|
| `service.ts:method` | [what is not tested] | High / Medium / Low |

---

## Imperial Risk Assessment

[One paragraph synthesizing all three verdicts. Highlight compounding risks.]

---

## Final Judgment

**Level:** [Crítico | Alto Risco | Médio Risco | Baixo Risco]

**Rationale:** [1-3 sentences]

**Required Actions:**
- [ ] [most critical action first]

**To reach Baixo Risco:**
- [list every blocking issue]
```

## Judgment Level Criteria

| Level | Criteria |
|-------|----------|
| **Crítico** | Critical security vulnerability, OR no tests on security-critical paths, OR severe architectural violations |
| **Alto Risco** | High-severity security issues without mitigations, OR significant test gaps, OR major boundary violations |
| **Médio Risco** | Moderate issues, partial test coverage with gaps, design issues creating debt but no immediate risk |
| **Baixo Risco** | Minor issues only, good coverage on critical paths, no security vulnerabilities, clean architecture |

---

## Step 9: Notify

> "Inspeção concluída. Relatório salvo em `.darkside/the-grand-inquisitor/[filename]`. Julgamento final: **[level]**."

---

## Step 10: Offer TODO annotations (local code only)

If target was file/folder (not PR):

> "Deseja que eu adicione comentários `// TODO` nos locais com problemas identificados?"

If yes: insert `// TODO: [fix description]` above each identified line. Say: "Comentários TODO adicionados em [N] locais."

If no: stop.

---

## Rules

- Read all three sith-agent files before starting — never skip an agent
- Record exact file:line for every finding
- If Details table has no findings, write "No issues found"
- Report created silently in Step 4, filled in Step 8
- Source files are read-only — exception: Step 10 TODOs with explicit confirmation
