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
| `/quest` | Discovery e inception de um produto, módulo, feature ou estória. Classifica o nível do trabalho, investiga o código e conduz uma trilha adaptativa: problema e North Star (OKR/KR), atores e impactos, escopo, alternativas, métricas, riscos, incrementos (ondas + MVP) e validação por exemplos. Baseada em BABOK Agile Extension, Lean Inception e Impact Mapping. Responde "o quê e por quê" e alimenta o `/war-room`. **Use antes de planejar qualquer trabalho novo.** |
| `/sith-agents` | Edita os system prompts dos agentes especialistas gerados pelo `/explore`. **Use quando quiser ajustar o comportamento de um agente.** |
| `/order66` | Orquestra o ciclo completo de desenvolvimento: spec, plano, tarefas, TDD, código e revisão. **Use para executar uma feature de ponta a ponta.** |
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
| `/guide` | Este guia. |

---

## Fluxo recomendado

```
/explore → /quest (opcional) → /war-room → /order66 → /inquisitor

Para bugs: /explore → /hunter → /order66
```

| Etapa | Skill | O que produz |
|-------|-------|--------------|
| 1. Mapear o projeto | `/explore` | `tech.md` + sith-agents |
| 2. Discovery da tarefa | `/quest` | holomap |
| 3. Plano técnico | `/war-room` | plan.md |
| 4. Implementação | `/order66` | ordem imperial + tarefas + código revisado |
| 5. Auditoria | `/inquisitor` | relatório com julgamento final |

> `/order66` executa o `/war-room` automaticamente se nenhum plano for encontrado.

---

## Armazenamento

Todos os arquivos gerados ficam em `.darkside/` na raiz do projeto.

| Diretório | Criado por | Conteúdo |
|-----------|-----------|----------|
| `holocrons/` | `/explore` | `tech.md` — stack, arquitetura, convenções |
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
