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
| `/explore` | Analisa o projeto em profundidade: stack, arquitetura, pastas e convenções. Gera um holocron e 5 agentes especialistas calibrados para o projeto. **Use na primeira vez que trabalhar em um projeto.** |
| `/quest` | Discovery e inception de um produto, módulo, feature ou estória. Classifica o nível do trabalho, investiga o código e conduz uma trilha adaptativa: problema e North Star (OKR/KR), atores e impactos, escopo, alternativas, métricas, riscos, incrementos (ondas + MVP) e validação por exemplos. Baseada em BABOK Agile Extension, Lean Inception e Impact Mapping. Responde "o quê e por quê" e alimenta o `/war-room`. **Use antes de planejar qualquer trabalho novo.** |
| `/sith-agents` | Edita os system prompts dos agentes especialistas gerados pelo `/explore`. **Use quando quiser ajustar o comportamento de um agente.** |
| `/order66` | Orquestra o ciclo completo de desenvolvimento: spec, plano, tarefas, TDD, código e revisão. **Use para executar uma feature de ponta a ponta.** |
| `/inquisitor` | Inspeciona código com os olhos do engineer, security e tdd. Aceita arquivo, pasta ou PR e emite um Julgamento Final. **Use para auditar código antes do merge ou investigar uma área suspeita.** |
| `/mission` | Quest compacto para tarefas menores. Cobre problema, objetivo, limites, solução, plano e riscos em 4 passos curtos. **Use quando quiser planejar uma tarefa que não precise de `/war-room`.** |
| `/war-room` | Conduz um engineering discovery estruturado antes de implementar. Cobre entendimento funcional, impacto técnico e estratégia de implementação. Usa tech.md e quest como contexto. Gera um plano técnico completo. **Use antes do `/order66` para substituir a fase de spec.** |
| `/interrogate` | Interroga o plano do war-room — identifica pontos fracos, vagos ou contraditórios e desafia com perguntas direcionadas. Reescreve as seções melhoradas diretamente no plano. **Use depois do `/war-room` para refinar o plano.** |
| `/verdict` | Verifica se os critérios de aceite de cards (Jira, GitHub, Trello, etc.) estão atendidos no código. Lê o card, extrai ou cria critérios, valida com você e gera um relatório de cobertura por item. **Use para auditar a implementação contra os requisitos antes do merge.** |
| `/visual-fidelity` | Verifica a fidelidade visual entre um design no Figma e a implementação no código. Inspeciona cores, tipografia, espaçamentos, componentes, imagens e layout tela a tela via MCP do Figma. Gera um relatório com percentual de similaridade e classifica cada elemento como ✅ Completo, ⚠️ Parcial ou ❌ Ausente. **Use para auditar a aderência da implementação front-end ao design antes do merge ou entrega.** |
| `/guide` | Este guia. |
