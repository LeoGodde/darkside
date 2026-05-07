# Alterações

## 2026-05-06 — Padronização de idioma nas skills

**Contexto:** Todas as comunicações com o usuário do plugin devem ser em português do Brasil. Todos os arquivos gerados devem ser em inglês para economizar tokens.

### Arquivos modificados

**`skills/darkside/SKILL.md`**
- "Type any skill to get started." → "Digite qualquer skill para começar."

**`skills/explore/SKILL.md`**
- Step 4: notificação ao usuário traduzida para pt-br
- Adicionada seção `## Rules` ao final com as regras de idioma:
  - Mensagens ao usuário em pt-br
  - Arquivos gerados (`.darkside/holocrons/tech.md` e `.darkside/sith-agents/*.md`) em inglês

**`skills/quest/SKILL.md`**
- Todas as perguntas dos Steps 1–7 traduzidas para pt-br (20 perguntas no total)
- Todas as mensagens de transição entre steps traduzidas para pt-br
- Mensagem de conclusão da quest traduzida para pt-br
- Adicionadas duas regras ao final da seção `## Rules`:
  - Mensagens ao usuário em pt-br
  - Arquivos gerados (holomaps) em inglês

**`skills/order66/SKILL.md`**
- Adicionada regra na seção `## Rules`: arquivos gerados (order files e fallen-order files) em inglês
- Mensagens ao usuário já estavam em pt-br — sem alteração

**`skills/inquisitor/SKILL.md`**
- Adicionada regra na seção `## Rules`: arquivos gerados (relatórios de inspeção) em inglês
- Mensagens ao usuário já estavam em pt-br — sem alteração

---

## 2026-05-06 — Integração quest → order66

**Contexto:** Ao executar `/order66`, o skill deve aproveitar o discovery já feito via `/quest`, evitando retrabalho na fase de spec.

### Arquivos modificados

**`skills/order66/SKILL.md`**
- Adicionada seção `## Quest Context` entre os Prerequisites e a Phase 1
- Lógica: busca o arquivo mais recente em `.darkside/holomaps/` e apresenta ao usuário:
  - **A.** Usar a quest encontrada como base — pre-preenche respostas da Phase 1 a partir do que já foi mapeado
  - **B.** Usar outra quest — usuário informa o caminho do arquivo
  - **C.** Continuar sem quest — Phase 1 do zero
- Se nenhum arquivo de quest for encontrado, segue direto para a Phase 1 sem mencionar o assunto

---

## 2026-05-06 — Simplificação da tabela de skills no darkside

**Contexto:** A tabela de skills exibida pelo `/darkside` foi simplificada para descrições mais curtas e diretas.

### Arquivos modificados

**`skills/darkside/SKILL.md`**
- Descrições da tabela de skills encurtadas:
  - `/explore` → "Inicialização e análise profunda do projeto"
  - `/quest` → "Para uma conversa estruturada de descoberta"
  - `/sith-agents` → "Editar os agentes especialistas"
  - `/order66` → "Orquestração completa do ciclo de desenvolvimento"
  - `/inquisitor` → "Inspeção profunda de código, PR e reviews"
  - `/guide` → "Ajuda"
- Links de destino (`→ tech.md + 5 agentes`, `→ holomap`, etc.) removidos das descrições

---

## 2026-05-06 — Nova skill: `/war-room`

**Contexto:** Necessidade de um agente especialista em engineering discovery que produza um plano técnico completo antes de qualquer implementação, cobrindo entendimento funcional, impacto técnico e estratégia de implementação.

### Arquivos criados

**`skills/war-room/SKILL.md`**
- Nova skill com 3 seções estruturadas seguindo o schema `engineering_discovery`:
  - **Section 1 — Functional Understanding:** fluxo principal (3 perguntas individuais), estados, regras, casos alternativos e critérios de aceite
  - **Section 2 — Technical Impact:** sistemas, dados, APIs e dependências
  - **Section 3 — Implementation Strategy:** arquitetura (3 perguntas individuais), ordem de implementação, compatibilidade, segurança e geração automática do Technical Plan Summary
- Lê `tech.md` antes de começar e **pré-preenche silenciosamente** tudo que já conhece do projeto (stack, camadas, integrações, auth, padrões) — sem mencionar a fonte e sem pedir confirmação
- Pergunta apenas o que não conseguiu derivar do projeto
- Se todos os itens de um grupo já foram preenchidos, avança sem perguntar nada
- Regra explícita: nunca inventar pré-preenchimentos — derivar apenas do que o tech.md afirma explicitamente
- Comunicação simples, direta e fácil de entender — sem jargão desnecessário, sem comprometer precisão técnica
- Perguntas open-ended feitas uma a uma; perguntas de checklist apresentadas em grupo
- Cria o arquivo de plano silenciosamente após receber o nome; preenche cada seção em tempo real conforme o usuário responde
- Regras: mensagens em pt-br, arquivos gerados em inglês

### Arquivos modificados

**`package.json`**
- Adicionada entrada `/war-room` no índice de skills

**`CLAUDE.md`**
- Adicionada descrição da skill `war-room` na seção `## Available Skills`
- Adicionada seção `### War Room — .darkside/war-room/` em `## Storage`

**`skills/darkside/SKILL.md`**
- Adicionada linha `/war-room` na tabela de skills disponíveis

---

## 2026-05-07 — Integração war-room → order66 e reestruturação do imperial-orders

**Contexto:** O war-room passa a ser o passo de discovery antes do order66. A spec do imperial-orders é substituída pelo plano do war-room. O Quest Context migra do order66 para o war-room.

### `skills/war-room/SKILL.md`

- Adicionado **Pré-requisito**: exige que `/explore` tenha sido executado (verifica existência do `tech.md`); para se não existir
- Adicionada seção **Quest Context** (migrada do order66): procura o holomap mais recente em `.darkside/holomaps/` e oferece A / B / C antes de iniciar a sessão
- A quest selecionada é usada como fonte adicional de pré-preenchimento (junto com o tech.md)
- Regra de pré-preenchimento atualizada para mencionar tanto tech.md quanto a quest como fontes

### `skills/order66/SKILL.md`

- Removida seção **Quest Context** — migrou para o war-room
- Removida **Phase 1 — Spec** inteira (27 perguntas + engineer + security) — substituída pelo plano do war-room
- Adicionada seção **War Room Context**: procura o plano mais recente em `.darkside/war-room/` e oferece A / B / C
- **Phase 2 → Phase 1 — Order**: lê o plano do war-room + engineer.md + security.md e gera a order (arquitetura, componentes, sequência, trade-offs, segurança)
- **Phases 3–6 renumeradas** para 2–5
- **Order File Structure** simplificado: removidas todas as seções de Spec (`### Scope`, `### Functional Requirements` etc.); `## Plan` renomeado para `## Order`; adicionado campo `**War Room Plan:**` no cabeçalho
- Referências a "spec" nas fases substituídas por "order"
- Frontmatter atualizado para refletir o novo fluxo

### `CLAUDE.md`

- Descrição do `order66` atualizada para refletir o novo fluxo
- `imperial-orders` atualizado: "spec + plan + tasks" → "order + tasks"

---

## 2026-05-07 — war-room obrigatório no order66

**`skills/order66/SKILL.md`**
- War Room Context reescrito: plano do war-room agora é **obrigatório**
- Se nenhum arquivo for encontrado em `.darkside/war-room/`: executa o war-room inline sem anunciar; ao terminar, pede confirmação do usuário sobre o documento gerado antes de continuar para a Phase 1
- Opção C ("continuar sem plano") removida — não existe mais ordem sem war-room
- Cabeçalho do order file atualizado: `**War Room Plan:** [path to plan file, or "none"]` → `[path to the war-room plan file used]`

---

## 2026-05-07 — "order" substituído por "ordem imperial" em textos em português

**`skills/order66/SKILL.md`**
- Frontmatter description: "gera a order" → "gera a ordem imperial"
- Mensagem opção A do War Room Context: "vou gerar a order com base nele" → "vou gerar a ordem imperial com base nele"
- Mensagem opção C do War Room Context: "vou gerar a order com as informações disponíveis" → "vou gerar a ordem imperial com as informações disponíveis"
- Notificação de geração: "Order gerada em" → "Ordem imperial gerada em"
- Mensagem de aprovação: "Order executada com sucesso" → "Ordem imperial executada com sucesso"
- Mensagem de fallen order: "Ordem falhou após 2 iterações" → "Ordem imperial falhou após 2 iterações"

Nomes de arquivo (`-order.md`, `fallen-order`), termos técnicos em inglês e referências a diretórios não foram alterados.

---

## 2026-05-07 — Pergunta de abertura no war-room

**`skills/war-room/SKILL.md`**
- Adicionada seção `## Opening` como primeira interação: "Me dê mais detalhes sobre o que vamos executar."
- A resposta é usada como contexto primário para toda a sessão (pré-preenchimento, quest context, perguntas subsequentes)
- A resposta também serve de base para sugerir um nome de plano na seção `## Plan Name`
- `## Plan Name` atualizado: propõe um nome candidato derivado da abertura e aguarda confirmação ou correção

---

## 2026-05-07 — war-room reescrito em inglês

**`skills/war-room/SKILL.md`**
- Todo o conteúdo de instrução/lógica reescrito em inglês
- Mensagens ao usuário (blocos `>`) mantidas em português brasileiro
- Frontmatter `description` atualizado para inglês

---

## 2026-05-07 — war-room adicionado ao guide

**`skills/guide/SKILL.md`**
- Adicionada entrada `/war-room` na tabela de skills

---

### Skills não alteradas

- `skills/sith-agents/SKILL.md` — mensagens já em pt-br; agentes gerados pelo `/explore` já em inglês
