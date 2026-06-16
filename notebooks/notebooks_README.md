# notebooks/

## FINAL_multiagent_system_DASC.ipynb

This notebook contains the complete implementation of the P1–P6 multi-agent
pipeline and the LangGraph StateGraph orchestrator described in the paper.

### Structure

| Cell | Label | Type | Description |
|------|-------|------|-------------|
| 1 | Dependency installation | Code | `pip install` for all dependencies |
| 2 | API key, Drive, constants | Code | `ANTHROPIC_API_KEY`, `LLM_MODEL`, `BASE_DIR`, agent `MAX_TOKENS` |
| 3 | PipelineState + helpers | Code | `TypedDict` state schema; shared utilities |
| 4 | Pydantic schemas (P2) | Code | CoSMA metamodel dataclasses for 11 sub-agents |
| 5 | P1 + P2 prompts and runners | Code | `PreprocessingAgent` (P1) and `MissionAgent` (P2) |
| 6 | P3 Jinja2 templates + `TemplateGeneratorClass` | Code | 24 Jinja2 templates; 3 static CoSMA Framework packages (MPL 2.0) |
| 7 | P4 `RefinementAgent` | Code | RAG-based refinement; 8 package-family prompts |
| 8 | P5 `ValidatorAgent` | Code | MontiCore (syntactic) + Structural (S01–S16) + Coherence (C01–C10) |
| 9 | P6 `FixerAgent` | Code | 3-tier correction stack (Surgical → Targeted → LLM full-rewrite) |
| 10 | StateGraph, wrappers, loop | Code | LangGraph `StateGraph`; P5 ⇌ P6 bounded loop (max. 2 iterations) |
| 11 | Upload PDF, run, report | Code | Entry point: uploads mission PDF, triggers the pipeline, prints final report |

Markdown cells between code cells provide section headings only and contain no
substantive content.

### Running

See the top-level `README.md` for Quickstart paths (Colab, local, outputs-only).

### Deterministic vs. LLM-bound stages

| Stage | Agent | Type |
|-------|-------|------|
| P1 | PreprocessingAgent | LLM-bound (5 × PDF → Markdown calls) |
| P2 | MissionAgent | LLM-bound (11 sub-agent calls) |
| P3 | TemplateGeneratorClass | **Deterministic** (Jinja2 rendering, no LLM) |
| P4 | RefinementAgent | LLM-bound (RAG + up to 8 refinement calls) |
| P5 | ValidatorAgent | **Deterministic** (MontiCore JAR + rule-based checks) |
| P6 | FixerAgent | Mixed: Tier 1 deterministic (regex); Tiers 2–3 LLM-bound |
| — | Orchestrator | **Deterministic** (LangGraph transition logic) |

This separation is an explicit architectural contribution of the paper.
Re-running the notebook with the same backbone and input will produce
semantically equivalent but not byte-identical `.sysml` output for LLM-bound
stages. P3 and P5 are fully reproducible.
