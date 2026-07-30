---
name: probe-droid
description: Escaneia a branch atual, uma branch informada, ou a branch relacionada a um card, e gera casos de teste não-técnicos para QA a partir das mudanças encontradas. Ao final, oferece enviar as notas como comentário no card relacionado, caso exista e haja um MCP de gerenciamento de projeto conectado.
---

# Probe Droid — Non-Technical QA Notes Generator

Scan a branch's changes and translate them into plain-language test cases a QA person can execute without reading code. Follow each step in order. Do not skip steps.

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Step 1: Determine Target Branch

Ask:

> "Qual branch eu devo analisar? Pode informar:
>
> **A.** Nome de uma branch específica
> **B.** Link ou ID de um card (eu acho a branch relacionada)
> **C.** 'Atual' — uso a branch corrente"

Wait for the answer.

- **C or empty:** run `git branch --show-current`.
- **A:** verify the branch exists with `git rev-parse --verify <branch>`. If it doesn't exist, say so and ask again.
- **B:** extract a card ID/key from the input. Search for a matching branch: `git branch -a | grep -i <id>` and recent commit messages (`git log --all --oneline --grep=<id>`). If found, use that branch. If not found, ask:

  > "Não encontrei uma branch relacionada ao card [ID]. Qual branch devo usar?"

  Wait for the answer.

Regardless of how the branch was chosen, scan the branch name and the last 20 commit messages for a ticket-like pattern (e.g., `ABC-123`, `PROJ-456`) to detect a related card. Store the result (card ID or none) silently for Step 6 — skip this scan only if option B already gave you the card.

---

## Step 2: Investigate the Diff

Determine the base branch (`main` or `master`, whichever exists). Run:

- `git diff <base>...<branch> --stat` for the file list
- `git diff <base>...<branch>` for the full diff
- `git log <base>..<branch> --oneline` for commit context

Read enough of the changed files to understand user-facing behavior: new/changed screens, forms, buttons, validations, API responses surfaced to the UI, permissions, error messages, feature flags. Ignore pure refactors, internal utilities, and files with no observable behavior (types, configs, tests) unless they change validation rules or limits a user would notice.

For each change, also determine its **intent** — the underlying requirement or problem it solves. Sources, in order of reliability: the related card's title/description (if one was detected), commit messages, PR/code comments explaining the "why", and only then your own inference from the surrounding code. The diff tells you *what changed and where to look* — it is not the source of truth for what is *correct*. Do not treat "this is what the code currently does" as a fact worth testing on its own.

Do not show the raw diff to the user.

---

## Step 3: Generate Non-Technical QA Notes

For each user-observable change, write one test case using only product language — no function/class/file names, no code snippets, no technical jargon. Each test case has:

- **Scenario** — what is being tested, in plain language
- **Steps** — numbered actions a QA person can literally perform
- **Acceptance Criteria** — the condition(s) that must hold true for the test case to pass

Write acceptance criteria around the **intent** of the change, not around implementation details lifted verbatim from the diff. A test case must be something a QA person could judge as pass/fail without ever having read the code — if the only way to know the "expected" value is to have seen it in the diff, it is not a valid test case. When a visual or copy detail carries business meaning (e.g., an error state, a disabled state, a status indicator), phrase the criterion around that meaning ("the cancelled status must be visually distinguishable from the active status") rather than the exact value ("the label must be red"), unless the card or requirements explicitly mandate that exact value.

Cover, when applicable:
- The main/happy path for each change, judged against its intent
- Edge cases: empty fields, invalid input, boundary values, permission differences
- Regression risk: existing behavior near the change that could break

Group test cases by feature/screen, not by file.

---

## Step 4: Present and Save

Derive the filename from the branch name or feature description (suffix: `-qa-notes.md`). Save to `.darkside/probe-droid/YYYY-MM-DD-<name>-qa-notes.md` using the Report Structure below.

Show the full QA notes to the user in the chat, then say:

> "Notas de QA prontas e salvas em `.darkside/probe-droid/[filename]`."

---

## Step 5: Detect Card and MCP Availability

If no card was detected in Step 1, skip straight to the end of the flow — do not mention comment posting at all.

If a card was detected, identify its platform and check whether a matching MCP is available in the current session:

| Platform | Detection | Required MCP | Comment Format |
|----------|-----------|--------------|-----------------|
| Jira (atlassian.net) | ID/URL pattern or context | `mcp__claude_ai_Atlassian` | Markdown |
| GitHub Issues/Projects | URL contains `github.com` | GitHub MCP | Markdown |
| Businessmap | context or explicit mention | Businessmap MCP | HTML |
| Trello | URL contains `trello.com` | respective MCP if present | Markdown |
| ClickUp | URL contains `clickup.com` | respective MCP if present | Markdown |
| Asana | URL contains `asana.com` | respective MCP if present | HTML |
| Azure Boards | URL contains `dev.azure.com` | respective MCP if present | HTML |
| Linear | URL contains `linear.app` | respective MCP if present | Markdown |

If no MCP matches the detected platform, skip to the end — do not ask about sending.

---

## Step 6: Offer to Send

If a card was detected AND at least one matching MCP is available:

> "Encontrei o card [ID/title] relacionado a essa branch. Quer que eu envie essas notas como comentário nele?"

Wait for the answer. If no: stop here.

If yes and more than one MCP platform matched, ask which one:

> "Você tem mais de uma integração disponível. Para qual plataforma envio: [list]?"

Convert the QA notes into the Comment Format required by the selected platform (see the table in Step 5) before posting — e.g., render as HTML for Businessmap, Asana, or Azure Boards, or keep as Markdown for Jira, GitHub, Trello, ClickUp, or Linear. Then post the converted notes as a comment on the card using the selected MCP. Confirm:

> "Notas enviadas como comentário no card [ID]."

---

## Report Structure

Created after Step 3, before presenting:

```markdown
⚠️ Probe Droid in progress — not completed.

# QA Notes: <feature/branch name>

**Date:** YYYY-MM-DD
**Branch:** <branch>
**Related card:** <card ID or "None detected">

---

## [Screen/Feature Name]

### Test Case 1 — [Scenario]

**Steps:**
1. ...
2. ...

**Acceptance Criteria:** ...

### Test Case 2 — [Scenario]
...

---

[...repeat per screen/feature...]
```

Replace the first line with `✅ Probe Droid completed — DD/MM/YYYY HH:MM` once Step 4 is done.

---

## Rules

- Never use technical terms in the test cases themselves (no file names, function names, HTTP codes, stack traces)
- Never show the raw git diff to the user
- Never write a test case that just restates an implementation detail as if it were a requirement (e.g., an exact color, exact copy, exact spacing) unless it is explicitly mandated by the card or requirements — bias like this makes the notes tautological and useless for catching real bugs
- Only offer to send to a card if both a related card AND a matching MCP were found — otherwise stay silent about it
- Do not invent a card if none was detected or provided
