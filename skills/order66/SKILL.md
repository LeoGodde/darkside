---
name: order66
description: Orquestra o processo completo de desenvolvimento — lê o plano do war-room, gera a ordem imperial, quebra em tarefas, TDD, codificação e revisão com fallback para fallen-order em caso de falha repetida. Salva em .darkside/imperial-orders/.
---

# Order 66 — Development Orchestration

Execute the full development lifecycle. Follow each phase in order. Do not skip phases.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Prerequisites

Check that `.darkside/sith-agents/` contains: `engineer.md`, `security.md`, `tdd.md`, `coder.md`, `reviewer.md`.

If any are missing:
> "Os seguintes sith-agents estão faltando: [list]. Rode `/explore` primeiro para gerá-los."

Stop until all are present.

If `.darkside/holocrons/tech.md` exists, read it as project context.

---

## War Room Context

Look for plan files in `.darkside/war-room/`.

**If found:** identify the most recent. Ask:

> "Encontrei um plano recente: **`[filename]`**
>
> **A.** Usar esse plano
> **B.** Usar outro plano — me informe o caminho"

- **A:** Read the plan. Record the path.
- **B:** Ask for path, read, proceed as A.

**If none found:** execute the full War Room skill inline (every step from Prerequisite through Section 3.5). When complete:

> "O plano está salvo em `.darkside/war-room/[filename]`. Revise e confirme para continuar."

Wait for confirmation.

---

## Phase 1 — Order

Read `engineer.md` and `security.md` from sith-agents.

Get name of the execution plan from the war-room plan file or mission plan file to use as the order name.

Derive filename (suffix: `-order.md`). Create `.darkside/imperial-orders/` and the order file with empty sections (see Order File Structure) silently.

Using the war-room plan and agents, generate a development order covering:
- High-level approach and architecture decisions
- Main components to build
- Implementation order with rationale
- Key technical decisions and trade-offs
- Security considerations

Write into `## Order`.

> "Ordem imperial gerada em `.darkside/imperial-orders/[filename]`. Revise e confirme."

Wait for approval. If changes requested: update and ask again.

---

## Phase 2 — Tasks

Break work into small ordered tasks. Write into `## Tasks`.

Each task must contain:
- Clear description
- Exact file paths
- Complete code for every step — no summaries
- Exact verification commands with expected output

Format:

```markdown
## Tasks

- [ ] **Task 1: [description]**
  - Files: `exact/path/to/file.ts`
  - [ ] Step 1: [action] — [code or command]
  - [ ] Step 2: Verify — run `[command]`, expected: `[output]`
```

Say: "Tarefas definidas. Iniciando fase de testes."

---

## Phase 3 — TDD

Read `tdd.md` and act as the TDD specialist.

1. Write all tests for all tasks
2. Run all tests — they must all fail before proceeding
3. If any passes: flag as false positive, fix, re-run

Do not proceed until every test fails.

---

## Phase 4 — Code

Read `coder.md` and act as the Coder.

Implement minimum code to make all tests pass. Follow project conventions. No over-engineering. No changes outside scope.

Run tests after each task. Proceed to Phase 5 only when all pass.

---

## Phase 5 — Review

Read `reviewer.md` and act as the Reviewer. Track iteration count (start at 1).

```
## Review Report — Iteration [N]

### Blocking Issues
[specific, actionable]

### Suggestions
[optional improvements]

### Verdict
Approved / Rejected
```

**Approved:** "Ordem imperial executada com sucesso. Arquivo em `.darkside/imperial-orders/[filename]`." Stop.

**Rejected iteration 1:** read `coder.md`, fix blocking issues, run tests, return to Phase 5 as iteration 2.

**Rejected iteration 2:** create fallen-order report (see below). Stop.

---

## Fallen Order

**Triggered:** second rejection.
**Path:** `.darkside/imperial-orders/fallen-orders/YYYY-MM-DD-[feature-name]-fallen-order.md`

```markdown
# Fallen Order: [Feature Name]

**Date:** YYYY-MM-DD
**Original order:** `.darkside/imperial-orders/[original-filename]`

## What Was Attempted

## Review Iteration 1 — Blocking Issues

## Coder Response 1 — Changes Made

## Review Iteration 2 — Blocking Issues

## Root Cause Analysis

## Recommended Next Steps
```

Say: "Ordem imperial falhou após 2 iterações. Relatório salvo em `.darkside/imperial-orders/fallen-orders/[filename]`."

---

## Order File Structure

```markdown
# [Feature Name]

**War Room Plan:** [path to plan file]

## Order

## Tasks
```

---

## Rules

- Never skip a phase or proceed without completing the current one
- Never modify the order file outside the designated section for the current phase
- The order file is created silently at Phase 1 — announced only after order is generated
- The fallen-orders directory is created if needed
