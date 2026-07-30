# Design: `/forensics` — Skill de Debugging Investigativo

**Date:** 2026-07-24
**Status:** Draft

---

## Sumário

Skill de debugging para o Darkside que conduz investigação forense de bugs. Combina o modelo formal de Andreas Zeller (Why Programs Fail), as melhores práticas da skill `systematic-debugging` do Superpowers, e um processo de investigação guiado em 3 fases: compreensão dos sintomas (rubber duck), definição de escopo/contexto, e investigação profunda.

A skill também requer um novo sith-agent (`debugger.md`) gerado pelo `/explore`.

---

## Premissas de Design

1. O agente (Claude) tem tendência natural a propor fixes antes de investigar — a skill deve bloquear esse comportamento com regras duras
2. Debugging é investigação científica, não tentativa-e-erro
3. O modelo **Defeito → Infecção → Falha** (Zeller) é o framework conceitual central
4. Toda sessão de debugging deve produzir um artefato persistente (laudo forense)
5. O processo deve funcionar tanto para bugs simples (5 min) quanto complexos (horas)

---

## Modelo Conceitual: A Cadeia Causal

Baseado em Zeller, todo bug segue esta cadeia:

```
DEFEITO (no código) → INFECÇÃO (no estado) → FALHA (observável)
```

- **Defeito**: o erro no código-fonte (causa raiz)
- **Infecção**: o estado do programa que diverge do esperado (pode se propagar por múltiplas camadas)
- **Falha**: o comportamento observável errado (o que o usuário reporta)

O engenheiro observa a **falha**. A investigação rastreia a **infecção** de volta até o **defeito**.

**A regra de ouro: NUNCA corrigir a falha. NUNCA corrigir a infecção. SEMPRE corrigir o defeito.**

---

## Processo de Investigação — 3 Fases

### Fase 1 — Compreensão dos Sintomas (Rubber Duck)

**Objetivo:** Forçar o agente a entender completamente o problema ANTES de tocar no código.

**Estratégia:** O agente conduz um interrogatório estruturado com o usuário usando a técnica do rubber duck invertido — em vez do usuário explicar para o pato, o agente faz perguntas que forçam o usuário a articular o problema com precisão.

**Perguntas obrigatórias (uma por vez):**

1. **O que deveria acontecer?** — Comportamento esperado, com o máximo de especificidade
2. **O que está acontecendo?** — Comportamento observado, com evidências (erro, log, screenshot, resposta da API)
3. **Desde quando?** — Quando o problema foi percebido pela primeira vez (data/hora, deploy, commit, sprint)
4. **Com que frequência?** — Sempre? Intermitente? Sob carga? Em horários específicos?
5. **Qual o impacto?** — Quem é afetado? Quantos usuários? Há workaround?

**Regras da Fase 1:**
- Uma pergunta por mensagem
- Se o usuário responder vagamente ("não sei", "acho que..."), fazer uma follow-up para clarificar
- Se o usuário tentar pular direto para o fix ("eu acho que o problema é X, só corrige"), resistir: "Preciso entender o sintoma antes de investigar a causa."
- Ao final da Fase 1, o agente escreve um **Resumo de Sintomas** no laudo antes de prosseguir

**Saída — escrita no laudo:**

```markdown
## Sintomas

- **Esperado:** [comportamento correto]
- **Observado:** [comportamento errado + evidências]
- **Desde quando:** [referência temporal]
- **Frequência:** [sempre / intermitente / condições específicas]
- **Impacto:** [escopo e severidade]
```

---

### Fase 2 — Escopo e Contexto (Onde e Quando)

**Objetivo:** Delimitar o espaço de busca antes de investigar código. Entender O QUE mudou, ONDE acontece, e EM QUE CONTEXTO.

**O agente investiga ativamente (com perguntas ao usuário + análise própria):**

#### 2.1 — Mudanças Recentes

- **Git log do repositório:** verificar commits recentes na branch atual e em branches relacionadas
- **Perguntar ao usuário:** "Houve alguma mudança recente que possa ter relação? Deploy, migração, atualização de dependência, feature flag?"
- **Verificar branches:** investigar se há branches abertas do usuário ou de outros que toquem nos mesmos arquivos/módulos
- **Verificar merges recentes:** PRs mergeados que possam ter introduzido o defeito
- **Diff entre versão funcional e quebrada:** se o usuário sabe quando funcionava, comparar o estado

#### 2.2 — Ambiente do Erro

- **Onde acontece?** Produção, staging, homologação, dev local, CI?
- **Acontece em todos os ambientes ou só em um?**
- **Diferenças de configuração:** env vars, feature flags, versões de dependência, dados de seed
- **Infraestrutura:** se relevante — banco, cache, filas, CDN, DNS

#### 2.3 — Perímetro do Código

- **Quais módulos/serviços estão envolvidos?** (ler `tech.md` para contexto arquitetural)
- **O problema é no frontend, backend, infra, ou na integração entre eles?**
- **Há dependências externas envolvidas?** (APIs terceiras, SDKs, serviços cloud)

**Regras da Fase 2:**
- O agente DEVE investigar ativamente (git log, git diff, leitura de arquivos) — não apenas perguntar
- Combinar investigação própria com perguntas ao usuário
- Se o usuário não souber responder algo, o agente tenta descobrir sozinho via código/git
- Ao final da Fase 2, escrever o **Mapa de Contexto** no laudo

**Saída — escrita no laudo:**

```markdown
## Contexto

### Mudanças Recentes
- [lista de commits/PRs/branches relevantes com datas]

### Ambiente
- **Onde ocorre:** [produção / staging / dev / todos]
- **Configuração relevante:** [env vars, flags, versões]

### Perímetro
- **Módulos envolvidos:** [lista]
- **Dependências externas:** [lista ou "nenhuma"]
- **Arquivos-chave:** [lista dos arquivos mais prováveis]
```

---

### Fase 3 — Investigação Profunda (A Cadeia Causal)

**Objetivo:** Rastrear a cadeia Defeito → Infecção → Falha até encontrar o defeito original.

A Fase 3 segue um processo rigoroso em sub-etapas. O agente DEVE completar cada sub-etapa antes de avançar.

#### 3.1 — Observação Pura (ANTES de qualquer alteração)

Inspirado em Zeller: **observar antes de experimentar**.

- Ler o código nos arquivos-chave identificados na Fase 2
- Ler stack traces, logs de erro, outputs de teste completos
- Rastrear o fluxo de dados: de onde vem o valor errado? Por quais funções passa?
- Identificar os pontos de infecção: onde o estado começa a divergir do esperado?

**Regra dura:** Nenhuma alteração no código durante 3.1. Zero. Só leitura.

#### 3.2 — Análise de Padrões

- **Código funcional vs. quebrado:** localizar código similar que funciona no mesmo codebase e comparar
- **Race conditions:** verificar acessos concorrentes, operações assíncronas sem await, shared state mutável
- **Edge cases:** inputs nulos, vazios, limites de tamanho, unicode, timezone, overflow
- **Testes existentes:** verificar cobertura de testes para o código afetado. Há testes? Passam? Cobrem o cenário do bug?
- **Testes ausentes:** identificar cenários que deveriam ter teste mas não têm

#### 3.3 — Rastreamento Reverso (Root Cause Tracing)

Técnica central do Zeller adaptada:

```
1. Começar na FALHA (erro observável)
2. Identificar a INFECÇÃO mais próxima (qual variável/estado está errado?)
3. Perguntar: "O que escreveu esse valor errado?"
4. Rastrear um nível acima na call stack
5. Repetir até encontrar o DEFEITO (o código-fonte que está errado)
6. Verificar: este é realmente a origem? Ou há mais um nível acima?
```

**Se o bug é não-determinístico (intermitente, timing-dependent):**
- Não assumir que "não reproduz = não existe"
- Investigar: race conditions, order-dependent state, cache stale, clock skew
- Considerar condition-based waiting em vez de timeouts arbitrários (conceito do Superpowers)
- Se necessário, adicionar instrumentação diagnóstica temporária (logs, tracing) para capturar evidência na próxima ocorrência

#### 3.4 — Hipótese Única e Teste Mínimo

Método científico (Zeller + Superpowers convergem aqui):

1. **Formular UMA hipótese falsificável:** "O defeito é [X] porque [evidência Y]"
2. **Projetar o menor teste possível** que confirma ou refuta a hipótese
3. **Executar o teste**
4. **Avaliar resultado:**
   - Confirmada → avançar para correção
   - Refutada → formar NOVA hipótese com a nova informação. NÃO empilhar fixes
   - Inconclusiva → coletar mais evidência, voltar para 3.1

**Regras da Fase 3:**
- Uma hipótese por vez — nunca testar múltiplas simultaneamente
- Cada hipótese deve ter evidência que a sustente (não é chute)
- Se a hipótese for refutada, registrar no laudo (evita repetir investigações)
- Máximo de 3 hipóteses refutadas antes de acionar o circuit breaker

#### 3.5 — Circuit Breaker (3 Hipóteses Refutadas)

Se 3 hipóteses consecutivas forem refutadas:

**PARAR. Não tentar uma 4a hipótese.**

Escalar para o usuário com análise:

> "Três hipóteses foram refutadas. Padrão observado: [descrever]. Isso pode indicar um problema arquitetural, não um bug pontual. Vamos discutir antes de continuar?"

Sinais de problema arquitetural:
- Cada fix revela novo problema em lugar diferente
- O fix exigiria refatoração massiva
- State compartilhado entre módulos sem contrato claro
- O bug "volta" em forma diferente após cada correção

**Saída — escrita no laudo:**

```markdown
## Investigação

### Observação
- [achados da leitura de código, logs, stack traces]
- [pontos de infecção identificados]

### Análise de Padrões
- **Código similar funcional:** [referência]
- **Race conditions:** [encontradas / não encontradas]
- **Edge cases:** [identificados]
- **Cobertura de testes:** [existente / ausente / parcial]

### Rastreamento Reverso
- **Falha:** [comportamento observado]
- **Infecção nível 1:** [estado errado em X]
- **Infecção nível 2:** [valor errado vindo de Y]
- **...**
- **Defeito:** [código-fonte raiz do problema]

### Hipóteses
| # | Hipótese | Evidência | Teste | Resultado |
|---|----------|-----------|-------|-----------|
| 1 | [descrição] | [evidência] | [teste realizado] | Confirmada / Refutada |
| 2 | ... | ... | ... | ... |
```

---

## Fase 4 — Correção e Defesa

Após confirmar o defeito:

### 4.1 — Teste de Regressão Primeiro

- Criar teste automatizado que reproduz o bug (deve falhar com o código atual)
- O teste documenta o comportamento esperado vs. o defeito
- Usar o sith-agent `tdd.md` para garantir qualidade do teste
- **Regra:** o teste DEVE existir e falhar ANTES de qualquer fix

### 4.2 — Fix Único no Defeito

- Corrigir o DEFEITO (não a infecção, não a falha)
- Uma alteração por vez — sem "melhorias" bundled
- Sem refatoração oportunista — só o fix
- Verificar: o teste de regressão agora passa?
- Verificar: nenhum outro teste quebrou?

### 4.3 — Defesa em Profundidade

Conceito do Superpowers (defense-in-depth), formalizado por camada:

Após corrigir o defeito, adicionar validação nas camadas por onde a infecção se propagou:

| Camada | Propósito | Exemplo |
|--------|-----------|---------|
| **Entrada** | Rejeitar input inválido na fronteira da API | Validação de parâmetros, type checking |
| **Lógica** | Garantir invariantes do domínio | Assertions, guards em business logic |
| **Ambiente** | Prevenir operações perigosas em contextos específicos | Guards de NODE_ENV, feature flags |
| **Observabilidade** | Capturar contexto para futuras investigações | Logging estruturado, tracing |

**Regra:** Defesa em profundidade é OPCIONAL para bugs simples, OBRIGATÓRIA quando a infecção atravessou 2+ camadas.

### 4.4 — Verificação Final

- Todos os testes passam (novos + existentes)
- O comportamento esperado descrito na Fase 1 está restaurado
- Nenhum efeito colateral introduzido

**Saída — escrita no laudo:**

```markdown
## Correção

### Defeito Corrigido
- **Arquivo:** [path:line]
- **O que estava errado:** [descrição]
- **O que foi corrigido:** [descrição da mudança]

### Teste de Regressão
- **Arquivo:** [path do teste]
- **Cenário:** [o que o teste valida]

### Defesa em Profundidade
| Camada | Arquivo | Validação Adicionada |
|--------|---------|---------------------|
| Entrada | [path] | [descrição] |
| Lógica | [path] | [descrição] |
| ... | ... | ... |

### Verificação
- [ ] Teste de regressão passa
- [ ] Suíte completa passa
- [ ] Comportamento esperado restaurado
```

---

## Cenários Especiais

### Incidente de Produção (P0/P1)

A skill NÃO muda o processo, mas adiciona uma etapa zero:

> **Step 0 — Mitigação imediata:** Antes de investigar, estabilizar. Rollback, feature flag off, circuit breaker, traffic redirect. Mitigação ≠ fix. Depois de estabilizar, seguir as 4 fases normalmente.

Isso resolve o gap mais crítico da skill do Superpowers, que não distingue mitigação de correção.

### Bugs Não-Determinísticos

Para bugs intermitentes, race conditions, heisenbugs:

1. **Não desistir de reproduzir** — buscar condições específicas (carga, concorrência, ordem de execução)
2. **Instrumentação sobre suposição** — adicionar logging/tracing para capturar a próxima ocorrência em vez de chutar
3. **Condition-based waiting** — em testes, substituir `sleep()` por polling de condição (técnica do Superpowers)
4. **Statistical debugging** — se há logs suficientes, analisar correlação entre variáveis e falhas (conceito do Zeller)

### Bug Simples e Óbvio

Se o defeito é evidente (typo, import errado, variável com nome trocado):

- Fase 1 pode ser uma única pergunta
- Fase 2 pode ser um `git diff` rápido
- Fase 3 pode ser confirmação visual direta
- Fase 4 é obrigatória (teste de regressão sempre)

O processo escala para baixo, mas nenhuma fase é pulada.

---

## Artefato: Laudo Forense

Cada sessão de debugging gera um relatório persistente.

**Local:** `.darkside/forensics/YYYY-MM-DD-<nome>-forensics.md`

**Estrutura completa:**

```markdown
# Laudo Forense — <Nome do Bug>

**Data:** YYYY-MM-DD
**Status:** ✅ Resolvido / ⚠️ Em investigação / ❌ Escalado

## Cadeia Causal
- **Defeito:** [uma linha — o que estava errado no código]
- **Infecção:** [como o estado se corrompeu]
- **Falha:** [o que o usuário observou]

## Sintomas
[Fase 1]

## Contexto
[Fase 2]

## Investigação
[Fase 3]

## Correção
[Fase 4]

## Hipóteses Refutadas
[registro de caminhos que não levaram a lugar nenhum — evita re-investigação]
```

---

## Sith-Agent: `debugger.md`

### Alteração no `/explore`

O `/explore` passa a gerar **6 sith-agents** (atualmente são 5). O novo agente é o `debugger.md`.

**Alteração na tabela do Step 5 do `/explore`:**

| File | Role | Focus |
|------|------|-------|
| `tdd.md` | TDD specialist | test strategy, red-green-refactor, coverage |
| `engineer.md` | Software engineer | design decisions, trade-offs, architecture fit |
| `coder.md` | Coder | clean implementation, conventions, naming |
| `security.md` | Security specialist | OWASP, input validation, auth, secrets |
| `reviewer.md` | Code reviewer | correctness, consistency, standards |
| **`debugger.md`** | **Debug forensics specialist** | **root cause tracing, causal chain analysis, defect isolation, regression testing, defense-in-depth** |

### Template do Agent

O `debugger.md` gerado pelo `/explore` segue a mesma estrutura dos outros agents (Identity, Project context, Responsibilities, Rules, Output), mas com foco específico:

```markdown
**Identity** — Debug forensics specialist for [project stack]

**Project context** — [architecture layers, test framework, logging/observability
setup, deployment pipeline, environments — all from tech.md]

**Responsibilities:**
- Trace causal chains from failure back to defect through infection points
- Identify the defect origin — never fix at symptom or infection level
- Analyze race conditions, shared state, and concurrency issues specific to [project's async patterns]
- Evaluate test coverage gaps that allowed the defect to reach production
- Recommend defense-in-depth validations appropriate to [project's architecture layers]

**Rules:**
- NEVER propose a fix before completing root cause investigation
- NEVER fix at symptom level — always trace to the defect
- ONE hypothesis at a time — no shotgun fixes
- After 3 refuted hypotheses, escalate to architectural discussion
- Observe before experimenting — first pass is read-only

**Output:** Causal chain analysis (defect → infection → failure), root cause
identification, regression test specification, defense-in-depth recommendations.
```

O conteúdo real será customizado pelo `/explore` com base no `tech.md` do projeto (frameworks de teste, padrões de logging, camadas arquiteturais, etc).

---

## Integração com o Ecossistema Darkside

### Pré-requisitos

- `.darkside/holocrons/tech.md` — contexto arquitetural (gerado pelo `/explore`)
- `.darkside/sith-agents/debugger.md` — agente especialista (gerado pelo `/explore`)
- `.darkside/sith-agents/tdd.md` — para criação de teste de regressão (Fase 4)

### Encadeamento com Outras Skills

| Situação | Encadeamento |
|----------|-------------|
| Bug revelou problema arquitetural (circuit breaker acionado) | Sugerir `/war-room` para planejar refatoração |
| Fix implementado, precisa de code review | Sugerir `/inquisitor` no arquivo corrigido |
| Bug veio de uma feature em desenvolvimento | Consultar `.darkside/imperial-orders/` para contexto do `/order66` |
| Bug apareceu em feature recém-descoberta pelo `/quest` | Consultar `.darkside/holomaps/` para contexto de negócio |

### Storage

```
.darkside/
└── forensics/                          # NOVO — laudos forenses
    └── YYYY-MM-DD-<nome>-forensics.md
```

---

## Referências Teóricas Incorporadas

### Do livro "Why Programs Fail" (Zeller)

| Conceito | Como é usado na skill |
|----------|----------------------|
| Cadeia Defeito → Infecção → Falha | Modelo conceitual central — o agente deve identificar os 3 |
| Observação antes de experimento | Fase 3.1 é read-only obrigatória |
| Rastreamento reverso | Fase 3.3 — rastrear da falha ao defeito pela call stack |
| Delta debugging (minimização) | Princípio de reduzir ao menor caso reprodutível (Fase 3.4) |
| Method científico rigoroso | Hipótese única falsificável + teste mínimo (Fase 3.4) |
| Statistical debugging | Para bugs não-determinísticos — análise de correlação em logs |

### Da skill `systematic-debugging` (Superpowers)

| Conceito | Como é usado na skill |
|----------|----------------------|
| Iron Law (no fixes without investigation) | Regra dura em todas as fases |
| Circuit breaker (3 fixes) | Fase 3.5 — escalar após 3 hipóteses refutadas |
| Defense-in-depth | Fase 4.3 — validação em múltiplas camadas |
| Condition-based waiting | Cenário de bugs não-determinísticos |
| Red flags / rationalizations | Incorporadas como regras duras nas fases |
| Comparação com código funcional | Fase 3.2 — análise de padrões |

### Contribuições Originais

| Conceito | Origem |
|----------|--------|
| Rubber duck invertido (Fase 1) | Design da skill — forçar articulação do problema |
| Investigação ativa de branches/commits (Fase 2) | Design da skill — não depender só do usuário |
| Mitigação como Step 0 em P0/P1 | Gap identificado na análise do Superpowers |
| Laudo forense como artefato persistente | Padrão Darkside — todo processo gera documento |
| Sith-agent debugger especializado | Extensão do ecossistema Darkside |
| Escala para baixo sem pular fases | Design da skill — bugs simples usam fases curtas, não pulam |

---

## Anti-Padrões (O que o agente NUNCA deve fazer)

| Anti-padrão | Por que é proibido |
|-------------|-------------------|
| Propor fix antes de completar Fase 1 | Sintoma ≠ causa. Fix prematuro mascara defeito real |
| Alterar código durante observação (3.1) | Observar e experimentar simultaneamente contamina evidência |
| Testar múltiplas hipóteses ao mesmo tempo | Impossível isolar qual mudança teve efeito |
| Empilhar fixes sobre fix que não funcionou | Cada camada de fix esconde mais o defeito |
| Dizer "não consigo reproduzir" e desistir | 95% dos "não reproduz" são investigação incompleta |
| Fazer refatoração junto com o fix | Mudanças bundled introduzem novos defeitos |
| Pular teste de regressão por ser "bug simples" | Bugs simples sem teste voltam |
| Ignorar hipóteses refutadas | Re-investigar o mesmo caminho desperdiça tempo |

---

## Fluxo Visual

```
/forensics invocado
    │
    ▼
[Verifica pré-requisitos: tech.md + debugger.md]
    │
    ▼
FASE 1 — RUBBER DUCK
    │  Perguntas: esperado? observado? desde quando? frequência? impacto?
    │  Escreve: ## Sintomas
    │
    ▼
FASE 2 — ESCOPO E CONTEXTO
    │  Investiga: git log, branches, ambiente, perímetro
    │  Pergunta: mudanças recentes? onde ocorre?
    │  Escreve: ## Contexto
    │
    ▼
FASE 3 — INVESTIGAÇÃO
    │
    ├─ 3.1 Observação pura (read-only)
    ├─ 3.2 Análise de padrões
    ├─ 3.3 Rastreamento reverso (falha → infecção → defeito)
    ├─ 3.4 Hipótese + teste mínimo
    │       │
    │       ├─ Confirmada → FASE 4
    │       ├─ Refutada (< 3x) → Nova hipótese
    │       └─ Refutada (≥ 3x) → Circuit breaker → Escalar
    │
    │  Escreve: ## Investigação
    │
    ▼
FASE 4 — CORREÇÃO E DEFESA
    │
    ├─ 4.1 Teste de regressão (deve falhar)
    ├─ 4.2 Fix único no defeito
    ├─ 4.3 Defesa em profundidade (se infecção cruzou 2+ camadas)
    ├─ 4.4 Verificação final
    │
    │  Escreve: ## Correção
    │
    ▼
Laudo completo em .darkside/forensics/YYYY-MM-DD-<nome>-forensics.md
    │
    ▼
Sugere próximo passo (/inquisitor, /war-room, etc.)
```
