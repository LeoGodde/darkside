# darkside

```
██████╗  █████╗ ██████╗ ██╗  ██╗███████╗██╗██████╗ ███████╗
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██║██╔══██╗██╔════╝
██║  ██║███████║██████╔╝█████╔╝ ███████╗██║██║  ██║█████╗
██║  ██║██╔══██║██╔══██╗██╔═██╗ ╚════██║██║██║  ██║██╔══╝
██████╔╝██║  ██║██║  ██║██║  ██╗███████║██║██████╔╝███████╗
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝
```

Plugin interno para Claude Code — workflows padronizados de desenvolvimento para o time.

## Instalação

**1. Adicione o repositório como marketplace local:**

```bash
claude plugin marketplace add /caminho/para/darkside
```

**2. Instale o plugin:**

```bash
claude plugin install darkside@darkside
```

Após a instalação, as skills ficam disponíveis em toda nova sessão do Claude Code.

## Skills

| Skill | Descrição |
|-------|-----------|
| `/darkside` | Exibe o logo e lista todas as skills disponíveis |
| `/explore` | Análise profunda do projeto |
| `/quest` | Conversa estruturada de discovery → holomap |
| `/war-room` | Engineering discovery estruturado → plano técnico completo |
| `/sith-agents` | Edita os system prompts dos sith-agents |
| `/order66` | Orquestração completa de desenvolvimento → plano de implementação, TDD, código, revisão |
| `/inquisitor` | Inspeção profunda de código → relatório com julgamento final |
| `/guide` | Ajuda |

## Fluxo recomendado

```
/explore → /quest (opcional) → /war-room → /order66 → /inquisitor
```

| Etapa | Skill | O que produz |
|-------|-------|--------------|
| 1. Mapear o projeto | `/explore` | `tech.md` + sith-agents |
| 2. Discovery da tarefa | `/quest` | holomap |
| 3. Plano técnico | `/war-room` | plan.md |
| 4. Implementação | `/order66` | ordem imperial + tarefas + código revisado |
| 5. Auditoria | `/inquisitor` | relatório com julgamento final |

> `/order66` executa o `/war-room` automaticamente se nenhum plano for encontrado.

## Armazenamento

Todos os arquivos gerados ficam em `.darkside/` na raiz de cada projeto.

### Holocrons — `.darkside/holocrons/`

Arquivos de conhecimento sobre o projeto. Escritos uma vez, atualizados quando o projeto muda.

| Arquivo | Criado por | Conteúdo |
|---------|-----------|----------|
| `tech.md` | `/explore` | Stack, arquitetura, estrutura de pastas, convenções |

### Holomaps — `.darkside/holomaps/`

Documentos de discovery para tarefas específicas. Um arquivo por tarefa, criado pelo `/quest`.

| Arquivo | Criado por | Conteúdo |
|---------|-----------|----------|
| `YYYY-MM-DD-<tarefa>.md` | `/quest` | Discovery completo de uma tarefa de desenvolvimento |

### War Room — `.darkside/war-room/`

Planos técnicos de engineering discovery criados pelo `/war-room`.

| Arquivo | Criado por | Conteúdo |
|---------|-----------|----------|
| `YYYY-MM-DD-<plano>-plan.md` | `/war-room` | Entendimento funcional, impacto técnico e estratégia de implementação |

### Sith Agents — `.darkside/sith-agents/`

System prompts de agentes especialistas gerados pelo `/explore`. Editáveis via `/sith-agents`.

| Arquivo | Especialidade |
|---------|--------------|
| `tdd.md` | Estratégia de testes, red-green-refactor, cobertura |
| `engineer.md` | Decisões técnicas, trade-offs, fit arquitetural |
| `coder.md` | Implementação limpa, convenções do projeto, nomenclatura |
| `security.md` | OWASP, validação de input, autenticação, secrets |
| `reviewer.md` | Correção, consistência, enforcement de padrões |

### Imperial Orders — `.darkside/imperial-orders/`

Documentos do ciclo completo de desenvolvimento, criados pelo `/order66`.

| Arquivo | Conteúdo |
|---------|----------|
| `YYYY-MM-DD-<feature>-order.md` | Ordem imperial + tarefas de uma feature |
| `fallen-orders/YYYY-MM-DD-<feature>-fallen-order.md` | Relatório de falha após 2 revisões rejeitadas |

### The Grand Inquisitor — `.darkside/the-grand-inquisitor/`

Relatórios de inspeção profunda criados pelo `/inquisitor`.

| Arquivo | Conteúdo |
|---------|----------|
| `YYYY-MM-DD-<alvo>-report.md` | Veredictos de engenharia, segurança e cobertura + julgamento final |
