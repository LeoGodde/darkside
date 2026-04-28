# Design: `darkside` Plugin — `/order66` Skill

**Date:** 2026-04-28
**Status:** Approved

---

## Overview

`/order66` orchestrates the full development process using the sith-agents. It guides the user through a structured spec conversation (engineer + security perspectives integrated), generates a development plan, breaks it into small tasks, runs TDD, codes, and reviews — all in one skill.

---

## Prerequisites

Check that `.darkside/sith-agents/` contains all required agents:
- `engineer.md`
- `security.md`
- `tdd.md`
- `coder.md`
- `reviewer.md`

If any are missing, say:
> "Os seguintes sith-agents estão faltando: [list]. Rode `/explore` primeiro para gerá-los."

Stop until prerequisites are met.

---

## Output File

**Path:** `.darkside/imperial-orders/YYYY-MM-DD-[feature-name]-order.md`

The filename is derived from the feature name given or inferred during the spec conversation:
1. Convert to lowercase
2. Remove accents and special characters
3. Replace spaces with `-`
4. Append `-order` suffix
5. Prepend current date as `YYYY-MM-DD-`

Example: `"Sistema de autenticação JWT"` → `2026-04-28-sistema-de-autenticacao-jwt-order.md`

**Structure:**

```markdown
# [Feature Name]

## Spec

### Scope
### Functional Requirements
### Non-Functional Requirements
### Integrations & Dependencies
### Testability
### Data
### Access
### Threats & Risks
### Compliance & Controls
### Resilience

## Plan

## Tasks
```

The file is created at the start of Phase 1 with empty sections and filled progressively.

---

## Phase 1 — Spec

**Persona:** Claude reads `engineer.md` and `security.md` and conducts a single integrated conversation covering both perspectives. Questions alternate naturally between engineering and security concerns — not split into blocks.

**Interaction model:** One question at a time. Wait for the user's answer before asking the next.

**Question areas and their questions (asked one at a time):**

### Scope
1. O que exatamente precisa ser construído?
2. O que está dentro e fora do escopo?
3. Quais critérios definem pronto?

### Functional Requirements
4. O sistema deve fazer o quê? Descreva o comportamento esperado.
5. Existem fluxos principais e edge cases importantes?
6. Há regras de negócio relevantes?

### Non-Functional Requirements
7. Há metas de performance? (latência, throughput, tempo de resposta)
8. Escalabilidade importa para esse caso?
9. Qual o SLA ou nível de confiabilidade esperado?
10. Observabilidade é necessária? (logs, métricas, tracing)

### Integrations & Dependencies
11. Que sistemas externos estão envolvidos?
12. Há contratos ou APIs existentes que precisam ser respeitados?
13. Existem limitações da stack atual que afetam o design?

### Testability
14. Como isso será validado?
15. Que tipos de teste precisam existir? (unit, integration, e2e)

### Data
16. Há dados sensíveis envolvidos?
17. Como dados serão armazenados, transmitidos e protegidos?

### Access
18. Quem pode acessar o quê?
19. Autenticação e autorização são necessárias?

### Threats & Risks
20. Quais abusos ou ataques são possíveis nesse fluxo?
21. Quais são os trust boundaries?
22. Há vetores como injection, privilege escalation ou secrets exposure?

### Compliance & Controls
23. Há requisitos regulatórios?
24. Auditoria ou logs de acesso são necessários?
25. A gestão de segredos está definida?

### Resilience
26. Como o sistema deve falhar com segurança?
27. Como lidar com incidentes ou falhas parciais?

**After all questions:** Write the answers organized into the `## Spec` section of the order file. Then say: "Spec concluída. Gerando o plano de desenvolvimento."

---

## Phase 2 — Plan

Claude reads the completed `## Spec` section and generates a development plan covering:
- High-level approach
- Main components to build
- Order of implementation
- Key technical decisions

Writes the plan into the `## Plan` section of the order file.

Then says:
> "Plano gerado em `.darkside/imperial-orders/[filename]`. Por favor revise e confirme para prosseguir."

**Waits for user approval before continuing.**

If the user requests changes: update the `## Plan` section and ask for approval again.

---

## Phase 3 — Tasks

After plan approval, breaks the work into small, ordered tasks. Each task contains:
- Exact file paths (create or modify)
- Complete code for each step
- Verification steps with exact commands and expected output

Writes tasks as a checklist into the `## Tasks` section:

```markdown
## Tasks

- [ ] Task 1: [description]
  - Files: `exact/path/to/file.ts`
  - [ ] Step 1: ...
  - [ ] Step 2: ...

- [ ] Task 2: [description]
  ...
```

After writing, says: "Tarefas definidas. Iniciando fase de testes."

---

## Phase 4 — TDD

Claude reads `tdd.md` from `.darkside/sith-agents/` and acts as the TDD specialist.

1. Writes all tests for all tasks — unit, integration, and e2e as applicable
2. Runs the tests — confirms all fail before proceeding
3. If any test passes before implementation: flags it as a false positive and fixes the test

Only proceeds to Phase 5 when all tests are confirmed failing.

---

## Phase 5 — Code

Claude reads `coder.md` from `.darkside/sith-agents/` and acts as the Coder.

Implements the minimum code required to make all failing tests pass, following the project's conventions exactly. No over-engineering. No changes outside the scope of the tasks.

Runs tests after each task is complete. Proceeds to Phase 6 when all tests pass.

---

## Phase 6 — Review

Claude reads `reviewer.md` from `.darkside/sith-agents/` and acts as the Reviewer.

Delivers a structured report:

```
## Review Report

### Blocking Issues
[must fix before approval]

### Suggestions
[optional improvements]

### Verdict
[ ] Approved
[ ] Rejected — reason: [...]
```

**Review loop (max 2 iterations):**

```
Coder implements
    │
    ▼
Reviewer reviews
    ├── Approved → success, stop
    └── Rejected (1st time)
            │
            ▼
        Coder fixes blocking issues
            │
            ▼
        Reviewer reviews again
            ├── Approved → success, stop
            └── Rejected (2nd time)
                    │
                    ▼
                Create fallen-order report → stop
```

**If approved at any point:** says "Order executada com sucesso. Arquivo em `.darkside/imperial-orders/[filename]`." and stops.

**If rejected twice:** creates a fallen-order report at:

`.darkside/imperial-orders/fallen-orders/YYYY-MM-DD-[feature-name]-fallen-order.md`

The filename mirrors the original order file exactly, replacing the `-order.md` suffix with `-fallen-order.md`.

Example: `2026-04-28-sistema-de-autenticacao-jwt-order.md` → `2026-04-28-sistema-de-autenticacao-jwt-fallen-order.md`

**Fallen-order report structure:**

```markdown
# Fallen Order: [Feature Name]

**Date:** YYYY-MM-DD
**Original order:** `.darkside/imperial-orders/[original-filename]`

## What Was Attempted
[summary of what was built]

## Review Iteration 1 — Blocking Issues
[issues found in first review]

## Coder Response 1 — Changes Made
[what was fixed]

## Review Iteration 2 — Blocking Issues
[issues found in second review]

## Root Cause Analysis
[why the implementation could not pass review]

## Recommended Next Steps
[what should be done to unblock this order]
```

After writing the fallen-order, says: "Ordem falhou após 2 iterações. Relatório salvo em `.darkside/imperial-orders/fallen-orders/[fallen-filename]`." and stops.

---

## Integration with Other Skills

- Reads: `.darkside/sith-agents/engineer.md`, `security.md`, `tdd.md`, `coder.md`, `reviewer.md`
- Reads: `.darkside/holocrons/tech.md` (if available, for project context)
- Writes: `.darkside/imperial-orders/YYYY-MM-DD-[name]-order.md`
