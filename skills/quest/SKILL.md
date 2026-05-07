---
name: quest
description: Conversa estruturada de discovery para tarefas de desenvolvimento — reduz incerteza antes de escrever código cobrindo entendimento do problema, contexto, alternativas, direção técnica, riscos, plano de implementação e validação. Salva os resultados em .darkside/holomaps/.
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

1. "Qual problema estamos resolvendo?"
   - ⚠️ After receiving this answer: derive the holomap filename from it (see Filename Rules below), create the `.darkside/holomaps/` directory if it does not exist, and write the initial holomap file (see Initial Document below). Do this silently — do not announce it to the user yet.
2. "Qual é o resultado esperado?"
3. "Isso é uma correção de bug, melhoria, spike ou nova feature?"
4. "Quais restrições existem? Por exemplo: tempo, stack, arquitetura ou regras de negócio."
5. "Como é o pronto?"
6. "Como saberemos que funcionou?"

After the last answer: write everything learned in Step 1 into the `## 1. Problem Understanding` section of the holomap. Then say: "Entendido. Vamos mapear o contexto existente."

---

## Step 2 — Context

**Goal:** Map the terrain before proposing a solution.

Ask these questions one at a time, in order:

1. "Como isso funciona hoje? Descreva o comportamento ou estado atual."
2. "Existe algo similar já no projeto?"
3. "Quais módulos, serviços ou áreas serão impactados?"
4. "Existem regras de negócio ocultas que não são óbvias pelo código?"
5. "Há dependências externas a considerar? Por exemplo: APIs, bancos de dados, bibliotecas de terceiros."

After the last answer: write everything learned in Step 2 into the `## 2. Context` section of the holomap. Then say: "Ótimo. Agora vamos explorar as opções."

---

## Step 3 — Alternatives

**Goal:** Avoid assuming the first solution is the right one.

Based on everything learned so far, propose 2 to 3 distinct approaches. For each, briefly describe: what it is, its trade-offs in terms of simplicity, architectural impact, performance, maintainability, and risk.

Then ask, one at a time:

1. "Essas alternativas cobrem as opções que você vê, ou há outra abordagem que vale considerar?"
2. "Qual opção parece mais próxima da direção certa e por quê?"
3. "Qual é a solução mais simples que realmente resolve o problema?"

After the last answer: write the alternatives and the chosen direction into the `## 3. Alternatives` section of the holomap. Then say: "Vamos validar a direção técnica."

---

## Step 4 — Technical Direction

**Goal:** Validate the chosen design before writing code.

Ask these questions one at a time, in order. Use the project context from `tech.md` to make questions specific — reference actual frameworks, patterns, and modules found in the project:

1. "Como é o modelo de dados? Descreva as entidades e seus relacionamentos."
2. "Qual é o fluxo principal? Me guie pela sequência de operações."
3. "Quais são os contratos ou interfaces envolvidos? Por exemplo: endpoints de API, assinaturas de funções, eventos."
4. "Quais edge cases precisam ser tratados?"
5. "Qual é a estratégia de gerenciamento de estado?"
6. "Como erros e fallbacks são tratados?"

After the last answer: write everything into the `## 4. Technical Direction` section of the holomap. Then say: "Agora vamos identificar riscos e incógnitas."

---

## Step 5 — Risks & Unknowns

**Goal:** Discover what is not yet known.

Ask these questions one at a time:

1. "É necessário um spike para validar alguma premissa antes de começar?"
2. "Há premissas não testadas — coisas que assumimos serem verdadeiras mas ainda não confirmamos?"
3. "Quais decisões neste design são reversíveis? Quais não são?"

After the last answer: categorize findings into three groups and write them into `## 5. Risks & Unknowns`:

- **Known known** — facts we are certain of
- **Known unknown** — gaps we are aware of
- **Critical risk** — unknowns that could block or derail the work

Then say: "Quase lá. Vamos detalhar a implementação."

---

## Step 6 — Implementation Plan

**Goal:** Break the work into small, ordered increments.

Ask these questions one at a time:

1. "Quais mudanças de domínio são necessárias? Por exemplo: novas entidades, lógica de negócio atualizada."
2. "Quais mudanças de infraestrutura são necessárias? Por exemplo: migrations, novos serviços, configuração."
3. "Quais mudanças de UI ou API são necessárias?"
4. "Qual é a estratégia de testes? O que será testado unitariamente, por integração ou end-to-end?"
5. "Qual é a estratégia de rollout? Por exemplo: feature flag, rollout gradual, deploy direto."

After the last answer: write a numbered increment list into `## 6. Implementation Plan` following this order: domain changes → infrastructure → UI/API → tests → rollout. Then say: "Último passo — vamos definir como o sucesso se parece."

---

## Step 7 — Validation

**Goal:** Define how success is proven before writing a line of code.

Ask these questions one at a time:

1. "Quais testes cobrirão este trabalho?"
2. "Quais são os critérios de aceite? Liste como condições verificáveis."
3. "Qual observabilidade é necessária? Por exemplo: logs, métricas, alertas."
4. "Há um plano de rollback caso algo dê errado?"

After the last answer: write everything into `## 7. Validation`. Then:

1. Replace the first line of the holomap (`⚠️ Discovery in progress — not completed.`) with the completion line: `✅ Discovery completed — DD/MM/YYYY HH:MM` using the current date and time.
2. Say: "Quest concluído. Holomap salvo em `.darkside/holomaps/<filename>`. Revise e use como base para o seu plano de implementação."

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
- All messages to the user are in Brazilian Portuguese
- All generated files (holomaps) are written in English
