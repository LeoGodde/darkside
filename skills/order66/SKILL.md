---
name: order66
description: Orquestra o processo completo de desenvolvimento — lê o plano do war-room, gera a ordem imperial, quebra em tarefas, TDD, codificação e revisão com fallback para fallen-order em caso de falha repetida. Salva em .darkside/imperial-orders/.
---

# Order 66 — Development Orchestration

Execute the full development lifecycle. Follow each phase in order. Do not skip phases.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Prerequisites

Check that `.darkside/sith-agents/` contains: `engineer.md`, `security.md`, `tdd.md`, `reviewer.md`, and at least one of `coder-backend.md` or `coder-frontend.md`.

If any are missing:
> "Os seguintes sith-agents estão faltando: [list]. Rode `/explore` primeiro para gerá-los."

Stop until all are present.

If `.darkside/holocrons/tech.md` exists, read it as project context.

---

## Model Configuration

Each phase uses a specific model tier. When using subagents (Agent tool), pass the `model` parameter. When executing inline, the orchestrator's own model applies.

| Phase | Agent | Model |
|-------|-------|-------|
| Phase 1 — Order | engineer, security | `opus` |
| Phase 2 — Tasks & Squads | — | `sonnet` |
| Phase 2.5 — Execution Strategy | — | — |
| Phase 3 — TDD | tdd | `sonnet` |
| Phase 4 — Code | coder | `sonnet` |
| Phase 5 — Review | reviewer | `sonnet` |

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

Break work into small ordered tasks and organize them into **squads** — logical groups by domain or specialty. Write into `## Tasks`.

Each task must contain:
- Clear description
- Exact file paths
- Complete code for every step — no summaries
- Exact verification commands with expected output

Group tasks under squads. Each squad has a name and an associated agent type:

```markdown
## Tasks

### Squad: Backend API
**Agent:** coder-backend

- [ ] **Task 1: [description]**
  - Files: `exact/path/to/file.ts`
  - [ ] Step 1: [action] — [code or command]
  - [ ] Step 2: Verify — run `[command]`, expected: `[output]`

- [ ] **Task 2: [description]**
  - Files: `exact/path/to/file.ts`
  - [ ] Step 1: [action] — [code or command]
  - [ ] Step 2: Verify — run `[command]`, expected: `[output]`

### Squad: Login Screen
**Agent:** coder-frontend

- [ ] **Task 3: [description]**
  - Files: `exact/path/to/component.tsx`
  - [ ] Step 1: [action] — [code or command]
  - [ ] Step 2: Verify — run `[command]`, expected: `[output]`
```

Squad naming guidelines:
- Use clear, descriptive names reflecting the domain (e.g., "Backend API", "Login Screen", "Dashboard", "Security Hardening", "Refactoring")
- Assign `coder-backend`, `coder-frontend`, or both based on the squad's scope
- Keep squads independent when possible — minimize cross-squad file dependencies

Present the proposed squads to the user:

> "Organizei as tarefas nos seguintes squads:
>
> 1. **[Squad Name]** — [N] tarefas ([agent type])
> 2. **[Squad Name]** — [N] tarefas ([agent type])
> ...
>
> Deseja reorganizar, renomear ou fundir algum squad?"

Wait for confirmation or adjustments. Iterate until confirmed.

Say: "Tarefas e squads definidos."

---

## Phase 2.5 — Execution Strategy

Ask:

> "Como deseja executar os squads?"
>
> **A.** ⚡ **Multitask** — Para missões complexas que exigem múltiplas especialidades trabalhando simultaneamente. Convoca vários agentes como um esquadrão coordenado, permitindo que atuem em paralelo sobre diferentes frentes da missão. _Tempo & Tokens: Maior consumo de tokens e tempo devido à coordenação entre agentes._
>
> **B.** 🎯 **Singletask** — Para missões que podem ser divididas em etapas independentes ou dependentes. Os agentes são acionados sequencialmente, onde cada operativo conclui sua etapa antes que o próximo assuma a missão. _Tempo & Tokens: Menor consumo de tokens e tempo por reduzir a coordenação entre agentes._

Record the chosen strategy. Proceed to Phase 2.7.

---

## Phase 2.7 — Execution Delegation

Detect the current CLI name (e.g., "Claude Code", "Cursor", "Kimi"). Ask:

> "Quem vai executar as fases de TDD e codificação?"
>
> **A.** Deepseek V4-Pro (reasonix)
> **B.** Kimi K2.7 Coding (kimi)
> **C.** <current CLI name> (continuar aqui)

**If C:** proceed normally to Phase 3.

In **Multitask** mode, the CLI choice applies to all squads. In **Singletask** mode, the CLI choice applies to the squad being executed.

**If A or B:**

### 1. Check CLI availability

Run `reasonix --version` or `kimi --version`. If not found:
> "O CLI `[name]` não está instalado. Instale-o ou escolha outra opção."
Re-ask the question.

### 2. Annotate HEAD

Before dispatching, record the current HEAD:
```bash
git -C "<project_dir>" rev-parse HEAD
```

### 3. Build and dispatch

Build a self-contained execution prompt containing:
- The project path
- The full Tasks section from the order file
- The TDD agent instructions (from `tdd.md`) — include the full content and instruct: "Use these TDD agent instructions as your testing persona. Follow them exactly for test strategy, red-green-refactor cycle, and coverage requirements."
- The Coder agent instructions — include the full content of the applicable coder agent(s) based on the task scope: `coder-backend.md` for backend tasks, `coder-frontend.md` for frontend tasks, or both if the tasks span both layers. Instruct: "Use these Coder agent instructions as your implementation persona. Follow them exactly for naming conventions, code structure, and project patterns."
- The project conventions (from `tech.md`)
- Clear instruction: "Execute all tasks using TDD — write failing tests first, then implement minimum code to pass. Run tests after each task. When all tests pass, report the final result."
- **Scope restriction (always include in every prompt):** "IMPORTANTE: implemente APENAS o que está descrito nas tarefas acima. Não adicione funcionalidades extras, não refatore código fora do escopo, não melhore código existente que não faz parte das tarefas. Sua implementação limita-se estritamente ao solicitado."
- **Status reporting (always include in every prompt):** "Ao concluir CADA tarefa, imprima um status no formato: `[TASK N/TOTAL] ✅ <task description> — tests: X passed, Y failed`. Ao final de todas as tarefas, imprima um resumo: `[ORDER66 COMPLETE] Tasks: N/N — All tests passing` ou `[ORDER66 INCOMPLETE] Tasks: X/N — Y failures remaining`."
- **Git prohibition (always include in every prompt):** "IMPORTANTE: nunca rode 'git add', 'git commit', 'git push', ou qualquer variação — commitar/dar push é decisão exclusiva do usuário, fora desta tarefa, mesmo que os testes passem no final."

**Reasonix:**
```bash
reasonix run --dir "<project_dir>" --output-format json --permission-mode auto --model deepseek_v4_pro --allowed-tools "Bash(test commands matching project stack)" "<prompt>"
```
- `--permission-mode auto`: required for headless execution.
- `--model deepseek_v4_pro`: always use Deepseek V4-Pro model for execution.
- `--allowed-tools`: restrict to read/test/lint commands only — **never include `git commit`/`git push`/`git add`**.
- Reinforce the git prohibition both in `--allowed-tools` AND in the prompt text — defense in depth.
- For subsequent corrections: `reasonix run --dir "<project_dir>" --continue --output-format json --permission-mode auto --model deepseek_v4_pro --allowed-tools "..." "<correction prompt>"`.

**Kimi:**

Save the prompt to a temporary file and pass it via `-p` flag. Kimi CLI does not accept inline prompts as positional arguments.

```bash
# 1. Write prompt to file
/tmp/kimi-order66-prompt.txt

# 2. Dispatch
kimi -p /tmp/kimi-order66-prompt.txt --yolo --model k2-0725-coder-basic
```
- `--yolo`: auto-approve all actions (headless).
- `-p`: pass the prompt file — required because Kimi CLI interprets inline text as a command name.
- `--model k2-0725-coder-basic`: use K2.7 Coding model for execution.
- Always include the git prohibition, scope restriction, status reporting, and agent instructions in the prompt file — the prompt is the only enforcement layer.
- For subsequent corrections: save the correction prompt to `/tmp/kimi-order66-correction.txt` and run: `kimi -p /tmp/kimi-order66-correction.txt --continue --yolo --model k2-0725-coder-basic`. Always re-include the git prohibition and scope restriction in correction prompts.

Run in background and wait for completion notification — no polling or manual sleep.

### 4. Review external CLI output

**First, check for unauthorized commits:**
```bash
git -C "<project_dir>" log --oneline <annotated-HEAD>..HEAD
```
If any new commits appear: **stop immediately**. Do not review the rest, do not continue the cycle. Report to the user exactly which commits appeared (hash, message) and ask how to proceed. Never revert, reset, or push on your own.

Only after confirming no unauthorized commits, review normally:
```bash
git -C "<project_dir>" status --short
git -C "<project_dir>" diff
```

Read the full diff. Run the project's validation suite and check against the task acceptance criteria.

### 5. Decide

- **All passing** → proceed to Phase 5 (Review) in the current CLI.
- **Simple fix** (typo, missing import, off-by-one): fix directly with Edit, re-run validation, re-check.
- **Non-trivial issue**: write a specific correction prompt citing the concrete problem (failed test output, file:line, expected vs actual) and re-dispatch with `--continue`. Always re-include the git prohibition in correction prompts.
- **Same problem persists after 2 correction cycles**: stop delegation, report to user, proceed to Phase 5 with current state.

---

## Phase 3 — TDD

> Skip this phase if execution was delegated to an external CLI in Phase 2.7.

> Model: **sonnet** — when using subagents, set `model: "sonnet"`.

Read `tdd.md` and act as the TDD specialist.

### Multitask Mode

For each squad, launch a subagent (Agent tool with `run_in_background: true`) that:
1. Receives the TDD agent instructions (`tdd.md`) and the squad's tasks
2. Writes all tests for the squad's tasks
3. Runs all tests — they must all fail before proceeding
4. If any passes: flags as false positive, fixes, re-runs

All squad agents run in parallel. Wait for all to complete before proceeding.

### Singletask Mode

List the squads and ask:

> "Qual squad deseja executar?"
>
> 1. **[Squad Name]** — [N] tarefas
> 2. **[Squad Name]** — [N] tarefas
> ...

Execute TDD for the selected squad only:
1. Write all tests for the squad's tasks
2. Run all tests — they must all fail before proceeding
3. If any passes: flag as false positive, fix, re-run

Do not proceed until every test fails.

---

## Phase 4 — Code

> Skip this phase if execution was delegated to an external CLI in Phase 2.7.

> Model: **sonnet** — when using subagents, set `model: "sonnet"`.

### Multitask Mode

For each squad, launch a subagent (Agent tool with `run_in_background: true`) that:
1. Receives the applicable coder agent instructions based on the squad's agent type (`coder-backend.md`, `coder-frontend.md`, or both)
2. Implements minimum code to make the squad's tests pass
3. Follows project conventions — no over-engineering, no changes outside scope
4. Runs tests after each task

All squad agents run in parallel. Wait for all to complete. Run the full test suite to verify no cross-squad conflicts before proceeding to Phase 5.

### Singletask Mode

Read the applicable coder agent(s) for the current squad — `coder-backend.md` for backend squads, `coder-frontend.md` for frontend squads, or both if the squad spans both layers — and act as the Coder.

Implement minimum code to make the squad's tests pass. Follow project conventions. No over-engineering. No changes outside scope.

Run tests after each task. When the squad is complete, ask:

> "Squad **[name]** concluído. Próximo passo?"
>
> **A.** Executar próximo squad: **[next squad name]**
> **B.** Ir para a revisão (Phase 5)

If **A**: return to Phase 3 for the next squad. If **B** or all squads done: proceed to Phase 5.

---

## Phase 5 — Review

Review all executed squads together — regardless of execution mode (Multitask or Singletask) or delegation.

If execution was delegated to an external CLI, read the order file and review all changes made by the external CLI before proceeding with the review report.

> Model: **sonnet** — when using subagents, set `model: "sonnet"`.

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

**Rejected iteration 1:** read the applicable coder agent(s), fix blocking issues, run tests, return to Phase 5 as iteration 2.

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
