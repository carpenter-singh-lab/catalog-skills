# AGENTS.md - catalog-skills

Guidance for agents working **on this repository** (editing the skills themselves).
To work in a catalog that has these skills installed, read the installed skill, not this file.

## What this repo is

An installable collection of agent skills for the vignette-catalog method.
`README.md` is the human entry point and the conceptual reference.
Each skill under `skills/<name>/` is self-contained: a `SKILL.md` plus its own `references/` and (where needed) `scripts/`.
Skills are distributed via the [Agent Skills](https://agentskills.io) standard (`npx skills add carpenter-singh-lab/catalog-skills`).

## Editing rules

- Keep each `SKILL.md` lean: frontmatter (`name`, `description`, `allowed-tools`), the procedure, and pointers into `references/`. Depth goes in `references/`, not the SKILL body.
- A skill must be self-contained. Do not reference a sibling skill's files by relative path - `npx skills add` can install one skill without the others.
- The skills are dataset-agnostic. Anything dataset-specific belongs in a catalog's `catalog.toml` manifest, never hardcoded here. If you find yourself writing "JUMP" or "FinnGen" in a skill, it belongs in the manifest schema instead.
- This collection is the single source of truth. Catalogs install these skills rather than copy-pasting; a change here propagates by version bump, so do not let instance-specific drift back in.

## Conventions

Prose in `.md` files uses semantic line breaks (one sentence per line).
ASCII-only glyphs - hyphens, no em/en-dashes or arrows.
Conventional Commits (`feat:`, `fix:`, `docs:`, ...).
