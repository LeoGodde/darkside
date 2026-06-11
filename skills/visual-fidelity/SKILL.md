---
name: visual-fidelity
description: Verifica a fidelidade visual entre um design no Figma e a implementação no código — inspeciona botões, fontes, cores, espaçamentos, imagens, posicionamentos e telas via MCP do Figma, varre o código e gera relatório com percentual de similaridade por tela. Use quando quiser auditar a aderência de uma implementação front-end a um design no Figma.
---

# Visual Fidelity — Design vs. Code Verification

Verify whether the UI implementation matches the Figma design. Inspect design properties item by item, verify them in the codebase, and produce a fidelity report per screen with an overall similarity score.

**Follow Shared Rules** from `skills/_shared-rules.md`.

**REQUIRED PREREQUISITE:** Before any `use_figma` call, invoke the `figma:figma-use` skill. Never call `use_figma` without loading it first.

---

## Step 1: Check Figma MCP Availability

**Before anything else**, check if the `use_figma` tool is available in the session.

**If available:** proceed to Step 2.

**If not available**, say immediately:

> "O MCP do Figma não está configurado. Ele é obrigatório para esta skill.
>
> Para instalar, rode o comando abaixo no terminal e reinicie a sessão:
>
> ```
> claude mcp add --transport http https://mcp.figma.com/v1/sse
> ```
>
> Depois rode `/visual-fidelity` novamente."

**Stop here.** Do not continue.

---

## Step 2: Collect Figma Links

Ask:

> "Informe o link de uma ou mais telas do Figma.
>
> Cada link deve apontar para uma tela específica — use o botão "Copy link to selection" no Figma para garantir que o `node-id` está presente na URL."

Wait for the answer. The user may provide one or multiple links (one per line or separated by spaces).

---

## Step 3: Validate Links — One Frame Per Link

**Parse each URL** to extract the `node-id` query parameter.

A Figma URL looks like:
```
https://www.figma.com/design/<file-key>/<name>?node-id=<NODE_ID>&...
```

**Validation rule:** Each link must contain exactly one `node-id` value. A `node-id` with a single ID (e.g. `335-4205`) is valid. If a URL contains multiple comma-separated node IDs in `node-id` (e.g. `node-id=335-4205,172-2041`) or is missing `node-id` entirely, it is invalid.

**Load `figma:figma-use` skill**, then for each provided link run a silent inspection to confirm the node-id resolves to a single top-level frame:

```js
const node = await figma.getNodeByIdAsync('NODE_ID_HERE');
if (!node) return { valid: false, reason: 'Node not found' };
return {
  valid: true,
  id: node.id,
  name: node.name,
  type: node.type,
  width: node.width,
  height: node.height
};
```

**If all links are valid:** collect them as the **screen list** (each link = one screen). Derive a report name from the first frame name (suffix: `-visual-fidelity.md`). Silently create `.darkside/verdicts/` and the report file with empty sections (see Report Structure). Proceed to Step 4.

**If any link is invalid** (node not found, multiple node-ids, or no node-id), say:

> "O link abaixo não aponta para uma tela única:
>
> `[invalid URL]`
>
> Por favor, abra a tela no Figma, selecione apenas o frame dessa tela e use "Copy link to selection". Envie o link corrigido."

Wait for the corrected link before continuing. Loop until all links are valid.

---

## Step 4: Extract Design Properties Per Screen

For each validated screen (node-id from the provided link), run a **parallel fan-out** — one `use_figma` call per screen in a single message. Each call fetches the frame directly by its node-id:

```js
// Replace NODE_ID with the node-id extracted from the URL (e.g. '335-4205')
const frame = await figma.getNodeByIdAsync('NODE_ID');
if (!frame) return { error: 'Node not found' };

function extractNode(node) {
  const data = {
    id: node.id,
    name: node.name,
    type: node.type,
    width: node.width,
    height: node.height,
  };

  // Colors & fills
  if (node.fills && node.fills.length > 0) {
    data.fills = node.fills.map(f => ({
      type: f.type,
      color: f.color ? { r: f.color.r, g: f.color.g, b: f.color.b, a: f.opacity ?? 1 } : null,
      opacity: f.opacity
    }));
  }

  // Strokes
  if (node.strokes && node.strokes.length > 0) {
    data.strokes = node.strokes.map(s => ({
      type: s.type,
      color: s.color ? { r: s.color.r, g: s.color.g, b: s.color.b } : null
    }));
    data.strokeWeight = node.strokeWeight;
  }

  // Typography
  if (node.type === 'TEXT') {
    data.fontFamily = node.fontName?.family;
    data.fontStyle = node.fontName?.style;
    data.fontSize = node.fontSize;
    data.lineHeight = node.lineHeight;
    data.letterSpacing = node.letterSpacing;
    data.textAlignHorizontal = node.textAlignHorizontal;
    data.textContent = node.characters?.substring(0, 80);
  }

  // Corner radius
  if (node.cornerRadius !== undefined) data.cornerRadius = node.cornerRadius;

  // Auto-layout / spacing
  if (node.layoutMode && node.layoutMode !== 'NONE') {
    data.layoutMode = node.layoutMode;
    data.itemSpacing = node.itemSpacing;
    data.paddingTop = node.paddingTop;
    data.paddingBottom = node.paddingBottom;
    data.paddingLeft = node.paddingLeft;
    data.paddingRight = node.paddingRight;
    data.primaryAxisAlignItems = node.primaryAxisAlignItems;
    data.counterAxisAlignItems = node.counterAxisAlignItems;
  }

  // Effects (shadows, blurs)
  if (node.effects && node.effects.length > 0) {
    data.effects = node.effects.map(e => ({
      type: e.type,
      color: e.color,
      offset: e.offset,
      radius: e.radius
    }));
  }

  // Component / instance
  if (node.type === 'INSTANCE') {
    data.componentName = node.mainComponent?.name;
  }

  return data;
}

// Collect up to 3 levels deep to avoid token bloat
function collectTree(node, depth = 0) {
  if (depth > 3) return null;
  const entry = extractNode(node);
  if (node.children && node.children.length > 0) {
    entry.children = node.children.map(c => collectTree(c, depth + 1)).filter(Boolean);
  }
  return entry;
}

return collectTree(frame);
```

After collecting, group the extracted properties into categories:

| Category | What to capture |
|----------|----------------|
| **Typography** | font family, weight/style, size, line height, letter spacing, text align |
| **Colors** | background fills, text fills, stroke colors (as hex or rgba) |
| **Spacing & Layout** | padding, gap/item spacing, layout direction, alignment |
| **Sizing** | width, height (fixed vs. fill vs. hug) |
| **Border & Radius** | corner radius, stroke weight |
| **Shadows & Effects** | drop shadow, blur, inner shadow |
| **Components** | component names, variants used |
| **Images & Assets** | nodes with IMAGE fills (reference by name) |

Record the extracted properties in the report file under each screen's section before proceeding.

---

## Step 5: Present and Validate Design Inventory

For each screen, present a summary of extracted properties:

> "Extraí os seguintes elementos de design para a tela **[Screen Name]**:
>
> **Tipografia:** [font families, sizes found]
> **Cores:** [main colors found]
> **Componentes:** [component names]
> **Espaçamentos:** [key spacing values]
> ...
>
> Está correto? Há elementos específicos para adicionar ou excluir da verificação?"

**This step loops until the user confirms.** On each round:
- If changes are requested: update the inventory in the file and ask again.
- If confirmed: mark the section `✅ Inventário validado` and move to the next screen.

Do not advance to Step 6 until ALL screens have their inventory confirmed.

---

## Step 6: Locate Codebase

If `.darkside/holocrons/tech.md` exists, read it for project structure context and proceed silently.

Otherwise ask:

> "Onde está o código-fonte front-end que devo verificar? Informe o caminho da pasta raiz."

Wait for the answer.

---

## Step 7: Code Verification Per Screen

For each screen and each design property category, search the codebase systematically.

**Search strategy by category:**

| Category | Where to look | What to match |
|----------|--------------|---------------|
| **Typography** | CSS/SCSS/styled-components/Tailwind config/theme files, component files | `font-family`, `font-size`, `font-weight`, `line-height`, `letter-spacing` |
| **Colors** | Theme files, design token files, CSS variables, Tailwind config, component styles | Hex values, CSS variables, token names |
| **Spacing & Layout** | Component styles, layout files, Tailwind classes | `padding`, `margin`, `gap`, `flex`, `grid` values |
| **Sizing** | Component files, CSS | `width`, `height`, `min-width`, `max-width` |
| **Border & Radius** | Component styles | `border-radius`, `border-width`, `border-color` |
| **Shadows & Effects** | Theme files, CSS | `box-shadow`, `filter: blur`, `drop-shadow` |
| **Components** | `src/components/`, `src/ui/`, similar directories | File names matching component names |
| **Images & Assets** | `src/assets/`, `public/`, `static/` | File names, import statements, `src` attributes |

Skip `node_modules`, `.git`, `dist`, `build`, `vendor`, `.next`, `.nuxt`.

**For each design property:**

1. Identify the expected value from the Figma extraction (e.g., `font-size: 16px`, `color: #1A1A2E`).
2. Search the codebase for the implementation.
3. Compare Figma spec vs. code value.
4. Assign a status:
   - ✅ **Completo** — matches the Figma spec (exact or within 2px/2% tolerance for spacing)
   - ⚠️ **Parcial** — implemented but with divergence (different value, missing state, approximate match)
   - ❌ **Ausente** — not implemented or not found in the codebase

Record exact `file:line` for every finding. If a property cannot be verified through code (e.g., animation easing, hover state), note: "Verificação manual necessária."

Write each category result to the report file immediately — do not batch.

**Color normalization:** Convert all colors to hex for comparison:
- Figma RGB (0–1) → hex: `#RRGGBB`
- CSS `rgba(255, 255, 255, 1)` → `#FFFFFF`
- Tailwind/token names: look up resolved value in theme config

---

## Step 8: Calculate Similarity Score

After all properties are verified for a screen:

```
Screen Similarity = (Complete × 1.0 + Partial × 0.5) / Total × 100
```

Round to the nearest whole number.

**Weight categories by visual impact:**

| Category | Weight |
|----------|--------|
| Colors | 25% |
| Typography | 25% |
| Components | 20% |
| Spacing & Layout | 15% |
| Border & Radius | 5% |
| Shadows & Effects | 5% |
| Images & Assets | 5% |

Apply weighted scoring only if it results in a meaningfully different score than simple averaging; otherwise use simple averaging.

Overall similarity = average across all screens (equal weight per screen, unless the user specifies otherwise).

---

## Step 9: Write Report

After all screens are verified, finalize the report at `.darkside/verdicts/[filename]`:

```markdown
# Visual Fidelity: [Report Name]

**Date:** YYYY-MM-DD
**Branch:** [current git branch]
**Figma Source:** [file name / URL fragment]
**Screens audited:** [N]

---

## Legend

| Status | Meaning |
|--------|---------|
| ✅ Completo | Matches Figma spec (within tolerance) |
| ⚠️ Parcial | Implemented with divergence |
| ❌ Ausente | Not implemented |

---

## Screen: [Screen Name]

**Overall Similarity: XX%**

### Typography

| Element | Figma Spec | Code Value | Status | File:Line |
|---------|-----------|-----------|--------|-----------|
| Heading font | Inter Bold 32px | Inter Bold 32px | ✅ | src/components/Hero.tsx:14 |
| Body text | Inter Regular 16px / 24px lh | Inter Regular 16px / 1.5 | ⚠️ | src/styles/global.css:22 |

### Colors

| Element | Figma Value | Code Value | Status | File:Line |
|---------|------------|-----------|--------|-----------|
| Primary background | #1A1A2E | #1a1a2e | ✅ | src/theme/colors.ts:3 |
| CTA button fill | #E94560 | — | ❌ | — |

### Spacing & Layout

| Element | Figma Spec | Code Value | Status | File:Line |
|---------|-----------|-----------|--------|-----------|
| Card padding | 24px all sides | p-6 (24px) | ✅ | src/components/Card.tsx:8 |
| Section gap | 48px | gap-10 (40px) | ⚠️ | src/layouts/Section.tsx:12 |

### Sizing

| Element | Figma Spec | Code Value | Status | File:Line |
|---------|-----------|-----------|--------|-----------|

### Border & Radius

| Element | Figma Spec | Code Value | Status | File:Line |
|---------|-----------|-----------|--------|-----------|

### Shadows & Effects

| Element | Figma Spec | Code Value | Status | File:Line |
|---------|-----------|-----------|--------|-----------|

### Components

| Component | Figma Name | Code Location | Status | Notes |
|-----------|-----------|--------------|--------|-------|

### Images & Assets

| Asset | Figma Reference | Code Location | Status | Notes |
|-------|----------------|--------------|--------|-------|

**Screen Summary:** [1–2 sentences on the main findings for this screen]

---

[...repeat per screen...]

---

## Overall Summary

| Screen | Elements | ✅ Complete | ⚠️ Partial | ❌ Absent | Similarity |
|--------|----------|------------|-----------|----------|-----------|
| [Screen Name] | N | N | N | N | XX% |
| **Total** | **N** | **N** | **N** | **N** | **XX%** |

---

## Critical Gaps

### [Screen / Category] — [description of gap]
[Grouped ❌ Ausente and ⚠️ Parcial items with specific divergences and their visual impact]
```

---

## Step 10: Notify

> "Análise de fidelidade visual concluída. Relatório salvo em `.darkside/verdicts/[filename]`.
>
> **Resultado geral: [XX]% de similaridade** — [N] completos · [N] parciais · [N] ausentes de [Total] elementos em [N] tela(s)."

---

## Report Structure

Created silently after Step 1:

```markdown
⚠️ Visual Fidelity in progress — not completed.

# Visual Fidelity: <report name>

**Date:** YYYY-MM-DD
**Branch:**
**Figma Source:**
**Screens audited:**

---

## Legend

| Status | Meaning |
|--------|---------|
| ✅ Completo | Matches Figma spec (within tolerance) |
| ⚠️ Parcial | Implemented with divergence |
| ❌ Ausente | Not implemented |
```

---

## Rules

- Load `figma:figma-use` before every `use_figma` call — never skip this
- Fan out `use_figma` calls in parallel for multi-screen extraction (one call per screen/page in a single message)
- Record exact `file:line` for every finding — no vague references
- Convert all colors to hex before comparing
- Tolerance: ±2px for spacing/sizing, exact match for colors and font names
- Do not modify any application source file or Figma file
- Screen sections in the report are written live — update each as it is verified
- If a property cannot be verified through code, mark "Verificação manual necessária" — do not guess
- If Figma returns token/variable references instead of raw values, resolve them by inspecting the variable collection before reporting
