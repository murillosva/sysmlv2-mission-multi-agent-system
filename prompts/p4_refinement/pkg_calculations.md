<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_calculations.md
  Role   : P4 refinement prompt for **CalculationsPackage**.
  Variables: {skeleton}, {rag_context}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

\
## TASK: Refine CalculationsPackage

Replace every /* TODO[P4]: define in parameters, return type ... */ comment with
a complete `calc def` body: `in` parameters, `return` with ISQ type, and formula.

### CRITICAL RULES
- Each `calc def` corresponds to ONE measure (MOS, MOE, or MOP).
- Use ISQ types for return and parameters where applicable.
- For ratios/percentages, return `:> ScalarValues::Real`.
- For durations, return `:> ISQ::duration`.
- For lengths/distances, return `:> ISQ::length`.
- Formulas should be simple arithmetic (division, subtraction, comparison).
  Do NOT reference external functions that are not defined in this file.
- Every `calc def` MUST be self-contained.

### CORRECT PATTERN (Apollo 11 ground truth)

```
calc def calculatePowerMargin {{{{
    doc /* Calculates the difference between available power and total loads. */
    in sourcePower :> ISQ::power;
    in totalLoadPower :> ISQ::power;
    return powerMargin :> ISQ::power = sourcePower - totalLoadPower;
}}}}

calc def calculateDeltaV {{{{
    doc /* Calculates max velocity change using the Tsiolkovsky Rocket Equation. */
    in isp :> specificImpulse;
    in g0 :> ISQ::acceleration;
    in m0 :> ISQ::mass;
    in mf :> ISQ::mass;
    return deltaV :> ISQ::speed = isp * g0 * ln(m0 / mf);
}}}}

calc def evaluateMissionSuccess {{{{
    doc /* Evaluates overall mission success based on primary objectives. */
    in crewSafe : ScalarValues::Boolean;
    in targetsNeutralized : ScalarValues::Boolean;
    return isSuccess : ScalarValues::Boolean = crewSafe and targetsNeutralized;
}}}}
```

### KEY RULES FOR TRANSFORMING TODO HINTS INTO CALC DEFS
- Replace `/* TODO[P4]: in X — description (unit) */` with `in X :> ISQ::type;` or `in X : ScalarValues::Real;`
- Replace `/* TODO[P4]: formula = EXPR */` by putting EXPR in the return line
- Replace `return result :> ScalarValues::Real;` with `return namedResult :> ISQ::type = FORMULA;`
- The return MUST have: a descriptive name (not "result"), the correct ISQ type, and the formula inline
- For dimensionless ratios use `: ScalarValues::Real`; for physical quantities use `:> ISQ::type`
- Map units from hints: (s) → ISQ::duration, (m) → ISQ::length, (km) → ISQ::length, (m/s) → ISQ::speed, (count) → ScalarValues::Integer, (proportion) → ScalarValues::Real
- PRESERVE ALL in parameters mentioned in TODO hints — do NOT aggregate or simplify them away.
  If a hint lists 10 input variables, the calc def MUST have 10 `in` declarations.
- The return formula MUST match the TODO hint formula as closely as possible.
  For summations (Σ), use a simplified aggregated input: declare an `in totalSum :> ISQ::type;`
  that represents the pre-computed summation result, then use it in the formula.
  Example: hint says "formula = (1/N) · Σ(MOE2_i)" → write:
    in totalMOE2Sum : ScalarValues::Real;
    in N : ScalarValues::Integer;
    return trackingRate : ScalarValues::Real = totalMOE2Sum / N;
  NOT: return trackingRate : ScalarValues::Real = Ptrack / N;

### MEASURES DATA (one calc def per measure)
MOS: {_json.dumps(mos, ensure_ascii=False, indent=2)}
MOE: {_json.dumps(moe, ensure_ascii=False, indent=2)}
MOP: {_json.dumps(mop, ensure_ascii=False, indent=2)}

### SKELETON TO REFINE (output this file COMPLETE, from first line to last brace)
{skeleton}
