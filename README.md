# darkside

```
██████╗  █████╗ ██████╗ ██╗  ██╗███████╗██╗██████╗ ███████╗
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██║██╔══██╗██╔════╝
██║  ██║███████║██████╔╝█████╔╝ ███████╗██║██║  ██║█████╗
██║  ██║██╔══██║██╔══██╗██╔═██╗ ╚════██║██║██║  ██║██╔══╝
██████╔╝██║  ██║██║  ██║██║  ██╗███████║██║██████╔╝███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝
```

Plugin para Claude Code — workflows padronizados de desenvolvimento para o time.

Versão para Cursor: [darkside-cursor](https://github.com/LeoGodde/darkside-cursor)

## Instalação

```bash
curl -fsSL https://raw.githubusercontent.com/LeoGodde/darkside/main/install-remote.sh | bash
```

O installer:
- Instala todas as skills em `~/.claude/commands/`
- Salva a versão instalada em `~/.darkside/VERSION`
- Instala o update checker em `~/.darkside/check-update.sh`
- Registra um hook no `~/.claude/settings.json` para checar atualizações automaticamente uma vez por dia

Abra o Claude Code e digite `/darkside` para confirmar a instalação.

## Atualização

```bash
curl -fsSL https://raw.githubusercontent.com/LeoGodde/darkside/main/install-remote.sh | bash
```

O mesmo comando sempre instala a versão mais recente. Quando uma nova versão estiver disponível, o Claude Code exibirá um alerta automaticamente ao abrir o menu `/darkside`.

## Skills

| Skill | Descrição |
|-------|-----------|
| `/darkside` | Exibe o logo e lista todas as skills disponíveis |
| `/explore` | Análise profunda do projeto → `tech.md` + sith-agents |
| `/quest` | Discovery e inception de produto, módulo, feature ou estória → holomap |
| `/war-room` | Engineering discovery estruturado → plano técnico completo |
| `/interrogate` | Interroga e refina o plano do war-room |
| `/order66` | Orquestração completa de desenvolvimento → TDD, código, revisão |
| `/inquisitor` | Inspeção profunda de código → relatório com julgamento final |
| `/mission` | Brainstorming compacto para tarefas menores |
| `/sith-agents` | Edita os system prompts dos sith-agents |
| `/verdict` | Verifica critérios de aceite de cards contra o código |
| `/visual-fidelity` | Verifica fidelidade visual entre Figma e código |
| `/guide` | Ajuda |

## Fluxo recomendado

```
/explore → /quest (opcional) → /war-room → /order66 → /inquisitor
```

| Etapa | Skill | O que produz |
|-------|-------|--------------|
| 1. Mapear o projeto | `/explore` | `tech.md` + sith-agents |
| 2. Discovery (o quê e por quê) | `/quest` | holomap |
| 3. Plano técnico | `/war-room` | plan.md |
| 4. Implementação | `/order66` | ordem imperial + tarefas + código revisado |
| 5. Auditoria | `/inquisitor` | relatório com julgamento final |

> `/order66` executa o `/war-room` automaticamente se nenhum plano for encontrado.

## Armazenamento

Todos os arquivos gerados ficam em `.darkside/` na raiz de cada projeto.

| Diretório | Criado por | Conteúdo |
|-----------|-----------|----------|
| `holocrons/` | `/explore` | `tech.md` — stack, arquitetura, convenções |
| `holomaps/` | `/quest` | Discovery completo por tarefa |
| `war-room/` | `/war-room` | Planos técnicos |
| `sith-agents/` | `/explore` | System prompts dos agentes (tdd, engineer, coder, security, reviewer) |
| `imperial-orders/` | `/order66` | Ordens de desenvolvimento + fallen-orders |
| `the-grand-inquisitor/` | `/inquisitor` | Relatórios de inspeção |
| `missions/` | `/mission` | Brainstorming compacto |
| `verdicts/` | `/verdict`, `/visual-fidelity` | Verificação de critérios de aceite e fidelidade visual |
