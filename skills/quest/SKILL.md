---
name: quest
description: Discovery e inception estruturados para produto, módulo, feature ou estória — classifica o nível do trabalho, investiga o código para pré-preencher respostas, e conduz uma trilha adaptativa cobrindo problema, usuários, valor, escopo, alternativas, riscos e validação. Salva os resultados em .darkside/holomaps/. É a etapa do "o quê e por quê" que alimenta o /war-room (o "como").
---

# Quest — Discovery & Inception

Guide the user through an adaptive discovery conversation to fully understand **what** should be built and **why**, before any engineering planning. Quest produces a holomap — the discovery document that `/war-room` later consumes to plan **how**.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Positioning

- `/quest` answers **what and why** — problem, users, value, scope, risks.
- `/war-room` answers **how** — systems, data, APIs, implementation strategy.
- `/mission` is a lightweight brainstorm when the user doesn't yet know what they want.

Never propose code or detailed engineering design during a quest. If the conversation drifts into implementation details, capture the point briefly under Risks or Notes and steer back.

---

## Before You Begin

1. If `.darkside/holocrons/tech.md` exists, read it in full and use as project context. If not, proceed without it and note the absence in the holomap.
2. Look at `.darkside/holomaps/` and `.darkside/missions/` for recent related documents. If one clearly relates to the topic, mention it and ask whether to use it as context.

---

## Active Investigation Rule

Quest is not a passive questionnaire. Throughout the session:

- **Investigate before asking.** When a question can be answered by reading the codebase (current behavior, similar features, impacted modules, existing patterns), read the relevant code first.
- **Pre-fill, then confirm.** Write what you found into the holomap and present it to the user as a summary to confirm or correct — instead of asking from zero.
- **Never invent.** If the code doesn't answer it, ask. Pre-filled content must come from tech.md, the codebase, or prior darkside documents — and be marked as confirmed only after the user validates it.
- **Skip what is known.** If every question in a block is already answered and confirmed, say so in one line and move on.

---

## Interaction Model

Three interaction patterns. Pick the right one for each moment:

1. **Open question** — when exploring territory only the user knows (problem, users, business rules). One question at a time.
2. **Options (A/B/C)** — when you can propose concrete alternatives (scope cuts, approaches, risk posture). Present a short context paragraph, then up to 3 options. The user can pick, combine, or answer freely.
3. **Confirmation loop** — after synthesizing an answer or pre-filled findings, state your understanding and ask: "Está correto ou preciso ajustar algo?" Iterate until confirmed.

Never ask two questions in the same message. Adapt question wording to the project's actual stack and domain (from tech.md).

---

## Step 1 — Opening & Classification

Ask:

> "Me conte o que vamos descobrir. Pode ser uma ideia de produto, um módulo, uma feature ou uma estória — descreva do seu jeito."

Wait for the answer. Then propose a classification with a one-line justification:

> "Pelo que você descreveu, isso parece ser **[Produto | Módulo | Feature | Estória]** — [justificativa].
>
> **A.** Concordo, seguir nesse nível
> **B.** É outro nível — vou te dizer qual
> **C.** Não sei — me ajude a decidir"

Level definitions (use to classify and to explain option C):

- **Produto** — something new with its own users, value proposition, and lifecycle.
- **Módulo** — a bounded area inside an existing product, with its own domain and integration boundaries.
- **Feature** — a new capability inside an existing module or product.
- **Estória** — a small, well-bounded slice of a feature, deliverable in one iteration.

After the level is confirmed: derive filename (suffix: `.md`) from the user's description, silently create `.darkside/holomaps/[file]` with the sections of the chosen track (see Holomap Templates), and run your initial investigation (tech.md + relevant code) to pre-fill whatever you can.

Say: "Nível confirmado. Vamos começar a discovery."

---

## Step 2 — The Track

Run only the blocks listed for the confirmed level, in order. Each block lists its questions; apply the Active Investigation Rule and the Interaction Model to every block. Write each block into its holomap section before moving to the next.

| Block | Produto | Módulo | Feature | Estória |
|---|---|---|---|---|
| A. Problem & Value | ✅ | ✅ | ✅ | ✅ |
| B. Users & Personas | ✅ | ✅ | — | — |
| C. Current Context | — | ✅ | ✅ | ✅ |
| D. Scope & Boundaries | ✅ | ✅ | ✅ | ✅ |
| E. Alternatives | ✅ | ✅ | ✅ | — |
| F. Success Metrics | ✅ | ✅ | optional¹ | — |
| G. Risks & Assumptions | ✅ | ✅ | ✅ | ✅ (short) |
| H. Increments | ✅ | ✅ | ✅ | — |
| I. Validation | ✅ | ✅ | ✅ | ✅ |

¹ Ask block F for a feature only if its value is measurable (conversion, performance, adoption). Skip for purely internal changes.

### Block A — Problem & Value

Open questions, one at a time:

1. "Qual problema estamos resolvendo? Para quem esse problema dói?"
2. "O que acontece se não fizermos nada?"
3. "Qual é o resultado esperado quando isso existir?"

For **Produto**, also ask:

4. "Por que agora? O que torna esse o momento certo?"
5. "Existe alternativa hoje — concorrente, planilha, processo manual?"

Synthesize into a short value statement and run a confirmation loop. Write into `## Problem & Value`.

### Block B — Users & Personas

Open questions, one at a time:

1. "Quem usa isso? Descreva os perfis principais."
2. "O que cada perfil precisa conseguir fazer?"
3. "Algum perfil tem restrições especiais — permissão, acessibilidade, contexto de uso?"

Write into `## Users & Personas`.

### Block C — Current Context

**Investigate first.** Read the relevant code and pre-fill: current behavior, similar existing solutions, impacted modules, external dependencies. Present findings as a summary and run a confirmation loop. Then ask only what the code cannot answer:

1. "Existem regras de negócio ocultas que não estão no código?"
2. "Há algo no contexto atual — histórico, decisões passadas, dívidas — que eu deveria saber?"

Write into `## Current Context`.

### Block D — Scope & Boundaries

Propose a scope cut based on everything learned, as options:

> [Short paragraph framing the scope decision]
>
> **A.** [Minimal cut — smallest version that solves the core problem]
> **B.** [Balanced cut — core problem + the most valuable extensions]
> **C.** [Complete cut — full vision]

After the user picks or refines, ask:

> "O que está explicitamente **fora** do escopo? Liste tudo que alguém poderia assumir que entra, mas não entra."

Write **In scope** and **Out of scope** lists into `## Scope & Boundaries`.

### Block E — Alternatives

Propose 2–3 distinct approaches with trade-offs (simplicity, impact, maintainability, risk) — directions, not engineering designs. Then ask, one at a time:

1. "Essas alternativas cobrem as opções que você vê, ou há outra?"
2. "Qual parece a direção certa e por quê?"
3. "Qual é a opção mais simples que ainda resolve o problema?"

Record the chosen direction and why the others were discarded. Write into `## Alternatives`.

### Block F — Success Metrics

Ask, one at a time:

1. "Como vamos medir que isso deu certo? Quais números mudam?"
2. "Qual é o valor atual dessas métricas (baseline), se conhecido?"
3. "Em quanto tempo esperamos ver o efeito?"

Write metrics as **metric → baseline → target → horizon**. Write into `## Success Metrics`.

### Block G — Risks & Assumptions

Ask, one at a time (for **Estória**, ask only question 1):

1. "Quais premissas estamos assumindo sem ter validado?"
2. "Quais decisões são reversíveis? Quais não são?"
3. "É necessário um spike para validar alguma premissa antes de seguir?"

Categorize each item as **Assumption** (believed, unvalidated), **Known unknown** (we know we don't know), or **Critical risk** (can sink the work). For each critical risk, record a mitigation or a spike. Write into `## Risks & Assumptions`.

### Block H — Increments

Propose a slicing into increments where **each increment delivers verifiable value** — never layer-by-layer (domain → infra → UI). Present as options when there are meaningfully different slicings, otherwise as a proposal with a confirmation loop.

For **Produto**, the first increment is the MVP: ask explicitly "O que é o mínimo que já entrega o valor central?"

Write a numbered increment list — each with a one-line value statement — into `## Increments`.

### Block I — Validation

Ask, one at a time (for **Estória**, questions 1 and 2 only):

1. "Quais são os critérios de aceite? Liste como condições verificáveis."
2. "Como vamos testar isso?"
3. "Qual observabilidade é necessária — logs, métricas, alertas?"

Write acceptance criteria as a checklist (`- [ ]`). Write into `## Validation`.

---

## Step 3 — Synthesis & Handoff

1. Write an `## Executive Summary` at the top of the holomap (below the title): 5–8 lines covering problem, who it serves, chosen direction, scope cut, top risk, and first increment.
2. Present the summary to the user and run a confirmation loop. Apply any corrections to the file.
3. When confirmed, replace the first line (`⚠️ Discovery in progress — not completed.`) with: `✅ Discovery completed — DD/MM/YYYY HH:MM`
4. Say: "Quest concluída. Holomap salvo em `.darkside/holomaps/<filename>`."
5. Suggest the next step:
   - **Produto / Módulo / Feature:** "Deseja executar `/war-room` para transformar essa discovery em um plano de engenharia? Ele vai usar este holomap como contexto."
   - **Estória:** "Deseja executar `/order66` para implementar essa estória?"

If yes, invoke the corresponding skill. If no, stop.

---

## Holomap Templates

Created silently after the level is confirmed. Include only the sections of the chosen track, in this order. `<Level>` is one of Product, Module, Feature, Story.

```markdown
⚠️ Discovery in progress — not completed.

# Quest: <short title derived from the user's description>

**Level:** <Level>
**Date:** YYYY-MM-DD

## Executive Summary

## Problem & Value

## Users & Personas

## Current Context

## Scope & Boundaries

## Alternatives

## Success Metrics

## Risks & Assumptions

## Increments

## Validation
```

Omit the sections not used by the track (e.g., a Story holomap has only Executive Summary, Problem & Value, Current Context, Scope & Boundaries, Risks & Assumptions, Validation).
