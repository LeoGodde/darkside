# darkside

Internal Claude Code plugin — standardized development workflows for the team.

## Installation

```bash
claude plugin install <repo-url>
```

After installation, the skills are available in every Claude Code session.

## Skills

### `/explore`

Deep analysis of any project. Scans technology stack, architecture, packages,
folder structure, and code conventions.

**Output:** `.darkside/holocrons/tech.md` — a structured knowledge file used
by subsequent darkside skills and available for manual review.

**Usage:** Type `/explore` in Claude Code.

## Holocrons

Holocrons are knowledge files stored in `.darkside/holocrons/` at the root of each project.
They are created by darkside skills and serve as persistent context for future operations.

| File | Created by | Content |
|------|-----------|---------|
| `tech.md` | `/explore` | Technology stack, architecture, folder structure, conventions |

## Contributing

Add new skills under `skills/<skill-name>/SKILL.md`.
Update `CLAUDE.md` to list the new skill.
Bump the version in `package.json` and `.claude-plugin/plugin.json`.
