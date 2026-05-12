---
name: quest
description: Conversa estruturada de discovery para tarefas de desenvolvimento — reduz incerteza antes de escrever código cobrindo entendimento do problema, contexto, alternativas, direção técnica, riscos, plano de implementação e validação. Salva os resultados em .darkside/holomaps/.
---

# Quest — Discovery Session

Guide the user through a structured discovery conversation to fully understand a development task before any code is written. Follow every step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

## Before You Begin

If `.darkside/holocrons/tech.md` exists, read it and use as project context. If not, proceed without it.

## Step 1 — Problem Understanding

Ask one at a time:

1. "Qual problema estamos resolvendo?"
   - After this answer: derive filename (suffix: `.md`) and silently create `.darkside/holomaps/[file]` with empty sections (see Initial Document).
2. "Qual é o resultado esperado?"
3. "Isso é uma correção de bug, melhoria, spike ou nova feature?"
4. "Quais restrições existem? Por exemplo: tempo, stack, arquitetura ou regras de negócio."
5. "Como é o pronto?"
6. "Como saberemos que funcionou?"

Write into `## 1. Problem Understanding`. Say: "Entendido. Vamos mapear o contexto existente."

---

## Step 2 — Context

Ask one at a time:

1. "Como isso funciona hoje? Descreva o comportamento ou estado atual."
2. "Existe algo similar já no projeto?"
3. "Quais módulos, serviços ou áreas serão impactados?"
4. "Existem regras de negócio ocultas que não são óbvias pelo código?"
5. "Há dependências externas a considerar?"

Write into `## 2. Context`. Say: "Ótimo. Agora vamos explorar as opções."

---

## Step 3 — Alternatives

Propose 2-3 distinct approaches with trade-offs (simplicity, architecture, performance, maintainability, risk).

Ask one at a time:

1. "Essas alternativas cobrem as opções que você vê, ou há outra abordagem?"
2. "Qual opção parece mais próxima da direção certa e por quê?"
3. "Qual é a solução mais simples que realmente resolve o problema?"

Write into `## 3. Alternatives`. Say: "Vamos validar a direção técnica."

---

## Step 4 — Technical Direction

Ask one at a time (reference actual frameworks/patterns from tech.md):

1. "Como é o modelo de dados? Entidades e relacionamentos."
2. "Qual é o fluxo principal? Sequência de operações."
3. "Quais contratos ou interfaces envolvidos?"
4. "Quais edge cases precisam ser tratados?"
5. "Qual a estratégia de gerenciamento de estado?"
6. "Como erros e fallbacks são tratados?"

Write into `## 4. Technical Direction`. Say: "Agora vamos identificar riscos e incógnitas."

---

## Step 5 — Risks & Unknowns

Ask one at a time:

1. "É necessário um spike para validar alguma premissa?"
2. "Há premissas não testadas?"
3. "Quais decisões são reversíveis? Quais não são?"

Categorize into **Known known**, **Known unknown**, **Critical risk**. Write into `## 5. Risks & Unknowns`. Say: "Quase lá. Vamos detalhar a implementação."

---

## Step 6 — Implementation Plan

Ask one at a time:

1. "Quais mudanças de domínio são necessárias?"
2. "Quais mudanças de infraestrutura?"
3. "Quais mudanças de UI ou API?"
4. "Qual a estratégia de testes?"
5. "Qual a estratégia de rollout?"

Write numbered increment list (domain → infra → UI/API → tests → rollout) into `## 6. Implementation Plan`. Say: "Último passo — vamos definir como o sucesso se parece."

---

## Step 7 — Validation

Ask one at a time:

1. "Quais testes cobrirão este trabalho?"
2. "Quais são os critérios de aceite? Liste como condições verificáveis."
3. "Qual observabilidade é necessária?"
4. "Há um plano de rollback?"

Write into `## 7. Validation`. Then:

1. Replace first line (`⚠️ Discovery in progress — not completed.`) with: `✅ Discovery completed — DD/MM/YYYY HH:MM`
2. Say: "Quest concluído. Holomap salvo em `.darkside/holomaps/<filename>`. Revise e use como base para o seu plano de implementação."

---

## Initial Document

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
