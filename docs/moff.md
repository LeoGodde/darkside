# /moff — Governanca de Projeto

Skill de governanca do Darkside que atua no papel de **Product Manager**. Centraliza as quatro responsabilidades que nenhuma outra skill cobre:

1. **Contrato de expectativa** — o que sera entregue, o que esta fora, criterios de sucesso verificaveis
2. **Backlog e sincronizacao com o tracker** — historias, cards executaveis, ordem de execucao
3. **Sistema de metricas** — snapshots datados, tendencias, previsoes
4. **Registro de mudancas de compromisso** — log de renegociacoes

---

## Setup Inicial

Na primeira execucao, o `/moff` conduz uma entrevista para declarar o **Project Shape**:

- **Receptor:** cliente externo / stakeholder interno / nenhum
- **Executor:** solo / time pequeno / papeis dedicados

Todas as decisoes posteriores se adaptam a esse shape.

## Charter

O charter (`.darkside/moff/charter.md`) e o contrato vivo do projeto, composto por 11 secoes:

1. Project Shape
2. Criterios de sucesso verificaveis (com exclusoes nomeadas)
3. Contrato de comunicacao
4. Capacidade e orcamento de governanca
5. Fontes de conhecimento
6. Gitflow
7. Fluxo de desenvolvimento (modelo de entrega, agrupamento, escala de estimativa, politica de design handoff)
8. Metricas
9. Riscos
10. Log de negociacao
11. **Decisoes em aberto** — mantem perguntas nao respondidas visivelmente separadas de decisoes tomadas

---

## Modos de Operacao

O `/moff` opera em quatro modos distintos:

### Planning

- Agrupamento de trabalho
- Split de historias
- Geracao de cards executaveis
- Ordem de execucao derivada (dependencias primeiro, cards de long-lead nunca na frente da fila)
- Sync com tracker com reconciliacao de read-back

### Execution

Router que delega para as skills especializadas:

| Necessidade | Skill delegada |
|---|---|
| Discovery | `/quest` |
| Planejamento tecnico | `/war-room` |
| Implementacao | `/order66` |
| Verificacao de aceite | `/verdict` |
| Inspecao de codigo | `/inquisitor` |

### Report

Gera relatorio sobre uma janela declarada:

- **Tipos de janela:** semanal, sprint, mensal, milestone, project-to-date
- **Conteudo:** resumo executivo, entregue vs planejado (com explicacao de 3 linhas por card fechado), metricas com tendencia, riscos re-pontuados, ajustes sugeridos, acoes de melhoria, decisoes necessarias, agenda da proxima reuniao

### Renegotiate

Registra mudancas de escopo de forma estruturada:

- Posicao atual
- Trocas propostas
- Log de negociacao

---

## Agentes de Gestao

O `/moff` gera ate 3 agentes especializados em `.darkside/sith-agents/`:

| Agente | Arquivo | Funcao |
|---|---|---|
| Product Manager | `pm.md` | Qualidade de backlog, agrupamento, story splitting, Definition of Ready |
| Delivery Analyst | `delivery-analyst.md` | Metricas computadas do tracker e repo, tendencias, impacto de previsao |
| Client Liaison | `client-liaison.md` | Traducao de entrega para termos do receptor, deteccao de surpresas. **Gerado apenas quando o Project Shape declara um receptor** |

---

## Artefatos

Todos salvos em `.darkside/moff/`:

| Arquivo | Descricao |
|---|---|
| `charter.md` | Contrato vivo de governanca (11 secoes) |
| `risk-register.md` | Registro de riscos, re-pontuado a cada rodada com historico preservado |
| `YYYY-MM-DD-<name>-backlog.md` | Escopo + agrupamento + historias + cards + ordem de execucao + estimativas + sync |
| `execution-log.jsonl` | Log append-only por card: datas, dias de espera, falhas de gate, rodadas de retrabalho |
| `metrics/YYYY-MM-DD.json` | Snapshot datado de metricas (base para tendencias) |
| `reports/YYYY-MM-DD-<type>.md` | Relatorio de status por janela declarada |

---

## Principios

- **Git e proposal-only; o tracker e operacional** — o repositorio propoe, o tracker e a fonte da verdade operacional
- **Delega por nome** — nunca reimplementa o que outra skill ja faz
- **Shape-driven** — todas as decisoes se ramificam a partir do Project Shape declarado no setup
- **Decisoes abertas sao visiveis** — nunca confunde algo nao respondido com algo decidido
