# Reproducibility Guide

This document provides step-by-step instructions for reproducing the results
in Table I and Fig. 4 of the paper, at three levels of effort.

---

## Level 0 — Inspect committed artifacts (5 min)

No API key, no Java, no external downloads required.

```bash
git clone <this-repository-url>
cd sysmlv2-mission-multi-agent-system
```

The quantitative results are committed directly as CSV files under
`evaluation/metrics/`:

| File | Reproduces |
|------|-----------|
| `aggregate.csv` | Table I — convergence results per model and state |
| `per_layer_error_free.csv` | Table II — correct SLOC rate (%) by CoSMA layer |
| `per_package_sloc.csv` | Fig. 4 — SLOC error-free (%) per package |

Compare these values against Tables I–II and Fig. 4 of the paper. The SLOC
counts derive from the 108 `.sysml` files in `models/case-study/`; you can
recount them directly with any line-counting tool on the `final/` snapshots.
See `evaluation/metrics/README.md` for the authoritative values vs. automated
pipeline output, and the `run_metadata.json` file in each
`models/case-study/{backbone}/` folder for provenance notes.

**What this verifies**: that the committed `.sysml` artifacts and the CSV
metrics are mutually consistent and match the paper. The raw automated
validation reports are not committed — anyone who wants them can regenerate
them by running the system (Level 2).

---

## Level 1 — Re-run P5 validation only (15 min)

Verify error counts by running the ValidatorAgent against the committed
`.sysml` files. Requires Java 11+ and the MontiCore JAR.

### Prerequisites

```bash
# Java 11+
java -version    # must be 11 or later

# MontiCore SysML v2 JAR (v7.6.2-SNAPSHOT, ~80 MB)
mkdir -p tools
wget -q -O tools/MCSysMLv2.jar https://www.monticore.de/download/MCSysMLv2.jar

# Python dependencies
pip install -r requirements.txt

# Environment
cp .env.example .env
# Edit .env: set MONTICORE_JAR_PATH=tools/MCSysMLv2.jar
```

### Run P5 standalone

```python
# In a Python session or notebook cell:
import os
os.environ['MONTICORE_JAR_PATH'] = 'tools/MCSysMLv2.jar'

from pathlib import Path
# Import ValidatorAgent from the notebook
# (extract cell 23 into a module, or run inline in Jupyter)

validator = ValidatorAgent(jar_path=Path('tools/MCSysMLv2.jar'))
report = validator.validate_directory(Path('models/case-study/sonnet-4.5/final'))
print(f"Errors: {report['metrics']['sloc']['sloc_with_issues']}")
print(f"Packages clean: {report['metrics']['sloc']['packages_clean']} / 27")
```

**Expected output** (pre-human-review baseline from pipeline report):

| Backbone | Snapshot | Errors (pipeline rpt) | Paper Table I |
|----------|----------|-----------------------|---------------|
| Sonnet 4.5 | final | 110 (warnings+errors) | 5 errors |
| Haiku 4.5 | final | 120 (warnings+errors) | 14 errors |

The gap between the pipeline report and Table I reflects the human-in-the-loop
review stage (§III.C). The `final/` files already incorporate those corrections;
re-running P5 on them will yield a lower count than the original automated run.

---

## Level 2 — Full pipeline re-execution (60–75 min, API cost ~USD 1.26–3.69)

Re-run the complete P1–P6 pipeline on a mission PDF input.

> **Note**: The mission case study PDF (Continental ZIDA Shield Operation) is
> reserved for an ongoing Master's thesis. See `case-study/README.md`.
> The pipeline accepts any mission-engineering PDF describing a mission of interest,
> its stakeholders, capabilities, and operational concept.

### Option A — Google Colab (recommended)

1. Open `notebooks/FINAL_multiagent_system_DASC.ipynb` in Google Colab.

2. Add secrets in the Colab left panel (🔑 icon):
   - `ANTHROPIC_API_KEY` — your Anthropic API key

3. Upload the MontiCore JAR to Google Drive:
   ```
   # In a Colab cell:
   !wget -q -O /content/drive/MyDrive/COSME_SysMLv2/tools/MCSysMLv2.jar \
       https://www.monticore.de/download/MCSysMLv2.jar
   ```

4. Set the backbone in Cell 2:
   ```python
   LLM_MODEL = 'claude-sonnet-4-5'          # to reproduce Sonnet results
   # LLM_MODEL = 'claude-haiku-4-5-20251001' # to reproduce Haiku results
   ```

5. Run all cells. Cell 11 will prompt you to upload the mission PDF.

6. Outputs are written to `BASE_DIR` (default:
   `MyDrive/COSME_SysMLv2/outputs/`).

### Option B — Local (venv)

```bash
# 1. Clone and install
git clone https://github.com/murillosva/sysmlv2-mission-multi-agent-system.git
cd sysmlv2-mission-multi-agent-system
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt

# 2. Configure
cp .env.example .env
# Edit .env:
#   ANTHROPIC_API_KEY=sk-ant-...
#   MONTICORE_JAR_PATH=tools/MCSysMLv2.jar
#   COSME_BASE_DIR=./outputs/run_local
#   LLM_MODEL=claude-sonnet-4-5

# 3. Download MontiCore JAR
mkdir -p tools
wget -q -O tools/MCSysMLv2.jar https://www.monticore.de/download/MCSysMLv2.jar
java -jar tools/MCSysMLv2.jar -h    # verify: should print MontiCore help

# 4. Launch notebook
pip install jupyter
jupyter notebook notebooks/FINAL_multiagent_system_DASC.ipynb
```

---

## Expected variance

The pipeline combines deterministic and LLM-bound stages (see
`docs/architecture.md`). Re-running the pipeline with the same backbone and
input document will produce:

| Stage | Reproducibility |
|-------|----------------|
| P1 text extraction (`T_pdf`) | **Bit-identical** |
| P1–P2 LLM calls | Semantically equivalent, not byte-identical |
| P3 template rendering | **Bit-identical** given same P2 output |
| P4 RAG retrieval | **Bit-identical** given same ChromaDB index |
| P4 LLM refinement | Semantically equivalent, not byte-identical |
| P5 validation | **Bit-identical** given same `.sysml` input |
| P6 Tier 1 (regex) | **Bit-identical** |
| P6 Tiers 2–3 (LLM) | Semantically equivalent, not byte-identical |

The paper's evaluation is a **single-replicate, two-backbone study** (one run
per backbone), as declared in §V (Limitations). Re-running the pipeline may
produce different SLOC counts and error distributions due to LLM sampling
variance, while remaining within the same order of magnitude.

---

## Environment reference

| Component | Version used in paper |
|-----------|----------------------|
| Python | 3.10 (Google Colab default) |
| `anthropic` | **0.97.0** |
| `langgraph` | latest at 2026-04-22 |
| `pymupdf` | 1.x |
| `jinja2` | 3.x |
| `pydantic` | 2.x |
| `chromadb` | latest at 2026-04-22 |
| `sentence-transformers` model | `all-MiniLM-L6-v2` |
| MontiCore SysML v2 JAR | **v7.6.2-SNAPSHOT** |
| Java | 11 (Colab default) |
| Apollo 11 baseline | v1.0.0 (retrieved 2026-02-19, see `models/apollo11-baseline/README.md`) |
