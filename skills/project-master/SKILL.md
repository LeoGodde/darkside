---
name: project-master
description: Avaliação profunda e completa do código — gera scorecard e relatório de engenharia cobrindo code smells, segurança, complexidade, testes, débito técnico e arquitetura
---

# Project Master — Deep Code Evaluation

Performs a comprehensive engineering evaluation of the entire project codebase. Uses
`tech.md` as context for technology stack, packages, and architecture, then conducts
deep analysis across 8 scored dimensions producing an actionable report.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Prerequisite

Check `.darkside/holocrons/tech.md`. If missing, stop and say:

> "O `tech.md` não foi encontrado. Rode `/explore` primeiro para mapear o projeto."

Also check that `.darkside/sith-agents/` contains `engineer.md`, `security.md`, and `tdd.md`.
If any are missing, stop and say:

> "Os sith-agents não foram encontrados. Rode `/explore` primeiro para gerá-los."

---

## Step 1 — Initialize Report

Derive the output filename from the project name found in `tech.md` (or the repo folder name):
`YYYY-MM-DD-<project-name>-project-master.md`

Create the file at `.darkside/project-master/` with first line:
`⚠️ Project Master in progress — not completed.`

---

## Step 2 — Load Context

Read `tech.md` directly (single read). Extract:
- Technology stack and versions
- Package dependencies (direct and dev)
- Folder structure and architecture patterns
- Known conventions and project structure

---

## Step 3 — Deep Analysis via Parallel Agents

Dispatch three agents simultaneously using the Agent tool. Each agent receives
the full contents of `tech.md` and the relevant sith-agent system prompt as
context in its prompt. All three run in parallel — do not wait for one to finish
before launching the others.

**Agent 1 — engineer** (use the `Explore` agent type, thoroughness: "very thorough")

Prompt must instruct it to perform a deep engineering scan of the entire codebase and return findings covering:
- Code smells (long methods, God classes, feature envy, primitive obsession)
- Cognitive complexity (difficulty of understanding the logic, beyond cyclomatic metrics)
- Pattern consistency (naming conventions, structural uniformity, style coherence)
- Dead code (unused functions, imports, variables, unreachable branches)
- Critical performance (N+1 queries, inefficient loops, unnecessary allocations)
- Architecture (module dependencies, circular couplings, layer violations)
- Qualitative technical debt (anti-patterns, excessive coupling, SOLID violations, DRY violations)
- Duplication (copy-paste patterns, near-identical blocks)

**Agent 2 — security** (use the `Explore` agent type, thoroughness: "very thorough")

Prompt must instruct it to perform a deep security scan of the entire codebase and return findings covering:
- Injection vulnerabilities (SQL, command, LDAP)
- XSS and output encoding gaps
- Hardcoded secrets (API keys, passwords, tokens in source)
- Missing input validation at system boundaries
- Authentication and authorization gaps
- Insecure configurations (CORS, headers, env handling)
- Known vulnerable dependency versions

**Agent 3 — tdd** (use the `Explore` agent type, thoroughness: "very thorough")

Prompt must instruct it to perform a deep test analysis of the entire codebase and return findings covering:
- Test coverage breadth and depth (unit, integration, e2e — estimated from test files)
- Broken tests (failing assertions, compilation errors in test files)
- Flaky tests (time-dependent, order-dependent, external dependencies without mocking)
- Test quality (assertions that actually validate behavior vs. trivial or empty tests)
- Missing critical scenarios (error paths, edge cases, security boundaries)

Wait for all three agents to return before proceeding to Step 4.

If any ambiguity in the results blocks accurate scoring, ask the user before proceeding.
One question at a time.

---

## Step 4 — Score Each Dimension

Apply this scale:

| Score | Meaning |
|-------|---------|
| 5 | Excellent — no significant issues |
| 4 | Good — minor issues only |
| 3 | Acceptable — notable issues, manageable debt |
| 2 | At risk — significant issues requiring attention |
| 1 | Critical — severe issues blocking quality or safety |

Score these eight dimensions:

- **Complexidade** — cognitive + cyclomatic complexity across the codebase
- **Cobertura de testes** — breadth and depth of test coverage
- **Duplicação** — DRY violations, copy-paste patterns
- **Segurança** — vulnerabilities, secrets, validation gaps
- **Padrões/Consistência** — naming, structure, style uniformity
- **Débito técnico** — anti-patterns, coupling, SOLID violations
- **Documentação** — README, docstrings, inline comments where needed
- **Manutenibilidade** — overall ease of change (composite judgment)

Compute the overall score as the average of all eight dimensions, rounded to one decimal.

---

## Step 5 — CLI Summary Output

Before writing the file, print a summary to the chat using this exact format:

```
---
Project Master — <project-name> (<tech stack short label>)

Nota geral: X.X / 5

┌──────────────────────┬──────┐
│      Parâmetro       │ Nota │
├──────────────────────┼──────┤
│ Complexidade         │  X   │
├──────────────────────┼──────┤
│ Cobertura de testes  │  X   │
├──────────────────────┼──────┤
│ Duplicação           │  X   │
├──────────────────────┼──────┤
│ Segurança            │  X   │
├──────────────────────┼──────┤
│ Padrões/Consistência │  X   │
├──────────────────────┼──────┤
│ Débito técnico       │  X   │
├──────────────────────┼──────┤
│ Documentação         │  X   │
├──────────────────────┼──────┤
│ Manutenibilidade     │  X   │
└──────────────────────┴──────┘

---
<N> Issues Críticos

C1 — <title>
<file>:<lines> — <one-line explanation>

C2 — <title>
<file>:<lines> — <one-line explanation>

(list all critical issues)

---
Maiores riscos por dimensão

- <Dimensão>: <concise risk summary>
- <Dimensão>: <concise risk summary>
(one bullet per dimension that scored 1 or 2)
---
```

---

## Step 6 — Write Report (English + Portuguese)

Write **two files** with identical content — one in English, one in Brazilian Portuguese.

Filenames:
- `YYYY-MM-DD-<project-name>-project-master.md` (English)
- `YYYY-MM-DD-<project-name>-project-master-ptbr.md` (Portuguese)

Both files use this structure:

```
# Project Master Report — <project-name>

**Date:** DD/MM/YYYY HH:MM
**Tech stack:** <from tech.md>
**Evaluated by:** engineer + security + tdd agents

---

## Scorecard

| Parâmetro            | Nota (1-5) | Observação |
|----------------------|------------|------------|
| Complexidade         |     X      | <summary>  |
| Cobertura de testes  |     X      | <summary>  |
| Duplicação           |     X      | <summary>  |
| Segurança            |     X      | <summary>  |
| Padrões/Consistência |     X      | <summary>  |
| Débito técnico       |     X      | <summary>  |
| Documentação         |     X      | <summary>  |
| Manutenibilidade     |     X      | <summary>  |

**Nota geral:** X.X / 5

---

## Critical Issues

### 🔴 Critical

**C1 — <title>**
`<file>:<lines>` — <detailed explanation>

**C2 — <title>**
`<file>:<lines>` — <detailed explanation>

### 🟠 High

(issues classified as High)

### 🟡 Medium

(issues classified as Medium)

---

## Engineering Analysis

### Code Smells
<findings with file references>

### Cognitive Complexity
<findings with file references>

### Pattern Consistency
<findings with file references>

### Dead Code
<findings with file references>

### Duplication
<findings with file references>

### Technical Debt
<findings with file references>

### Critical Performance
<findings with file references>

### Architecture
<findings with file references>

---

## Security Analysis

### Vulnerabilities Found
<findings with file references>

### Hardcoded Secrets
<findings with file references>

### Validation Gaps
<findings with file references>

### Dependency Risks
<findings with file references>

---

## Test Analysis

### Coverage Assessment
<findings with file references>

### Broken Tests
<findings with file references>

### Flaky Tests
<findings with file references>

### Missing Critical Scenarios
<findings with file references>

---

## Recommended Actions

<Prioritized list — each item includes: title, impacted dimension(s), impact (Alto/Médio/Baixo), effort (Alto/Médio/Baixo), and file references>
```

Replace the first line `⚠️ Project Master in progress — not completed.` with:
`✅ Project Master completed — DD/MM/YYYY HH:MM`

in both files.
