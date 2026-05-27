---
name: mission
description: Brainstorming guiado para entender o que deve ser feito antes de implementar — faz perguntas estruturadas com até 3 opções (A/B/C) para mapear problema, objetivo, limites, solução, riscos e partes afetadas. Salva em .darkside/missions/.
---

# Mission — Guided Brainstorming

Guide the user through a structured brainstorming conversation to fully understand what needs to be done before any implementation. Every interaction follows the pattern: context text + up to 3 options (A, B, C). Follow each step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Before You Begin

If `.darkside/holocrons/tech.md` exists, read it and use as project context. If not, proceed without it.

---

## Step 1 — Opening

Ask:

> "Me explique um pouco o que vamos fazer."

Wait for the answer. Use it as primary context for the entire session. Derive filename (suffix: `-mission.md`) (prefix: `YYYY-MM-DD-`). Silently create `.darkside/missions/` and the mission file with empty sections (see Mission Document).

---

## Step 2 — Problem

Based on the user's answer, write a short paragraph summarizing your understanding of the problem. State what you understood and then add:

> Está correto ou preciso ajustar algo?

Do multiple interactions if necessary until the goal is reached and the user is satisfied with the understanding of the problem.

Once the user is satisfied with the understanding of the problem, write into `## 1. Problem`.

---

## Step 3 — Objective

Based on the confirmed approaches, write a short paragraph about what success looks like. Then present up to 3 possible objectives based on each approach:

> [Paragraph contextualizing the objective]
>
> **A.** [Objective 1 — e.g., minimal viable solution but solves the core problem]
> **B.** [Objective 2 — e.g., balanced approach solves the core problem with more robust solution]
> **C.** [Objective 3 — e.g., most complete solution]

After the user picks or refines: write into `## 2. Objective`.

---

## Step 4 — Boundaries

Based on what was confirmed, ask what the implementation limits are:

> Quais são os limites dessa implementação? Existem coisas que estão fora do escopo?

After answer, write a short paragraph summarizing your understanding of the problem and boundaries. State what you understood and then add:

> Está correto ou preciso ajustar algo?

Do multiple interactions if necessary until the goal is reached and the user is satisfied with the understanding of the boundaries.

Once the user is satisfied with the understanding of the boundaries, write into `## 3. Boundaries`.

---

## Step 5 — Solution Direction

Based on the problem, objective, and boundaries, write a short paragraph exploring the solution space. Then present up to 3 technical solutions:

> [Paragraph analyzing the solution space given what was decided]
>
> **A.** [Solution 1 — with brief trade-off]
> **B.** [Solution 2 — with brief trade-off]
> **C.** [Solution 3 — with brief trade-off]

After the user picks or refines: write into `## 4. Solution Direction`.

---

## Step 6 — Affected Areas & Risks

Based on the chosen execution plan, list the affected parts of the system and the risks. Present as text + up to 3 risk postures:

> **Partes afetadas:**
> - [list of affected files, modules, systems, APIs]
>
> **Riscos identificados:**
> - [risk 1]
> - [risk 2]
> - [risk 3]
>
> Como tratar esses riscos?
>
> **A.** [Conservative — mitigate all, slower delivery]
> **B.** [Balanced — mitigate critical, accept minor risks]
> **C.** [Aggressive — accept most risks, fastest delivery]

After the user picks or refines: write into `## 6. Affected Areas & Risks`.

---

## Step 7 — Validation

Write the complete mission summary as it exists in the file. Ask:

> "Esse e o resumo completo da missao. Revise e confirme se esta tudo certo, ou me diga o que ajustar."

If changes requested: update the file and ask again.

If confirmed:

1. Replace the first line (`⚠️ Mission in progress — not completed.`) with: `✅ Mission completed — DD/MM/YYYY HH:MM`
2. Say: "Missao definida. Arquivo salvo em `.darkside/missions/<filename>`."

---

## Step 8 — Next Step

Ask:

> "Deseja executar `/order66` para implementar essa missao?"

If yes: invoke the order66 skill. If no: stop.

---

## Interaction Rule

Every question to the user follows the same structure:

1. A short paragraph providing context, analysis, or synthesis
2. Up to Three options: **A**, **B**, **C**
3. Never skip steps or questions.

The user can pick one, combine elements, or provide their own answer. If the user provides a free-form answer, incorporate it and move to the next step.

---

## Mission Document

Created silently after the user provides the opening answer:

```markdown
⚠️ Mission in progress — not completed.

# Mission: <derived from user's opening answer>

**Date:** YYYY-MM-DD

---

## 1. Problem

## 2. Objective

## 3. Boundaries

## 4. Solution Direction

## 5. Execution Plan

## 6. Affected Areas & Risks
```
