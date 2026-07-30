---
name: design-schematic
description: Gera prompts otimizados para o Figma Make em três níveis de fidelidade (Lo-Fi, Mid-Fi, Hi-Fi) a partir de discovery de design estruturado
---

# Design Schematic — Design Prompt Engineering

Conduz um processo de discovery de design a partir de um documento de contexto, refina ideias usando heurísticas consagradas, e gera três prompts otimizados para o Figma Make em níveis de fidelidade progressivos (Lo-Fi, Mid-Fi, Hi-Fi).

**Follow Shared Rules** from `skills/_shared-rules.md`.

---

## Theoretical Foundation

Apply principles from these references throughout the discovery and prompt generation:

**Heuristics & Usability**
- Jakob Nielsen — 10 Usability Heuristics (Nielsen Norman Group)
- Steve Krug — *Don't Make Me Think* (simplicity, self-evidence, scannability)

**Discovery & Design Thinking**
- Jürgen Hehn et al. — *Design Thinking for Software Engineering* (structured requirements elicitation)
- Kim Goodwin — *Designing for the Digital Age* (Goal-Directed Design, structured discovery)
- Teresa Torres — *Continuous Discovery Habits* (discovery questions that feed design)
- IDEO.org — *The Field Guide to Human-Centered Design* (interview, synthesis, ideation, prototyping)

**Interview Frameworks**
- Stanford d.school — Background, Sequence, Physical/Virtual Tour, Stories & Emotions, Follow-up
- Sarah Stein Greenberg — *Creative Acts for Curious People* (structured interview for needs discovery)

**Design Concerns (applied to all prompts)**
- Accessibility (W3C – WAI)
- Design System (if available)
- Visual hierarchy
- User feedback patterns
- Error handling
- Responsiveness

---

## Interaction Pattern

Every question in every step must offer exactly four options:

> **A.** *[Option based on context]*
> **B.** *[Option based on context]*
> **C.** *[Option based on context]*
> **D.** Outro — descreva sua ideia

Options A, B, and C are generated dynamically from the document context and previous answers. Option D always allows the user to provide their own answer when none of the options fit.

One question per message. Wait for the answer before the next question.

---

## Step 1 — Context Insertion

Ask:

> "Compartilhe o documento de contexto do projeto (.docx, .doc ou .md). Pode colar o conteúdo ou enviar o arquivo."

Read and analyze the document. Extract:
- Project domain and purpose
- Target users / personas
- Core flows and features described
- Constraints or requirements mentioned
- Any existing design system references

Create the output file at `.darkside/design-schematic/YYYY-MM-DD-<derived-name>-design-schematic.md`. First line: `⚠️ Design Schematic in progress — not completed.`

Write a `## Context` section summarizing what was extracted.

---

## Step 2 — Discovery Questions

Based on the extracted context, identify what information is missing or ambiguous to generate high-quality Figma Make prompts. Generate dynamic questions — one at a time — to fill those gaps.

Use the theoretical foundation (d.school interview categories, IDEO techniques, Goal-Directed Design, Continuous Discovery) to guide question formulation. Draw from these dimensions as needed — not as a checklist:

- Users, goals, and motivations
- Current experience and pain points
- Core flows and decision points
- Edge cases, error scenarios, empty states
- Information architecture and content hierarchy
- Interaction patterns and user feedback expectations
- Target platform and responsiveness needs
- Existing design system or visual identity
- Accessibility considerations

**Rules:**
- No predefined questions — every question is generated from analysis of the specific document and previous answers
- Every question offers options A, B, C, and D (Outro)
- One question per message
- One follow-up allowed if the answer is ambiguous
- Stop when there is enough information to generate meaningful prompts (minimum 3 questions, maximum 8)

Write each answer to a `## Discovery` section in the file as it arrives.

---

## Step 3 — Idea Refinement

Based on discovery answers, present refinement options grounded in Nielsen/Krug heuristics. For each key design decision identified, offer options A, B, C (at different complexity levels), and D (Outro):

> **A.** *[Simple approach]* — lower complexity, focused on core flow
> **B.** *[Balanced approach]* — moderate complexity, adds supporting elements
> **C.** *[Complete approach]* — higher complexity, comprehensive solution
> **D.** Outro — descreva sua ideia

Each option must reference which heuristic or principle supports it (e.g., "Nielsen H2 — Match between system and the real world" or "Krug — Don't make me think").

Present one design decision at a time. Wait for the answer before the next.

Write decisions to a `## Design Decisions` section in the file.

---

## Step 4 — Context Definition

Synthesize all gathered information into a structured context definition:

- **Project** — name, domain, purpose
- **Users** — who they are, what they need
- **Platform** — target devices, responsiveness requirements
- **Design System** — tokens, components, constraints (or "none")
- **Core Flows** — main user journeys
- **Design Decisions** — chosen approaches from Step 3
- **Constraints** — accessibility, error handling, feedback patterns

Write to a `## Final Context` section in the file.

Present the synthesis to the user:

> "Esse é o contexto consolidado. Está correto ou quer ajustar algo?"

Iterate until confirmed.

---

## Step 5 — Prompt Generation

Generate three Figma Make prompts, each optimized for its fidelity level. All prompts must incorporate:

- Accessibility requirements (W3C WAI)
- Design System references (if available)
- Visual hierarchy principles
- User feedback patterns
- Error states and empty states
- Responsiveness (per platform identified during discovery)

### Lo-Fi Prompt
Purpose: validate idea and flow.
Focus: layout structure, content blocks, navigation flow, basic hierarchy. Wireframe style — no colors, no final typography. Placeholder content.

### Mid-Fi Prompt
Purpose: validate with suggestions.
Focus: refined layout, real content samples, basic color and typography application, interactive states indicated, component identification. Suggests design improvements based on heuristics.

### Hi-Fi Prompt
Purpose: final prototype.
Focus: pixel-perfect design, full Design System application, all states (default, hover, active, disabled, error, empty, loading), micro-interactions described, accessibility annotations, responsive breakpoints.

Write all three prompts to a `## Prompts` section in the file, under subsections `### Lo-Fi`, `### Mid-Fi`, `### Hi-Fi`.

Display all three prompts in the chat.

---

## Step 6 — Confirmation

Ask:

> "Os prompts estão prontos. Deseja ajustar alguma coisa ou posso finalizar?"

If adjustments are needed, iterate. When confirmed:

- Replace the first line of the file with: `✅ Design Schematic completed — DD/MM/YYYY HH:MM`
- Display the final prompts once more in the chat

Say:

> "Design Schematic finalizado. Relatório salvo em `.darkside/design-schematic/YYYY-MM-DD-<name>-design-schematic.md`."
