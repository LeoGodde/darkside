---
name: spec-verdict
description: Verifica se os critérios de aceite de um card ou fornecidos diretamente estão representados em um ou mais designs no Figma — extrai critérios do board (Jira, Trello, BusinessMap ou similar) via MCP ou aceita colagem direta, inspeciona os designs via Figma MCP, classifica cada critério como ✅ Atendido, ⚠️ Parcial ou ❌ Ausente, e gera relatório de cobertura. Use quando quiser validar se um design atende os requisitos antes do desenvolvimento começar.
---

# Spec Verdict — Design × Acceptance Criteria

Verify whether acceptance criteria from a task card (or provided directly) are represented in one or more Figma designs. Inspect the design screen by screen and classify each criterion as ✅ Atendido, ⚠️ Parcial, or ❌ Ausente. Generate a coverage report.

**Follow Shared Rules** from `skills/_shared-rules.md`.

**REQUIRED PREREQUISITE:** Before any `use_figma` call, invoke the `figma:figma-use` skill. Never call `use_figma` without loading it first.

---

## Step 1 — Collect Inputs

Ask in a single message:

> "Informe os links para rodar o `/spec-verdict`:
>
> 1. **Link(s) do Figma** — um ou mais links de design (use "Copy link to selection" no Figma para incluir o `node-id`)
> 2. **Critérios de aceite** — link de um card (Jira, BusinessMap, Trello, ClickUp, Asana, Azure Boards) ou cole os critérios diretamente"

Wait for the answer.

---

## Step 2 — Derive Filename and Create File

Derive the filename from the card title, feature name, or first Figma link title (suffix: `-spec-verdict.md`). Create `.darkside/spec-verdicts/YYYY-MM-DD-<name>-spec-verdict.md` with:

```
⚠️ Spec Verdict in progress — not completed.

# Spec Verdict: <name>

**Date:** YYYY-MM-DD
**Figma:**
**Card / Source:**
```

---

## Step 3 — Extract Acceptance Criteria

**If a board link was provided:**

Identify the platform and check MCP availability:

| Platform | Detection | Required MCP |
|----------|-----------|-------------|
| Jira (atlassian.net) | URL contains `atlassian.net` or `jira` | `mcp__claude_ai_Atlassian` |
| GitHub Projects (github.com) | URL contains `github.com` | GitHub MCP |
| Trello (trello.com) | URL contains `trello.com` | None — manual fallback |
| ClickUp (clickup.com) | URL contains `clickup.com` | None — manual fallback |
| Asana (asana.com) | URL contains `asana.com` | None — manual fallback |
| Azure Boards (dev.azure.com) | URL contains `dev.azure.com` | None — manual fallback |
| BusinessMap / Kanbanize | URL contains `businessmap` or `kanbanize` | None — manual fallback |

**If MCP is available:** read the card and extract all criteria from description, custom fields, comments, and linked documents. If no explicit criteria are found, derive them from the card intent (title, description, context).

**If MCP is not available:**

> "Não encontrei integração MCP para esse board. Cole o conteúdo do card diretamente."

Wait for the pasted content.

**If criteria were provided directly:** use them as-is.

After extraction, list the criteria and ask:

> "Esses são os critérios que vou verificar no design. Estão corretos? Algum para adicionar, remover ou ajustar?"

Wait for confirmation. Loop until confirmed. Write confirmed criteria to the report file before proceeding.

---

## Step 4 — Check Figma MCP Availability

Check if the `use_figma` tool is available in the session.

**If not available**, say:

> "O MCP do Figma não está configurado. Ele é obrigatório para esta skill.
>
> Para instalar, rode o comando abaixo no terminal e reinicie a sessão:
>
> ```
> claude mcp add --transport http https://mcp.figma.com/v1/sse
> ```
>
> Depois rode `/spec-verdict` novamente."

**Stop here.** Do not continue.

**If available:** proceed to Step 5.

---

## Step 5 — Validate Figma Links

Parse each Figma URL to extract the `node-id` query parameter.

A Figma URL looks like:
```
https://www.figma.com/design/<file-key>/<name>?node-id=<NODE_ID>&...
```

Each link must contain exactly one `node-id`. If a link is missing `node-id` or has multiple comma-separated IDs, say:

> "O link abaixo não aponta para uma tela única:
>
> `[invalid URL]`
>
> Por favor, selecione apenas o frame dessa tela no Figma e use "Copy link to selection". Envie o link corrigido."

Wait for corrected links. Loop until all are valid.

---

## Step 6 — Extract Design Inventory from Figma

Load `figma:figma-use` skill, then for each validated Figma link run a `use_figma` call. Fan out in parallel — one call per link in a single message.

For each frame, collect:

- Screens and frames present (names, types)
- UI components and their states (active, disabled, error, empty, loading, success)
- Navigation and flow elements (buttons, links, tabs, breadcrumbs, modals, drawers)
- Form fields, labels, placeholders, helper text, validation messages
- Feedback states (empty state, success confirmation, error message, loading indicator)
- Text content and action labels
- Any flows or prototype connections indicating navigation paths

Group the inventory per screen and write it to the report file before proceeding to Step 7.

---

## Step 7 — Verify Each Criterion Against the Design

For each confirmed acceptance criterion:

1. Analyze what UI element, screen, state, or behavior would represent this criterion in the design.
2. Search the extracted design inventory for matching elements.
3. Classify:

| Status | Meaning |
|--------|---------|
| ✅ Atendido | The design fully represents this criterion — screen, component, or state found |
| ⚠️ Parcial | The design partially represents this criterion — element found but incomplete, unclear, or missing a state |
| ❌ Ausente | The design does not represent this criterion — no screen, component, or state found |

For ⚠️ Parcial and ❌ Ausente, note specifically what is missing (e.g., "Error state not designed", "Success message present but no redirection flow shown", "Field exists but validation feedback not visible").

If a criterion is inherently non-visual (e.g., API response time, backend rule), note: "Verificação no design não aplicável — requer validação técnica."

Write each criterion's result to the report file immediately after verifying it — do not batch.

---

## Step 8 — Generate Report

After all criteria are verified, finalize the report at `.darkside/spec-verdicts/[filename]`:

```markdown
# Spec Verdict: [Report Name]

**Date:** DD/MM/YYYY
**Figma:** [links]
**Card / Source:** [card link or "Provided directly"]

---

## Legend

| Status | Meaning |
|--------|---------|
| ✅ Atendido | Design fully represents this criterion |
| ⚠️ Parcial | Design partially represents this criterion — something missing or unclear |
| ❌ Ausente | Design does not represent this criterion |

---

## Acceptance Criteria Coverage

| # | Criterion | Status | Notes |
|---|-----------|--------|-------|
| 1 | [criterion text] | ✅ Atendido | Screen: [frame name] — [component/state] |
| 2 | [criterion text] | ⚠️ Parcial | Found: [element]. Missing: [what's missing] |
| 3 | [criterion text] | ❌ Ausente | No screen or element found for this criterion |

---

## Summary

| Status | Count |
|--------|-------|
| ✅ Atendido | N |
| ⚠️ Parcial | N |
| ❌ Ausente | N |
| **Total** | **N** |

**Overall coverage: XX%**
*(Atendido × 1.0 + Parcial × 0.5) / Total × 100*

---

## Critical Gaps

### [Criterion theme] — [description of gap]
[Grouped ❌ Ausente and ⚠️ Parcial items with specific missing elements — these must be addressed in the design before development begins]
```

Replace the first line `⚠️ Spec Verdict in progress — not completed.` with `✅ Spec Verdict completed — DD/MM/YYYY HH:MM`.

---

## Step 9 — Notify

> "Verificação concluída. Relatório salvo em `.darkside/spec-verdicts/[filename]`.
>
> **Resultado:** [N] atendidos · [N] parciais · [N] ausentes de [Total] critérios.
> **Cobertura geral: XX%**"

---

## Rules

- Load `figma:figma-use` before every `use_figma` call — never skip this
- Fan out `use_figma` calls in parallel for multi-screen extraction (one call per link in a single message)
- Criteria sections in the report are written live — update each as it is verified
- Do not modify any application source file or Figma file
- Coverage formula: (Atendido × 1.0 + Parcial × 0.5) / Total × 100
- If a criterion is non-visual or backend-only, mark as "Verificação no design não aplicável — requer validação técnica" — do not classify as ❌ Ausente
