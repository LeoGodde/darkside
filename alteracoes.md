# Alterações — Darkside Plugin

**Data:** 2026-05-26

Nova skill `/mission` — brainstorming guiado com perguntas estruturadas (texto + 3 opções A/B/C).

---

## Resumo

| Alteração | Tipo |
|-----------|------|
| Nova skill `/mission` | Feature |
| `package.json` atualizado | Registro |
| `CLAUDE.md` atualizado — skill + storage | Documentação |
| `skills/darkside/SKILL.md` atualizado | Documentação |
| `skills/guide/SKILL.md` atualizado | Documentação |

---

## 1. Novo arquivo: `skills/mission/SKILL.md`

Brainstorming guiado para entender o que deve ser feito antes de implementar. Toda interação segue o formato: parágrafo de contexto + 3 opções (A, B, C).

### Fluxo:

1. Pergunta aberta: "Me explique um pouco o que vamos fazer"
2. **Problem** — texto + A/B/C (3 interpretações do problema)
3. **Objective** — texto + A/B/C (minimal / balanced / comprehensive)
4. **Boundaries** — texto + A/B/C (strict / moderate / wider scope)
5. **Solution Direction** — texto + A/B/C (3 abordagens técnicas)
6. **Execution Plan** — texto + A/B/C (3 planos concretos de execução)
7. **Affected Areas & Risks** — lista de impactos + A/B/C (conservative / balanced / aggressive)
8. **Validation** — exibe resumo completo, pede confirmação
9. **Next Step** — oferece chamar `/order66`

### Storage:

`.darkside/missions/YYYY-MM-DD-<name>-mission.md`

### Conteúdo completo:

```markdown
---
name: mission
description: Brainstorming guiado para entender o que deve ser feito antes de implementar — faz perguntas estruturadas com 3 opções (A/B/C) para mapear problema, objetivo, limites, solução, riscos e partes afetadas. Salva em .darkside/missions/.
---

# Mission — Guided Brainstorming

Guide the user through a structured brainstorming conversation to fully understand what needs to be done before any implementation. Every interaction follows the pattern: context text + 3 options (A, B, C). Follow each step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Before You Begin

If `.darkside/holocrons/tech.md` exists, read it and use as project context. If not, proceed without it.

---

## Step 1 — Opening

Ask:

> "Me explique um pouco o que vamos fazer."

Wait for the answer. Use it as primary context for the entire session. Derive filename (suffix: `-mission.md`). Silently create `.darkside/missions/` and the mission file with empty sections (see Mission Document).

---

## Step 2 — Problem

Based on the user's answer, write a short paragraph summarizing your understanding of the problem. Then present 3 interpretations of the core problem as options:

> [Summary paragraph of what you understood]
>
> **A.** [Problem interpretation 1]
> **B.** [Problem interpretation 2]
> **C.** [Problem interpretation 3]

After the user picks or refines: write into `## 1. Problem`.

---

## Step 3 — Objective

Based on the confirmed problem, write a short paragraph about what success looks like. Then present 3 possible objectives:

> [Paragraph contextualizing the objective]
>
> **A.** [Objective 1 — e.g., minimal viable solution]
> **B.** [Objective 2 — e.g., balanced approach]
> **C.** [Objective 3 — e.g., comprehensive solution]

After the user picks or refines: write into `## 2. Objective`.

---

## Step 4 — Boundaries

Based on what was confirmed, write a short paragraph about scope boundaries. Then present 3 sets of constraints:

> [Paragraph about what should be kept out of scope]
>
> **A.** [Boundary set 1 — strict scope, minimal changes]
> **B.** [Boundary set 2 — moderate scope, some flexibility]
> **C.** [Boundary set 3 — wider scope, more included]

After the user picks or refines: write into `## 3. Boundaries`.

---

## Step 5 — Solution Direction

Based on the problem, objective, and boundaries, write a short paragraph exploring the solution space. Then present 3 technical approaches:

> [Paragraph analyzing the solution space given what was decided]
>
> **A.** [Approach 1 — with brief trade-off]
> **B.** [Approach 2 — with brief trade-off]
> **C.** [Approach 3 — with brief trade-off]

After the user picks or refines: write into `## 4. Solution Direction`.

---

## Step 6 — Execution Options

Synthesize everything into 3 concrete execution plans. Each must include: what will be built, in what order, and what the trade-off is.

> Baseado em tudo que definimos, aqui estao 3 caminhos de execucao:
>
> **A.** [Execution plan 1 — summary + order + trade-off]
>
> **B.** [Execution plan 2 — summary + order + trade-off]
>
> **C.** [Execution plan 3 — summary + order + trade-off]

After the user picks or refines: write into `## 5. Execution Plan`.

---

## Step 7 — Affected Areas & Risks

Based on the chosen execution plan, list the affected parts of the system and the risks. Present as text + 3 risk postures:

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

## Step 8 — Validation

Write the complete mission summary as it exists in the file. Ask:

> "Esse e o resumo completo da missao. Revise e confirme se esta tudo certo, ou me diga o que ajustar."

If changes requested: update the file and ask again.

If confirmed:

1. Replace the first line (`⚠️ Mission in progress — not completed.`) with: `✅ Mission completed — DD/MM/YYYY HH:MM`
2. Say: "Missao definida. Arquivo salvo em `.darkside/missions/<filename>`."

---

## Step 9 — Next Step

Ask:

> "Deseja executar `/order66` para implementar essa missao?"

If yes: invoke the order66 skill. If no: stop.

---

## Interaction Rule

Every question to the user follows the same structure:

1. A short paragraph providing context, analysis, or synthesis
2. Three options: **A**, **B**, **C**

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
```

---

## 2. Alteração: `package.json`

Adicionada entrada na seção `skills`:

```json
"/mission": "Guided brainstorming → problem, objective, boundaries, solution, risks"
```

---

## 3. Alteração: `CLAUDE.md`

### Nova skill na seção Available Skills:

```markdown
- **mission** — Guided brainstorming to understand what needs to be done before
  implementing. Asks structured questions with 3 options (A/B/C) covering problem,
  objective, boundaries, solution direction, execution plan, affected areas, and risks.
  Offers to invoke `/order66` at the end. Saves to
  `.darkside/missions/YYYY-MM-DD-<name>-mission.md`.
  Invoke with: `/mission`
```

### Nova seção de storage (antes de War Room):

```markdown
### Missions — `.darkside/missions/`

Brainstorming documents written by `/mission`.

- `YYYY-MM-DD-<name>-mission.md` — problem + objective + boundaries + solution + execution plan + risks
```

---

## 4. Alteração: `skills/darkside/SKILL.md`

Adicionada linha na tabela de skills:

```markdown
| `/mission` | Brainstorming guiado → problema, objetivo, solução, riscos |
```

---

## 5. Alteração: `skills/guide/SKILL.md`

Adicionada linha na tabela:

```markdown
| `/mission` | Brainstorming guiado com perguntas estruturadas (texto + 3 opções A/B/C). Mapeia problema, objetivo, limites, solução, plano de execução e riscos. Ao final, oferece chamar `/order66`. **Use quando tiver uma ideia e quiser entender o que fazer antes de planejar.** |
```

---

## Como implementar em outro projeto

### Ordem de execução:

1. **Criar** `skills/mission/SKILL.md` (conteúdo na seção 1)
2. **Adicionar** `/mission` em `package.json` na seção `skills` (seção 2)
3. **Adicionar** entrada do `/mission` em `CLAUDE.md` — skill + storage (seção 3)
4. **Adicionar** linha do `/mission` em `skills/darkside/SKILL.md` (seção 4)
5. **Adicionar** linha do `/mission` em `skills/guide/SKILL.md` (seção 5)

### Pré-requisitos:

- `skills/_shared-rules.md` deve existir (contém regras de comunicação, interação e filename derivation)
- Diretório `.darkside/missions/` será criado automaticamente pela skill na primeira execução
