---
name: forge
description: Criação e edição de skills do Darkside — pergunta o que a skill deve fazer, aplica todos os padrões do plugin e gera os arquivos para Claude Code e Cursor simultaneamente.
---

# Forge — Skill Builder

Create or edit Darkside skills following all established plugin patterns. Forge is a meta-skill — it knows the anatomy of every skill and ensures every new or modified skill fits seamlessly into the ecosystem.

**Follow Shared Rules** from `skills/_shared-rules.md`.

> **Note:** Forge is not listed in `/darkside` or `/guide`. It is an internal tool for skill authors.

---

## Darkside Skill Patterns

These are the canonical patterns applied to every skill. Forge must enforce all of them.

### Language

- **All communication with the user**: Brazilian Portuguese
- **All generated files, storage, configuration, frontmatter, and code**: English

### Claude Code — `skills/<name>/SKILL.md`

**Frontmatter**
```yaml
---
name: <skill-name>
description: <one-line description in Brazilian Portuguese — used for skill discovery>
---
```

**Header**
```markdown
# <Skill Title> — <Short subtitle>

<One paragraph describing what the skill does and when to use it.>

**Follow Shared Rules** from `skills/_shared-rules.md`.
```

**Step structure**
- Steps are numbered and titled: `## Step 1 — <Name>`
- Each step has a clear action and a clear output (what gets written where)
- Never skip steps — always explicit ordering
- Pre-fill rule: if `tech.md` or context already answers an item, write it silently without asking

**Document lifecycle**
- Create the output file silently after the first meaningful user input
- First line: `⚠️ <Skill> in progress — not completed.`
- Final line replacement: `✅ <Skill> completed — DD/MM/YYYY HH:MM`
- Always write each section to the file before moving to the next

**Filename derivation** (from `_shared-rules.md`)
1. Lowercase
2. Remove accents (`ã` → `a`, `ç` → `c`)
3. Spaces → `-`
4. Remove non-alphanumeric except `-`
5. Collapse consecutive `-`
6. Prepend `YYYY-MM-DD-`
7. Append suffix specified by the skill (e.g., `-plan.md`, `-order.md`, `.md`)

**Storage locations**
| Skill | Output directory |
|-------|-----------------|
| `explore` | `.darkside/holocrons/` |
| `quest` | `.darkside/holomaps/` |
| `war-room` | `.darkside/war-room/` |
| `mission` | `.darkside/missions/` |
| `order66` | `.darkside/imperial-orders/` |
| `inquisitor` | `.darkside/the-grand-inquisitor/` |
| `verdict` / `visual-fidelity` | `.darkside/verdicts/` |
| New skills | `.darkside/<skill-name>/` (unless specified otherwise) |

**Prerequisite check pattern**
```markdown
## Prerequisite

Check prerequisite `.darkside/holocrons/tech.md`. If missing:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."
```

**Interaction pattern**
- One question per message — never two
- Options A/B/C when applicable
- One follow-up allowed if the answer is ambiguous

---

### Cursor — `.cursor/rules/<name>.mdc`

**Frontmatter**
```yaml
---
description: "Darkside /<name> — <same description as Claude Code, in English>"
globs:
alwaysApply: false
---
```

**Shared Rules** — must be inlined (Cursor cannot reference external files):
```markdown
## Shared Rules

- All messages to the user are in Brazilian Portuguese
- All generated files are written in English
- One question or block at a time — never ask two questions in the same message
- Wait for the user's answer before continuing
- One follow-up allowed if the answer is ambiguous — do not interrogate
- Never propose code during discovery conversations
- If the user stops mid-session, preserve the partial file with its "in progress" header — do not delete it
- Always write each section to the file before moving to the next
- Communication is simple, direct, and easy to understand — no unnecessary jargon, without compromising technical precision

### Filename Derivation

When a skill says "derive filename", apply these steps:

1. Lowercase
2. Remove accents (`ã` → `a`, `ç` → `c`)
3. Spaces → `-`
4. Remove non-alphanumeric except `-`
5. Collapse consecutive `-`
6. Prepend `YYYY-MM-DD-`
7. Append the suffix specified by the skill
```

**Cursor-specific constraints**
- No `TaskCreate` / `TaskUpdate` — removed entirely
- No subagents — all logic is inline within the rule file
- Skill registration: add the new command to the routing table in `darkside.mdc`
- Inter-skill invocation: "follow the `<name>.mdc` rule instructions" instead of "invoke the X skill"

---

## Opening

Ask:

> "Qual skill nós vamos criar ou alterar?"

Wait for the answer.

---

## Mode Detection

Determine from the user's answer whether this is:

- **CREATE** — a brand new skill that does not exist yet
- **EDIT** — an existing skill that needs to be modified

If ambiguous, ask:

> "Você quer criar uma skill nova ou editar uma existente?"
>
> **A.** Criar nova skill
> **B.** Editar skill existente

---

## CREATE Mode

### Step 1 — Name & Purpose

Propose a skill name derived from the user's description. Ask:

> "Vou chamar essa skill de `/<suggested-name>`. Está bom ou prefere outro nome?"

Wait for confirmation or correction.

### Step 2 — Clarify Behavior

Ask one question at a time to understand:

1. "Essa skill é interativa (faz perguntas ao usuário) ou executiva (executa diretamente)?"
2. "Ela gera algum arquivo? Se sim, qual é o conteúdo e onde fica?"
3. "Ela tem algum pré-requisito? (ex: precisa que `/explore` já tenha rodado)"
4. "Ela deve encadear outra skill ao final? (ex: invocar `/order66` depois)"

Each question waits for an answer before proceeding.

### Step 3 — Draft Review

Write a draft of the skill in the chat (not to a file yet). Include:

- Frontmatter
- Opening instruction paragraph
- Prerequisite check (if applicable)
- Step-by-step flow
- Output document template (if applicable)

Say:

> "Aqui está o rascunho da skill. Revise e me diga se quer ajustar alguma coisa antes de eu criar os arquivos."

Wait for approval or adjustments. Iterate until confirmed.

### Step 4 — Write Claude Code Skill

Create `skills/<name>/SKILL.md` with the approved content. Say nothing — proceed silently to Step 5.

### Step 5 — Write Cursor Rule

Create `.cursor/rules/<name>.mdc` in `/Users/leogodde/PROJECTS/darkside-cursor/` with the Cursor-adapted version:
- Inline shared rules
- Remove TaskCreate/TaskUpdate
- Replace subagent invocations with inline instructions
- Update inter-skill references to use rule file format

### Step 6 — Register in Cursor Router

Open `/Users/leogodde/PROJECTS/darkside-cursor/.cursor/rules/darkside.mdc`. Add the new command to the routing table:

```
| `/<name>` | `<name>.mdc` |
```

Skip this step if the skill is intentionally hidden (like `forge` itself).

### Step 7 — Confirmation

Say:

> "Skill `/<name>` criada com sucesso.
>
> - `skills/<name>/SKILL.md` — Claude Code
> - `.cursor/rules/<name>.mdc` — Cursor (Darkside Cursor atualizado)"

---

## EDIT Mode

### Step 1 — Identify Target

If the user did not name the skill, ask:

> "Qual skill você quer editar? Pode digitar o nome ou descrever o que ela faz."

List available skills if helpful.

### Step 2 — Read Current State

Read `skills/<name>/SKILL.md`. Summarize what the skill currently does in 2–3 lines. Ask:

> "Encontrei a skill `/<name>`. O que você quer mudar?"

Wait for the answer.

### Step 3 — Propose Changes

Show the proposed diff or rewritten section in the chat. Ask:

> "Essas são as mudanças propostas. Está correto?"

Iterate until confirmed.

### Step 4 — Apply to Claude Code

Edit `skills/<name>/SKILL.md` with the approved changes. Proceed silently to Step 5.

### Step 5 — Apply to Cursor

Read `/Users/leogodde/PROJECTS/darkside-cursor/.cursor/rules/<name>.mdc`.

Apply equivalent changes adapted for the Cursor format (inline shared rules, no TaskCreate/TaskUpdate, inline inter-skill instructions).

### Step 6 — Confirmation

Say:

> "Skill `/<name>` atualizada.
>
> - `skills/<name>/SKILL.md` — Claude Code
> - `.cursor/rules/<name>.mdc` — Cursor (Darkside Cursor atualizado)"
