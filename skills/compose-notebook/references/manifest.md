# The catalog.toml manifest

The skills in this collection are shared and dataset-agnostic.
Each catalog declares its specifics in a `catalog.toml` at its repo root.
This is what lets every catalog install the same skills instead of forking them - shared procedure, instance-local data.

```toml
name = "jx"
description = "JUMP Cell Painting exploration catalog"

[data]
surface = "duckdb"        # one of: rest | duckdb | pooch | files
cache = "$JX_CACHE"       # env var or path for large cached artifacts; omit if none

[auth]
env_var = ""              # required token var, e.g. "FINNGENIE_TOKEN"; empty = public

[getting_started]
first_notebook = "nb07_compound_neighborhood.py"

# one [[vignette]] block per catalog notebook - this is the table compose-notebook reads
[[vignette]]
notebook = "nb01_retrieve_profiles.py"
helpers  = ["load_profile_index", "load_profiles", "profile_stats"]
does     = "Pull JUMP morphological profiles by perturbation"

[[vignette]]
notebook = "nb05_explore_similarity.py"
helpers  = ["latest_zenodo_id", "load_distance_matrix", "plot_similarity_heatmap"]
does     = "Cosine-similarity search over JUMP profiles"
```

How the skills use it:

- `getting-started` reads `[getting_started].first_notebook` and `[auth].env_var`.
- `compose-notebook` reads the `[[vignette]]` table to pick which notebooks to import, and `[data]`/`[auth]` to know the surface.
- `scaffold-catalog` writes the initial `catalog.toml` and adds a `[[vignette]]` row when a composed notebook is promoted.

Keep `catalog.toml` the single source of the vignette table.
Do not duplicate the table into a skill or hardcode dataset names into the skills - if you are tempted to, the manifest schema is the place to extend instead.
