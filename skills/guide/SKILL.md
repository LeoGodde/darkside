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
| `/quest` | Conduz uma conversa estruturada de discovery antes de implementar. Cobre problema, contexto, alternativas, direção técnica, riscos e validação. **Use ao iniciar uma tarefa nova.** |
| `/sith-agents` | Edita os system prompts dos agentes especialistas gerados pelo `/explore`. **Use quando quiser ajustar o comportamento de um agente.** |
| `/order66` | Orquestra o ciclo completo de desenvolvimento: spec, plano, tarefas, TDD, código e revisão. **Use para executar uma feature de ponta a ponta.** |
| `/inquisitor` | Inspeciona código com os olhos do engineer, security e tdd. Aceita arquivo, pasta ou PR e emite um Julgamento Final. **Use para auditar código antes do merge ou investigar uma área suspeita.** |
| `/war-room` | Conduz um engineering discovery estruturado antes de implementar. Cobre entendimento funcional, impacto técnico e estratégia de implementação. Usa tech.md e quest como contexto. Gera um plano técnico completo. **Use antes do `/order66` para substituir a fase de spec.** |
| `/interrogate` | Interroga o plano do war-room — identifica pontos fracos, vagos ou contraditórios e desafia com perguntas direcionadas. Reescreve as seções melhoradas diretamente no plano. **Use depois do `/war-room` para refinar o plano.** |
| `/guide` | Este guia. |
