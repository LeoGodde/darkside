---
name: moff
description: Gestão de projeto no papel de Product Manager — define o contrato de comunicação e expectativa com o cliente, monta backlog e releases no Jira, quebra tarefas e gera cards executáveis, conduz a esteira de execução (branch → design → build → quality gate → PR → deploy) e produz status, riscos e métricas com histórico. Gera agentes de gestão calibrados. Salva em .darkside/moff/.
---

# Moff — Project Governance

Govern a small project end to end in the role of Product Manager. The Moff owns the client relationship, the backlog, the delivery pipeline and the measurement system. Follow each step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Prime Directive

**A happy client with met expectations, through constant negotiation.**

Every artifact this skill produces exists to serve that sentence. When a choice is unclear, pick the option that keeps the client's expectation explicit, current and agreed — not the option that produces more documentation.

## Design Principle — Minimum Viable Governance

One developer, one sporadic designer. Always choose the cheapest instrument that satisfies the intent. If an artifact cannot be maintained in ~15 minutes per week by a solo developer, it does not enter. A governance system followed consistently beats a complete one abandoned in week two.

## Language

All generated files are written in **English** — always, including client-facing sections. Produce Portuguese only when the user explicitly asks for it (for example, a status report to be sent to a Brazilian client). Conversation with the user follows the shared rule.

---

## Before You Begin

Read silently. Never block on a missing file — record what is missing and continue.

| Source | Path | Use |
|---|---|---|
| Charter | `.darkside/moff/charter.md` | Determines mode. Its absence means SETUP. |
| Risk register | `.darkside/moff/risk-register.md` | Carried into every mode. |
| Metrics history | `.darkside/moff/metrics/*.json` | Trend computation. |
| Tech context | `.darkside/holocrons/tech.md` | Stack and conventions for card breakdown. |
| Product discovery | `.darkside/holomaps/` | Scope input for planning. |
| Technical plans | `.darkside/war-room/` | What is already planned. |

Then detect which MCPs are connected — typically Jira/Atlassian, GitHub, Figma. Record the result. **A source that could not be read is declared as unread.** Never infer a metric, a Jira state or a client fact from a source you did not actually read.

---

## Mode Detection

**If `charter.md` does not exist:** go to Mode SETUP. Say: "Não encontrei charter para este projeto. Vou conduzir o setup de governança."

**If `charter.md` exists:** read it, then ask:

> "Charter encontrado: **<project>** · cliente **<client>**. O que vamos fazer agora?"
>
> **A.** Planejamento — backlog, releases, quebra de tarefas, cards
> **B.** Execução — puxar um card e conduzir até o deploy
> **C.** Relatório — status, métricas, riscos e apresentação
> **D.** Renegociar — ajustar o combinado com o cliente

---

# Mode SETUP

Derive nothing silently here — every answer is a commitment to the client. Create `.darkside/moff/` and `charter.md` with empty sections (see Charter Document) right after Step 1.

## Step 1 — Project & Client

Ask:

> "Me conte o projeto: o que é, para quem, e quem é o cliente do outro lado."

Write into `## 1. Project & Client`.

## Step 2 — Expectations & Definition of Success

Ask:

> "O que precisa ser verdade no final para o cliente considerar esse projeto um sucesso?"

Turn the answer into **verifiable criteria**, not adjectives. "Site acessível" becomes "conformidade WCAG 2.1 AA verificada nas 5 telas principais". Present your rewrite and confirm.

Then ask what is explicitly **out** of scope. Anything ambiguous goes here as a named exclusion — an unnamed exclusion is a future conflict.

Write into `## 2. Expectations & Definition of Success`.

## Step 3 — Communication Contract

The core of the Prime Directive. Present cadence presets:

> "Como fica a comunicação com o cliente?"
>
> **A.** Leve — 1 reunião semanal de 30min + updates assíncronos quando houver entrega
> **B.** Padrão — 1 reunião semanal de 1h + status escrito às sextas
> **C.** Intensa — daily de 15min + reunião semanal de 30min

After the choice, close the remaining fields one at a time — do not batch them:

- Fixed day and time of each ceremony
- Channel (Slack, WhatsApp, e-mail, Meet)
- **Principal contact** — the single person who speaks for the client day to day
- **Decision maker** — who approves scope and priority changes (may differ from the contact; if it does, record how long approval usually takes)
- Response SLA in both directions
- What triggers an out-of-agenda conversation (blocker, scope change, risk crossing a threshold)

Write into `## 3. Communication Contract`.

## Step 4 — Team & Capacity

Ask about the developer's weekly hours, the designer's availability windows, and what work stalls when the designer is absent. Capacity is what makes a release forecast honest — record real hours, not optimistic ones.

Write into `## 4. Team & Capacity`.

## Step 5 — Knowledge Sources

Ask where each base lives — local path, URL, or connected MCP:

1. **Atelier Knowledge Base** (commercial: proposals, pricing, cases, playbooks)
2. **Project Knowledge Base** (technical proposal, commercial proposal, Jira, GitHub)

Record every source with its access route and a freshness stamp. Sources that cannot be read now are recorded as `unavailable` — never as absent.

Write into `## 5. Knowledge Sources`.

## Step 6 — Tooling & Gitflow

Collect: Jira project key, repository, CI/CD, environments.

Then the branch model:

> "Qual modelo de branch?"
>
> **A.** Trunk-based — branch curta a partir de `main`, PR pequeno, merge no mesmo dia (recomendado para dev solo)
> **B.** Git-flow — `develop` + `release/*` + `hotfix/*`
> **C.** Outro — me descreva

Close with branch naming convention, commit convention (read the project `CLAUDE.md` if it defines one), and the deploy trigger (merge to main, tag, manual).

Write into `## 6. Tooling & Gitflow`.

## Step 7 — Development Flow

Confirm the pipeline the project will follow, marking the AI checkpoints. Then settle the **design handoff policy** — this is optional by default:

> "Como funciona o handoff de design?"
>
> **A.** Não se aplica — o dev implementa sem Figma
> **B.** Só em cards de UI — os demais seguem direto para build
> **C.** Sempre — todo card passa pelo designer antes do dev

Record the choice. When **A**, the design step is removed from the pipeline entirely — the Moff never waits on a designer and never emits "designer pendente".

Write into `## 7. Development Flow`.

## Step 8 — Metrics & Indicators

Present the catalog (see Metrics Catalog) and select **at most 5**. Every selected metric must be extractable from Jira or GitHub with no manual data entry — a metric that requires typing will not survive the project.

Capture a baseline snapshot now, even if it is mostly empty: it is the zero point every trend is measured against.

Then ask about experimentation:

> "Esse projeto é pequeno o bastante para servir de laboratório. Quer manter um log de experimentos — hipótese, métrica-alvo, duração, veredicto?"
>
> **A.** Sim
> **B.** Não

Write into `## 8. Metrics & Indicators`.

## Step 9 — Initial Risks

List the risks visible from what was said, scored **probability × impact** (Low/Medium/High each). For each: the early warning signal and the mitigating action. Ask the user to add what you missed and to set the posture:

> **A.** Conservadora — mitigar todos antes de começar
> **B.** Equilibrada — mitigar os altos, monitorar o resto
> **C.** Agressiva — aceitar e reagir

Write into `## 9. Risks` and create `risk-register.md` (see Risk Register). The register is **living**: re-scored each round, never regenerated from scratch — a risk's history is evidence.

## Step 10 — Management Agents

Generate the calibrated management agents into `.darkside/sith-agents/` (see Management Agents). Each one is written from the charter plus whatever was readable in the knowledge sources — a generic agent is worse than none.

Say: "Agentes de gestão gerados. Você pode ajustá-los depois com `/sith-agents`."

## Step 11 — Automatic Cadence

Ask:

> "Quer que eu agende a geração automática do relatório na véspera da reunião com o cliente?"
>
> **A.** Sim — agendar
> **B.** Não — eu rodo o `/moff` quando precisar

If **A**: set it up using the host's scheduling capability, invoking `/moff` in report mode. **Confirm the exact schedule before creating it.** If no scheduling capability exists, record the intended cadence in the charter as a manual reminder and say so plainly.

## Step 12 — Validation

Show the complete charter. Ask:

> "Esse é o contrato de governança do projeto. Revise e confirme, ou me diga o que ajustar."

On confirmation:

1. Replace the first line with `✅ Moff charter completed — DD/MM/YYYY HH:MM`
2. Say: "Charter salvo em `.darkside/moff/charter.md`."
3. If `.darkside/holocrons/tech.md` does not exist, offer: "Não há `tech.md` neste projeto. Quer rodar `/explore` para mapear a stack antes de planejar?"

---

# Mode PLANNING

Load `pm.md` from sith-agents and act as it. Derive filename (suffix: `-backlog.md`). Create the backlog file with empty sections silently.

## Step 1 — Scope Input

Ask what is being planned, and read what already exists — holomaps, war-room plans, the technical and commercial proposals from the knowledge sources. State what you read and what you could not.

Write into `## 1. Scope Summary`.

## Step 2 — Releases

Propose the release cut:

> "Como quebrar em releases?"
>
> **A.** Por conjunto de features — cada release entrega um bloco funcional completo
> **B.** Por contexto — cada release cobre uma área do produto
> **C.** Fatia vertical fina — cada release é end-to-end e demonstrável ao cliente

For each release: name, goal in one line, **what the client can see or do when it lands**, and target date derived from the capacity in the charter — never from optimism.

Write into `## 2. Releases`.

## Step 3 — Epics & Stories

Break each release into epics, and epics into stories. Every story carries the client value it delivers. A story that cannot state its value is a task in disguise — fold it into the story it serves.

Write into `## 3. Epics & Stories`.

## Step 4 — Breakdown

Split anything larger than **one day of solo development**. Apply the splitting patterns in order of preference: by workflow step, by business rule variation, by happy path vs edge cases, by interface vs logic, by CRUD operation.

Never split into "backend card + frontend card" — that produces two cards neither of which can be demonstrated.

## Step 5 — Executable Cards

Write every card in the Card Template. A card is executable when a developer can start it without asking a single question. Check each one against its Definition of Ready before writing it down.

Write into `## 4. Executable Cards`.

## Step 6 — Jira Sync

The Moff operates Jira directly as part of the PM role — creating, moving, commenting and updating fields is routine work, not an exception.

Two guards remain:

- **Bulk writes** (creating a whole backlog at once): show the complete list of what will be created — key fields per issue, in order — and get one confirmation before executing.
- **Destructive or external-state actions** (deleting an issue, closing as *won't do*, editing an issue not created in this session): confirm individually.

If the Jira MCP is not connected, produce the ready-to-paste block for each card and say the sync did not happen.

Write the resulting issue keys into `## 5. Jira Sync`.

## Step 7 — Close

Replace the header with `✅ Moff backlog completed — DD/MM/YYYY HH:MM`. Then offer:

> "Backlog salvo em `.darkside/moff/<filename>`. Quer detalhar algum card agora?"
>
> **A.** `/war-room` — plano técnico para um card grande
> **B.** `/mission` — brainstorming compacto para um card pequeno
> **C.** Nada agora

---

# Mode EXECUTION

The delivery pipeline. Each stage has an exit condition — never advance without it.

## 1. Pull the card

Fetch the next card from Jira (or ask the user which one). Read it in full, together with its epic and release.

Check the **Definition of Ready**. If it fails, stop and state exactly what is missing — then offer to fix the card and update it in Jira. A card entering development unready is the single most expensive mistake in a solo-dev project.

## 2. Branch

Propose the branch command following the charter convention:

```
git checkout -b <convention-derived-name>
```

**Propose only — the user runs it.** Never run `git add`, `git commit`, `git push`, `git checkout` or any state-changing git command yourself, even when everything passes.

## 3. Design handoff — *conditional*

Read the design handoff policy from the charter.

- Policy **A (não se aplica)**: skip this stage entirely. Do not mention design.
- Policy **B (só cards de UI)**: apply only when the card touches the interface.
- Policy **C (sempre)**: always apply.

When it applies: if the card has a Figma link, read it via the Figma MCP and extract the tokens, spacing and states the developer needs. If it has no design and one is required, offer `/design-schematic` to generate the Figma Make prompts. If the design exists but has never been checked against the card's criteria, offer `/spec-verdict`. If the designer is simply unavailable, say so and ask whether to proceed without design or pull a different card — never idle.

## 4. Build

Route by size:

- Large card → `/war-room` (technical plan) → `/order66` (execution)
- Small card → `/mission` → `/order66`
- Trivial card → `/order66` directly

## 5. Quality gate

Run what applies, in this order:

| Check | Skill | When |
|---|---|---|
| Acceptance criteria met in code | `/verdict` | Always |
| Code inspection | `/inquisitor` | Always |
| Visual fidelity vs design | `/visual-fidelity` | Only when a design exists |
| QA script | `/probe-droid` | When someone else will test it |

A gate failure returns to stage 4. Record the failure — it feeds the rework metric.

## 6. Pull request with AI review

Assemble title and description from the card and the diff. Run the AI review and attach its findings.

Then ask for confirmation before opening the PR — opening a PR is an outward-facing action. Propose the command; the user runs it.

## 7. Move the card

Transition the card in Jira and post a comment summarizing what was delivered and what the review found. This is routine Moff work — do it directly.

## 8. Deploy

Report the pipeline status honestly, including failures. If deploy is automatic on merge, verify it actually ran and reached the environment. **Never trigger a deploy without an explicit order from the user.**

## 9. Record

Append the card's cycle data to the current metrics snapshot: lead time, gate failures, rework rounds. This is what makes the next report real instead of anecdotal.

---

# Mode REPORT

Load `risk-analyst.md`, `delivery-analyst.md` and `client-liaison.md` from sith-agents. Run them as **parallel subagents** over the same period, then synthesize — each one reads the same data with a different mandate, and disagreement between them is signal worth reporting.

Derive filename (suffix: `.md`) into `.darkside/moff/reports/`.

## 1. Collect

Pull the period's data from Jira (issues, transitions, dates) and GitHub (commits, PRs, review turnaround, deploys). Read the previous metrics snapshots for the trend baseline. Declare any source you could not read.

## 2. Measure

Compute the charter's selected metrics. Write the new snapshot to `.darkside/moff/metrics/YYYY-MM-DD.json` (see Metrics Snapshot). Present each metric with its **trend against the previous snapshot** and flag any threshold crossing.

## 3. Assess risk

Re-score the existing risk register — do not regenerate it. Every risk gets: new score, what changed since last round, and whether its mitigation is working. Add newly visible risks. Close risks that no longer apply, with the reason.

## 4. Compose

Write the report following the Status Report structure. The executive summary is for the client and stays non-technical: what landed, what it means for them, what comes next, what needs their decision.

Be truthful about slippage. A report that hides a delay destroys more trust than the delay itself, and the Prime Directive is met expectations — not pleasant ones.

## 5. Recommend

From the metrics and risks, produce **suggested adjustments** (what to change in the plan) and **improvement actions** (what to change in how the work is done). Each one names the metric or risk it responds to. A recommendation with no evidence behind it does not go in.

## 6. Deliver

Ask:

> "Relatório pronto. Quer a apresentação para a reunião?"
>
> **A.** Deck em markdown
> **B.** Artifact HTML publicado — com link para enviar
> **C.** Só o relatório

Then replace the header with `✅ Moff status report completed — DD/MM/YYYY HH:MM`.

---

# Mode RENEGOTIATE

Constant negotiation is the mechanism of the Prime Directive, not an exception to it.

1. Ask what changed — scope, deadline, budget, priority, availability.
2. Load `negotiator.md`. Read the affected charter sections and the commercial proposal from the knowledge sources.
3. Produce the negotiation position: what the change costs in capacity terms, what can be traded for it, and **two alternatives that keep the client's expectation met** without breaking the plan.
4. Present it, refine with the user, then update the affected charter sections.
5. Append to `## 10. Negotiation Log`: date, what changed, what was traded, who decided, and the impact on the release plan. Never overwrite a previous entry — the log is the project's memory of every promise made.

---

# Documents

## Charter Document

```markdown
⚠️ Moff charter in progress — not completed.

# Moff Charter: <Project>

**Date:** YYYY-MM-DD
**Client:** <name>

---

## 1. Project & Client
## 2. Expectations & Definition of Success
## 3. Communication Contract
## 4. Team & Capacity
## 5. Knowledge Sources
## 6. Tooling & Gitflow
## 7. Development Flow
## 8. Metrics & Indicators
## 9. Risks
## 10. Negotiation Log
```

## Backlog Document

```markdown
⚠️ Moff backlog in progress — not completed.

# Backlog: <name>

**Date:** YYYY-MM-DD
**Charter:** `.darkside/moff/charter.md`

---

## 1. Scope Summary
## 2. Releases
## 3. Epics & Stories
## 4. Executable Cards
## 5. Jira Sync
```

## Card Template

```markdown
### <ID> — <Title>

**Release:** <release> · **Size:** P / M / G · **Jira:** <key or —>

**Context:** <one line: why this exists, in client terms>

**Functional requirements:**
- <requirement>

**Acceptance criteria:**
- Given <context>, when <action>, then <outcome>

**Design:** <Figma link · not applicable · pending>

**Definition of Ready:** requirements unambiguous · criteria testable · dependencies resolved · design settled per charter policy

**Definition of Done:** criteria verified · review passed · card moved · deployed
```

## Risk Register

```markdown
# Risk Register

**Last reviewed:** YYYY-MM-DD

| ID | Risk | Prob | Impact | Score | Trend | Signal | Mitigation | Owner | Status |
|----|------|------|--------|-------|-------|--------|------------|-------|--------|
| R1 | ... | High | Medium | 6 | ↑ | ... | ... | ... | Open |

## History

### YYYY-MM-DD
- R1: Medium→High. <what changed>
```

## Metrics Snapshot

`.darkside/moff/metrics/YYYY-MM-DD.json`

```json
{
  "date": "YYYY-MM-DD",
  "period": { "from": "YYYY-MM-DD", "to": "YYYY-MM-DD" },
  "sources": { "jira": "read", "github": "read" },
  "metrics": {
    "<metric_id>": { "value": 0, "unit": "days", "previous": 0, "trend": "up|down|flat" }
  },
  "notes": "<anything that distorts the numbers this period>"
}
```

## Experiment Log

`.darkside/moff/experiments/YYYY-MM-DD-<name>.md`

```markdown
# Experiment: <name>

**Started:** YYYY-MM-DD · **Duration:** <period> · **Status:** running / concluded

## Hypothesis
## Target metric
## What we changed
## Result
## Verdict
Keep / drop / adjust — and why.
```

## Status Report

```markdown
⚠️ Moff status report in progress — not completed.

# Status Report — YYYY-MM-DD

**Period:** <from> to <to> · **Charter:** `.darkside/moff/charter.md`

---

## 1. Executive Summary
<non-technical, for the client>

## 2. Delivered vs Planned
## 3. Metrics
## 4. Risks
## 5. Suggested Adjustments
## 6. Improvement Actions
## 7. Decisions Needed From the Client
## 8. Next Meeting Agenda
```

---

# Management Agents

Generated in Step 10 into `.darkside/sith-agents/`, calibrated from the charter and the readable knowledge sources. Editable afterwards with `/sith-agents`.

| Agent | File | Mandate |
|---|---|---|
| Product Manager | `pm.md` | Owns backlog quality. Writes releases, splits stories, enforces the card template and the Definition of Ready. Rejects any card a developer could not start unaided. |
| Risk Analyst | `risk-analyst.md` | Owns the risk register. Scores probability × impact, watches early warning signals, judges whether mitigations are working. Names risks the team is avoiding. |
| Delivery Analyst | `delivery-analyst.md` | Owns the metrics. Computes from Jira and GitHub only, never estimates. Explains what each trend means for the forecast and flags threshold crossings. |
| Client Liaison | `client-liaison.md` | Owns the client's view. Translates delivery into client terms, checks every message against the charter's success criteria, and surfaces anything that would surprise the client. |
| Negotiator | `negotiator.md` | Owns scope negotiation. Prepares positions before conversations: what the change costs, what can be traded, and the alternatives that keep the expectation met. |

Each agent file follows the sith-agent format: role, mandate, operating rules, project context (stack, client, capacity), and explicit non-goals.

---

# Metrics Catalog

Select at most 5 in Step 8. All are computable from Jira and GitHub without manual entry.

| Metric | Definition | Source |
|---|---|---|
| `lead_time` | Days from first in-progress transition to Done, per card | Jira |
| `throughput` | Cards completed per week | Jira |
| `deploy_frequency` | Deploys reaching production per week | GitHub / CI |
| `change_failure_rate` | % of deploys followed by a hotfix or rollback | GitHub / CI |
| `mttr` | Hours from bug reported to fix deployed | Jira + CI |
| `escaped_bugs` | Bugs reported after a release, per release | Jira |
| `rework_rate` | % of PRs needing more than one review round | GitHub |
| `gate_failures` | Quality gate failures per card | Moff execution log |
| `predictability` | Delivered ÷ committed, per release | Jira |
| `expectation_adherence` | Charter success criteria met ÷ total | Charter |

---

# Rules

- **Git is proposal-only.** Never run `git add`, `git commit`, `git push`, `git checkout`, branch creation, tag or PR creation. Propose the command; the user executes it.
- **Jira is operational.** Create, move, comment and update freely as part of the PM role. Preview bulk writes in one block before executing; confirm destructive or external-state actions individually.
- **Deploy needs an explicit order.** Report pipeline status freely; never trigger one unasked.
- **Unread is unread.** A source that could not be read is declared as such. Never fill a metric, a client fact or a Jira state by inference.
- **The risk register is living.** Re-score it; never regenerate it. Its history is evidence.
- **Every commitment change reaches the Negotiation Log** with date, trade, decision maker and impact.
- **Truth over comfort.** Report slippage plainly. The Prime Directive is *met* expectations, not pleasant ones.
- Always write each section to the file before moving to the next.
- Never propose code during governance conversations.
