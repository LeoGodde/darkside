# Design: `darkside` Plugin — `/sith-agents` Skill

**Date:** 2026-04-28
**Status:** Approved

---

## Overview

`/sith-agents` is a skill for editing existing sith-agent files in `.darkside/sith-agents/`. It lists available agents, asks the user which one to modify and what change to make, confirms the change in plain language, and applies it on user approval.

---

## Trigger

User calls `/sith-agents` in any project.

---

## Flow

```
/sith-agents invoked
    │
    ▼
Check .darkside/sith-agents/
    │
    ├── empty or missing → warn user + suggest /explore → stop
    │
    └── agents found
            │
            ▼
        Display numbered list of agents
        Ask: "Qual agente você deseja alterar?"
            │
            ▼
        User picks (number or name)
            │
            ▼
        Ask: "O que deve ser alterado neste agente?"
            │
            ▼
        User describes the change
            │
            ▼
        Claude describes the change in plain text
        Ask: "Confirma a alteração?"
            │
            ├── User confirms → apply + notify success
            └── User cancels → notify cancellation, offer to restart
```

---

## Agent Icons

| File | Display name |
|------|-------------|
| `tdd.md` | 🧪 tdd |
| `engineer.md` | ⚙️ engineer |
| `coder.md` | 💻 coder |
| `security.md` | 🔒 security |
| `reviewer.md` | 🔍 reviewer |
| `architect.md` | 🏛️ architect |

Icons are displayed in the list and in all subsequent messages referencing the chosen agent.

---

## Messages (Brazilian Portuguese)

**When no agents found:**
> "Nenhum sith-agent encontrado em `.darkside/sith-agents/`. Rode `/explore` primeiro para gerar os agentes com base no projeto."

**Agent list:**
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

**After user picks an agent:**
> "O que deve ser alterado no agente `🔒 security`?"

**Confirmation (description of change):**
```
Vou fazer as seguintes alterações no agente `🔒 security`:

- [plain text description of what will change]

Confirma?
```

**After applying:**
> "Alteração aplicada com sucesso no agente `🔒 security`."

**After cancelling:**
> "Alteração cancelada. Deseja modificar outro agente?"

---

## Behavior Details

- The skill reads the list of `.md` files from `.darkside/sith-agents/` dynamically — it shows whatever files exist, not a hardcoded list
- The user may select an agent by number or by name
- After cancellation, the skill offers to restart the selection — the user can pick another agent or decline
- The skill never modifies agents without explicit user confirmation
- After a successful edit, the skill asks if the user wants to modify another agent

---

## Integration

- Reads: `.darkside/sith-agents/*.md`
- Modifies: the selected `.darkside/sith-agents/<agent>.md`
