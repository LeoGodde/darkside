---
name: hunter
description: Investigação forense de bugs — conduz o processo completo de debugging desde a compreensão dos sintomas até a correção, usando cadeia causal (Defeito → Infecção → Falha), rastreamento reverso e defesa em profundidade. Gera relatório forense e oferece execução via /order66.
---

# Hunter — Bug Forensics

Investigate bugs through a structured forensic process. Trace the causal chain from failure back to defect. Follow each step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Trigger

This skill activates when the user describes or asks about a bug, error, or unexpected behavior. Common triggers:

- "Qual o erro..."
- "Encontre o erro..."
- "O que está acontecendo..."
- "Isso não deveria estar..."
- "Por que isso está falhando..."
- "Tem um bug em..."
- "Isso parou de funcionar..."
- Any description of unexpected behavior, test failure, or error message

---

## Core Concept: The Causal Chain

Every bug follows this chain:

```
DEFECT (in the code) → INFECTION (in the state) → FAILURE (observable)
```

- **Defect:** the error in the source code (root cause)
- **Infection:** the program state that diverges from expected (may propagate through multiple layers)
- **Failure:** the observable wrong behavior (what the user reports)

**The golden rule: NEVER fix the failure. NEVER fix the infection. ALWAYS fix the defect.**

---

## Prerequisite

Check prerequisite `.darkside/holocrons/tech.md`. If missing:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."

If `.darkside/sith-agents/debugger.md` exists, read it and use as specialist context throughout the session.

If `.darkside/sith-agents/tdd.md` exists, read it for use in Phase 4.

---

## Step 1 — Derive Filename and Create Report

From the user's first description, derive a short name for the bug.

Derive filename (suffix: `-hunter.md`). Create `.darkside/hunter/` and the report file silently with the initial structure:

```markdown
⚠️ Hunter in progress — not completed.

# Forensic Report: [Bug Name]

**Date:** YYYY-MM-DD
**Status:** In Progress

## Causal Chain
- **Defect:** [pending investigation]
- **Infection:** [pending investigation]
- **Failure:** [pending investigation]

## Symptoms

## Context

## Investigation

## Fix Plan
```

---

## Step 2 — Symptom Comprehension (Rubber Duck)

Conduct a structured interrogation to force precise articulation of the problem. Each question must be **contextual** — elaborated based on the specific bug described and on previous answers. Follow the Interaction Rule.

Cover these 5 areas, one per message. For each area, write a short paragraph analyzing what you understood so far, then present up to 3 options (A/B/C) tailored to the specific problem. Skip any area already answered in the user's initial description.

**Area 1 — Expected behavior:**
Write a paragraph restating what you think should happen based on the bug description. Then offer options:

> [Contextual paragraph based on the specific bug]
>
> **A.** [Hypothesis of expected behavior 1]
> **B.** [Hypothesis of expected behavior 2]
> **C.** [Hypothesis of expected behavior 3]

**Area 2 — Observed behavior:**
Write a paragraph about what seems to be going wrong. Then offer options:

> [Contextual paragraph about what might be happening]
>
> **A.** [Possible observed behavior 1 — e.g., error message, wrong output]
> **B.** [Possible observed behavior 2 — e.g., silent failure, partial result]
> **C.** [Possible observed behavior 3 — e.g., intermittent crash, data corruption]

**Area 3 — Timeline:**
Write a paragraph about when this might have started. Then offer options:

> [Contextual paragraph based on recent project activity]
>
> **A.** [Timeline hypothesis 1 — e.g., after last deploy]
> **B.** [Timeline hypothesis 2 — e.g., after dependency update]
> **C.** [Timeline hypothesis 3 — e.g., always existed, only noticed now]

**Area 4 — Frequency:**
Write a paragraph about the pattern of occurrence. Then offer options:

> [Contextual paragraph about reproducibility]
>
> **A.** [Frequency hypothesis 1 — e.g., always, every request]
> **B.** [Frequency hypothesis 2 — e.g., intermittent, under specific conditions]
> **C.** [Frequency hypothesis 3 — e.g., only with certain data/users/load]

**Area 5 — Impact:**
Write a paragraph about the scope and severity. Then offer options:

> [Contextual paragraph about who/what is affected]
>
> **A.** [Impact hypothesis 1 — e.g., all users blocked]
> **B.** [Impact hypothesis 2 — e.g., subset of users, workaround exists]
> **C.** [Impact hypothesis 3 — e.g., cosmetic, no data loss]

**Rules:**
- One area per message — wait for answer before the next
- Options must be specific to the bug, never generic
- The user can pick one option, combine elements, or provide their own answer
- If the user answers vaguely ("não sei", "acho que..."), ask one follow-up to clarify
- If the user tries to skip to the fix ("eu acho que o problema é X, só corrige"), resist: "Preciso entender o sintoma antes de investigar a causa."
- Pre-fill: if the user already provided any of this information in their initial message, skip that area

After all areas are covered, write into `## Symptoms`:

```markdown
## Symptoms

- **Expected:** [correct behavior]
- **Observed:** [wrong behavior + evidence]
- **Since:** [temporal reference]
- **Frequency:** [always / intermittent / specific conditions]
- **Impact:** [scope and severity]
```

---

## Step 3 — Scope and Context (Where and When)

Investigate actively — combine code analysis with user questions. Follow the Interaction Rule for all questions.

### 3.1 — Recent Changes

- Run `git log --oneline -20` on the current branch
- Check for open branches that touch related files: `git branch --list` and inspect recent ones
- Check recent merges: `git log --merges --oneline -10`

Analyze the git history and present findings with options:

> [Paragraph summarizing relevant recent changes found in git]
>
> **A.** [Most likely related change — e.g., specific commit/PR that touches affected area]
> **B.** [Second candidate — e.g., dependency update, config change]
> **C.** [No related change found — the bug may predate recent history]

### 3.2 — Error Environment

Based on the symptoms and project context, ask with options:

> [Contextual paragraph about where this type of bug typically manifests in this project]
>
> **A.** [Most likely environment — contextualized to the bug]
> **B.** [Second likely environment]
> **C.** [Third option or "all environments"]

If the error is environment-specific, investigate configuration differences (env vars, feature flags, dependency versions, data).

### 3.3 — Code Perimeter

Using `tech.md` as architectural context:

- Identify which modules/services are involved based on the symptoms
- Determine: frontend, backend, infra, or integration boundary?
- List the key files most likely related to the bug

Present the perimeter analysis with options:

> [Paragraph describing the likely affected area based on symptoms and architecture]
>
> **A.** [Perimeter hypothesis 1 — e.g., isolated to module X]
> **B.** [Perimeter hypothesis 2 — e.g., integration between X and Y]
> **C.** [Perimeter hypothesis 3 — e.g., cross-cutting concern affecting multiple layers]

Write into `## Context`:

```markdown
## Context

### Recent Changes
- [list of relevant commits/PRs/branches with dates]

### Environment
- **Where it occurs:** [production / staging / dev / all]
- **Relevant config:** [env vars, flags, versions]

### Perimeter
- **Modules involved:** [list]
- **External dependencies:** [list or "none"]
- **Key files:** [list of most likely related files]
```

---

## Step 4 — Deep Investigation (The Causal Chain)

### 4.1 — Pure Observation (Read-Only)

**Hard rule: NO code changes during this sub-step. Read only.**

- Read the key files identified in Step 3
- Read stack traces, error logs, test outputs completely
- Trace data flow: where does the wrong value come from? Through which functions does it pass?
- Identify infection points: where does state start diverging from expected?

### 4.2 — Pattern Analysis

- **Working vs. broken code:** find similar working code in the same codebase, compare
- **Race conditions:** check for concurrent access, async operations without await, mutable shared state
- **Edge cases:** null inputs, empty values, size limits, unicode, timezone, overflow
- **Existing tests:** check test coverage for the affected code. Do tests exist? Do they pass? Do they cover the bug scenario?
- **Missing tests:** identify scenarios that should have tests but don't

### 4.3 — Reverse Tracing (Root Cause)

```
1. Start at the FAILURE (observable error)
2. Identify the nearest INFECTION (which variable/state is wrong?)
3. Ask: "What wrote this wrong value?"
4. Trace one level up in the call stack
5. Repeat until the DEFECT is found (the source code that is wrong)
6. Verify: is this truly the origin? Or is there another level above?
```

**For non-deterministic bugs (intermittent, timing-dependent):**
- Do NOT assume "can't reproduce = doesn't exist"
- Investigate: race conditions, order-dependent state, stale cache, clock skew
- Consider adding temporary diagnostic instrumentation (logs, tracing) to capture evidence on next occurrence

### 4.4 — Single Hypothesis and Minimal Test

1. **Formulate ONE falsifiable hypothesis:** "The defect is [X] because [evidence Y]"
2. **Design the smallest possible test** that confirms or refutes the hypothesis
3. **Execute the test**
4. **Evaluate:**
   - Confirmed → proceed to Step 5
   - Refuted (< 3 times) → form NEW hypothesis with new information. Do NOT stack fixes
   - Refuted (≥ 3 times) → trigger circuit breaker (4.5)

### 4.5 — Circuit Breaker (3 Refuted Hypotheses)

If 3 consecutive hypotheses are refuted:

**STOP. Do not attempt a 4th hypothesis.**

Escalate to the user:

> "Três hipóteses foram refutadas. Padrão observado: [describe]. Isso pode indicar um problema arquitetural, não um bug pontual. Vamos discutir antes de continuar?"

Signs of architectural problem:
- Each fix reveals new problem in different place
- The fix would require massive refactoring
- Shared state between modules without clear contract
- The bug "returns" in different form after each correction

Wait for the user's direction before proceeding.

**Rules for Step 4:**
- One hypothesis at a time — never test multiple simultaneously
- Each hypothesis must have supporting evidence (not guessing)
- If a hypothesis is refuted, record it in the report (avoid re-investigation)
- Record all findings progressively

Write into `## Investigation`:

```markdown
## Investigation

### Observation
- [findings from code reading, logs, stack traces]
- [infection points identified]

### Pattern Analysis
- **Similar working code:** [reference]
- **Race conditions:** [found / not found]
- **Edge cases:** [identified]
- **Test coverage:** [existing / absent / partial]

### Reverse Trace
- **Failure:** [observable behavior]
- **Infection level 1:** [wrong state at X]
- **Infection level 2:** [wrong value coming from Y]
- ...
- **Defect:** [root cause in source code]

### Hypotheses
| # | Hypothesis | Evidence | Test | Result |
|---|-----------|----------|------|--------|
| 1 | [description] | [evidence] | [test performed] | Confirmed / Refuted |
```

---

## Step 5 — Fix Plan and Test Specification

After confirming the defect, write the fix plan. Do NOT implement the fix — prepare it for `/order66`.

### 5.1 — Regression Test Specification

Specify the test that must be created to cover this bug:
- What the test validates (expected vs. defect behavior)
- Which file/module the test belongs to
- Test type: unit, integration, or e2e
- Edge cases the test should cover

### 5.2 — Fix Description

Describe the fix at the defect level:
- Exact file(s) and line(s) to change
- What the current code does wrong
- What the corrected code should do
- Any defense-in-depth validations to add (if infection crossed 2+ layers)

### 5.3 — Defense in Depth (when applicable)

If the infection propagated through 2 or more layers, specify validations at each layer:

| Layer | Purpose | Where |
|-------|---------|-------|
| **Entry** | Reject invalid input at API boundary | [file:line] |
| **Logic** | Ensure domain invariants | [file:line] |
| **Environment** | Prevent dangerous operations in specific contexts | [file:line] |
| **Observability** | Capture context for future investigations | [file:line] |

Write into `## Fix Plan`:

```markdown
## Fix Plan

### Regression Test
- **Validates:** [expected behavior that the bug breaks]
- **File:** [path for the test file]
- **Type:** [unit / integration / e2e]
- **Scenarios:**
  - [scenario 1 — the main bug case]
  - [scenario 2 — edge case if applicable]

### Defect Fix
- **File:** [path:line]
- **Current behavior:** [what the code does wrong]
- **Expected behavior:** [what it should do]
- **Change:** [description of the fix]

### Defense in Depth
| Layer | Validation | File |
|-------|-----------|------|
| [layer] | [what to validate] | [path:line] |
```

Update the `## Causal Chain` section at the top of the report:

```markdown
## Causal Chain
- **Defect:** [one line — root cause in the code]
- **Infection:** [how state became corrupted]
- **Failure:** [what the user observed]
```

---

## Step 6 — Review and Handoff

Update the report header:

```markdown
✅ Hunter completed — DD/MM/YYYY HH:MM
```

Update status:

```markdown
**Status:** Resolved
```

Present a summary to the user:

> "Investigação concluída. Relatório salvo em `.darkside/hunter/[filename]`.
>
> **Cadeia causal:**
> - **Defeito:** [one line]
> - **Infecção:** [one line]
> - **Falha:** [one line]
>
> **Fix planejado:** [one line summary]
> **Teste de regressão:** [one line summary]
>
> Está tudo correto? Deseja executar a correção com `/order66`?"

**If yes:** invoke the `/order66` skill. The hunter report serves as the plan input — order66 should read the Fix Plan section for tasks, test specification, and implementation details.

**If no:** ask what needs adjustment. Update the report and ask again.

---

## Production Incident (P0/P1)

If the user indicates the bug is in production and causing active impact:

**Before Step 2, add Step 0 — Immediate Mitigation:**

> "Esse bug está causando impacto ativo em produção. Antes de investigar, vamos estabilizar:
>
> **A.** Rollback para versão anterior
> **B.** Desativar feature flag
> **C.** Outro workaround
> **D.** Já foi mitigado, pode investigar"

Mitigation ≠ fix. After stabilizing, proceed with the normal investigation (Steps 2–6).

---

## Anti-Patterns

The agent must NEVER:

| Anti-pattern | Why it is prohibited |
|-------------|---------------------|
| Propose fix before completing Step 2 | Symptom ≠ cause. Premature fix masks real defect |
| Change code during observation (4.1) | Observing and experimenting simultaneously contaminates evidence |
| Test multiple hypotheses at once | Impossible to isolate which change had effect |
| Stack fixes on top of failed fix | Each fix layer hides the defect further |
| Say "can't reproduce" and give up | 95% of "can't reproduce" is incomplete investigation |
| Bundle refactoring with the fix | Bundled changes introduce new defects |
| Skip regression test specification | Bugs without tests come back |
| Ignore refuted hypotheses | Re-investigating the same path wastes time |
| Implement the fix directly | The fix is executed by `/order66`, not by `/hunter` |

---

## Interaction Rule

Every question to the user follows the same structure:

1. A short paragraph providing context, analysis, or synthesis — specific to the bug being investigated
2. Up to three options: **A**, **B**, **C** — elaborated based on the problem, never generic
3. The user can pick one, combine elements, or provide their own answer
4. If the user provides a free-form answer, incorporate it and move to the next step
5. Never present generic/template options — every option must reflect the specific bug context

---

## Rules

- Read `tech.md` and `debugger.md` (if available) before starting — use as context throughout
- Record exact file:line for every finding
- Write each section to the report before moving to the next step
- Report created silently in Step 1, filled progressively through Steps 2–5
- Source files are read-only throughout the entire skill — hunter investigates, never implements
- The fix plan must include regression test specification — no fix without test
- Always present the complete causal chain (defect → infection → failure) before asking for confirmation
