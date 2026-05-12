# Alterações — Darkside Plugin

**Data:** 2026-05-11

Duas frentes de mudança: (1) nova skill `/interrogate` e (2) otimização de tokens em todas as skills.

---

## Resumo

| Alteração | Tipo |
|-----------|------|
| Nova skill `/interrogate` | Feature |
| Arquivo `_shared-rules.md` com regras compartilhadas | Otimização |
| Todas as skills otimizadas (~50% menos tokens) | Otimização |
| `CLAUDE.md`, `guide`, `darkside` atualizados com `/interrogate` | Documentação |
| `/war-room` sugere `/interrogate` ao final | Integração |

**Redução total:** de ~2.397 linhas para ~1.184 linhas (~50%)

---

## 1. Novo arquivo: `skills/_shared-rules.md`

Regras comuns extraídas de todas as skills para evitar repetição. Cada skill referencia com `**Follow Shared Rules** from skills/_shared-rules.md`.

### Conteúdo completo:

```markdown
# Shared Rules

Rules referenced by all Darkside skills. When a skill says "Follow Shared Rules", apply everything below.

---

## Communication

- All messages to the user are in Brazilian Portuguese
- All generated files are written in English

## Interaction

- One question or block at a time — never ask two questions in the same message
- Wait for the user's answer before continuing
- One follow-up allowed if the answer is ambiguous — do not interrogate
- Never propose code during discovery conversations (quest, war-room, interrogate)

## Files

- If the user stops mid-session, preserve the partial file with its "in progress" header — do not delete it
- Always write each section to the file before moving to the next
- Communication is simple, direct, and easy to understand — no unnecessary jargon, without compromising technical precision

## Filename Derivation

When a skill says "derive filename", apply these steps:

1. Lowercase
2. Remove accents (`ã` → `a`, `ç` → `c`)
3. Spaces → `-`
4. Remove non-alphanumeric except `-`
5. Collapse consecutive `-`
6. Prepend `YYYY-MM-DD-`
7. Append the suffix specified by the skill (e.g., `-plan.md`, `-order.md`, `.md`)

## Prerequisite Check

When a skill says "check prerequisite [path]", do:

- If the file/directory does not exist: say the message specified by the skill and stop
- If it exists: read it in full and use as context throughout the session
```

---

## 2. Nova skill: `skills/interrogate/SKILL.md`

Interrogatório focado do plano do war-room. Lê o plano e tech.md, identifica pontos fracos, vagos ou contraditórios, e desafia o usuário com perguntas direcionadas. Reescreve as seções melhoradas diretamente no arquivo do plano.

### Conteúdo completo:

```markdown
---
name: interrogate
description: Interrogatório focado do plano do war-room — lê o plano e tech.md, identifica pontos fracos, vagos ou contraditórios, e desafia o usuário com perguntas direcionadas. Reescreve as seções melhoradas diretamente no arquivo do plano.
---

# Interrogate — Plan Refinement

Read a war-room plan, identify weak spots, and grill the user with targeted questions to strengthen the plan. Follow every step in order.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Step 1 — Select the Plan

Check prerequisite `.darkside/holocrons/tech.md`. If missing:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."

Look for `-plan.md` files in `.darkside/war-room/`.

**If found:** identify the most recent. Ask:

> "Encontrei um plano recente: **`[filename]`**
>
> É esse que vamos interrogar?
>
> **A.** Sim, usar esse
> **B.** Não, quero informar outro caminho"

- **A:** Read the file in full.
- **B:** Ask for path, read the file.

**If none found:**

> "Nenhum plano encontrado em `.darkside/war-room/`. Rode `/war-room` primeiro."

Stop.

---

## Step 2 — Silent Analysis

Read the entire plan and tech.md. Silently identify:

1. **Vague language** — imprecise, generic wording
2. **Missing details** — sections too short or superficial
3. **Internal contradictions** — conflicts between sections
4. **Unaddressed edge cases** — scenarios mentioned but not covered in the Technical Plan
5. **Gaps with tech.md** — plan assumes something that doesn't match the project
6. **Weak acceptance criteria** — not verifiable or too broad
7. **Missing risk mitigation** — risks without clear mitigation
8. **Ambiguous responsibilities** — unclear which layer owns the logic

Order by severity. Do not share the list — address them one by one.

---

## Step 3 — Interrogation

For each issue, ask **one question at a time**:

1. **Quote the specific part** of the plan
2. **Explain why it's a problem**
3. **Suggest a concrete improvement**

Example:

> O plano diz: *"Erros serão tratados adequadamente."*
>
> Isso é vago demais para implementar. Que tipo de erro pode acontecer aqui? O usuário vê uma mensagem? Tem retry? Tem fallback?
>
> Minha sugestão: definir os 2-3 cenários de erro mais prováveis e o comportamento esperado para cada um.

After a clear answer, immediately rewrite the affected section in the plan file.

If the user disagrees with a valid reason, accept and move on.

If no issues found: say "Analisei o plano em detalhe e não encontrei pontos fracos relevantes. O plano está sólido." and skip to Step 5.

---

## Step 4 — Final Sweep

> "Tem algo que ficou de fora ou que você quer reforçar antes de fecharmos?"

If new point: discuss and update. If not: proceed.

---

## Step 5 — Close

1. Add after the first line of the plan (`✅ Engineering discovery completed`):

   ```
   🔍 Plan refined by /interrogate — DD/MM/YYYY HH:MM
   ```

2. Say:

   > "Interrogatório concluído. Plano refinado e salvo em `.darkside/war-room/<filename>`."
```

---

## 3. Alteração: `skills/war-room/SKILL.md`

### O que mudou:
- **Otimizado** — removidas regras duplicadas, explicações triviais, "Goal:" headers
- **Adicionada sugestão do `/interrogate`** ao final da execução
- **Referencia `_shared-rules.md`** em vez de repetir regras
- De 373 linhas → 302 linhas

### Mudança principal — final do Step 3.5:

Antes:
```
2. Say: "War Room concluído. Plano salvo em `.darkside/war-room/<filename>`."
```

Depois:
```
2. Say: "War Room concluído. Plano salvo em `.darkside/war-room/<filename>`."
3. Say: "Se quiser refinar ainda mais seu plano, execute `/interrogate`."
```

### Padrão de otimização aplicado (exemplo — Plan Name):

Antes (17 linhas):
```markdown
## Plan Name

Based on the opening answer, propose a candidate name. Ask:

> "Como vamos chamar esse plano? Sugiro: **[candidate name]**"

Wait for the answer — the user may confirm or provide a different name.
Derive the filename from the final answer:

1. Convert to lowercase
2. Remove accents (`ã` → `a`, `ç` → `c` etc.)
3. Replace spaces with `-`
4. Remove non-alphanumeric characters except `-`
5. Collapse consecutive `-`
6. Prefix with current date: `YYYY-MM-DD-`
7. Suffix with `-plan.md`

Create `.darkside/war-room/` if it does not exist. Create the plan file immediately
with empty sections (see Plan Structure below) — do this silently.
```

Depois (5 linhas):
```markdown
## Plan Name

Propose a candidate name. Ask:

> "Como vamos chamar esse plano? Sugiro: **[candidate name]**"

Derive filename (suffix: `-plan.md`). Create `.darkside/war-room/` and the plan file
with empty sections (see Plan Structure) silently.
```

---

## 4. Alteração: `skills/quest/SKILL.md`

### O que mudou:
- **Otimizado** — removidos "Goal:" headers, regras duplicadas, filename rules inline
- **Referencia `_shared-rules.md`**
- De 193 linhas → 137 linhas

### Padrão aplicado em todos os steps:

Antes:
```markdown
## Step 1 — Problem Understanding

**Goal:** Understand what is really being solved.

Ask these questions one at a time, in order. Wait for the answer before asking the next:
```

Depois:
```markdown
## Step 1 — Problem Understanding

Ask one at a time:
```

### Regras removidas do final (agora em _shared-rules.md):
```
- One question at a time — never ask two questions in the same message
- Wait for the user's answer before continuing
- One follow-up allowed per answer if the response is ambiguous — do not interrogate
- Never propose code, implementation artifacts, or solutions during the conversation
- If the user stops mid-quest, the partial holomap is preserved with the "in progress" header
- Always write each section to the holomap before moving to the next step
- All messages to the user are in Brazilian Portuguese
- All generated files (holomaps) are written in English
```

---

## 5. Alteração: `skills/explore/SKILL.md`

### O que mudou:
- **Maior otimização** — de 269 linhas → 90 linhas (-67%)
- **Referencia `_shared-rules.md`**
- **Agentes sith:** substituído 5 blocos verbosos (~140 linhas) por um template + tabela
- Removidas explicações óbvias de como criar diretórios

### Mudança principal — geração de agentes:

Antes (140 linhas, cada agente com Identity/Context/Responsibilities/Rules/Output expandidos):
```markdown
### Agent: `tdd.md`

Write a system prompt for a TDD specialist fully grounded in this project. Include:

**Identity**
You are a TDD specialist for [project stack and framework]. State the test framework...

**Project context**
List the main testable layers found in this project...

**Responsibilities**
- Define the test strategy before any implementation begins
- Write the first failing test for every new behavior
...

**Rules**
- Never write implementation code before the failing test exists
...

**Output**
Failing test files ready to run...
```
(repetido 5 vezes)

Depois (15 linhas total):
```markdown
Each agent follows this template — customize entirely based on the project:

**Identity** — role + project stack
**Project context** — relevant layers, tools, patterns from tech.md
**Responsibilities** — 4-5 key duties
**Rules** — 3-4 strict constraints
**Output** — what the agent produces

| File | Role | Focus |
|------|------|-------|
| `tdd.md` | TDD specialist | test strategy, red-green-refactor, coverage |
| `engineer.md` | Software engineer | design decisions, trade-offs, architecture fit |
| `coder.md` | Coder | clean implementation, conventions, naming |
| `security.md` | Security specialist | OWASP, input validation, auth, secrets |
| `reviewer.md` | Code reviewer | correctness, consistency, standards |
```

---

## 6. Alteração: `skills/order66/SKILL.md`

### O que mudou:
- **Otimizado** — de 243 linhas → 193 linhas
- **Referencia `_shared-rules.md`**
- Comprimidos prerequisite checks, filename derivation, fallen order template
- Removidas explicações redundantes

### Regras removidas do final (agora em _shared-rules.md):
```
- All messages to the user are in Brazilian Portuguese
- All generated files (order files, fallen-order files) are written in English
```

---

## 7. Alteração: `skills/inquisitor/SKILL.md`

### O que mudou:
- **Otimizado** — de 258 linhas → 192 linhas
- **Referencia `_shared-rules.md`**
- Comprimidos: prerequisite check, test discovery, filename derivation
- Mantida estrutura do report (necessária como template)

### Exemplo de compressão — test discovery:

Antes (11 linhas):
```markdown
After collecting the target, automatically search for related test files using these patterns:

1. Files with the same base name matching `*.spec.*` or `*.test.*` anywhere in the project
2. Files inside `__tests__/` directories adjacent to or above the target path
3. Files inside `tests/` or `test/` directories that mirror the target path structure

Read all found test files. Note them for the report.

If no test files are found: record "None found" — do not stop.
```

Depois (3 linhas):
```markdown
Search for related test files: `*.spec.*`, `*.test.*`, `__tests__/`, `tests/`, `test/`
directories. Read all found. If none: record "None found".
```

---

## 8. Alteração: `skills/sith-agents/SKILL.md`

### O que mudou:
- **Otimizado** — de 111 linhas → 68 linhas
- **Referencia `_shared-rules.md`**
- Comprimidos steps e regras

### Regras removidas do final:
```
- All messages to the user are in Brazilian Portuguese
```

---

## 9. Alteração: `skills/darkside/SKILL.md`

### O que mudou:
- Adicionada linha na tabela de skills:

```markdown
| `/interrogate` | Interroga e refina o plano do war-room |
```

---

## 10. Alteração: `skills/guide/SKILL.md`

### O que mudou:
- Adicionada linha na tabela:

```markdown
| `/interrogate` | Interroga o plano do war-room — identifica pontos fracos, vagos ou contraditórios e desafia com perguntas direcionadas. Reescreve as seções melhoradas diretamente no plano. **Use depois do `/war-room` para refinar o plano.** |
```

---

## 11. Alteração: `CLAUDE.md`

### O que mudou:
- Adicionada entrada na seção Available Skills:

```markdown
- **interrogate** — Interrogates a war-room plan to find weak, vague, or contradictory
  points. Reads the plan and `tech.md`, identifies gaps, and grills the user with
  targeted questions one at a time. Rewrites improved sections directly in the plan file.
  Invoke with: `/interrogate`
```

---

## Como implementar

### Ordem de execução:

1. **Criar** `skills/_shared-rules.md` (conteúdo na seção 1)
2. **Criar** `skills/interrogate/SKILL.md` (conteúdo na seção 2)
3. **Substituir** cada skill listada nas seções 3-8 pela versão otimizada
4. **Adicionar** linha do `/interrogate` em `skills/darkside/SKILL.md` (seção 9)
5. **Adicionar** linha do `/interrogate` em `skills/guide/SKILL.md` (seção 10)
6. **Adicionar** entrada do `/interrogate` em `CLAUDE.md` (seção 11)

### Princípios da otimização (para aplicar em novas skills):

- **Referencia `_shared-rules.md`** em vez de repetir regras de comunicação, interação e files
- **Usa "derive filename (suffix: X)"** em vez de listar os 7 passos
- **Usa "check prerequisite [path]"** em vez de escrever o if/else completo
- **Remove "Goal:" headers** — o título da seção é suficiente
- **Não explica operações triviais** (criar diretório, converter para lowercase)
- **Comprime listas** quando a semântica se mantém
