# Darkside — Developer Documentation

Darkside is a Claude Code plugin: a flat collection of skills — plain Markdown instruction files — that Claude follows procedurally to run standardized team development workflows (discovery, planning, TDD orchestration, code review, documentation, and more).

This directory documents Darkside **for people who maintain, extend, or contribute to the plugin itself** — not for people who use its skills inside their own projects. If you're looking for what each skill does and how to invoke it, see the root [`README.md`](../../README.md) or run `/guide` inside Claude Code.

## Start here

- **[Architecture](architecture.md)** — what Darkside is made of, how it's distributed, how state is stored, and its known limitations
- **[Creating and Editing Skills](creating-and-editing-skills.md)** — the conventions every skill follows and the steps to add or change one

## Quick start for contributors

Darkside has no build step, no dependencies, and no test runner — it's Markdown, executed by Claude.

1. Clone the repository.
2. To try your changes as a real plugin, either:
   - Register the local clone as a plugin source in Claude Code and load `darkside` from it, or
   - Run `bash install.sh` from the repo root — it copies each skill's `SKILL.md` into `~/.claude/commands/` (see [Architecture](architecture.md#distribution-two-mechanisms) for what this second path does and does not carry over).
3. Open Claude Code in any project and run `/darkside` to confirm your version loaded.
4. Make your change, reload, and re-test the affected skill(s) directly.

There's nothing to compile and nothing to lint — verification is running the skill and checking its output against what its `SKILL.md` promises.
