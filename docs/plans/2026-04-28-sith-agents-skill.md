# `/sith-agents` Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a `/sith-agents` skill that lets the user browse, select, and edit any sith-agent file in `.darkside/sith-agents/` through a guided conversation.

**Architecture:** A single `SKILL.md` with complete instructions for the interactive flow: check for agents, display a numbered list with icons, ask which agent to modify, ask what change to make, describe the change for confirmation, apply on approval. `CLAUDE.md` is updated to list the new skill.

**Tech Stack:** Markdown only

---

## File Map

| File | Action | Purpose |
|------|--------|---------|
| `skills/sith-agents/SKILL.md` | Create | Full skill instruction for `/sith-agents` |
| `CLAUDE.md` | Modify | Add `/sith-agents` to available skills list |

---

## Task 1: Create the `/sith-agents` skill

**Files:**
- Create: `skills/sith-agents/SKILL.md`

- [ ] **Step 1: Create `skills/sith-agents/SKILL.md`**

Create the file with this exact content:

```markdown
---
name: sith-agents
description: Edit existing sith-agent system prompts in .darkside/sith-agents/. Lists available agents, asks the user which one to modify and what change to make, confirms in plain language, and applies on approval.
---

# Sith Agents Editor

Guide the user through selecting and editing a sith-agent file. Follow the steps in order.

## Step 1: Check for agents

Check if the directory `.darkside/sith-agents/` exists and contains `.md` files.

**If the directory is missing or empty:**

Say:
> "Nenhum sith-agent encontrado em `.darkside/sith-agents/`. Rode `/explore` primeiro para gerar os agentes com base no projeto."

Stop. Do not continue.

**If agents are found:** proceed to Step 2.

---

## Step 2: List agents

Read the list of `.md` files in `.darkside/sith-agents/`. Display them as a numbered list using the icon mapping below. Show only the files that actually exist — do not hardcode the list.

**Icon mapping:**
- `tdd.md` → 🧪 tdd
- `engineer.md` → ⚙️ engineer
- `coder.md` → 💻 coder
- `security.md` → 🔒 security
- `reviewer.md` → 🔍 reviewer
- `architect.md` → 🏛️ architect
- Any other `.md` file → 🤖 [filename without extension]

**Display format:**
```
Os seguintes sith-agents foram encontrados:

1. 🧪 tdd
2. ⚙️ engineer
3. 💻 coder
4. 🔒 security
5. 🔍 reviewer
6. 🏛️ architect

Qual agente você deseja alterar?
```

Wait for the user's answer before continuing.

---

## Step 3: Confirm agent selection

The user may answer with a number (e.g., "4") or a name (e.g., "security"). Resolve the selection to the corresponding file.

If the answer is ambiguous or does not match any agent, say:
> "Não entendi a seleção. Por favor, informe o número ou o nome do agente."

Wait for a valid answer before continuing.

Once resolved, say:
> "O que deve ser alterado no agente `[icon] [name]`?"

Wait for the user's answer.

---

## Step 4: Describe the change

Read the full content of the selected agent file. Based on the user's description, determine exactly what will change: which section will be affected and what text will be added, removed, or modified.

Describe the change in plain language. Do not show code or the full file. Say:

> "Vou fazer as seguintes alterações no agente `[icon] [name]`:
>
> - [one-line description of each change]
>
> Confirma?"

Wait for the user's answer.

- If the user confirms (yes / sim / confirma / ok): proceed to Step 5.
- If the user cancels (no / não / cancela): say "Alteração cancelada." then ask "Deseja modificar outro agente?" and restart from Step 2 if yes, or stop if no.

---

## Step 5: Apply the change

Edit the selected agent file applying exactly what was described in Step 4. Do not change anything else in the file.

After writing, say:
> "Alteração aplicada com sucesso no agente `[icon] [name]`."

Then ask:
> "Deseja modificar outro agente?"

- If yes: restart from Step 2.
- If no: stop.

---

## Rules

- Never modify an agent file without explicit user confirmation in Step 4
- Only change what was described — do not rewrite, reformat, or improve unrelated parts of the file
- All messages to the user are in Brazilian Portuguese
- If the user selects by number, resolve to the file at that position in the list shown in Step 2
- The agent list is always read from disk — never assume which agents exist
```

- [ ] **Step 2: Verify frontmatter**

Run:
```bash
head -5 skills/sith-agents/SKILL.md
```

Expected:
```
---
name: sith-agents
description: Edit existing sith-agent system prompts in .darkside/sith-agents/. Lists available agents, asks the user which one to modify and what change to make, confirms in plain language, and applies on approval.
---
```

---

## Task 2: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Add `/sith-agents` to the Available Skills section and Sith Agents storage entry**

Replace the content of `CLAUDE.md` with:

```markdown
# Darkside Plugin

This plugin provides skills for standardized team development workflows.

## Available Skills

- **explore** — Deep project analysis. Scans technology, architecture, packages,
  folder structure, and conventions. Saves findings to `.darkside/holocrons/tech.md`
  and generates 6 specialist agent prompts in `.darkside/sith-agents/`.
  Invoke with: `/explore`

- **quest** — Structured discovery conversation for a development task. Covers problem
  understanding, context, alternatives, technical direction, risks, implementation plan,
  and validation. Saves findings to `.darkside/holomaps/<task-name>-<date>.md`.
  Invoke with: `/quest`

- **sith-agents** — Edit existing sith-agent system prompts. Lists available agents,
  asks which one to modify and what change to make, confirms, and applies.
  Invoke with: `/sith-agents`

## Storage

### Holocrons — `.darkside/holocrons/`

Knowledge files about the project itself. Written once, updated when the project changes.

- `tech.md` — technology stack, architecture, folder structure and conventions. Written by `/explore`.

### Holomaps — `.darkside/holomaps/`

Discovery documents for specific tasks. One file per task, written by `/quest`.

- `YYYY-MM-DD-<task-name>.md` — full discovery for a development task.

### Sith Agents — `.darkside/sith-agents/`

Specialist agent system prompts generated by `/explore`. Fully customized to the project.
Editable via `/sith-agents`.

- 🧪 `tdd.md` — TDD specialist: test strategy, red-green-refactor, coverage
- ⚙️ `engineer.md` — Software engineer: design decisions, trade-offs, architecture fit
- 💻 `coder.md` — Coder: clean implementation, project conventions, naming
- 🔒 `security.md` — Security specialist: OWASP, input validation, auth, secrets
- 🔍 `reviewer.md` — Code reviewer: correctness, consistency, standards enforcement
- 🏛️ `architect.md` — Software architect: structure, module boundaries, scalability
```

---

## Task 3: Verify structure

- [ ] **Step 1: Confirm all skill files exist**

Run:
```bash
find . -path './.git' -prune -o -name "SKILL.md" -print | sort
```

Expected:
```
./skills/explore/SKILL.md
./skills/quest/SKILL.md
./skills/sith-agents/SKILL.md
```

---

## Self-Review

**Spec coverage:**

| Requirement | Task |
|-------------|------|
| Check for agents, warn + suggest /explore if missing | Task 1 — Step 1 of SKILL.md |
| Numbered list with icons | Task 1 — Step 2 of SKILL.md |
| User picks by number or name | Task 1 — Step 3 of SKILL.md |
| Ask what change to make | Task 1 — Step 3 of SKILL.md |
| Describe change in plain text + confirm | Task 1 — Step 4 of SKILL.md |
| Apply on confirmation | Task 1 — Step 5 of SKILL.md |
| Cancel path: notify + offer restart | Task 1 — Step 4 cancellation branch |
| After success: offer to edit another | Task 1 — Step 5 |
| List read dynamically from disk | Task 1 — "read from disk" rule |
| All messages in Brazilian Portuguese | Task 1 — Rules section |
| CLAUDE.md updated | Task 2 |
| Icons on all 6 agents + fallback for unknown | Task 1 — Icon mapping |

All requirements covered. No placeholders. No TODOs.
