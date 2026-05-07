---
name: war-room
description: Structured engineering discovery — covers functional understanding, technical impact, and implementation strategy. Requires /explore. Incorporates quest as context. Reads tech.md and silently pre-fills known answers. Saves the plan to .darkside/war-room/YYYY-MM-DD-plan-name-plan.md.
---

# War Room — Engineering Discovery

Conduct a structured engineering discovery to produce a complete technical plan before any implementation begins. Follow each section in order. Do not skip sections.

---

## Prerequisite

Check if `.darkside/holocrons/tech.md` exists.

If it does not exist, say:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."

Stop. Do not continue until the file exists.

If it exists: read it in full. Silently extract everything already known about the project: stack, architecture layers, existing components, integrations, database, authentication mechanism, and conventions. Use this knowledge to write answers directly into the plan file for any item that can be derived — without asking the user and without mentioning the source. Ask only what could not be derived.

---

## Opening

Ask:

> "Me dê mais detalhes sobre o que vamos executar."

Wait for the answer. Use it as the primary context for the entire session — it informs the pre-fill strategy, the quest context, and all subsequent questions. From this answer, also derive a candidate plan name to propose when asking for the plan name later.

---

## Quest Context

Before starting, look for files in `.darkside/holomaps/`.

**If one or more files are found:**

Identify the most recent file by filename (files are prefixed `YYYY-MM-DD-`). Ask:

> "Encontrei uma quest recente: **`[filename]`**
>
> Como quer usar?
>
> **A.** Usar essa quest — vou incorporar o que já foi mapeado
> **B.** Usar outra quest — me informe o caminho
> **C.** Continuar sem quest"

Wait for the answer.

- **A:** Read the file in full. Use its content (problem understanding, context, technical direction, risks, plan) to pre-fill answers throughout the session. For items already answered by the quest, write directly to the file without asking.
- **B:** Ask: "Informe o caminho do arquivo de quest." Read the file and proceed as in option A.
- **C:** Continue without quest context.

**If no files are found:** continue without mentioning it.

---

## Pre-fill Rule

For each item in each section: if tech.md or the quest already answers it, write it directly to the file and skip the question. Ask only what could not be derived.

If all items in a group are already filled, move to the next group without asking anything.

Never invent answers. When in doubt, ask.

---

## Plan Name

Based on the opening answer, propose a candidate name. Ask:

> "Como vamos chamar esse plano? Sugiro: **[candidate name]**"

Wait for the answer — the user may confirm or provide a different name. Derive the filename from the final answer:

1. Convert to lowercase
2. Remove accents (`ã` → `a`, `ç` → `c` etc.)
3. Replace spaces with `-`
4. Remove non-alphanumeric characters except `-`
5. Collapse consecutive `-` into one
6. Prefix with current date: `YYYY-MM-DD-`
7. Suffix with `-plan.md`

Create `.darkside/war-room/` if it does not exist. Create the plan file immediately with empty sections (see Plan Structure below) — do this silently.

---

## Section 1 — Functional Understanding

### 1.1 — Main Flow

Always ask — tech.md and the quest do not know the feature in detail. Ask one at a time:

1. "O que inicia essa feature?"
2. "O que o sistema deve fazer?"
3. "Qual é o resultado ao final?"

Write the answers into `### Main Flow` of the plan file.

---

### 1.2 — States

Ask what is not yet known about state handling in the project:

> "Quais desses estados a feature precisa tratar?
>
> - Loading
> - Estado vazio
> - Erro
> - Retry
> - Timeout
>
> Para cada um que existir, descreva como deve funcionar."

Write into `### States` of the plan file.

---

### 1.3 — Rules

Ask what is not yet known about permissions, validations, and limitations:

> "Quais regras se aplicam?
>
> - Permissões — quem pode acessar ou executar?
> - Validações — o que precisa ser validado?
> - Limitações — existe algum limite (quantidade, tamanho, frequência)?
> - Dependências — depende de outra feature ou condição estar ativa?"

Write into `### Rules` of the plan file.

---

### 1.4 — Alternative Cases

Always ask — feature-specific:

> "O que acontece em cada um desses casos?
>
> - Falha na operação
> - Operação já executada antes
> - Dado ou evento duplicado
> - Dois usuários executando ao mesmo tempo"

Write into `### Alternative Cases` of the plan file.

---

### 1.5 — Acceptance Criteria

Always ask:

> "Quais condições precisam ser verdadeiras para a feature estar pronta?"

Write into `### Acceptance Criteria` of the plan file.

Say: "Entendimento funcional completo. Vamos ao impacto técnico."

---

## Section 2 — Technical Impact

### 2.1 — Systems

Silently pre-fill the systems that already exist in the project. Ask only what changes in each for this feature:

> "O que muda em cada sistema?
>
> - Frontend
> - Backend
> - Banco de dados
> - Infraestrutura
> - Analytics / Eventos"

Omit from the question any systems that do not exist in the project. Write into `### Systems` of the plan file.

---

### 2.2 — Data

Ask what is not yet known about the data layer:

> "Sobre os dados:
>
> - Algum campo novo em entidades existentes?
> - Alguma entidade nova?
> - Precisa de migration? É destrutiva ou aditiva?
> - Dados existentes continuam funcionando depois da mudança?"

Write into `### Data` of the plan file.

---

### 2.3 — APIs

Ask what is not yet known about API contracts:

> "Sobre as APIs:
>
> - Algum endpoint novo?
> - Algum contrato existente muda?
> - Alguma mudança quebra clientes atuais?
> - Precisa versionar?"

Write into `### APIs` of the plan file.

---

### 2.4 — Dependencies

Silently pre-fill integrations and infrastructure that already exist. Ask only what is feature-specific:

> "Sobre dependências:
>
> - Alguma integração externa envolvida?
> - Fila ou mensageria?
> - Cache?
> - Feature flag?"

Write into `### Dependencies` of the plan file.

Say: "Impacto técnico mapeado. Agora a estratégia de implementação."

---

## Section 3 — Implementation Strategy

### 3.1 — Architecture

Silently pre-fill the layer separation and responsibilities already established in the project. Ask only what is feature-specific. Ask one at a time:

1. "Onde fica a regra de negócio dessa feature?"
2. "O que é do frontend e o que é do backend?"
3. "Tem algo já existente que pode ser reutilizado?"

Write into `### Architecture` of the plan file.

---

### 3.2 — Implementation Order

Always ask:

> "Qual é a sequência ideal para implementar?
>
> - O backend precisa sair antes do frontend?
> - Alguma task depende de outra?
> - Qual é a menor entrega que já tem valor?"

Write into `### Implementation Order` of the plan file.

---

### 3.3 — Compatibility

Ask what is not yet known about rollout strategy and fallback:

> "Sobre compatibilidade:
>
> - Precisa manter o comportamento atual durante a transição?
> - Vai para todos de uma vez ou rollout gradual?
> - Existe um fallback se precisar reverter?"

Write into `### Compatibility` of the plan file.

---

### 3.4 — Security

Silently pre-fill what is already known about auth and validation in the project. Ask only what is feature-specific:

> "Sobre segurança:
>
> - Tem checagem de permissão antes de executar?
> - Pode expor dados sensíveis?
> - A entrada do usuário é validada no servidor?"

Write into `### Security` of the plan file.

---

### 3.5 — Technical Plan

Based on everything collected, write the plan into `### Technical Plan`. Include:

- Approach in 3–5 bullet points
- Numbered implementation sequence
- Responsibilities by layer (frontend / backend / infra)
- Rollout strategy
- Key risks and how to mitigate them

Do not ask anything — generate from the answers already collected.

Then:

1. Replace the first line of the plan file (`⚠️ Engineering discovery in progress — not completed.`) with: `✅ Engineering discovery completed — DD/MM/YYYY HH:MM`
2. Say: "War Room concluído. Plano salvo em `.darkside/war-room/<filename>`."

---

## Plan Structure

Created silently after the user provides the plan name:

```markdown
⚠️ Engineering discovery in progress — not completed.

# Plan: <plan name>

**Date:** YYYY-MM-DD

---

## 1. Functional Understanding

### Main Flow

### States

### Rules

### Alternative Cases

### Acceptance Criteria

---

## 2. Technical Impact

### Systems

### Data

### APIs

### Dependencies

---

## 3. Implementation Strategy

### Architecture

### Implementation Order

### Compatibility

### Security

### Technical Plan
```

---

## Rules

- One question or block at a time — never advance without writing the current section to the file
- Wait for the user's answer before continuing
- One follow-up allowed if the answer is ambiguous — do not interrogate
- Never invent pre-fills — only use what tech.md or the quest explicitly state
- Never propose code during the conversation
- If the user stops mid-session, the partial file is preserved with the "in progress" header — do not delete it
- Always write each section to the file before moving to the next
- Communication is always simple, direct, and easy to understand — no unnecessary jargon, without compromising technical precision
- All messages to the user are in Brazilian Portuguese
- All generated files are written in English
