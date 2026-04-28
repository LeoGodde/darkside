---
name: quest
description: Structured discovery conversation for development tasks — reduces uncertainty before writing code by covering problem understanding, context, alternatives, technical direction, risks, implementation plan, and validation. Saves findings to .darkside/holomaps/.
---

# Quest — Discovery Session

Guide the user through a structured discovery conversation to fully understand a development task before any code is written. Follow every step in order. Do not skip steps. Ask one question at a time and wait for the user's answer before continuing.

## Before You Begin

Check if `.darkside/holocrons/tech.md` exists.

- If it exists: read it and use it as project context throughout the conversation. Reference specific technologies, modules, and patterns from it when asking questions.
- If it does not exist: proceed without it. Do not ask the user to run `/explore` first — just note internally that project context is unavailable.

## Step 1 — Problem Understanding

**Goal:** Understand what is really being solved.

Ask these questions one at a time, in order. Wait for the answer before asking the next:

1. "What problem are we solving?"
   - ⚠️ After receiving this answer: derive the holomap filename from it (see Filename Rules below), create the `.darkside/holomaps/` directory if it does not exist, and write the initial holomap file (see Initial Document below). Do this silently — do not announce it to the user yet.
2. "What is the expected outcome?"
3. "Is this a bug fix, improvement, spike, or new feature?"
4. "What constraints exist? For example: time, stack, architecture, or business rules."
5. "What does done look like?"
6. "How will we know it worked?"

After the last answer: write everything learned in Step 1 into the `## 1. Problem Understanding` section of the holomap. Then say: "Got it. Let's map the existing context."

---

## Step 2 — Context

**Goal:** Map the terrain before proposing a solution.

Ask these questions one at a time, in order:

1. "How does this work today? Describe the current behavior or state."
2. "Is there anything similar already in the project?"
3. "Which modules, services, or areas will be impacted?"
4. "Are there hidden business rules involved that aren't obvious from the code?"
5. "Are there external dependencies to consider? For example: APIs, databases, third-party libraries."

After the last answer: write everything learned in Step 2 into the `## 2. Context` section of the holomap. Then say: "Good. Now let's explore the options."

---

## Step 3 — Alternatives

**Goal:** Avoid assuming the first solution is the right one.

Based on everything learned so far, propose 2 to 3 distinct approaches. For each, briefly describe: what it is, its trade-offs in terms of simplicity, architectural impact, performance, maintainability, and risk.

Then ask, one at a time:

1. "Do these alternatives cover the options you see, or is there another approach worth considering?"
2. "Which option feels closest to the right direction, and why?"
3. "What is the simplest solution that actually solves the problem?"

After the last answer: write the alternatives and the chosen direction into the `## 3. Alternatives` section of the holomap. Then say: "Let's validate the technical direction."

---

## Step 4 — Technical Direction

**Goal:** Validate the chosen design before writing code.

Ask these questions one at a time, in order. Use the project context from `tech.md` to make questions specific — reference actual frameworks, patterns, and modules found in the project:

1. "What does the data model look like? Describe the entities and their relationships."
2. "What is the main flow? Walk me through the sequence of operations."
3. "What are the contracts or interfaces involved? For example: API endpoints, function signatures, events."
4. "What edge cases need to be handled?"
5. "What is the state management strategy?"
6. "How are errors and fallbacks handled?"

After the last answer: write everything into the `## 4. Technical Direction` section of the holomap. Then say: "Now let's surface risks and unknowns."

---

## Step 5 — Risks & Unknowns

**Goal:** Discover what is not yet known.

Ask these questions one at a time:

1. "Is a spike needed to validate any assumption before starting?"
2. "Are there untested premises — things we're assuming are true but haven't confirmed?"
3. "Which decisions in this design are reversible? Which are not?"

After the last answer: categorize findings into three groups and write them into `## 5. Risks & Unknowns`:

- **Known known** — facts we are certain of
- **Known unknown** — gaps we are aware of
- **Critical risk** — unknowns that could block or derail the work

Then say: "Almost there. Let's break down the implementation."

---

## Step 6 — Implementation Plan

**Goal:** Break the work into small, ordered increments.

Ask these questions one at a time:

1. "What are the domain changes needed? For example: new entities, updated business logic."
2. "What infrastructure changes are needed? For example: migrations, new services, configuration."
3. "What UI or API changes are needed?"
4. "What is the test strategy? What will be unit tested, integration tested, or end-to-end tested?"
5. "What is the rollout approach? For example: feature flag, gradual rollout, direct deploy."

After the last answer: write a numbered increment list into `## 6. Implementation Plan` following this order: domain changes → infrastructure → UI/API → tests → rollout. Then say: "Last step — let's define what success looks like."

---

## Step 7 — Validation

**Goal:** Define how success is proven before writing a line of code.

Ask these questions one at a time:

1. "What tests will cover this work?"
2. "What are the acceptance criteria? List them as checkable conditions."
3. "What observability is needed? For example: logs, metrics, alerts."
4. "Is there a rollback plan if something goes wrong?"

After the last answer: write everything into `## 7. Validation`. Then:

1. Replace the first line of the holomap (`⚠️ Discovery in progress — not completed.`) with the completion line: `✅ Discovery completed — DD/MM/YYYY HH:MM` using the current date and time.
2. Say: "Quest complete. Holomap saved to `.darkside/holomaps/<filename>`. Review it and use it as the foundation for your implementation plan."

---

## Filename Rules

Derive the filename from the user's answer to "What problem are we solving?":

1. Convert to lowercase
2. Remove accents and special characters (e.g., `ã` → `a`, `ç` → `c`)
3. Replace spaces with `-`
4. Remove any remaining non-alphanumeric characters except `-`
5. Collapse multiple consecutive `-` into one
6. Prepend the current date as `YYYY-MM-DD-`
7. Add `.md` extension

Examples:
- `"Criar formulário de cadastro de conta"` → `2026-04-27-criar-formulario-de-cadastro-de-conta.md`
- `"Fix login bug on mobile"` → `2026-04-27-fix-login-bug-on-mobile.md`
- `"API rate limiting"` → `2026-04-27-api-rate-limiting.md`

---

## Initial Document

Write this to `.darkside/holomaps/<filename>` immediately after receiving the answer to the first question:

```markdown
⚠️ Discovery in progress — not completed.

# Quest: <user's answer to "What problem are we solving?">

## 1. Problem Understanding

## 2. Context

## 3. Alternatives

## 4. Technical Direction

## 5. Risks & Unknowns

## 6. Implementation Plan

## 7. Validation
```

---

## Rules

- One question at a time — never ask two questions in the same message
- Wait for the user's answer before continuing
- One follow-up allowed per answer if the response is ambiguous — do not interrogate
- Never propose code, implementation artifacts, or solutions during the conversation — this skill produces only the holomap
- If the user stops mid-quest, the partial holomap is preserved with the "in progress" header — do not delete it
- Always write each section to the holomap before moving to the next step
