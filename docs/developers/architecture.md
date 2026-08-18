# Architecture

## What Darkside is

Darkside is a plugin/skill registry for Claude Code. It has no application code, no server, and no traditional runtime — each skill is a self-contained Markdown instruction document with YAML frontmatter, and Claude executes it procedurally when the user types the matching `/command`. There's no shared code between skills; each `SKILL.md` is fully self-sufficient and may only reference `skills/_shared-rules.md` for conventions common to all of them.

## Plugin anatomy

```
darkside/
  .claude-plugin/
    plugin.json           # native plugin manifest — name, description, version, license
  skills/
    _shared-rules.md       # conventions referenced by every skill
    <skill-name>/
      SKILL.md              # the skill itself — frontmatter + procedural instructions
      references/           # optional — supporting material a skill loads on demand (see Known Limitations)
  scripts/
    check-update.sh        # daily update check, installed alongside the legacy distribution path
  docs/
    developers/             # this documentation
    plans/, specs/          # internal design history — one plan/spec per skill, written when it was built
    releases/                # release notes, one file per version
  install.sh                 # local installer — legacy distribution path
  install-remote.sh          # curl-based installer — legacy distribution path
  uninstall.sh                # removes the legacy-installed commands
  package.json                # npm-style manifest — name, version, partial skill index
  VERSION                     # plain-text version marker read by the update checker
  CLAUDE.md                   # project instructions loaded into every Claude Code session in this repo
  README.md                   # installation and usage guide (Portuguese)
```

Skills read and write to a project-local `.darkside/` directory for persistence across sessions, and — since `/scribe` — to a project-local `docs/` directory for documentation meant for humans. See [Storage model](#storage-model).

## No runtime, no dependencies

- **Language:** Markdown. Skill files are plain-text instructions, not source code in the traditional sense.
- **Build step:** none.
- **Test runner, linter:** none — `package.json` declares no `dependencies` or `devDependencies`.
- **External tool dependencies at skill runtime:** the `gh` CLI, used only by `/inquisitor` for PR-mode diffs (with a manual-paste fallback if it's unavailable), and optional MCP servers (Figma, Atlassian, and similar) used by the skills that integrate with those platforms.

## Distribution: two mechanisms

Darkside ships through two independent paths, and they don't carry the same files.

**Native plugin manifest** — `.claude-plugin/plugin.json` declares the plugin's identity (name, description, version, license). When Claude Code loads Darkside as a native plugin from this repository, it can discover the full `skills/<name>/` directory structure, including any subdirectories a skill defines (like a `references/` folder).

**Legacy flat-file installers** — `install.sh` and `install-remote.sh` (the curl-based variant, downloading a tagged GitHub release) both iterate `skills/*/` and copy **only** each skill's `SKILL.md` into `~/.claude/commands/<name>.md`, rewriting the `name:` frontmatter field to match. `guide` is installed as `darkside-guide` to avoid colliding with another plugin's `/guide`. `uninstall.sh` removes that fixed list of flat files. This path also installs `scripts/check-update.sh` to `~/.darkside/check-update.sh` and registers it as a `UserPromptSubmit` hook in `~/.claude/settings.json`, so an update check runs at most once per day and writes `~/.darkside/.update-available` when a newer GitHub release exists — `/darkside` reads and clears that sentinel to show the update banner.

See [Known Limitations](#known-limitations) for what this second path drops.

## Storage model

| Location | Written by | Contains |
|----------|-----------|----------|
| `.darkside/` (project-local) | every skill | Darkside's own internal knowledge and artifacts — holocrons, holomaps, plans, orders, reports, manifests |
| `docs/` (project-local) | `/scribe` only | documentation meant for humans outside the plugin's workflow — developers, users, clients |

Every other skill writes exclusively under `.darkside/<skill-name>/` (or a shared subdirectory, e.g. `/verdict` and `/visual-fidelity` both use `.darkside/verdicts/`). `/scribe` is the only skill that writes outside `.darkside/`, and it also keeps its own internal session manifests under `.darkside/scribe/` — never inside `docs/`.

This same distinction applies one level up, inside this repository: `docs/plans/` and `docs/specs/` hold the *design history of Darkside itself* (one plan and one spec per skill, written while building it) — they predate `/scribe` and are not part of its output.

## Update mechanism

Versioning is a plain `VERSION` file at the repo root, copied to `~/.darkside/VERSION` by whichever installer ran. `scripts/check-update.sh` compares it against the latest GitHub release tag once a day and writes a sentinel file when they differ; `/darkside` displays and clears that sentinel on the next invocation.

## Known limitations

These are verified, current gaps — not proposals.

- **The legacy installers drop non-`SKILL.md` files.** `install.sh` and `install-remote.sh` copy only `skills/<name>/SKILL.md`. A skill that ships supporting files alongside it — for example `skills/scribe/references/*.md`, or `skills/spec-verdict/PROMPT.md` — will not have those files present after a legacy install; only native plugin-directory loading carries the full skill folder. `SKILL.md` files that depend on such files should stay correct without them (see [Creating and Editing Skills](creating-and-editing-skills.md#multi-file-skills)).
- **Version markers are out of sync.** At the time of writing, `VERSION` reads `1.2.0` while `package.json` and `.claude-plugin/plugin.json` both read `1.3.1`, and `docs/releases/v1.4.0.md` already documents a released version neither file reflects. Don't treat any single one of these as the authoritative "current version" without cross-checking the others.
- **`package.json`'s `skills` field is a partial, stale index.** It lists 10 of the skills present in `skills/` and isn't read by either installer (both iterate the `skills/` directory directly) — it's descriptive only, and currently incomplete.
- **`.claude-plugin/marketplace.json` is gitignored.** It isn't part of the versioned repository; don't assume it exists in a fresh clone.
- **`uninstall.sh` has a stale, hardcoded skill list.** It removes a fixed set of nine names (`darkside explore quest sith-agents order66 inquisitor war-room interrogate darkside-guide`) instead of iterating `skills/*/` the way the installers do. Running it currently leaves every skill added since — `mission`, `verdict`, `visual-fidelity`, `hunter`, `design-schematic`, `probe-droid`, `spec-verdict`, `scribe` — installed in `~/.claude/commands/`.
- **Cursor and Kimi companion repositories are external.** `skills/forge/SKILL.md` describes generating and registering equivalent skills in `darkside-cursor` and `darkside-kimi`, two separate repositories — neither is part of this repository, and neither was available to verify at the time this documentation was written.

## See also

- `docs/specs/` — one design spec per skill, written before implementation
- `docs/plans/` — one implementation plan per skill
- `docs/releases/` — release notes, one file per version
