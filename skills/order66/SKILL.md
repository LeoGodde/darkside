---
name: order66
description: Orquestra o processo completo de desenvolvimento — lê o plano do war-room, gera a ordem imperial, quebra em tarefas, TDD, codificação e revisão com fallback para fallen-order em caso de falha repetida. Salva em .darkside/imperial-orders/.
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

## War Room Context

Before starting Phase 1, look for plan files in `.darkside/war-room/`.

**If one or more files are found:**

Identify the most recent file by filename (files are prefixed `YYYY-MM-DD-`). Then ask:

> "Encontrei um plano recente: **`[filename]`**
>
> **A.** Usar esse plano
> **B.** Usar outro plano — me informe o caminho do arquivo"

Wait for the user's answer.

- **A:** Read the plan file in full. Use its content to inform Phase 1. Record the file path.
- **B:** Ask: "Informe o caminho do arquivo de plano." Read the file provided and proceed as in option A.

**If no plan files are found:**

Execute the full War Room skill inline — follow every step defined in the `war-room` skill exactly, from Prerequisite through Section 3.5 (Technical Plan). Do not skip any section. Do not announce that you are starting the war-room.

When the war-room is complete and the plan file has been written, ask:

> "O plano está salvo em `.darkside/war-room/[filename]`. Revise o documento e confirme para continuar com a ordem imperial."

Wait for the user's confirmation before proceeding to Phase 1.

---

## Phase 1 — Order

Read `.darkside/sith-agents/engineer.md` and `.darkside/sith-agents/security.md` in full.

**Before generating the order:** ask the feature name to derive the order filename.

> "Como você chamaria essa feature ou tarefa?"

After receiving the name:
1. Derive the filename: lowercase, remove accents, replace spaces with `-`, prepend `YYYY-MM-DD-`, append `-order.md`
2. Create `.darkside/imperial-orders/` if it does not exist
3. Create the order file with empty sections (see Order File Structure below) — do this silently

Using the war-room plan (if provided) and the engineer and security agents, generate a development order covering:
- High-level approach and architecture decisions
- Main components to build
- Order of implementation with rationale
- Key technical decisions and trade-offs
- Security considerations

Write into the `## Order` section of the order file.

Then say:
> "Ordem imperial gerada em `.darkside/imperial-orders/[filename]`. Por favor revise e confirme para prosseguir."

Wait for user approval.

If the user requests changes: update `## Order` and ask for approval again. Repeat until approved.

---

## Phase 2 — Tasks

After order approval, break the work into small ordered tasks. Write into the `## Tasks` section of the order file.

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

## Phase 3 — TDD

Read `.darkside/sith-agents/tdd.md` in full and act as the TDD specialist for this project.

1. Write all tests for all tasks — following the test strategy defined in the order (unit, integration, e2e as applicable)
2. Run all tests — they must all fail before proceeding
3. If any test passes before implementation: flag it as a false positive, fix the test, re-run to confirm it fails

Do not proceed to Phase 4 until every test is confirmed failing.

---

## Phase 4 — Code

Read `.darkside/sith-agents/coder.md` in full and act as the Coder for this project.

Implement the minimum code required to make all failing tests pass. Follow the project's conventions exactly as described in the coder agent. No over-engineering. No changes outside the scope of the tasks.

Run tests after completing each task. Proceed to Phase 5 only when all tests pass.

---

## Phase 5 — Review

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

**If approved:** say "Ordem imperial executada com sucesso. Arquivo em `.darkside/imperial-orders/[filename]`." and stop.

**If rejected on iteration 1:**
- Read `coder.md` again and act as the Coder
- Fix every blocking issue listed in the review report
- Run all tests — confirm they pass
- Return to Phase 5 as iteration 2

**If rejected on iteration 2:**
- Create the fallen-order report (see Fallen Order below)
- Say: "Ordem imperial falhou após 2 iterações. Relatório salvo em `.darkside/imperial-orders/fallen-orders/[fallen-filename]`."
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

**War Room Plan:** [path to the war-room plan file used]

## Order

## Tasks
```

---

## Rules

- Never skip a phase
- Never proceed to the next phase without completing the current one
- Never modify the order file outside the designated section for the current phase
- All messages to the user are in Brazilian Portuguese
- All generated files (order files, fallen-order files) are written in English
- The order file is created silently at the start of Phase 1 — do not announce it until the order is generated
- The fallen-orders directory is created if it does not exist
