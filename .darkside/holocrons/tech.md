# Project Tech Overview

## Stack

- **Language:** Markdown (skill files are plain `.md` documents with YAML frontmatter)
- **Runtime:** Claude Code plugin system — no traditional language runtime
- **Plugin format:** `.claude-plugin/plugin.json` + `package.json` declare metadata and skill index
- **Skill loader:** Claude Code reads `skills/<name>/SKILL.md` and exposes each as a `/command`

## Dependencies

- **Production:** None — skills are pure Markdown instructions executed by the LLM
- **Development:** None — no build step, no test runner, no linter
- **Infrastructure:** Claude Code CLI (consumer); `gh` CLI (used at runtime by the `inquisitor` skill for PR diffs)

## Architecture

- **Pattern:** Plugin / skill registry — flat collection of autonomous skill modules
- Each skill is a self-contained instruction document that Claude follows procedurally
- Skills read and write to a shared `.darkside/` directory for persistence across sessions
- Skills can delegate to named "sith-agents" (system prompt files) stored in `.darkside/sith-agents/`
- No shared code between skills — each skill file is fully self-sufficient
- The `explore` skill bootstraps the system by generating `tech.md` (this file) and the 5 sith-agent files

## Folder Structure

```
darkside/
  skills/                    # One subdirectory per skill
    darkside/SKILL.md        # Entry point — shows logo and lists skills
    explore/SKILL.md         # Deep project analysis → holocron + sith-agents
    quest/SKILL.md           # Structured discovery conversation → holomap
    sith-agents/SKILL.md     # Editor for sith-agent system prompts
    order66/SKILL.md         # Full dev lifecycle orchestration
    inquisitor/SKILL.md      # Deep code inspection → verdict report
    guide/SKILL.md           # Help text
  .claude-plugin/
    plugin.json              # Plugin metadata (name, description, version, license)
    marketplace.json         # Marketplace registration metadata
  .darkside/                 # Runtime output — written by skills during sessions
    holocrons/               # Project knowledge files (tech.md)
    holomaps/                # Per-task discovery docs (written by /quest)
    sith-agents/             # Specialist agent system prompts (written by /explore)
    imperial-orders/         # Full dev lifecycle docs (written by /order66)
      fallen-orders/         # Failure reports after 2 rejected reviews
    the-grand-inquisitor/    # Code inspection reports (written by /inquisitor)
  docs/
    specs/                   # Design specs for each skill (one per skill)
    plans/                   # Implementation plans for each skill
  package.json               # npm-style manifest (name, version, skills index)
  CLAUDE.md                  # Project instructions loaded into every Claude session
  README.md                  # Installation and usage guide (Portuguese)
```

## Conventions & Patterns

- **Skill files:** `skills/<skill-name>/SKILL.md` — kebab-case directory, uppercase filename
- **Frontmatter:** every skill has `name` and `description` fields in YAML frontmatter
- **Output files:** all runtime output goes under `.darkside/` — never elsewhere
- **Date prefix:** all generated files use `YYYY-MM-DD-<name>.<ext>` naming
- **Language:** all user-facing messages inside skills are in Brazilian Portuguese
- **Step pattern:** skills are written as numbered sequential steps with explicit "wait for user" gates
- **Agent delegation:** skills read sith-agent `.md` files and instruct Claude to "act as" the agent
- **Silence rule:** file creation steps are done silently unless a step explicitly says to notify the user
- **One question at a time:** conversational skills (quest, order66) ask exactly one question per message

## Config & Infrastructure

- **No environment variables** — the plugin has no runtime environment of its own
- **No Docker, CI/CD, or deployment pipeline** — distributed as a local Claude Code plugin
- **Installation:** `claude plugin marketplace add <path>` + `claude plugin install darkside@darkside`
- **External tool dependency:** `gh` CLI is required only by the `inquisitor` skill for PR inspection; graceful fallback if unavailable
- **Version:** `1.0.0` in both `package.json` and `.claude-plugin/plugin.json`
- **License:** UNLICENSED (private internal tool)
