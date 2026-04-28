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
