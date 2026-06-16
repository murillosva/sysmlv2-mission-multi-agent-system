# Pipeline Architecture

This document describes the multi-agent pipeline architecture implemented in
`notebooks/FINAL_multiagent_system_DASC.ipynb` and summarized in §III.B of
the paper. It complements Figs. 1 and 3 of the paper and the notebook README.

---

## Overview

The pipeline is a sequence of transformations on a typed state `S` (a
`PipelineState` TypedDict). Starting from a mission engineering PDF `I`, it
produces a terminal artifact `π: M → Σ*` — a mapping from each of the 27
CoSMA package identifiers to its concrete SysML v2 textual source.

```
I (PDF)
  │
  ▼
┌──────┐     ┌──────┐     ┌──────┐     ┌──────┐
│  P1  │────▶│  P2  │────▶│  P3  │────▶│  P4  │
└──────┘     └──────┘     └──────┘     └──────┘
                                            │
                                            ▼
                                        ┌──────┐◀──────┐
                                        │  P5  │       │ (max 2 iter)
                                        └──────┘       │
                                            │    ┌──────┐
                                        auto-│───▶│  P6  │
                                       fixable    └──────┘
                                            │
                                        converged / max iter
                                            │
                                            ▼
                                    Final SysML v2 model
                                      (27 packages)
```

The LangGraph StateGraph orchestrates all transitions. The bounded
P5 ⇌ P6 loop runs for at most 2 iterations; after that the pipeline delivers
regardless of remaining issues, which are flagged for human review.

---

## Deterministic vs. LLM-bound stages

A core architectural contribution of the paper is the explicit separation
between deterministic and LLM-bound stages. This separation anchors
reproducibility and isolates variance to the stages where it is unavoidable.

| Stage | Agent | Type | Tool(s) |
|-------|-------|------|---------|
| P1 | PreprocessingAgent | **LLM-bound** | `T_pdf` (PyMuPDF, deterministic) |
| P2 | MissionAgent | **LLM-bound** | — |
| P3 | TemplateGeneratorClass | **Deterministic** | `T_jinja` (Jinja2 rendering) |
| P4 | RefinementAgent | **LLM-bound** | `T_RAG` (ChromaDB + sentence-transformers) |
| P5 | ValidatorAgent | **Deterministic** | MontiCore JAR, rule-based checkers |
| P6 | FixerAgent | Mixed | `T_regex`, `T_grammar` (det.); LLM calls (Tier 2–3) |
| — | Orchestrator | **Deterministic** | LangGraph StateGraph |

---

## Agent descriptions

### P1 — PreprocessingAgent

Transforms the mission PDF `I` into five structured Markdown artifacts, one
per CoSMA layer (Purpose → Operational → Functional → Logical → Technical).

- **Tool `T_pdf`**: PyMuPDF extracts raw text deterministically from the PDF.
  This is the only deterministic sub-step inside an otherwise LLM-bound agent.
- **LLM calls**: five sequential calls, one per layer, each receiving the
  accumulated context from preceding layers (Eq. 1 in the paper):
  `A_j = f(concat(SP_j, A_{<j}, T_pdf(I)))`
- **System prompt**: `prompts/p1_preprocessing/system_prompt.md`
- **Layer prompts**: `prompts/p1_preprocessing/layer_{purpose|operational|functional|logical|technical}.md`

### P2 — MissionAgent

Decomposes the five Markdown artifacts into a validated JSON object
representing the CoSMA metamodel for the mission case study.

- **11 sub-agents** (called sequentially): Stakeholder, Capability, Mission,
  Context, Operation, Function, Logical, Technical, Requirements, Measures,
  Specification.
- **Output**: a Pydantic-validated `PipelineState` dict with typed fields for
  each sub-agent's extraction.
- **JSON repair**: `json_repair` library provides resilient parsing of LLM
  output before Pydantic validation.
- **System prompt**: `prompts/p2_mission/system_prompt.md`
- **Sub-agent prompts**: `prompts/p2_mission/sub_agents/*.md`

### P3 — TemplateGeneratorClass *(deterministic)*

Renders 24 Jinja2 templates into SysML v2 skeleton source text, using the
`PipelineState` produced by P2 as context. The three static CoSMA Framework
packages (MPL 2.0) are injected directly without rendering.

- **Tool `T_jinja`**: `jinja2.Environment.from_string()` + `render()`.
  Given the same `PipelineState`, always produces bit-identical output.
- **Templates**: `templates/{layer}/*.j2` (24 files) and
  `templates/cosma_framework/*.sysml` (3 static files).
- **Output**: 27 complete package skeletons — structurally correct but
  semantically thin (placeholders for domain-specific content).

### P4 — RefinementAgent

Refines only the **9 semantically dense packages** (of the 27) via the LLM,
using RAG-retrieved Apollo 11 examples as In-Context Learning demonstrations.
The remaining 18 packages — 15 non-dense Jinja2 skeletons plus the 3 static
CoSMA Framework packages — pass through unchanged, keeping cost proportional to
refined content (paper Eq. 6, |M_dense| = 9).

- **Tool `T_RAG`**: ChromaDB vector store indexed over the 28 Apollo 11
  packages (`models/apollo11-baseline/`). Uses `all-MiniLM-L6-v2` embeddings
  via `sentence-transformers`. At query time, retrieves the `k` most similar
  package segments as few-shot context.
- **8 package-family prompts**: `prompts/p4_refinement/pkg_*.md` — each
  targets a semantically dense package family.
- **3 static packages** (CoSMA Framework) are passed through unchanged.
- **Output**: 27 `.sysml` packages (9 LLM-refined + 18 unchanged) — the
  `post-p4` snapshot in `models/case-study/`.

### P5 — ValidatorAgent *(deterministic)*

Validates each package against four independent layers of rules. Results
are aggregated into a structured validation report that drives the P6 fix
strategy.

| Layer | Checker | Rules | Tool |
|-------|---------|-------|------|
| 1 — Syntactic | MontiCore SysML v2 parser | Grammar conformance | `MCSysMLv2.jar` v7.6.2 |
| 2 — Structural | Rule-based (S01–S16) | `part def`, ports, typing, `refine`/`satisfy` links | Python |
| 3 — Coherence | Rule-based (C01–C10) | Cross-package reference integrity | Python |
| L — Limitation | LimitationDetector (L01–L04) | Known SysML v2 parser limitations | Python |

Issues classified as `KNOWN_LIMITATION` (L01–L04) are flagged for human
review and excluded from the P6 fix queue.

### P6 — FixerAgent

Applies corrections to packages with residual errors from P5 using a
three-tier cascade. A **monotonicity guard `G`** rejects any candidate fix
that would increase the error count or reduce SLOC by more than 50%.

| Tier | Handler | Method | Cost |
|------|---------|--------|------|
| 1 — Surgical | `SurgicalFixHandler` | Regex pattern replacement (`T_regex`) | Zero (deterministic) |
| 2 — Targeted | `TargetedFixHandler` | LLM rewrite of the erroneous snippet only | Low |
| 3 — Full rewrite | `LLMFullFixHandler` | LLM full-package rewrite under guard `G` | Medium |
| — | `HumanReviewHandler` | Defer to human (L01–L04 issues) | Zero |

- **System prompt**: `prompts/p6_fixer/system_prompt.md` (shared by Tiers 2–3)
- **User prompts**: built dynamically by `_build_targeted_prompt()` (Tier 2)
  and `_build_user_prompt()` (Tier 3) at runtime.

### Orchestrator — LangGraph StateGraph *(deterministic)*

LangGraph `StateGraph` with explicit, deterministic transition logic.

```
start → router → P1 → P2 → P3 → P4 → P5
                                        │
                              auto-fixable? ──yes──▶ P6 ──▶ P5 (iter++)
                                        │
                              no / max_iter reached
                                        │
                                      delivery → end
```

- **State**: `PipelineState` TypedDict — grows monotonically as each agent
  appends its artifact `a_i` to the accumulated state `S_i = S_{i-1} ∪ {a_i}`.
- **Loop bound**: `max_iter = 2` for the P5 ⇌ P6 cycle.
- **Router node**: checks `resume_from` field to support partial re-runs
  (e.g., restarting from P4 without repeating P1–P3).

---

## Tool inventory

| Tool | Used by | Type | Description |
|------|---------|------|-------------|
| `T_pdf` | P1 | Deterministic | PyMuPDF text extraction |
| `T_jinja` | P3 | Deterministic | Jinja2 template rendering |
| `T_RAG` | P4 | Deterministic retrieval + LLM generation | ChromaDB similarity search |
| `T_regex` | P6 Tier 1 | Deterministic | Regex-based surgical fix patterns |
| `T_grammar` | P6 Tier 1 | Deterministic | Grammar-aware token substitution |

---

## State schema (`PipelineState`)

```python
class PipelineState(TypedDict):
    # Input
    pdf_path:         str
    # P1 outputs — five Markdown artifacts
    purpose_md:       str
    operational_md:   str
    functional_md:    str
    logical_md:       str
    technical_md:     str
    # P2 output — validated CoSMA metamodel JSON
    mission_json:     dict
    # P3/P4 output — 27 package source texts
    packages:         dict[str, str]   # package_name → sysml_source
    # P5 output — validation report
    validation_report: dict
    # P6 output — fix report
    fix_report:       dict
    # Orchestration
    iteration:        int
    resume_from:      str | None
```

---

## Backbone configuration

Two Anthropic models were evaluated (Table I of the paper):

| Backbone | Model string | SDK version |
|----------|-------------|-------------|
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | `anthropic==0.97.0` |
| Claude Haiku 4.5 | `claude-haiku-4-5-20251001` | `anthropic==0.97.0` |

The backbone is selected via the `LLM_MODEL` environment variable (see
`.env.example`) and applies to all LLM-bound stages (P1, P2, P4, P6).
