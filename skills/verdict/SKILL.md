---
name: verdict
description: Verifica se os critérios de aceite de cards de tarefa estão atendidos no código — solicita links de cards, extrai ou cria critérios, valida com o usuário e gera relatório de cobertura por item. Use quando quiser auditar a implementação contra requisitos de Jira, GitHub Projects, Trello, ClickUp, Asana, Azure Boards ou similar.
---

# Verdict — Acceptance Criteria Verification

Verify whether the acceptance criteria from task cards are met in the codebase. Follow each step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Step 1: Collect Card Links

Ask:

> "Informe o link (ou links) dos cards de tarefa que vamos verificar.
>
> Aceito: Jira, GitHub Projects, Trello, ClickUp, Asana, Azure Boards ou similar."

Wait for the answer. Collect all links provided. Derive a report name from the card IDs or titles (suffix: `-verdict.md`). Silently create `.darkside/verdicts/` and the report file with empty sections (see Report Structure).

---

## Step 2: Check MCP Availability

For each link provided, identify the platform and required MCP:

| Platform | Detection | Required MCP |
|----------|-----------|-------------|
| Jira (atlassian.net) | URL contains `atlassian.net` or `jira` | `mcp__claude_ai_Atlassian` |
| GitHub Projects (github.com) | URL contains `github.com` | GitHub MCP |
| Trello (trello.com) | URL contains `trello.com` | None — manual fallback |
| ClickUp (clickup.com) | URL contains `clickup.com` | None — manual fallback |
| Asana (asana.com) | URL contains `asana.com` | None — manual fallback |
| Azure Boards (dev.azure.com) | URL contains `dev.azure.com` | None — manual fallback |

**For Jira:** check if `mcp__claude_ai_Atlassian` tools are available in the session. If available, proceed to Step 3. If not:

> "Para ler cards do Jira automaticamente, preciso do MCP do Atlassian configurado.
>
> **A.** Instalar agora — rode `claude mcp add --transport http https://mcp.atlassian.com/v1/sse` no terminal e reinicie a sessão
> **B.** Colar o conteúdo do card manualmente

Wait for the answer. If **A**: say "Reinicie a sessão e rode `/verdict` novamente." and stop. If **B**: proceed to the manual fallback.

**For GitHub Projects:** check if GitHub MCP tools are available. Apply the same pattern.

**For manual fallback (Trello, ClickUp, Asana, Azure, or MCP unavailable):**

> "Não encontrei um MCP para [platform]. Cole o conteúdo completo do card."

Wait for the pasted content before continuing.

---

## Step 3: Read Cards

For each card:

**Via Jira MCP:** call `mcp__claude_ai_Atlassian__getJiraIssue` with the issue key extracted from the URL. Read: summary, description, acceptance criteria fields, comments, and any linked documents. If the issue has sub-tasks, read them too.

**Via GitHub MCP:** read the project item and any linked issues or PRs.

**Via pasted content:** parse the content provided by the user directly.

Record each card's raw content internally before proceeding.

---

## Step 4: Extract Acceptance Criteria

Say: "Fazendo busca profunda por critérios de aceite…"

Then, for each card, execute all of the following searches silently and transparently — do not pause to ask or report between sub-steps:

**4.1 — Standard fields**
Search in: summary, description, `acceptance_criteria`, `customfield_*` (all custom fields returned by the API), `story_points`, `labels`, `components`, comments, and any linked Confluence pages or remote links.

**4.2 — Custom field deep scan (Jira)**
Call `mcp__claude_ai_Atlassian__getJiraIssueTypeMetaWithFields` to list all available custom fields for the issue type. For each field that could contain text, documentation, or checklist data, read its value. Common field names to check: `Acceptance Criteria`, `Critérios de Aceite`, `AC`, `Definition of Done`, `Guia da Task`, `QA Notes`, `Test Cases`, `Description`, `Business Rules`, `User Story`, `Scenario`.

**4.3 — Comments scan**
Read all comments on the card. Extract any acceptance criteria, checklists, or Given/When/Then blocks written in comments — these are often added after card creation.

**4.4 — Linked documents**
If any Confluence pages are linked, call `mcp__claude_ai_Atlassian__getConfluencePage` to read them. Look for AC sections within.

**4.5 — Sub-tasks**
If the card has sub-tasks, read each one and extract any criteria they contain.

**4.6 — Synthesis**
After all sources are scanned:
- If criteria were found: extract and normalize into a numbered list.
- If criteria were not found anywhere: derive candidate criteria from the card's intent — analyze the title, description, and all collected context to determine what must be true for the card to be considered done.

Write all extracted or derived criteria into the report file under the card's section before moving to Step 5. Do not ask the user to list criteria you can derive yourself.

---

## Step 5: Present and Validate Criteria

For each card, present its criteria:

> "Extraí os seguintes critérios de aceite para **[Card ID] — [Title]**:
>
> 1. [criterion]
> 2. [criterion]
> ...
>
> Estão corretos? Algum para adicionar, remover ou ajustar?"

**This step loops until the user confirms.** On each round:
- If changes are requested: apply them, rewrite the section in the file, and ask again.
- If confirmed: mark the section `✅ Critérios validados` in the file and move to the next card.

Do not advance to Step 6 until ALL cards have their criteria confirmed.

---

## Step 6: Locate Codebase

If `.darkside/holocrons/tech.md` exists, read it for project structure context and proceed silently.

Otherwise ask:

> "Onde está o código-fonte que devo verificar? Informe o caminho da pasta raiz."

Wait for the answer.

---

## Step 7: Code Verification

For each card and each confirmed criterion:

1. Analyze the criterion to identify what code evidence would prove it is met (UI component, API call, validation logic, data model, test case, etc.).
2. Search the codebase — use grep and glob to find relevant files and patterns. Skip `node_modules`, `.git`, `dist`, `build`, `vendor`.
3. Read identified files and verify the criterion against the actual implementation.
4. Assign a status:
   - ✅ **Completo** — fully implemented as specified
   - ⚠️ **Parcial** — implemented but with divergence, missing parameters, or incomplete behavior
   - ❌ **Ausente** — not implemented

Record the exact `file:line` for every finding. If a criterion cannot be verified through code (e.g., UX animation, infrastructure behavior), note: "Verificação manual necessária."

Write each criterion's result to the report file immediately after verifying it — do not batch.

---

## Step 8: Write Report

After all criteria are verified, finalize the report at `.darkside/verdicts/[filename]`:

```markdown
# Verdict: [Report Name]

**Date:** YYYY-MM-DD
**Branch:** [current git branch, from `git branch --show-current`]
**Source:** [list card IDs and platform]

---

## Legend

| Status | Meaning |
|--------|---------|
| ✅ Completo | Implemented as specified |
| ⚠️ Parcial | Implemented with divergence or incomplete |
| ❌ Ausente | Not implemented |

---

## [Card ID] — [Card Title]

**Card Status:** [status field from card system]

### Acceptance Criteria

| # | Scenario | Status | Observation |
|---|----------|--------|-------------|
| 1 | [criterion] | ✅/⚠️/❌ | [file:line + explanation] |

**Summary [Card ID]:** [1–2 sentences on findings for this card]

---

[...repeat per card...]

---

## Overall Summary

| Card | Complete | Partial | Absent | Total |
|------|----------|---------|--------|-------|
| [Card ID] — [Title] | N | N | N | N |
| **Total** | **N** | **N** | **N** | **N** |

---

## Critical Gaps

### [Theme or Card] — [description of gap]
[Grouped ❌ Ausente and ⚠️ Parcial items with specific divergences]
```

---

## Step 9: Notify

> "Verificação concluída. Relatório salvo em `.darkside/verdicts/[filename]`.
>
> **Resumo:** [N] completos · [N] parciais · [N] ausentes de [Total] critérios."

---

## Report Structure

Created silently after Step 1:

```markdown
⚠️ Verdict in progress — not completed.

# Verdict: <report name>

**Date:** YYYY-MM-DD
**Branch:**
**Source:**

---

## Legend

| Status | Meaning |
|--------|---------|
| ✅ Completo | Implemented as specified |
| ⚠️ Parcial | Implemented with divergence or incomplete |
| ❌ Ausente | Not implemented |
```

---

## Rules

- Read cards before asking about criteria — never ask the user to list criteria you can read yourself
- Record exact `file:line` for every finding — no vague references
- Criteria sections in the report are written live — update each as it is verified
- Do not modify any application source file
- If a Details row has no issues, write "No divergences found"
