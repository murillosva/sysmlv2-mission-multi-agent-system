# docs/

Technical documentation for the sysmlv2-mission-multi-agent-system repository.

| Document | Contents |
|----------|----------|
| [`architecture.md`](architecture.md) | Pipeline architecture: StateGraph, all agents (P1–P6), tools (`T_pdf`, `T_jinja`, `T_RAG`, `T_regex`, `T_grammar`), `PipelineState` schema, backbone configuration |
| [`reproducibility.md`](reproducibility.md) | Step-by-step reproduction guide at three levels: metrics only (Level 0), P5 re-validation (Level 1), full pipeline re-execution (Level 2) |
| [`package_taxonomy.md`](package_taxonomy.md) | 27-package CoSMA layer mapping, generation method (Jinja2 / static), Fig. 4 package annotation, folder layout |

> **Paper figures.** The figures of the accompanying paper are not redistributed
> here: their copyright was transferred to the IEEE. The data underlying Fig. 4
> is committed as CSV in
> [`../evaluation/metrics/per_package_sloc.csv`](../evaluation/metrics/per_package_sloc.csv),
> so the heatmap can be re-plotted independently (see
> [`reproducibility.md`](reproducibility.md)).
