<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/measures.md
  Role   : P2 sub-agent: **Measures** (MOS/MOE/MOP) extraction.
  Variables: {sec} — Technical-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Technical Layer — Measures and Parameters):
---
{sec}
---

Extract ALL MOSs, MOEs, MOPs, and simulation parameters.
Capture EVERY row from the parameters table.

CRITICAL — Formula extraction:
- For each MOS and MOE, extract the "formula" field as a single-line math expression
  (e.g., "Nn / Nt", "1 - (1/(N * Tmax)) * sum(tef_i)").
- For "variables", extract EACH symbol used in the formula as a FormulaVariable object:
  name = symbol (e.g., "Nn"), description = what it represents,
  role = "in" for inputs or "out" for the result, unit = physical unit if applicable.
- For MOS "threshold", extract the success criterion (e.g., ">= 0.80", "< 45 s").
- For MOP "threshold", extract the valid range or criterion per configuration
  (e.g., "[1, 10] s", "[5, 60] s", "2 to 14 km").
- If a formula or threshold is not stated, use "" or "TBD" respectively.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
