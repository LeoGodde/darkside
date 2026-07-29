# Darkside Plugin

This plugin provides skills for standardized team development workflows.

## Available Skills

- **darkside** — Entry point. Displays the logo and lists all skills.
  Invoke with: `/darkside`

- **explore** — Deep project analysis. Scans technology, architecture, packages,
  folder structure, and conventions. Saves findings to `.darkside/holocrons/tech.md`
  and generates 6 specialist agent prompts in `.darkside/sith-agents/`.
  Invoke with: `/explore`

- **quest** — Discovery & inception for a product, module, feature, or user story.
  Classifies the level of work (mapped to BABOK Agile Extension planning horizons),
  actively investigates the codebase to pre-fill answers, and runs an adaptive track:
  problem & North Star (OKR/KR), actors & impacts (Impact Mapping), scope
  (É–Não é–Faz–Não faz), alternatives, metrics, risks, increments (sequencer in waves,
  MVP Canvas), and validation by examples. Answers "what and why" and feeds
  `/war-room` (the "how"). Saves to `.darkside/holomaps/YYYY-MM-DD-<name>.md`.
  Invoke with: `/quest`

- **sith-agents** — Edit existing sith-agent system prompts. Lists available agents,
  asks which one to modify and what change to make, confirms, and applies.
  Invoke with: `/sith-agents`

- **order66** — Full development orchestration. Reads a war-room plan, generates
  the order (engineer + security), tasks, TDD, code, and review cycle. Saves to
  `.darkside/imperial-orders/`. Creates fallen-order report on repeated review failure.
  Invoke with: `/order66`

- **inquisitor** — Deep code inspection using engineer, security, and tdd agents.
  Accepts a file, folder, or PR. Auto-discovers tests. Produces a report with
  Engineering, Security, and Test Coverage verdicts plus a Final Judgment level
  (Crítico / Alto Risco / Médio Risco / Baixo Risco).
  Invoke with: `/inquisitor`

- **guide** — Help. Explains all skills and storage structure.
  Invoke with: `/guide`

- **war-room** — Structured engineering discovery for a feature. Covers functional
  understanding (main flow, states, rules, edge cases), technical impact (systems,
  data, APIs, dependencies), and implementation strategy (architecture, order,
  compatibility, security). Uses `tech.md` as context. Saves the plan to
  `.darkside/war-room/YYYY-MM-DD-<plan-name>-plan.md`.
  Invoke with: `/war-room`

- **interrogate** — Interrogates a war-room plan to find weak, vague, or contradictory
  points. Reads the plan and `tech.md`, identifies gaps, and grills the user with
  targeted questions one at a time. Rewrites improved sections directly in the plan file.
  Invoke with: `/interrogate`

- **mission** — Guided brainstorming to understand what needs to be done before
  implementing. Asks structured questions with 3 options (A/B/C) covering problem,
  objective, boundaries, solution direction, execution plan, affected areas, and risks.
  Offers to invoke `/order66` at the end. Saves to
  `.darkside/missions/YYYY-MM-DD-<name>-mission.md`.
  Invoke with: `/mission`

- **verdict** — Acceptance criteria verification. Requests links to task cards (Jira,
  GitHub Projects, Trello, ClickUp, Asana, Azure Boards, or similar), checks MCP
  availability, reads the cards, extracts or derives acceptance criteria, validates them
  with the user, and verifies whether each criterion is met in the codebase. Generates a
  detailed coverage report. Saves to `.darkside/verdicts/YYYY-MM-DD-<name>-verdict.md`.
  Invoke with: `/verdict`

- **visual-fidelity** — Design-to-code fidelity check. Requests a Figma file link,
  uses the Figma MCP to extract design properties screen by screen (colors, typography,
  spacing, border/radius, shadows, components, images), then searches the codebase to
  verify each element. Classifies each item as ✅ Completo, ⚠️ Parcial, or ❌ Ausente,
  and generates a report with a similarity percentage per screen and overall. Saves to
  `.darkside/verdicts/YYYY-MM-DD-<name>-visual-fidelity.md`.
  Invoke with: `/visual-fidelity`

- **hunter** — Bug forensics investigation. Conducts structured debugging through 4
  phases: symptom comprehension (rubber duck interrogation), scope and context (branches,
  environment, recent changes), deep investigation (pure observation, pattern analysis,
  reverse tracing of the causal chain Defect→Infection→Failure, single hypothesis testing
  with circuit breaker), and fix plan with regression test specification. Generates a
  forensic report and offers execution via `/order66`. Saves to
  `.darkside/hunter/YYYY-MM-DD-<name>-hunter.md`.
  Invoke with: `/hunter`

- **design-schematic** — Structured design discovery from a context document. Refines
  ideas using Nielsen, Krug, IDEO and d.school heuristics, and generates three optimized
  Figma Make prompts: Lo-Fi (validate idea and flow), Mid-Fi (validate with suggestions),
  and Hi-Fi (final prototype). Covers accessibility, design system, visual hierarchy,
  responsiveness, and error handling. Saves to
  `.darkside/design-schematic/YYYY-MM-DD-<name>-design-schematic.md`.
  Invoke with: `/design-schematic`

## Storage

### Holocrons — `.darkside/holocrons/`

Knowledge files about the project itself. Written once, updated when the project changes.

- `tech.md` — technology stack, architecture, folder structure and conventions. Written by `/explore`.

### Holomaps — `.darkside/holomaps/`

Discovery documents written by `/quest`. One file per product, module, feature, or story.

- `YYYY-MM-DD-<name>.md` — adaptive discovery: problem, users, value, scope, alternatives, risks, increments, and validation.

### Sith Agents — `.darkside/sith-agents/`

Specialist agent system prompts generated by `/explore`. Fully customized to the project.
Editable via `/sith-agents`.

- 🧪 `tdd.md` — TDD specialist: test strategy, red-green-refactor, coverage
- ⚙️ `engineer.md` — Software engineer: design decisions, trade-offs, architecture fit
- 💻 `coder.md` — Coder: clean implementation, project conventions, naming
- 🔒 `security.md` — Security specialist: OWASP, input validation, auth, secrets
- 🔍 `reviewer.md` — Code reviewer: correctness, consistency, standards enforcement
- 🔬 `debugger.md` — Debug forensics specialist: root cause tracing, causal chain analysis, defect isolation

### Imperial Orders — `.darkside/imperial-orders/`

Full development lifecycle documents written by `/order66`.

- `YYYY-MM-DD-<feature-name>-order.md` — order + tasks for a feature
- `fallen-orders/YYYY-MM-DD-<feature-name>-fallen-order.md` — failure report after 2 rejected reviews

### The Grand Inquisitor — `.darkside/the-grand-inquisitor/`

Deep inspection reports written by `/inquisitor`.

- `YYYY-MM-DD-<target-name>-report.md` — engineering + security + test coverage verdicts and final judgment

### Missions — `.darkside/missions/`

Brainstorming documents written by `/mission`.

- `YYYY-MM-DD-<name>-mission.md` — problem + objective + boundaries + solution + execution plan + risks

### War Room — `.darkside/war-room/`

Engineering discovery plans written by `/war-room`.

- `YYYY-MM-DD-<plan-name>-plan.md` — functional understanding + technical impact + implementation strategy

### Hunter — `.darkside/hunter/`

Bug investigation reports written by `/hunter`.

- `YYYY-MM-DD-<name>-hunter.md` — causal chain (defect → infection → failure) + symptoms + context + investigation + fix plan with regression test specification

### Verdicts — `.darkside/verdicts/`

Acceptance criteria coverage reports written by `/verdict`. Visual fidelity reports written by `/visual-fidelity` are also saved here.

- `YYYY-MM-DD-<name>-verdict.md` — criteria per card + per-item code verification + overall summary + critical gaps
- `YYYY-MM-DD-<name>-visual-fidelity.md` — design properties per screen + per-item code verification + similarity score + critical gaps

### Design Schematic — `.darkside/design-schematic/`

Optimized Figma Make prompts written by `/design-schematic`.

- `YYYY-MM-DD-<name>-design-schematic.md` — context + discovery + design decisions + Lo-Fi, Mid-Fi, Hi-Fi prompts
