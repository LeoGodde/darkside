---
name: quest
description: Discovery e inception estruturados para produto, módulo, feature ou estória — classifica o nível do trabalho, investiga o código para pré-preencher respostas, e conduz uma trilha adaptativa cobrindo problema, usuários, valor, escopo, alternativas, riscos e validação. Salva os resultados em .darkside/holomaps/. É a etapa do "o quê e por quê" que alimenta o /war-room (o "como").
---

# Quest — Discovery & Inception

Guide the user through an adaptive discovery conversation to understand **what** should be built and **why**, before any engineering planning. Quest produces a holomap — the discovery document `/war-room` consumes to plan **how**. `/mission` remains the lightweight brainstorm for when the user doesn't yet know what they want.

Grounding: **Agile Extension to the BABOK® Guide v2** (planning horizons, seven principles of agile analysis), **Lean Inception — Paulo Caroli** (vision, É–Não é–Faz–Não faz, personas, journeys, sequencer, MVP Canvas), and **OKRs + Impact Mapping — Gojko Adzic** (the chain **KR → ator → impacto → entregável** traces every deliverable back to the metric it must move).

**The anti-pattern quest exists to avoid is the Feature Factory**: shipping features on time without knowing if they move any metric. Deliverables are hypotheses to be tested, never commitments to be batched.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Operating Rules

**Minimum viable discovery.** The holomap is done when `/war-room` (or `/order66`) can proceed without guessing — not when every section is exhaustive. Depth is proportional to uncertainty and to the level: probe deeply where confidence is low; one confirmed line is enough where it is high. Don't ask what is already known, and don't document beyond what the next decision needs (Avoid Waste).

**Investigate before asking.** When the codebase, `tech.md`, or prior darkside documents can answer a question (current behavior, similar features, impacted modules), read first, pre-fill the holomap, and present a summary to confirm — never ask from zero, and never invent. If a whole block is already answered, say so in one line and move on.

**Interaction patterns.** One question per message, wording adapted to the project's stack and domain. Pick per moment: **open question** for territory only the user knows; **options A/B/C** when you can propose concrete alternatives; **confirmation loop** ("Está correto ou preciso ajustar algo?") after any synthesis or pre-fill.

**Stay on "what and why".** Never propose code or engineering design. Anchor on the customer's experience (Think as a Customer), connect everything to the bigger picture (See the Whole), prefer concrete examples to abstract statements (Get Real Using Examples), and surface doability constraints early (Understand What is Doable). If conversation drifts into implementation, capture the point under Risks and steer back.

**Before you begin:** read `.darkside/holocrons/tech.md` if present (note its absence otherwise) and check `.darkside/holomaps/` and `.darkside/missions/` for related documents, offering them as context.

---

## Step 1 — Opening & Classification

Ask:

> "Me conte o que vamos descobrir. Pode ser uma ideia de produto, um módulo, uma feature ou uma estória — descreva do seu jeito."

Then propose a classification with a one-line justification:

> "Pelo que você descreveu, isso parece ser **[Produto | Módulo | Feature | Estória]** — [justificativa].
>
> **A.** Concordo, seguir nesse nível
> **B.** É outro nível — vou te dizer qual
> **C.** Não sei — me ajude a decidir"

Levels map to the Agile Extension planning horizons, which set the time frame and detail of the conversation — product discovery stops before feature details; story discovery doesn't reopen strategy:

- **Produto** *(Strategy Horizon)* — something new with its own users, value proposition, and lifecycle. Decides whether a need is worth satisfying; hypotheses to test, not facts.
- **Módulo** *(Initiative Horizon)* — a bounded area inside an existing product, with its own domain and integration boundaries. Decides which solution option and which components deliver the outcome, in what order.
- **Feature** *(Initiative Horizon)* — a new capability inside an existing module or product; a solution component evaluated by impact, cost, constraints, and risks.
- **Estória** *(Delivery Horizon)* — a small, well-bounded slice deliverable in one iteration; value verified by concrete examples and rapid feedback.

After confirmation: derive filename (suffix: `.md`), silently create `.darkside/holomaps/[file]` with the track's sections (see Holomap Template), run the initial investigation, and say: "Nível confirmado. Vamos começar a discovery."

---

## Step 2 — The Track

Run only the blocks for the confirmed level, in order. Write each block into its holomap section before moving on.

| Block | Produto | Módulo | Feature | Estória |
|---|---|---|---|---|
| A. Problem & North Star | ✅ | ✅ | ✅ | ✅ |
| B. Actors & Impacts | ✅ | ✅ | — | — |
| C. Current Context | — | ✅ | ✅ | ✅ |
| D. Scope & Boundaries | ✅ | ✅ | ✅ | ✅ |
| E. Alternatives | ✅ | ✅ | ✅ | — |
| F. Success Metrics | ✅ | ✅ | optional¹ | — |
| G. Risks & Assumptions | ✅ | ✅ | ✅ | ✅ (Q1 only) |
| H. Increments | ✅ | ✅ | ✅ | — |
| I. Validation | ✅ | ✅ | ✅ | ✅ |

¹ Only if the feature's value is measurable (conversion, performance, adoption); skip for purely internal changes.

### Block A — Problem & North Star

Open questions, one at a time:

1. "Qual problema ou oportunidade estamos endereçando? Para quem isso dói, e o que acontece se não fizermos nada?"
2. "Qual é o resultado (outcome) esperado — o que muda no comportamento das pessoas ou no negócio quando isso existir?"
3. "Existe um OKR ou Key Result que esse trabalho ajuda a mover? Qual indicador, de quanto para quanto?"

A confirmed KR becomes the quest's **North Star** — the root of the impact map (B), refined as metric (F), and the prioritization criterion (H). If none exists, don't block: derive a proposed KR in Block F.

For **Estória**: capture the need as a job story — *Quando [situação], quero [motivação], para que [resultado]* — and, when it descends from a quest with an impact map, its traceability chain: *Como [ator], quero [entregável], para gerar [impacto] e mover [KR]*.

For **Produto** and **Módulo**, the go/no-go check (skip what's already answered):

4. "Por que agora? Como isso se alinha à estratégia da organização e o que torna esse o momento certo?"
5. "Que alternativa existe hoje — concorrente, planilha, processo manual — e por que ela não basta?"

For **Produto**, close with the vision statement (Lean Inception template), synthesized and confirmed: *Para [cliente final], cujo [problema], o [nome] é um [categoria] que [benefício-chave]; diferentemente de [alternativa], o nosso produto [diferencial-chave]*.

Synthesize a short value statement distinguishing **output** (what we deliver) from **outcome** (the change it causes), confirm, and write into `## Problem & North Star`.

### Block B — Actors & Impacts

Build the impact map rooted in the North Star:

> **[KR / North Star]** ───► **Atores** ───► **Impactos** ───► **Entregáveis**
> (o que mover?) (quem afeta?) (como mudam?) (o que testar?)

1. "Quem interage com isso ou influencia a métrica — incluindo perfis internos (operação, suporte) e quem pode atrapalhar?"
2. For each main actor, a lightweight persona: "Quem é (nome fictício), como se comporta, o que precisa alcançar, o que dói hoje?" Then: "Qual perfil é o principal — aquele que decide prioridades em conflito?"
3. Per actor, the impacts: "Que comportamento de [ator] nos impede hoje de mover a métrica? O que deveria **começar**, **parar** ou **mudar** de fazer?"

**Critical rule: an impact is a change in actor behavior — observable, ideally measurable — never a screen or feature** (e.g., "completa o checkout em menos de 1 minuto", not "tela simplificada"). Leave the Entregáveis level empty — it is filled in Block H.

Then map the **user journey** of the primary persona toward one goal: "Como é a jornada de [persona] até [objetivo]? Comece antes do contato com o produto — o que desperta a necessidade — e vá passo a passo." Keep it at synthesis level; prioritize if multiple journeys emerge. Journeys anchor features and increments in Block H.

Confirm and write personas, impact map, and journey into `## Actors & Impacts`.

### Block C — Current Context

**Investigate first.** Read the relevant code and pre-fill: current behavior, similar solutions, impacted modules, external dependencies. Present a summary, confirm, then ask only what the code cannot answer:

1. "Existem regras de negócio ocultas que não estão no código?"
2. "Há histórico, decisões passadas ou dívidas que eu deveria saber?"

Write into `## Current Context`.

### Block D — Scope & Boundaries

For **Produto** and **Módulo**, run **É – Não é – Faz – Não faz** (Lean Inception) — it is often easier to define something by what it is not. Propose the four lists from everything learned and let the user correct and extend:

> - **É** (substantivos/adjetivos) | **Não é** | **Faz** (verbos/ações) | **Não faz**

Distinguish "não faz **ainda**" (deferred) from "não faz **nunca**" (strategic boundary). Tag each in-scope item as **diferenciador** (deserves depth and investment) or **paridade** (solve in the simplest way — buy, reuse, standard pattern) — the Purpose Alignment Model.

For **Feature** and **Estória**, propose a scope cut as options when there's real choice:

> **A.** [Minimal — smallest version that solves the core problem]
> **B.** [Balanced — core + most valuable extensions]
> **C.** [Complete — full vision]

For **Feature**, classify expectations when useful (Kano): **básico** (non-negotiable), **desempenho** (more is better), **encantamento** (first cut candidate).

Always close with: "O que alguém poderia assumir que entra, mas **não entra**?" Write the resulting in/out lists (or ENFN quadrants) into `## Scope & Boundaries`.

### Block E — Alternatives (Solution Options)

Propose 2–3 distinct solution options — directions, not engineering designs — all at the **same level of precision**: broad description, assumptions, constraints that could make it nonviable, risks, rough cost. Then, one at a time:

1. "Essas opções cobrem as alternativas que você vê, ou há outra?"
2. "Qual parece a direção certa e por quê? E qual é a opção mais simples que ainda resolve o problema?"

A decision that can be kept open at low cost may be **deferred to the last responsible moment** (Real Options) — record the condition that will close it. Write the chosen (or deferred) direction and why the others were discarded into `## Alternatives`.

### Block F — Success Metrics

Refine the North Star (or derive a proposed KR if Block A found none). Key Results are **quantitative and based on behavior or business — never a task list** ("entregar a feature X" is not a metric). Ask, one at a time:

1. "Qual é o baseline atual e qual a meta — de quanto para quanto, em quanto tempo?"
2. "Existe uma métrica antecedente (leading) que mostra progresso antes do resultado final?"
3. "Qual sinal nos diria para **parar ou pivotar**?"

Write as **metric → baseline → target → horizon** plus the stop/pivot signal into `## Success Metrics`.

### Block G — Risks & Assumptions

Ask, one at a time (**Estória**: question 1 only):

1. "Quais premissas estamos assumindo sem validar? Qual delas, se errada, derruba o plano?"
2. "Quais decisões são irreversíveis? Para essas: dá para adiar até o último momento responsável, e que informação precisaríamos para decidir bem?" (Real Options)
3. "Há restrições de viabilidade — tecnologia, habilidades do time, prazo — que tornam alguma direção impossível?"

Categorize as **Assumption** / **Known unknown** / **Critical risk**. Every critical risk gets a mitigation or a **spike** (the question it answers + timebox). Write into `## Risks & Assumptions`.

### Block H — Increments

For **Produto** and **Módulo** (Lean Inception sequence):

1. **Entregáveis (feature brainstorm)** — fill the last level of the impact map: "O que podemos construir, automatizar ou experimentar para gerar [impacto] em [ator]?" Every feature must attach to an impact and a journey step; orphans are cut. **Golden rule: deliverables are hypotheses** — the goal is to find which one moves the metric with the least effort, not to build them all. Invite simple solutions the business hadn't imagined.
2. **Review & routing** — rate each feature: **esforço (E)** 1–3, **valor** ($ negócio / ♥ UX) 1–3, and **confiança** combining "sabemos o quê?" and "sabemos como?": **verde** (both), **amarelo** (one), **vermelho** (neither). Route by value × effort: high value + low effort → next wave; high value + high effort or **vermelho** → discovery first (prototype, research, or spike) before sequencing; low value + high effort → discard. Record the decisions and assumptions that surface — they're as valuable as the ratings.
3. **Sequencer (ondas)** — numbered waves, adapted rules: ≤3 features per wave; ≤1 red; never only yellows/reds; balanced effort; every wave carries real value; dependencies in earlier waves. Most impactful learning first. Mark on the sequencer which waves form the **MVP** and which are subsequent increments.

For **Produto**, the MVP is an experiment: "Qual é o mínimo que entrega o valor central **e** testa a premissa mais arriscada?" Detail it in `## MVP Canvas` — proposta, personas segmentadas (podemos testar com um grupo menor?), resultado esperado (o aprendizado buscado), custo e cronograma — referencing the journeys, features, and metrics already in the holomap instead of repeating them.

For **Feature**: skip the brainstorm; slice with Story Mapping — thin horizontal slices across the journey (walking skeleton first), never layer-by-layer (domain → infra → UI).

For **Produto** and **Módulo**, close with the outcome roadmap: "Quais resultados buscamos **agora**, **em seguida** e **depois**?" — outcomes, not feature lists.

Write the rated feature list, waves, and numbered increments — each with a one-line value statement — into `## Increments`.

### Block I — Validation

Derive acceptance criteria from concrete examples (Get Real Using Examples). Ask, one at a time (**Estória**: questions 1–3):

1. "Me dê exemplos concretos: dado [contexto], quando [ação], então [resultado]. Comece pelo caminho feliz."
2. "Agora os que quebram: entrada inválida, limite, exceção — o que deve acontecer?"
3. "O que precisa ser verdade para estar pronto — e o que explicitamente NÃO precisa?"
4. "Qual observabilidade é necessária — logs, métricas, alertas?"

Convert the examples into a checklist (`- [ ]`), keeping given/when/then where it adds clarity. Write into `## Validation`.

---

## Step 3 — Synthesis & Handoff

1. Write `## Executive Summary` below the title: 5–8 lines — problem, who it serves, chosen direction, scope cut, top risk, first increment — ending with the traceability chain when an impact map exists: **KR → ator principal → impacto central → primeiro entregável**.
2. Present the summary, run a confirmation loop, apply corrections.
3. Replace the first line with: `✅ Discovery completed — DD/MM/YYYY HH:MM`
4. Say: "Quest concluída. Holomap salvo em `.darkside/holomaps/<filename>`."
5. Suggest the next step — **Produto/Módulo/Feature:** "Deseja executar `/war-room` para transformar essa discovery em um plano de engenharia?" **Estória:** "Deseja executar `/order66` para implementar essa estória?" If yes, invoke the skill.

---

## Holomap Template

Created silently after the level is confirmed, with only the sections of the chosen track, in this order. `<Level>` is Product, Module, Feature, or Story. `## MVP Canvas` exists only for Produto.

```markdown
⚠️ Discovery in progress — not completed.

# Quest: <short title>

**Level:** <Level>
**Date:** YYYY-MM-DD

## Executive Summary

## Problem & North Star

## Actors & Impacts

## Current Context

## Scope & Boundaries

## Alternatives

## Success Metrics

## Risks & Assumptions

## Increments

## MVP Canvas

## Validation
```
