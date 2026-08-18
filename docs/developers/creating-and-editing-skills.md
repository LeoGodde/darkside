# Creating and Editing Skills

This is the contract every skill in `skills/` follows. Read it before adding a new skill or changing an existing one — consistency across skills is what lets someone jump from `/order66` to `/inquisitor` to `/scribe` without relearning the interaction model each time.

## Use `/forge` first

`skills/forge/SKILL.md` is the meta-skill that creates and edits Darkside skills — it asks what the skill should do, drafts it, and generates the Claude Code, Cursor, and Kimi versions together. Run `/forge` for the actual work; read the rest of this document to understand what it's enforcing and why, or when you need to make a manual edit it doesn't cover.

`forge` is intentionally not listed in `/darkside` or `/guide` — it's a tool for skill authors, not a workflow skill.

## Anatomy of a skill

Every skill lives at `skills/<skill-name>/SKILL.md` — kebab-case directory, uppercase filename.

**Frontmatter** — exactly two fields, both required:

```yaml
---
name: <skill-name>
description: <one-line description in Brazilian Portuguese — used for skill discovery>
---
```

**Header** — a title, one paragraph describing what the skill does and when to use it, and a reference to the shared conventions:

```markdown
# <Skill Title> — <Short subtitle>

<One paragraph.>

**Follow Shared Rules** from `skills/_shared-rules.md`.
```

**Body** — numbered, titled steps (`## Step 1 — <Name>`), each with a clear action and a clear output. Steps are never skipped or reordered; a skill that needs conditional branches (like `/order66`'s CLI delegation) still numbers every phase and states the skip condition explicitly rather than omitting the step.

## Shared rules

`skills/_shared-rules.md` is the one file every skill is allowed to depend on. It covers:

- **Language** — every message to the user is Brazilian Portuguese; every generated file is English. This split is absolute — it applies to `/scribe`'s own manifests and to the documentation it writes in `docs/`.
- **Interaction** — one question per message, never two; wait for the answer; one clarifying follow-up is allowed if the answer is ambiguous; discovery-style skills (`quest`, `war-room`, `interrogate`) never propose code.
- **Document lifecycle** — a skill that writes a file creates it silently after the first meaningful input, opens with `⚠️ <Skill> in progress — not completed.`, writes each section as it's finalized (never batches the whole file at the end), and replaces the first line with `✅ <Skill> completed — DD/MM/YYYY HH:MM` on completion.
- **Filename derivation** — lowercase, strip accents, spaces to `-`, strip non-alphanumeric except `-`, collapse repeated `-`, prepend `YYYY-MM-DD-`, append the suffix the skill defines (`-plan.md`, `-order.md`, `-scribe.md`, and so on).
- **Prerequisite check** — the standard pattern for a skill that requires another skill's output to exist first (see below).

## Storage convention

Every skill writes to its own subdirectory of `.darkside/`, project-local (not inside the plugin repo):

| Skill | Output directory |
|-------|-------------------|
| `explore` | `.darkside/holocrons/` |
| `quest` | `.darkside/holomaps/` |
| `war-room` | `.darkside/war-room/` |
| `mission` | `.darkside/missions/` |
| `order66` | `.darkside/imperial-orders/` |
| `inquisitor` | `.darkside/the-grand-inquisitor/` |
| `hunter` | `.darkside/hunter/` |
| `verdict`, `visual-fidelity` | `.darkside/verdicts/` |
| `spec-verdict` | `.darkside/spec-verdicts/` |
| `design-schematic` | `.darkside/design-schematic/` |
| `probe-droid` | `.darkside/probe-droid/` |
| `scribe` (internal manifests only) | `.darkside/scribe/` |
| New skills | `.darkside/<skill-name>/`, unless the skill has a specific reason to do otherwise |

`/scribe` is the single exception to "everything stays under `.darkside/`": its finished, human-facing documentation goes to `docs/<audience>/`, while its own session manifests still follow the standard convention at `.darkside/scribe/`.

**Prerequisite check pattern** — when a skill needs another skill's output to already exist:

```markdown
## Prerequisite

Check prerequisite `.darkside/holocrons/tech.md`. If missing:

> "O tech.md não foi encontrado. Rode `/explore` primeiro para mapear o projeto."
```

If it exists, read it in full and use it as context for the rest of the session — don't re-derive what it already answers.

## Interaction pattern

- One question per message, never combined.
- Present options as **A.** / **B.** / **C.** when there's a concrete, enumerable choice; ask an open question when only the user has the answer (e.g., a business rule that isn't in the code).
- One follow-up is allowed if an answer is ambiguous — don't turn it into an interrogation.
- Silence is the default for file writes: create and update files without narrating the write itself, and speak up only where the skill's steps say to notify.

## Registration checklist

A skill meant for everyday use must be registered in four places, each with the same one-line description (in Brazilian Portuguese):

- [ ] `skills/darkside/SKILL.md` — the skill table shown by `/darkside`
- [ ] `skills/guide/SKILL.md` — the detailed entry shown by `/guide`, plus the recommended-flow diagram and storage table if the skill produces files
- [ ] `CLAUDE.md` — the `## Available Skills` bullet list and, if it writes files, a `## Storage` entry
- [ ] `README.md` — the skill table, recommended-flow diagram, and storage table

Skills meant to stay internal (like `forge`) are deliberately left out of all four — don't register them by default.

## Multi-file skills

A skill can define supporting files beyond `SKILL.md` — for example, `skills/scribe/references/*.md` holds editorial depth `/scribe` doesn't need loaded on every run. Two rules follow directly from [the distribution limitation](architecture.md#known-limitations):

1. **`SKILL.md` must be correct on its own.** Don't put anything load-bearing exclusively in a supporting file — the legacy installers never copy it. Put the minimum a correct run requires directly in `SKILL.md`, and use supporting files only to add depth, not to hold information the skill can't function without.
2. **Reference supporting files by relative path** (e.g., `references/google-style.md`) and describe them as optional depth, not a hard dependency — a skill that fails when it can't find its own `references/` folder is a skill that's broken under the legacy install path.

## Releasing a change

Release notes live in `docs/releases/vX.Y.Z.md`, one file per version, written in Brazilian Portuguese, organized by the skill(s) the release touches. There's no automation tying this to `VERSION`, `package.json`, or `.claude-plugin/plugin.json` — bump those explicitly and keep them in sync (see [Known Limitations](architecture.md#known-limitations) for the current state, which they aren't).
