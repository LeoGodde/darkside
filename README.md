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
| `/explore` | Análise profunda do projeto → `tech.md` + 6 sith-agents |
| `/quest` | Conversa estruturada de discovery → holomap |
| `/sith-agents` | Edita os system prompts dos sith-agents |
| `/order66` | Orquestração completa de desenvolvimento → spec, TDD, código, revisão |
| `/inquisitor` | Inspeção profunda de código → relatório com julgamento final |
| `/guide` | Ajuda — explica todas as skills e a estrutura de armazenamento |

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
| `YYYY-MM-DD-<feature>-order.md` | Spec + plano + tarefas de uma feature |
| `fallen-orders/YYYY-MM-DD-<feature>-fallen-order.md` | Relatório de falha após 2 revisões rejeitadas |

### The Grand Inquisitor — `.darkside/the-grand-inquisitor/`

Relatórios de inspeção profunda criados pelo `/inquisitor`.

| Arquivo | Conteúdo |
|---------|----------|
| `YYYY-MM-DD-<alvo>-report.md` | Veredictos de engenharia, segurança e cobertura + julgamento final |

## Contribuindo

Adicione novas skills em `skills/<nome-da-skill>/SKILL.md`.
Atualize o `CLAUDE.md` para listar a nova skill.
Incremente a versão em `package.json` e `.claude-plugin/plugin.json`.
