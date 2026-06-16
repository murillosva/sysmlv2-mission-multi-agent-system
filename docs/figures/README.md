# docs/figures/

Paper figures for use in documentation and presentations.

## Expected contents (to be added post-acceptance)

| File | Figure | Description |
|------|--------|-------------|
| `fig1_adopted_approach.png` | Fig. 1 | Overview of the adopted AI-assisted MBSE approach (mission PDF → multi-agent pipeline → human review) |
| `fig2_a29n.jpg` | Fig. 2 | A-29N Super Tucano fighter aircraft in a C-UAS operation |
| `fig3_stategraph.png` | Fig. 3 | Proposed multi-agent system flow (LangGraph StateGraph) |
| `fig4_heatmap.png` | Fig. 4 | Heatmap of SLOC error-free (%) per package, both LLM backbones |

## Underlying data for Fig. 4

The per-package SLOC error-free percentages plotted in Fig. 4 are committed as
data in [`../../evaluation/metrics/per_package_sloc.csv`](../../evaluation/metrics/per_package_sloc.csv),
so the heatmap can be re-plotted from that CSV (e.g. with `matplotlib`) or
regenerated end-to-end by running the system (see
[`../reproducibility.md`](../reproducibility.md)).

## Note on copyright

Figures 1–4 are © 2026 the authors and are part of the paper submitted to
DASC 2026. They will be added to this folder after acceptance and camera-ready
submission, at which point the IEEE copyright notice will apply. Do not
redistribute figures from the submitted manuscript prior to acceptance.
