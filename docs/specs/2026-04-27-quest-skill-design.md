# Design: `darkside` Plugin — `/quest` Skill

**Date:** 2026-04-27
**Status:** Approved

---

## Overview

`/quest` is a discovery skill that guides the user through a structured conversation to fully understand a development task before any code is written. It reduces uncertainty by covering 7 discovery steps — from problem understanding to validation strategy — and saves the findings as a holomap document.

---

## Trigger

User calls `/quest` in any project.

---

## Behavior

### Prerequisites

The skill reads `.darkside/holocrons/tech.md` at startup to use as project context when formulating questions. If the file does not exist, the skill proceeds without it and notes the absence.

### Filename Generation

The filename is derived automatically from the user's first answer (their description of the problem being solved):

- Convert to lowercase
- Replace spaces and special characters with `-`
- Append the current date as `-DD-MM-YYYY`
- Extension: `.md`

Example: `"Criar formulário de cadastro de conta"` → `criar-formulario-de-cadastro-de-conta-27-04-2026.md`

### Document Lifecycle

1. **On creation:** the holomap is written to `.darkside/holomaps/` with all 7 sections empty and the following header:

```
⚠️ Discovery in progress — not completed.
```

2. **After each step:** the corresponding section is filled in with what was discussed before the next step begins.

3. **On completion:** the header is replaced with:

```
✅ Discovery completed — DD/MM/YYYY HH:MM
```

### Interaction Model

- One question at a time — Claude asks, waits for the user's answer, then continues
- Questions are contextualized using `tech.md` when available (e.g., if the project uses NestJS, questions reference modules and decorators; if it uses React, questions reference components and state)
- Claude does not advance to the next step without a user response
- After the user's answer, Claude may ask one follow-up if the answer is ambiguous — but does not interrogate

---

## The 7 Discovery Steps

### Step 1 — Problem Understanding

Goal: understand what is really being solved.

Questions (one at a time):
- What problem are we solving? *(filename derived from this answer)*
- What is the expected outcome?
- Is this a bug fix, improvement, spike, or new feature?
- What constraints exist? (time, stack, architecture, business rules)
- What does "done" look like?
- How will we know it worked?

### Step 2 — Context

Goal: map the terrain before proposing a solution.

Questions (one at a time):
- How does this work today?
- Is there anything similar already in the project?
- Which modules or areas will be impacted?
- Are there hidden business rules involved?
- Are there external dependencies? (APIs, databases, libraries)

### Step 3 — Alternatives

Goal: avoid assuming the first solution is the right one.

Claude proposes up to 3 approaches based on what was learned, then asks:
- Does this list of alternatives cover the options you see?
- For each option: what is the trade-off in terms of simplicity, architectural impact, performance, maintainability, and risk?
- What is the simplest solution that solves the problem?

### Step 4 — Technical Direction

Goal: validate the chosen design before writing code.

Questions (one at a time):
- What does the data model look like?
- What is the main flow?
- What are the contracts/interfaces involved?
- What are the edge cases?
- What is the state management strategy?
- How are errors and fallbacks handled?

### Step 5 — Risks & Unknowns

Goal: surface what is not yet known.

Questions (one at a time):
- Is a spike needed to validate any assumption?
- Are there untested premises?
- Which decisions are reversible? Which are not?

Claude categorizes findings as:
- Known known
- Known unknown
- Critical risk

### Step 6 — Implementation Plan

Goal: break the work into small increments.

Questions (one at a time):
- What are the domain changes needed?
- What infrastructure changes are needed?
- What UI/API changes are needed?
- What is the test strategy?
- What is the rollout approach?

### Step 7 — Validation

Goal: define how success is proven before writing a line of code.

Questions (one at a time):
- What tests will cover this?
- What are the acceptance criteria?
- What observability is needed? (logs, metrics, alerts)
- Is there a rollback plan?

---

## Output File

**Path:** `.darkside/holomaps/<derived-name>-DD-MM-YYYY.md`

**Structure:**

```markdown
⚠️ Discovery in progress — not completed.

# Quest: <derived name>

## 1. Problem Understanding

## 2. Context

## 3. Alternatives

## 4. Technical Direction

## 5. Risks & Unknowns

## 6. Implementation Plan

## 7. Validation
```

When complete, the header becomes:

```
✅ Discovery completed — DD/MM/YYYY HH:MM
```

---

## Integration with Other Skills

- Reads: `.darkside/holocrons/tech.md` (created by `/explore`)
- Writes: `.darkside/holomaps/<name>-<date>.md`
- Future: other skills may read holomaps as input context

---

## Notes

- The skill never writes code or implementation artifacts — it produces only the discovery document
- The user can stop mid-quest; the partial holomap is preserved with the "in progress" header
