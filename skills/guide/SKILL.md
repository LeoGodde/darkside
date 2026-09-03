---
name: guide
description: Guia de ajuda do Darkside — explica todas as skills disponíveis, como usá-las e a estrutura de armazenamento.
---

# Guia Darkside

Exiba o conteúdo abaixo exatamente como mostrado. Não adicione comentários antes ou depois.

---

## Skills disponíveis

| Skill | Descrição |
|-------|-----------|
| `/explore` | Analisa o projeto em profundidade: stack, arquitetura, pastas e convenções. Gera um holocron e 6 agentes especialistas calibrados para o projeto. **Use na primeira vez que trabalhar em um projeto.** |
| `/moff` | Assume o papel de Product Manager do projeto. Cuida do que nenhuma outra skill cuida — o contrato de expectativa, o backlog e seu sync com o tracker, as métricas e o registro de cada mudança de combinado; o resto ele delega para as skills do plugin. No primeiro uso conduz o setup de governança, que começa declarando a **forma do projeto** (quem recebe: cliente externo / stakeholder interno / ninguém; quem executa: você sozinho / time pequeno / papéis dedicados) — todo o resto se ramifica a partir daí, em vez de assumir. O charter cobre critérios verificáveis de sucesso, contrato de comunicação, capacidade, bases de conhecimento, gitflow, fluxo de desenvolvimento (modelo de entrega, um agrupamento, uma escala de estimativa, política de design), métricas, riscos e decisões em aberto. Depois opera em quatro modos: planejamento, execução (roteia para as outras skills), relatório e renegociação. **Use no início do projeto e a cada rodada de planejamento ou reunião.** |
| `/quest` | Discovery e inception de um produto, módulo, feature ou estória. Classifica o nível do trabalho, investiga o código e conduz uma trilha adaptativa: problema e North Star (OKR/KR), atores e impactos, escopo, alternativas, métricas, riscos, incrementos (ondas + MVP) e validação por exemplos. Baseada em BABOK Agile Extension, Lean Inception e Impact Mapping. Responde "o quê e por quê" e alimenta o `/war-room`. **Use antes de planejar qualquer trabalho novo.** |
| `/sith-agents` | Edita os system prompts dos agentes especialistas gerados pelo `/explore`. **Use quando quiser ajustar o comportamento de um agente.** |
| `/order66` | Orquestra o ciclo completo de desenvolvimento: lê a mission ou o plano do war-room, gera a ordem, tarefas, TDD, código e revisão. **Use para executar uma feature de ponta a ponta.** |
| `/inquisitor` | Inspeciona código com os olhos do engineer, security e tdd. Aceita arquivo, pasta ou PR e emite um Julgamento Final. **Use para auditar código antes do merge ou investigar uma área suspeita.** |
| `/mission` | Quest compacto para tarefas menores. Cobre problema, objetivo, limites, solução, plano e riscos em 4 passos curtos. **Use quando quiser planejar uma tarefa que não precise de `/war-room`.** |
| `/war-room` | Conduz um engineering discovery estruturado antes de implementar. Cobre entendimento funcional, impacto técnico e estratégia de implementação. Usa tech.md e quest como contexto. Gera um plano técnico completo. **Use antes do `/order66` para substituir a fase de spec.** |
| `/interrogate` | Interroga o plano do war-room — identifica pontos fracos, vagos ou contraditórios e desafia com perguntas direcionadas. Reescreve as seções melhoradas diretamente no plano. **Use depois do `/war-room` para refinar o plano.** |
| `/verdict` | Verifica se os critérios de aceite de cards (Jira, GitHub, Trello, etc.) estão atendidos no código. Lê o card, extrai ou cria critérios, valida com você e gera um relatório de cobertura por item. **Use para auditar a implementação contra os requisitos antes do merge.** |
| `/visual-fidelity` | Verifica a fidelidade visual entre um design no Figma e a implementação no código. Inspeciona cores, tipografia, espaçamentos, componentes, imagens e layout tela a tela via MCP do Figma. Gera um relatório com percentual de similaridade e classifica cada elemento como ✅ Completo, ⚠️ Parcial ou ❌ Ausente. **Use para auditar a aderência da implementação front-end ao design antes do merge ou entrega.** |
| `/hunter` | Investigação forense de bugs. Conduz debugging estruturado em 4 fases: compreensão dos sintomas (rubber duck), escopo e contexto (branches, ambiente, mudanças recentes), investigação profunda (observação, análise de padrões, rastreamento reverso da cadeia causal Defeito→Infecção→Falha), e plano de correção com especificação de testes de regressão. Gera relatório forense e oferece execução via `/order66`. **Use quando encontrar um bug, erro ou comportamento inesperado.** |
| `/design-schematic` | Discovery de design estruturado a partir de um documento de contexto. Refina ideias com heurísticas de Nielsen, Krug, IDEO e d.school, e gera três prompts otimizados para o Figma Make: Lo-Fi (validar ideia e fluxo), Mid-Fi (validar com sugestões) e Hi-Fi (protótipo final). Contempla acessibilidade, design system, hierarquia visual, responsividade e tratamento de erros. **Use quando precisar gerar prompts de design para o Figma Make.** |
| `/probe-droid` | Escaneia a branch atual, uma branch informada, ou a branch relacionada a um card, e gera casos de teste não-técnicos para QA a partir das mudanças encontradas. Ao final, oferece enviar as notas como comentário no card relacionado, caso exista e haja um MCP de gerenciamento de projeto conectado. **Use depois de implementar uma feature, para gerar o roteiro de testes que o QA vai executar.** |
| `/spec-verdict` | Verifica se os critérios de aceite de um card (Jira, GitHub, Trello, etc.) ou fornecidos diretamente estão representados em um ou mais designs no Figma. Extrai os critérios via MCP do board ou aceita colagem direta, inspeciona os designs via MCP do Figma e classifica cada critério como ✅ Atendido, ⚠️ Parcial ou ❌ Ausente. **Use para validar se o design cobre os requisitos antes do desenvolvimento começar.** |
| `/scribe` | Gera, revisa e mantém documentação do projeto para desenvolvedores, usuários finais e clientes, a partir do código e do conhecimento produzido pelo Darkside. Determina audiência e escopo, investiga o estado real do projeto, distingue o que está implementado do que está apenas planejado, e produz documentação em `docs/`, aplicando os princípios do Google Developer Documentation Style Guide. **Use a qualquer momento para criar, atualizar ou revisar documentação — não só ao final do fluxo.** |
| `/project-master` | Avaliação profunda e completa do código. Usa `tech.md` e os sith-agents como base, analisa code smells, segurança, complexidade, testes, débito técnico e arquitetura, e gera um scorecard com nota geral e relatório detalhado com issues priorizados. **Use para obter uma visão abrangente da saúde do projeto antes de uma refatoração, auditoria ou entrega.** |
| `/guide` | Este guia. |

---

## Fluxo recomendado

```
/explore → /quest (opcional) → /mission ou /war-room → /order66 → /inquisitor → /scribe

Para bugs: /explore → /hunter → /order66

Com gestão de projeto:
/moff (setup) → /explore → /moff (planejamento) → /war-room → /order66
              → /inquisitor + /verdict → /moff (relatório)
```

| Etapa | Skill | O que produz |
|-------|-------|--------------|
| 0. Governança do projeto | `/moff` | charter (forma do projeto + combinado) + risk register |
| 1. Mapear o projeto | `/explore` | `tech.md` + sith-agents |
| 2. Discovery da tarefa | `/quest` | holomap |
| 3. Backlog e cards | `/moff` | agrupamento + cards executáveis + ordem de execução + issues no tracker |
| 4. Plano técnico | `/war-room` | plan.md |
| 5. Implementação | `/order66` | ordem imperial + tarefas + código revisado |
| 6. Auditoria | `/inquisitor` | relatório com julgamento final |
| 7. Documentação | `/scribe` | documentação para devs, usuários e clientes em `docs/` |
| 8. Status e métricas | `/moff` | relatório de status + métricas com tendência |

> `/order66` executa o `/mission` automaticamente se nenhum contexto (mission ou war-room) for encontrado.
> `/scribe` não depende desse fluxo — pode ser chamado a qualquer momento para documentar o projeto inteiro ou uma parte dele.

---

## Armazenamento

Todos os arquivos internos do Darkside ficam em `.darkside/` na raiz do projeto.

| Diretório | Criado por | Conteúdo |
|-----------|-----------|----------|
| `holocrons/` | `/explore` | `tech.md` — stack, arquitetura, convenções |
| `moff/` | `/moff` | `charter.md`, `risk-register.md`, backlogs, `execution-log.jsonl`, `metrics/` e `reports/` |
| `holomaps/` | `/quest` | Discovery completo por tarefa |
| `war-room/` | `/war-room` | Planos técnicos |
| `sith-agents/` | `/explore` | System prompts dos agentes (tdd, engineer, coder-backend, coder-frontend, security, reviewer, debugger) |
| `hunter/` | `/hunter` | Relatórios forenses de investigação de bugs |
| `imperial-orders/` | `/order66` | Ordens de desenvolvimento + fallen-orders |
| `the-grand-inquisitor/` | `/inquisitor` | Relatórios de inspeção |
| `missions/` | `/mission` | Brainstorming compacto |
| `verdicts/` | `/verdict`, `/visual-fidelity` | Verificação de critérios de aceite e fidelidade visual |
| `spec-verdicts/` | `/spec-verdict` | Verificação de critérios de aceite contra o design do Figma |
| `design-schematic/` | `/design-schematic` | Prompts Lo-Fi, Mid-Fi e Hi-Fi para Figma Make |
| `probe-droid/` | `/probe-droid` | Notas de QA não-técnicas geradas a partir de uma branch |
| `scribe/` | `/scribe` | Manifests internos de cada sessão de documentação (fontes consultadas, modelo de evidências, lacunas) |
| `project-master/` | `/project-master` | Scorecard + relatório de engenharia, segurança e testes |

### Documentação para humanos — `docs/`

`/scribe` é a única skill que escreve fora de `.darkside/`. A documentação final, destinada a pessoas, fica em `docs/` na raiz do projeto:

| Diretório | Audiência |
|-----------|-----------|
| `docs/developers/` | Desenvolvedores |
| `docs/users/` | Usuários finais |
| `docs/clients/` | Clientes e stakeholders |

`.darkside/` guarda conhecimento e artefatos internos do Darkside; `docs/` guarda documentação pronta para ser lida por humanos fora do fluxo do plugin.
