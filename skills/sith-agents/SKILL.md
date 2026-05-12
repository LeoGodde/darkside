---
name: sith-agents
description: Edita os system prompts dos sith-agents em .darkside/sith-agents/. Lista os agentes disponíveis, pergunta qual modificar e o que alterar, confirma em linguagem simples e aplica mediante aprovação.
---

# Sith Agents Editor

Guide the user through selecting and editing a sith-agent file. Follow the steps in order.

**Follow Shared Rules** from `skills/_shared-rules.md`.

## Step 1: Check for agents

Check if `.darkside/sith-agents/` exists and contains `.md` files.

If missing or empty:
> "Nenhum sith-agent encontrado em `.darkside/sith-agents/`. Rode `/explore` primeiro para gerar os agentes."

Stop.

## Step 2: List agents

Read `.md` files from `.darkside/sith-agents/`. Display as numbered list:

- `tdd.md` → 🧪 tdd
- `engineer.md` → ⚙️ engineer
- `coder.md` → 💻 coder
- `security.md` → 🔒 security
- `reviewer.md` → 🔍 reviewer
- Other `.md` → 🤖 [name]

> "Qual agente você deseja alterar?"

## Step 3: Confirm agent selection

Resolve number or name to file. If ambiguous, ask again.

> "O que deve ser alterado no agente `[icon] [name]`?"

## Step 4: Describe the change

Read the agent file. Describe changes in plain language:

> "Vou fazer as seguintes alterações no agente `[icon] [name]`:
>
> - [one-line description per change]
>
> Confirma?"

If confirmed: proceed. If cancelled: "Alteração cancelada." Ask if wants another agent.

## Step 5: Apply the change

Edit the file applying exactly what was described. Do not change anything else.

> "Alteração aplicada com sucesso no agente `[icon] [name]`."
> "Deseja modificar outro agente?"

If yes: restart from Step 2. If no: stop.

---

## Rules

- Never modify without explicit confirmation in Step 4
- Only change what was described — no reformatting or unrelated improvements
- If selected by number, resolve to position in the list shown in Step 2
- Agent list is always read from disk
