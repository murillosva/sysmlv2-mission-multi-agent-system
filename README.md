# SysML v2 Mission Multi-Agent System

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Python](https://img.shields.io/badge/Python-3.10%20%7C%203.11-blue.svg)
![DOI](https://img.shields.io/badge/DOI-TBD%20%28upon%20IEEE%20Xplore%20indexing%29-lightgrey.svg)

> Companion code for the paper **"Digital Avionics Operations in Mission
> Simulation: an AI-assisted MBSE Modeling Approach"**, accepted at the
> **AIAA DATC/IEEE 45th Digital Avionics Systems Conference (DASC) 2026**.
>
> - **Conference:** 13–17 September 2026, Orlando, Florida, USA
> - **Session:** Human–AI Teaming and Digital Engineering for Avionics
> - **Track:** AI Applications for Aerospace
>
> Repository: https://github.com/murillosva/sysmlv2-mission-multi-agent-system

---

## Overview

This repository contains the full implementation of an AI-assisted Model-Based
Systems Engineering (MBSE) approach that automatically converts a mission
engineering document into syntactically and structurally valid SysML v2 textual
models (concrete syntax) structured according to the CoSMA framework (Helle &
Schramm, 2026).

The pipeline is composed of six specialized agents (P1–P6) orchestrated by a
LangGraph StateGraph. Starting from a natural-language mission PDF as a
proof-of-concept (PoC), it produces a complete 27-package SysML v2 model covering
all five CoSMA layers (Purpose, Operational, Functional, Logical, Technical) plus
cross-cutting packages (Requirements, Analysis, Program, Mission Execution, CoSMA
Framework, Root). Validation and auto-correction are performed through a bounded
P5 ⇌ P6 loop using the MontiCore SysML v2 parser.

Evaluated against a case study of Counter-Unmanned Aerial System (C-UAS)
avionics operation involving the Embraer EMB-314 Super Tucano (A-29 Super
Tucano) in an airspace policing mission against illicit UAS, using two Anthropic
backbone models:

| Backbone         | Final SLOC | Error-free (%) | Cost (USD) | Time (min) |
|------------------|-----------|----------------|------------|------------|
| Claude Sonnet 4.5 | 3,043     | **99.8**       | 3.69       | 75.0       |
| Claude Haiku 4.5  | 2,976     | **99.6**       | 1.26       | 60.8       |

Haiku 4.5 achieves within 0.2 p.p. of Sonnet 4.5 quality at ≈ 1/3 the cost,
suggesting that final SysML v2 model quality is determined primarily by pipeline
structure rather than by the standalone capability of the underlying LLM.

---

## Repository structure

```
.
├── notebooks/
│   └── FINAL_multiagent_system_DASC.ipynb   # Complete pipeline (Colab-ready)
├── prompts/
│   ├── p1_preprocessing/                     # 1 system + 5 layer prompts
│   ├── p2_mission/                           # 1 system + 11 sub-agent prompts
│   ├── p4_refinement/                        # 1 system + 8 package-family prompts
│   └── p6_fixer/                             # LLM fix system prompt
├── templates/                                # 24 Jinja2 templates (.j2), one per package
│   ├── purpose/ operation/ function/
│   ├── logical/ technical/ requirements/
│   ├── analysis/ program/ execution/ root/
│   └── cosma_framework/                      # 3 static packages (Airbus MPL 2.0)
├── models/
│   ├── apollo11-baseline/                    # 28-package Apollo 11 ground truth (MPL 2.0)
│   └── case-study/
│       ├── sonnet-4.5/{post-p4, final}/      # 27 .sysml files per snapshot
│       └── haiku-4.5/{post-p4, final}/
├── case-study/
│   └── README.md                             # Reserved (see note below)
├── evaluation/
│   └── metrics/                              # CSV files reproducing Tables I–II and Fig. 4
└── docs/
    ├── architecture.md                       # StateGraph + tool descriptions
    ├── reproducibility.md                    # Step-by-step execution guide
    └── package_taxonomy.md                   # 27-package CoSMA layer mapping
```

---

## Quickstart

Three usage paths, from lowest to highest friction:

### Path A — Explore outputs only (no execution required)

Browse `models/case-study/sonnet-4.5/final/` or
`models/case-study/haiku-4.5/final/` directly. Each folder contains the 27
`.sysml` files that produced the metrics in Table I of the paper. Open them in
a textual modeling environment, such as [SysIDE](https://www.syside.org/), or any
other editor for syntax-highlighted inspection (e.g. Eclipse IDE, which runs the
[OMG SysML v2 Pilot Implementation](https://github.com/Systems-Modeling/SysML-v2-Release)).

### Path B — Run in Google Colab (recommended for full reproduction)

1. Open `notebooks/FINAL_multiagent_system_DASC.ipynb` in Google Colab.
2. Add your Anthropic API key as a Colab Secret named `ANTHROPIC_API_KEY`
   (lock icon in the left panel → "Add new secret").
3. Download the MontiCore SysML v2 JAR and upload it to your Drive:
   ```
   wget -q -O MCSysMLv2.jar https://www.monticore.de/download/MCSysMLv2.jar
   ```
   Then upload it to the path configured in `BASE_DIR / 'tools' / 'MCSysMLv2.jar'`
   (default: `MyDrive/COSME_SysMLv2/tools/MCSysMLv2.jar`).
4. Select the backbone by setting `LLM_MODEL` in Cell 2:
   - `'claude-sonnet-4-5'` to reproduce the Sonnet results
   - `'claude-haiku-4-5-20251001'` to reproduce the Haiku results
5. Run all cells in order. The pipeline will prompt you to upload the mission
   PDF when Cell 11 executes.

> **Note on the mission input document:** The mission case study PDF is reserved
> for an ongoing Master's thesis. See `case-study/README.md` for details.
> The pipeline is executable with other mission-engineering PDFs describing a
> mission of interest, its stakeholders, capabilities, and operational concept.

### Path C — Run locally (venv or conda)

```bash
git clone https://github.com/murillosva/sysmlv2-mission-multi-agent-system.git
cd sysmlv2-mission-multi-agent-system

python -m venv .venv && source .venv/bin/activate   # or conda create -n cosme python=3.11
pip install -r requirements.txt

cp .env.example .env
# Edit .env: set ANTHROPIC_API_KEY, MONTICORE_JAR_PATH, COSME_BASE_DIR

# Download MontiCore JAR
wget -q -O tools/MCSysMLv2.jar https://www.monticore.de/download/MCSysMLv2.jar

# Run the notebook via Jupyter
jupyter notebook notebooks/FINAL_multiagent_system_DASC.ipynb
```

Java 11+ is required for the MontiCore parser (P5 ValidatorAgent):

```bash
java -version          # must be 11 or later
java -jar tools/MCSysMLv2.jar -h   # should print MontiCore help
```

---

## Stack and exact versions

| Dependency             | Version used in paper     | Notes                                |
|------------------------|--------------------------|--------------------------------------|
| `anthropic`            | **0.97.0**               | Anthropic Python SDK                 |
| `langgraph`            | latest at time of paper  | StateGraph orchestration             |
| `pymupdf`              | 1.x                      | Deterministic PDF extraction (P1 T_pdf) |
| `jinja2`               | 3.x                      | Template rendering (P3 T_jinja)      |
| `pydantic`             | 2.x                      | CoSMA metamodel schema validation    |
| `chromadb`             | latest                   | Vector store for RAG (P4 T_RAG)      |
| `json_repair`          | latest                   | Resilient JSON parsing (P2)          |
| MontiCore SysML v2 JAR | **v7.6.2-SNAPSHOT**      | Syntactic validation (P5 Layer 1)    |
| Python                 | 3.10 / 3.11              | Google Colab default                 |

> `sentence-transformers` is pulled transitively by `chromadb` for embedding
> (`all-MiniLM-L6-v2`). First run will download ~90 MB of model weights.

> **Note on the Sonnet identifier.** `claude-sonnet-4-5` is a moving alias that
> resolves to whichever Sonnet 4.5 snapshot is current at call time, whereas the
> Haiku backbone is pinned to the dated `claude-haiku-4-5-20251001`. See
> `docs/reproducibility.md` for the environment date of the reported runs.

---

## Reproducibility statement

The pipeline combines deterministic stages (P3 TemplateGeneratorClass and P5
ValidatorAgent) with LLM-bound stages (P1 PreprocessingAgent, P2 MissionAgent,
P4 RefinementAgent, P6 FixerAgent).

Deterministic stages produce identical output across runs given the same input
state. LLM-bound stages are subject to model sampling variance, and the results in
Table I indicate trends observed in this single-replicate, two-backbone
evaluation. Re-running the pipeline with the same backbone and input document
will produce semantically equivalent but not byte-identical `.sysml` output. The
published outputs in `models/case-study/` are the exact artifacts evaluated in
the paper.

---

## Licenses

| Component | License | Attribution |
|---|---|---|
| Pipeline source code (P1–P6) | **MIT** — see `LICENSE` | Murillo S. Szvaticsek, 2026 |
| CoSMA Framework packages (`templates/cosma_framework/`, `models/apollo11-baseline/`) | **MPL 2.0** — see `NOTICE` | © 2026 AIRBUS and its affiliates |
| Apollo 11 SysML v2 ground truth (`models/apollo11-baseline/`) | **MPL 2.0** | © 2026 AIRBUS — https://github.com/airbus/apollo-11-sysml-v2 |

The MPL 2.0 permits use and redistribution with preservation of the original
copyright notices. See `NOTICE` for the full text.

The figures of the accompanying paper are **not** redistributed in this
repository: their copyright was transferred to the IEEE. The data underlying
Fig. 4 is committed as CSV in `evaluation/metrics/per_package_sloc.csv`, so the
heatmap can be re-plotted independently of the published figure.

---

## Citing this work

If you use this code or the generated models in your research, please cite the
accompanying paper (the BibTeX entry will be updated with the DOI and the final
page numbers once the proceedings are indexed in IEEE Xplore):

```bibtex
@inproceedings{szvaticsek2026digital,
  title     = {Digital Avionics Operations in Mission Simulation:
               an AI-assisted MBSE Modeling Approach},
  author    = {Szvaticsek, Murillo S. and Marcondes, Cesar A. C. and Loubach, Denis S.},
  booktitle = {AIAA DATC/IEEE 45th Digital Avionics Systems Conference (DASC)},
  year      = {2026},
  doi       = {TBD},
  note      = {Accepted for presentation. Repository:
               https://github.com/murillosva/sysmlv2-mission-multi-agent-system}
}
```

---

## Publication status

The paper has been **accepted** for presentation at the AIAA DATC/IEEE 45th
Digital Avionics Systems Conference (DASC) 2026, in the session *Human–AI Teaming
and Digital Engineering for Avionics* (track *AI Applications for Aerospace*).

The camera-ready version and the IEEE Copyright and Consent Form have been
submitted. The paper will be presented at the conference (13–17 September 2026,
Orlando, Florida, USA) and the proceedings will subsequently be indexed in IEEE
Xplore. The IEEE Xplore DOI and the remaining bibliographic details will be added
to this README and to `CITATION.cff` as soon as they are assigned; until then the
BibTeX entry and the DOI badge above are provisional. The thesis DOI referenced
in `case-study/README.md` will be added after the thesis defense and
institutional deposit.

Until the conference presentation, this repository remains private.
