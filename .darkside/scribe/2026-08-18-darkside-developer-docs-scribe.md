✅ Scribe completed — 18/08/2026 00:00

# Scribe: Darkside project — developer documentation

**Date:** 2026-08-18
**Audience:** developer
**Mode:** create
**Scope:** whole project (the Darkside plugin repository itself)

---

## Sources Consulted

- `.darkside/holocrons/tech.md` (stale — see Evidence Model)
- Every `skills/<name>/SKILL.md` (18 skills, including hidden `forge`)
- `skills/_shared-rules.md`
- `.claude-plugin/plugin.json`, `package.json`, `VERSION`, `.gitignore`
- `install.sh`, `install-remote.sh`, `uninstall.sh`, `scripts/check-update.sh`
- `docs/plans/`, `docs/specs/`, `docs/releases/` (listing + `v1.4.0.md` read in full)
- `CLAUDE.md`, `README.md`, `INSTALL.md`
- `git ls-files docs/plans docs/specs docs/releases`, `git remote -v`

---

## Evidence Model

| Status | Item |
|--------|------|
| Implemented | 18 skills under `skills/`, two independent distribution mechanisms (native plugin manifest + legacy flat-file installers), `.darkside/` storage convention, `docs/` convention (new, added by this session's earlier `/scribe` creation work) |
| Documented | `.darkside/holocrons/tech.md` — describes the project as of an earlier state |
| Inconsistent | `tech.md` lists only 6 skills, 5 sith-agents (actual: 7, with backend/frontend split), and an install method (`claude plugin marketplace add`) not reflected by any file in the repo — trusted the code over `tech.md` per Scribe's rule |
| Inconsistent | `VERSION` (1.2.0) vs `package.json`/`.claude-plugin/plugin.json` (1.3.1) vs `docs/releases/v1.4.0.md` (already published) — documented as a known limitation, not resolved |
| Inconsistent | `uninstall.sh`'s hardcoded skill list (9 entries) vs the 17 registrable skills that exist — documented as a known limitation |
| Unknown | Contents of the Cursor (`darkside-cursor`) and Kimi (`darkside-kimi`) companion repositories — not present in this environment; documented as external and unverified |

Recommendation not acted on (out of `/scribe`'s scope): `tech.md` should be regenerated with `/explore` — it undercounts skills and describes an installation method not present in this repo.

---

## Files Created

- `docs/developers/README.md`
- `docs/developers/architecture.md`
- `docs/developers/creating-and-editing-skills.md`

## Files Updated

- None

## Unverifiable Information

- Cursor/Kimi companion repository structure and current registration state (repos not available locally)

## Gaps Found

- `tech.md` is stale relative to the current `skills/` directory — recommend running `/explore` to regenerate it
- Version markers (`VERSION`, `package.json`, `.claude-plugin/plugin.json`) are inconsistent with each other and with published release notes
- `uninstall.sh` does not clean up 8 of the skills currently installable via `install.sh`/`install-remote.sh`
- `package.json`'s `skills` field lists 10 of 17 registrable skills and isn't read by either installer
