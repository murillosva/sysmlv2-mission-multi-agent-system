# docs/

Technical documentation for the sysmlv2-mission-multi-agent-system repository.

| Document | Contents |
|----------|----------|
| [`architecture.md`](architecture.md) | Pipeline architecture: StateGraph, all agents (P1–P6), tools (`T_pdf`, `T_jinja`, `T_RAG`, `T_regex`, `T_grammar`), `PipelineState` schema, backbone configuration |
| [`reproducibility.md`](reproducibility.md) | Step-by-step reproduction guide at three levels: metrics only (Level 0), P5 re-validation (Level 1), full pipeline re-execution (Level 2) |
| [`package_taxonomy.md`](package_taxonomy.md) | 27-package CoSMA layer mapping, generation method (Jinja2 / static), Fig. 4 package annotation, folder layout |
| [`figures/`](figures/) | Paper figures (to be populated post-acceptance); the data underlying Fig. 4 is committed in `evaluation/metrics/per_package_sloc.csv` |
