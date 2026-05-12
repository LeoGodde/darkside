---
name: war-room
description: Structured engineering discovery — covers functional understanding, technical impact, and implementation strategy. Requires /explore. Incorporates quest as context. Reads tech.md and silently pre-fills known answers. Saves the plan to .darkside/war-room/YYYY-MM-DD-plan-name-plan.md.
---

# War Room — Engineering Discovery

Conduct a structured engineering discovery to produce a complete technical plan before any implementation begins. Follow each section in order. Do not skip sections.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Prerequisite

Check prerequisite `.darkside/holocrons/tech.md`. If missing:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."

If it exists: silently extract everything already known — stack, architecture, components, integrations, database, auth, conventions. Pre-fill any item that can be derived without asking.

---

## Opening

Ask:

> "Me dê mais detalhes sobre o que vamos executar."

Wait for the answer. Use it as primary context for the entire session. Derive a candidate plan name from it.

---

## Quest Context

Look for files in `.darkside/holomaps/`.

**If found:** identify the most recent file (prefixed `YYYY-MM-DD-`). Ask:

> "Encontrei uma quest recente: **`[filename]`**
>
> **A.** Usar essa quest — vou incorporar o que já foi mapeado
> **B.** Usar outra quest — me informe o caminho
> **C.** Continuar sem quest"

- **A:** Read and use to pre-fill answers throughout.
- **B:** Ask for path, read, proceed as A.
- **C:** Continue without.

**If none found:** continue silently.

---

## Pre-fill Rule

For each item: if tech.md or quest already answers it, write directly and skip the question. If all items in a group are filled, skip the group. Never invent answers.

---

## Plan Name

Propose a candidate name. Ask:

> "Como vamos chamar esse plano? Sugiro: **[candidate name]**"

Derive filename (suffix: `-plan.md`). Create `.darkside/war-room/` and the plan file with empty sections (see Plan Structure) silently.

---

## Section 1 — Functional Understanding

### 1.1 — Main Flow

Always ask — one at a time:

1. "O que inicia essa feature?"
2. "O que o sistema deve fazer?"
3. "Qual é o resultado ao final?"

Write into `### Main Flow`.

### 1.2 — States

Ask what is not yet known:

> "Quais desses estados a feature precisa tratar?
>
> - Loading / Estado vazio / Erro / Retry / Timeout
>
> Para cada um que existir, descreva como deve funcionar."

Write into `### States`.

### 1.3 — Rules

Ask what is not yet known:

> "Quais regras se aplicam?
>
> - Permissões — quem pode acessar ou executar?
> - Validações — o que precisa ser validado?
> - Limitações — existe algum limite?
> - Dependências — depende de outra feature ou condição?"

Write into `### Rules`.

### 1.4 — Alternative Cases

Always ask:

> "O que acontece em cada um desses casos?
>
> - Falha na operação
> - Operação já executada antes
> - Dado ou evento duplicado
> - Dois usuários executando ao mesmo tempo"

Write into `### Alternative Cases`.

### 1.5 — Acceptance Criteria

Always ask:

> "Quais condições precisam ser verdadeiras para a feature estar pronta?"

Write into `### Acceptance Criteria`.

Say: "Entendimento funcional completo. Vamos ao impacto técnico."

---

## Section 2 — Technical Impact

### 2.1 — Systems

Pre-fill existing systems. Ask only what changes for this feature:

> "O que muda em cada sistema?
>
> - Frontend / Backend / Banco de dados / Infraestrutura / Analytics"

Omit systems that don't exist in the project. Write into `### Systems`.

### 2.2 — Data

Ask what is not yet known:

> "Sobre os dados:
>
> - Campo novo em entidades existentes?
> - Entidade nova?
> - Migration? Destrutiva ou aditiva?
> - Dados existentes continuam funcionando?"

Write into `### Data`.

### 2.3 — APIs

Ask what is not yet known:

> "Sobre as APIs:
>
> - Endpoint novo?
> - Contrato existente muda?
> - Quebra clientes atuais?
> - Precisa versionar?"

Write into `### APIs`.

### 2.4 — Dependencies

Pre-fill existing integrations. Ask only what is feature-specific:

> "Sobre dependências:
>
> - Integração externa? / Fila ou mensageria? / Cache? / Feature flag?"

Write into `### Dependencies`.

Say: "Impacto técnico mapeado. Agora a estratégia de implementação."

---

## Section 3 — Implementation Strategy

### 3.1 — Architecture

Pre-fill existing layer separation. Ask one at a time:

1. "Onde fica a regra de negócio dessa feature?"
2. "O que é do frontend e o que é do backend?"
3. "Tem algo já existente que pode ser reutilizado?"

Write into `### Architecture`.

### 3.2 — Implementation Order

Always ask:

> "Qual é a sequência ideal para implementar?
>
> - Backend antes do frontend?
> - Alguma task depende de outra?
> - Menor entrega com valor?"

Write into `### Implementation Order`.

### 3.3 — Compatibility

Ask what is not yet known:

> "Sobre compatibilidade:
>
> - Manter comportamento atual durante transição?
> - Rollout para todos ou gradual?
> - Fallback se precisar reverter?"

Write into `### Compatibility`.

### 3.4 — Security

Pre-fill existing auth/validation. Ask only what is feature-specific:

> "Sobre segurança:
>
> - Checagem de permissão antes de executar?
> - Pode expor dados sensíveis?
> - Entrada do usuário validada no servidor?"

Write into `### Security`.

### 3.5 — Technical Plan

Based on everything collected, write into `### Technical Plan`:

- Approach in 3–5 bullet points
- Numbered implementation sequence
- Responsibilities by layer
- Rollout strategy
- Key risks and mitigations

Do not ask — generate from collected answers.

Then:

1. Replace the first line (`⚠️ Engineering discovery in progress — not completed.`) with: `✅ Engineering discovery completed — DD/MM/YYYY HH:MM`
2. Say: "War Room concluído. Plano salvo em `.darkside/war-room/<filename>`."
3. Say: "Se quiser refinar ainda mais seu plano, execute `/interrogate`."

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
