<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_analysis.md
  Role   : P4 refinement prompt for **AnalysisPackage**.
  Variables: {skeleton}, {rag_context}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

\
## TASK: Refine AnalysisPackage

Replace every /* TODO[P4]: bind out to calc def from CalculationsPackage; add assert constraint */
comment with:
1. Keep the existing `out` line but change its type from `ScalarValues::Real` to the
   appropriate ISQ type if applicable (e.g., ISQ::duration for time metrics)
2. Add an `assert constraint {{ ... }}` with a threshold from the JSON data

### CRITICAL RULES
- For each `analysis def`, bind the `out` parameter to its corresponding calc def
  from CalculationsPackage using the pattern: out x :> type = calculateX(param1, param2);
- Use the calc def names exactly as defined in CalculationsPackage (e.g., calculateNeutralizationRate,
  calculateEngagementTimeRate). The in parameters should reference the subject's attributes.
- Add `assert constraint {{ ... }}` with threshold from the JSON measures data.
- Do NOT modify the `analysis` instances (the ones that specialize the def) — leave them as-is.
- For ratio/percentage metrics (0.0–1.0), keep `: ScalarValues::Real`.
- For time/duration metrics, use `:> ISQ::duration`.
- Do NOT reference subject attributes with dot notation (e.g., subject.neutralizedCount).
  Instead, declare `in` parameters in the analysis def and pass them to the calc def.
  CORRECT: in neutralizedCount : ScalarValues::Integer;
           out rate : ScalarValues::Real = calculateNeutralizationRate(neutralizedCount, totalIncursions);
  WRONG:   out rate :> ScalarValues::Real = calculateNeutralizationRate(subject.neutralizedCount, subject.totalIncursions);

### CORRECT PATTERN (Apollo 11 ground truth)

```
analysis def SystemPowerAnalysis {{{{
    doc /* Analysis to calculate total power generation, load, and margin. */
    subject missionSystem : System;
    out totalPowerGenerated :> ISQ::power = rollupPowerGeneration(missionSystem);
    out totalPowerLoad :> ISQ::power = rollupPowerConsumption(missionSystem);
    out powerMargin :> ISQ::power = calculatePowerMargin(totalPowerGenerated, totalPowerLoad);
    assert constraint {{{{
        powerMargin > 0 [W]
    }}}}
}}}}

analysis def NeutralizationRateAnalysis {{{{
    doc /* Percentage of UAS neutralized before boundary. */
    subject missionSystem : MissionSystem;
    out neutralizationRate : ScalarValues::Real = calculateNeutralizationRate(missionSystem.neutralizedCount, missionSystem.totalIncursions);
    assert constraint {{{{
        neutralizationRate >= 0.80
    }}}}
}}}}
```

### WRONG PATTERN

```
// WRONG: modifying analysis instances (bindings go in the DEF, not the instance)
analysis operacaoEscudoNeutralizationRateAnalysis : NeutralizationRateAnalysis {{{{
    out neutralizationRate :> ScalarValues::Real = calculateNeutralizationRate(...);
}}}}

// WRONG: inventing calc defs that don't exist in CalculationsPackage
out rate :> ScalarValues::Real = computeCustomMetric(x, y);
```
### AVAILABLE CALC DEFS (use ONLY these — do NOT invent, split, or rename)
{calc_list}

### MEASURES DATA
MOS: {_json.dumps(measures.get('measures_of_success', []), ensure_ascii=False, indent=2)}
MOE: {_json.dumps(measures.get('measures_of_effectiveness', []), ensure_ascii=False, indent=2)}
MOP: {_json.dumps(measures.get('measures_of_performance', []), ensure_ascii=False, indent=2)}

### SKELETON TO REFINE (output this file COMPLETE, from first line to last brace)
{skeleton}
