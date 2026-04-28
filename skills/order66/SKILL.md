---
name: order66
description: Orquestra o processo completo de desenvolvimento — conversa de spec (engineer + security), geração de plano, quebra em tarefas, TDD, codificação e revisão com fallback para fallen-order em caso de falha repetida. Salva em .darkside/imperial-orders/.
---

# Order 66 — Development Orchestration

Execute the full development lifecycle. Follow each phase in order. Do not skip phases.

---

## Prerequisites

Check that `.darkside/sith-agents/` contains all of the following files:
- `engineer.md`
- `security.md`
- `tdd.md`
- `coder.md`
- `reviewer.md`

If any are missing, say:
> "Os seguintes sith-agents estão faltando: [list missing files]. Rode `/explore` primeiro para gerá-los."

Stop. Do not continue until all agents are present.

If `.darkside/holocrons/tech.md` exists, read it now and use it as project context throughout all phases.

---

## Phase 1 — Spec

Read `.darkside/sith-agents/engineer.md` and `.darkside/sith-agents/security.md` in full. Conduct a single integrated conversation combining both perspectives. Do not separate into blocks — weave engineering and security questions naturally.

Ask one question at a time. Wait for the answer before asking the next.

**Before the first question:** ask the feature name to derive the order filename.

> "Como você chamaria essa feature ou tarefa? (será usado para nomear o arquivo)"

After receiving the name:
1. Derive the filename: lowercase, remove accents, replace spaces with `-`, prepend `YYYY-MM-DD-`, append `-order.md`
2. Create `.darkside/imperial-orders/` if it does not exist
3. Create the order file with empty sections (see Order File Structure below) — do this silently

Then begin the spec questions, one at a time, in this order:

**Scope**
1. "O que exatamente precisa ser construído?"
2. "O que está dentro e fora do escopo?"
3. "Quais critérios definem pronto?"

**Functional Requirements**
4. "O sistema deve fazer o quê? Descreva o comportamento esperado."
5. "Existem fluxos principais e edge cases importantes?"
6. "Há regras de negócio relevantes?"

**Non-Functional Requirements**
7. "Há metas de performance? (latência, throughput, tempo de resposta)"
8. "Escalabilidade importa para esse caso?"
9. "Qual o SLA ou nível de confiabilidade esperado?"
10. "Observabilidade é necessária? (logs, métricas, tracing)"

**Integrations & Dependencies**
11. "Que sistemas externos estão envolvidos?"
12. "Há contratos ou APIs existentes que precisam ser respeitados?"
13. "Existem limitações da stack atual que afetam o design?"

**Testability**
14. "Como isso será validado?"
15. "Que tipos de teste precisam existir? (unit, integration, e2e)"

**Data**
16. "Há dados sensíveis envolvidos?"
17. "Como dados serão armazenados, transmitidos e protegidos?"

**Access**
18. "Quem pode acessar o quê?"
19. "Autenticação e autorização são necessárias?"

**Threats & Risks**
20. "Quais abusos ou ataques são possíveis nesse fluxo?"
21. "Quais são os trust boundaries?"
22. "Há vetores como injection, privilege escalation ou secrets exposure?"

**Compliance & Controls**
23. "Há requisitos regulatórios?"
24. "Auditoria ou logs de acesso são necessários?"
25. "A gestão de segredos está definida?"

**Resilience**
26. "Como o sistema deve falhar com segurança?"
27. "Como lidar com incidentes ou falhas parciais?"

After the last answer: write all answers organized by section into `## Spec` of the order file. Then say: "Spec concluída. Gerando o plano de desenvolvimento."

---

## Phase 2 — Plan

Read the completed `## Spec` section of the order file. Generate a development plan covering:
- High-level approach and architecture decisions
- Main components to build
- Order of implementation with rationale
- Key technical decisions and trade-offs

Write into the `## Plan` section of the order file.

Then say:
> "Plano gerado em `.darkside/imperial-orders/[filename]`. Por favor revise e confirme para prosseguir."

Wait for user approval.

If the user requests changes: update `## Plan` and ask for approval again. Repeat until approved.

---

## Phase 3 — Tasks

After plan approval, break the work into small ordered tasks. Write into the `## Tasks` section of the order file.

Each task must contain:
- A clear description of what it does
- Exact file paths (create or modify)
- Complete code for every step that touches code — no summaries, no "similar to above"
- Exact verification commands with expected output

Format:

```markdown
## Tasks

- [ ] **Task 1: [description]**
  - Files: `exact/path/to/file.ts`
  - [ ] Step 1: [action] — [code or command]
  - [ ] Step 2: Verify — run `[exact command]`, expected: `[exact output]`

- [ ] **Task 2: [description]**
  ...
```

After writing tasks, say: "Tarefas definidas. Iniciando fase de testes."

---

## Phase 4 — TDD

Read `.darkside/sith-agents/tdd.md` in full and act as the TDD specialist for this project.

1. Write all tests for all tasks — following the test strategy defined in the spec (unit, integration, e2e as applicable)
2. Run all tests — they must all fail before proceeding
3. If any test passes before implementation: flag it as a false positive, fix the test, re-run to confirm it fails

Do not proceed to Phase 5 until every test is confirmed failing.

---

## Phase 5 — Code

Read `.darkside/sith-agents/coder.md` in full and act as the Coder for this project.

Implement the minimum code required to make all failing tests pass. Follow the project's conventions exactly as described in the coder agent. No over-engineering. No changes outside the scope of the tasks.

Run tests after completing each task. Proceed to Phase 6 only when all tests pass.

---

## Phase 6 — Review

Read `.darkside/sith-agents/reviewer.md` in full and act as the Reviewer.

Track the review iteration count. Start at iteration 1.

Deliver a structured report:

```
## Review Report — Iteration [N]

### Blocking Issues
[specific, actionable issues that must be fixed]

### Suggestions
[optional improvements — do not block approval]

### Verdict
Approved / Rejected
```

**If approved:** say "Order executada com sucesso. Arquivo em `.darkside/imperial-orders/[filename]`." and stop.

**If rejected on iteration 1:**
- Read `coder.md` again and act as the Coder
- Fix every blocking issue listed in the review report
- Run all tests — confirm they pass
- Return to Phase 6 as iteration 2

**If rejected on iteration 2:**
- Create the fallen-order report (see Fallen Order below)
- Say: "Ordem falhou após 2 iterações. Relatório salvo em `.darkside/imperial-orders/fallen-orders/[fallen-filename]`."
- Stop

---

## Fallen Order

**Triggered:** when the reviewer rejects the implementation for the second time.

**Path:** `.darkside/imperial-orders/fallen-orders/YYYY-MM-DD-[feature-name]-fallen-order.md`

The filename mirrors the original order file exactly, replacing `-order.md` with `-fallen-order.md`.

Example:
- Original: `2026-04-28-autenticacao-jwt-order.md`
- Fallen: `2026-04-28-autenticacao-jwt-fallen-order.md`

**Content:**

```markdown
# Fallen Order: [Feature Name]

**Date:** YYYY-MM-DD
**Original order:** `.darkside/imperial-orders/[original-filename]`

## What Was Attempted
[summary of what was built across both iterations]

## Review Iteration 1 — Blocking Issues
[issues found in first review]

## Coder Response 1 — Changes Made
[what was fixed after first review]

## Review Iteration 2 — Blocking Issues
[issues found in second review]

## Root Cause Analysis
[why the implementation could not pass review after two attempts]

## Recommended Next Steps
[concrete actions to unblock this order]
```

---

## Order File Structure

Created at the start of Phase 1 with empty sections:

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

---

## Rules

- Never skip a phase
- Never proceed to the next phase without completing the current one
- Never modify the order file outside the designated section for the current phase
- All messages to the user are in Brazilian Portuguese
- The order file is created silently at the start of Phase 1 — do not announce it until Phase 2
- The fallen-orders directory is created if it does not exist
