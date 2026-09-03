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

- **order66** — Full development orchestration. Reads a mission or war-room plan,
  generates the order (engineer + security), tasks, TDD, code, and review cycle.
  Saves to `.darkside/imperial-orders/`. Creates fallen-order report on repeated
  review failure. Invoke with: `/order66`

- **inquisitor** — Deep code inspection using engineer, security, and tdd agents.
  Accepts a file, folder, PR, or branch. Auto-discovers tests. Produces a report with
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

- **probe-droid** — Non-technical QA notes generator. Scans the current branch, a
  branch given by the user, or the branch related to a card, and turns the diff
  into plain-language test cases (scenario, steps, expected result). Shows the
  notes to the user and, if a related card and a matching MCP integration are
  both present, offers to post the notes as a card comment. Saves to
  `.darkside/probe-droid/YYYY-MM-DD-<name>-qa-notes.md`.
  Invoke with: `/probe-droid`

- **project-master** — Comprehensive deep code evaluation. Uses `tech.md` and sith-agents
  as context, then analyzes the entire codebase across 8 dimensions: code smells, security,
  cognitive complexity, test coverage, duplication, technical debt, documentation, and
  maintainability. Produces a scorecard with overall score and a prioritized report of issues.
  Invoke with: `/project-master`

- **scribe** — Documentation intelligence. Generates, reviews, and maintains
  project documentation for developers, end users, and clients, using the
  actual state of the codebase and Darkside's own knowledge (`tech.md`,
  holomaps, war-room plans, imperial orders, inquisitor reports) as sources.
  Distinguishes implemented behavior from planned-but-not-built behavior,
  reshapes the same knowledge per audience instead of resizing it, and applies
  the Google Developer Documentation Style Guide. Can be invoked at any point,
  not only at the end of the development flow. Saves human-facing documentation
  to `docs/developers/`, `docs/users/`, `docs/clients/`, and its own session
  manifests to `.darkside/scribe/YYYY-MM-DD-<name>-scribe.md`.
  Invoke with: `/scribe`

- **spec-verdict** — Design × Acceptance Criteria verifier. Receives one or more
  Figma design links and acceptance criteria from a task card (Jira, BusinessMap,
  Trello, ClickUp, Asana, Azure Boards) or provided directly. Checks MCP availability
  for the board, extracts the criteria, inspects the Figma designs via Figma MCP, and
  classifies each criterion as ✅ Atendido, ⚠️ Parcial, or ❌ Ausente. Generates a
  coverage report with overall percentage. Saves to
  `.darkside/spec-verdicts/YYYY-MM-DD-<name>-spec-verdict.md`.
  Invoke with: `/spec-verdict`

- **moff** — Project governance in the role of Product Manager. Owns the four things
  no other skill owns: the expectation contract, the backlog and its sync to the
  tracker, the measurement system, and the record of every commitment change.
  Everything else is delegated by name to the skills above — discovery to `/quest`,
  planning to `/war-room`, building to `/order66`, quality to `/verdict` and
  `/inquisitor`. On first run a setup interview declares the **Project Shape**
  (receiver: external client / internal stakeholder / none; executor: solo / small
  team / dedicated roles) and every later step branches on it rather than assuming.
  The charter covers verifiable success criteria with named exclusions, communication
  contract, capacity and governance budget, knowledge sources, gitflow, development flow
  (delivery model, one grouping, one estimation scale, design handoff policy), metrics
  and risks — plus `## 11. Open Decisions`, which keeps an unanswered question from
  looking identical to an answered one. Generates up to three calibrated management
  agents into `.darkside/sith-agents/`. Afterwards runs in four modes: planning
  (grouping, story splitting, executable cards, a derived execution order that puts
  dependencies first and never lets a long-lead card head the queue, then tracker sync
  with read-back reconciliation), execution (a router over the delegated skills), report (one declared
  window — weekly, sprint, monthly, milestone or project-to-date — explaining what each
  card closed in it actually delivered, with metrics trended against dated snapshots and
  a re-scored risk register) and renegotiate
  (position, trades, negotiation log). Git is proposal-only; the tracker is
  operational. Saves to `.darkside/moff/`.
  Invoke with: `/moff`

## Documentation — `docs/`

Human-facing documentation written by `/scribe`. Unlike every other Darkside output, this lives outside `.darkside/` — it's meant to be read by people outside the plugin's workflow, not by Darkside itself.

- `docs/developers/` — developer documentation
- `docs/users/` — end-user documentation
- `docs/clients/` — client and stakeholder documentation

Each populated directory gets a `README.md` index. Only directories actually needed are created.

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
- 💻 `coder-backend.md` — Backend coder: clean implementation, conventions, API design, data layer, service logic
- 🎨 `coder-frontend.md` — Frontend coder: clean implementation, conventions, design system, component architecture, accessibility
- 🔒 `security.md` — Security specialist: OWASP, input validation, auth, secrets
- 🔍 `reviewer.md` — Code reviewer: correctness, consistency, standards enforcement
- 🔬 `debugger.md` — Debug forensics specialist: root cause tracing, causal chain analysis, defect isolation

Management agents generated by `/moff`, calibrated from the governance charter. Also editable via `/sith-agents`.

- 📋 `pm.md` — Product Manager: backlog quality, grouping cuts, story splitting, Definition of Ready
- 📈 `delivery-analyst.md` — Delivery analyst: metrics computed from the tracker and repo, trends, forecast impact
- 🤝 `client-liaison.md` — Client liaison: delivery translated into receiver terms, surprise detection. Only generated when the Project Shape declares a receiver

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

### Spec Verdicts — `.darkside/spec-verdicts/`

Design × Acceptance Criteria coverage reports written by `/spec-verdict`.

- `YYYY-MM-DD-<name>-spec-verdict.md` — acceptance criteria per card + per-item design verification (✅ Atendido / ⚠️ Parcial / ❌ Ausente) + overall coverage percentage + critical gaps

### Probe Droid — `.darkside/probe-droid/`

Non-technical QA notes written by `/probe-droid`.

- `YYYY-MM-DD-<name>-qa-notes.md` — plain-language test cases (scenario + steps + acceptance criteria) grouped by feature/screen, plus the related card ID if detected

### Project Master — `.darkside/project-master/`

Comprehensive code evaluation reports written by `/project-master`.

- `YYYY-MM-DD-<project-name>-project-master.md` — scorecard (8 dimensions, overall score) + engineering, security, and test analysis + critical issues + recommended actions

### Scribe — `.darkside/scribe/`

Internal session manifests written by `/scribe`. Not documentation itself — the finished documentation lives in `docs/` (see above).

- `YYYY-MM-DD-<name>-scribe.md` — audience, scope, mode, sources consulted, evidence model (implemented / documented / planned / inconsistent / unknown), files created/updated, unverifiable information, gaps found

### Moff — `.darkside/moff/`

Project governance documents written by `/moff`.

- `charter.md` — living governance contract, sections 1–11: project shape, success criteria, communication contract, capacity, knowledge sources, gitflow, development flow, metrics, risks, negotiation log, open decisions
- `risk-register.md` — living risk register, re-scored each round with its history preserved
- `YYYY-MM-DD-<name>-backlog.md` — scope summary + declared grouping + stories + executable cards + derived execution order + estimates + tracker sync with read-back reconciliation
- `execution-log.jsonl` — append-only, one line per card executed: dates, waiting days, gate failures, rework rounds. The per-card record the metrics are computed from
- `metrics/YYYY-MM-DD.json` — dated metric snapshot, the basis for trend computation
- `reports/YYYY-MM-DD-<type>.md` — status report over one declared window (`weekly`, `sprint`, `monthly`, `milestone`, `project-to-date`), dated by the window's end: executive summary + delivered vs planned, carrying a three-line explanation of every card closed inside the window + metrics with trend + re-scored risks + suggested adjustments + improvement actions + decisions needed + next meeting agenda
