---
name: darkside
description: Ponto de entrada do plugin Darkside — exibe o logo e lista todas as skills disponíveis.
---

# Darkside

## Update Check

Before displaying anything, check if `~/.darkside/.update-available` exists.

If it does:
1. Read the new version from the file
2. Delete the file (`~/.darkside/.update-available`)
3. Display this alert (before the logo):

```
⚠️  Nova versão do Darkside disponível: v[version]
Para atualizar: curl -fsSL https://raw.githubusercontent.com/LeoGodde/darkside/main/install-remote.sh | bash
```

Then display the logo and skill list below normally.

---

Display the following logo and skill list exactly as shown. Do not add commentary before or after — just output this.

```
██████╗  █████╗ ██████╗ ██╗  ██╗███████╗██╗██████╗ ███████╗
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██║██╔══██╗██╔════╝
██║  ██║███████║██████╔╝█████╔╝ ███████╗██║██║  ██║█████╗
██║  ██║██╔══██║██╔══██╗██╔═██╗ ╚════██║██║██║  ██║██╔══╝
██████╔╝██║  ██║██║  ██║██║  ██╗███████║██║██████╔╝███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝
```

---

**Skills disponíveis:**

| Skill | Description |
|-------|-------------|
| `/explore` | Inicialização e análise profunda do projeto |
| `/quest` | Discovery e inception de produto, módulo, feature ou estória |
| `/sith-agents` | Editar os agentes especialistas |
| `/order66` | Orquestração completa do ciclo de desenvolvimento |
| `/inquisitor` | Inspeção profunda de código, PR e reviews |
| `/mission` | Quest compacto para tarefas menores |
| `/war-room` | Engineering discovery estruturado → plano técnico |
| `/interrogate` | Interroga e refina o plano do war-room |
| `/verdict` | Verifica critérios de aceite de cards contra o código |
| `/visual-fidelity` | Verifica fidelidade visual entre Figma e código |
| `/hunter` | Caçador de bug — Compreensão aprofundada |
| `/guide` | Ajuda |

---

Digite qualquer skill para começar.
