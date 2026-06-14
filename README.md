# catalog-skills

Installable agent skills for building and working in **vignette catalogs** - the lab's method for agent-driven data analysis.

A vignette catalog is a small, curated set of runnable [marimo](https://marimo.io) notebooks for one dataset, plus the skills in this repo that let an agent compose new analyses from them.
Each notebook is both a worked demonstration and a source of pure `@app.function` helpers that later notebooks import and reuse.
Given a question, a human and an agent pick relevant notebooks, import their helpers, compose them in a live kernel, and produce a self-contained, re-runnable notebook that answers it.

This is a general pattern for doing data analysis.
It works at one notebook and scales to many; scaling up is optional.
Four catalogs run today on this pattern: [jx](https://github.com/broadinstitute/jx) (JUMP Cell Painting), [fgx](https://github.com/broadinstitute/fgx) (FinnGen genetics), [prx](https://github.com/broadinstitute/prx) (PROSPECT chemical-genetics), [dmx](https://github.com/broadinstitute/dmx) (DepMap).

> This repo is the successor to the lab's old `workflows.md` (Cookiecutter Data Science + Snakemake/S3 pipeline SOP).
> Catalog-composition is now the default way we do data analysis.
> The heavy pipeline machinery still exists but is no longer where you start - see [Graduating to a production pipeline](#graduating-to-a-production-pipeline).

## Install

Works with any agent that supports the [Agent Skills](https://agentskills.io) open standard:

```bash
npx skills add carpenter-singh-lab/catalog-skills --agent claude-code -y
```

Or pull a single skill:

```bash
npx skills add carpenter-singh-lab/catalog-skills/compose-notebook --agent claude-code -y
```

## The skills

| Skill | Use it to |
|---|---|
| [`getting-started`](skills/getting-started/SKILL.md) | Set up a freshly cloned catalog: install uv + marimo-pair, launch the first notebook in a live kernel, hand off to composition. |
| [`compose-notebook`](skills/compose-notebook/SKILL.md) | Answer a question by composing a new notebook from a catalog's existing `@app.function` helpers, validate it in a live kernel, and snapshot it for molab. |
| [`scaffold-catalog`](skills/scaffold-catalog/SKILL.md) | Stand up a brand-new catalog for a new dataset - the minimum files, conventions, and an orientation notebook. |

The operational depth (conventions, gotchas, the data contract, the index notebook, scaffold templates) lives in each skill's `references/` folder and is read on demand.
This page is the conceptual orientation; the skills are the executable contract.

## The pattern

### Core principles

1. **Catalog over library.**
   Helpers live as top-level `@app.function` cells in numbered notebooks, not in a `src/` package.
   Later notebooks import them as plain Python.
   Do not extract a package until repeated cross-notebook imports make the notebook-as-library pattern painful.

2. **Vignettes vs composed notebooks.**
   Vignettes are the curated catalog - each teaches one move and the bar for entry is high.
   Composed notebooks are what an agent or user produces to answer a question; they only have to answer the question.
   The catalog stays small on purpose; one that absorbs every analysis loses the signal the agent depends on.

3. **Data flows one direction.**
   `raw/` + `external/` -> `interim/` -> `processed/`.
   Raw data is immutable.
   (Carried over from the old workflow; it is the one structural rule that did not change.)

4. **The composed notebook is the reproducible artifact.**
   A reader re-runs the notebook and gets the same result.
   Every fetched input is hash-pinned; the notebook carries its own dependencies; nothing depends on the agent run that produced it.

5. **Validate by running and looking.**
   Static checks do not catch empty tables, stale endpoints, wrong sign conventions, or plots that render but say nothing.
   After composing or editing any notebook, launch it in a live kernel, run every cell, and inspect the actual outputs.

6. **Human and agent dual-readability.**
   `README.md` orients a person; the installed skills orient an agent; the catalog notebooks serve both.

### When to use a catalog vs a production pipeline

Default to a catalog.
Reach for a production pipeline only when a stable subset of the analysis needs scheduled, large-scale, or fully-managed reproducibility (a paper's final numbers, a recurring batch job).
Most analysis never crosses that line.

### Graduating to a production pipeline

When a stable subset earns it, add a pipeline alongside the catalog - do not replace it.
Use [redun](https://github.com/insitro/redun) for orchestration (the jpx catalog runs 65 tasks, ~13 min full rebuild on 4x H100).
The catalog notebooks remain the source of the analysis logic; the pipeline wires the stable ones into a DAG for batch execution.
The four-tier `data/` tree, one-direction flow, raw immutability, and SHA-256-pinned fetches carry over unchanged.
What you add only at this stage: the DAG, a heavier environment manager if GPU/conda deps demand it (pixi), and team data sync.
See [jpx](https://github.com/broadinstitute/jpx) for a worked example.

## Per-instance manifest

The skills are shared; each catalog's specifics (its vignette table, data surface, auth, first notebook) live in a small `catalog.toml` at the catalog root that the skills read.
This is what lets every catalog install the same skills instead of forking them.
See [`compose-notebook/references/manifest.md`](skills/compose-notebook/references/manifest.md) for the schema.

## License

BSD 3-Clause - see [LICENSE](LICENSE).
