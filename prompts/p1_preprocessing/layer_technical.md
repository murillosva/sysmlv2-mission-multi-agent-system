<!--
  Agent  : P1
  File   : prompts/p1_preprocessing/layer_technical.md
  Role   : P1 user prompt for the **Technical** layer.
  Variables: {text}, {purpose_md}, {operational_md}, {functional_md}, {logical_md}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

ACCUMULATED CONTEXT (all 4 previous layers):
---
### PURPOSE LAYER
{purpose_md[:6000]}

### OPERATIONAL LAYER
{operational_md[:6000]}

### FUNCTIONAL LAYER
{functional_md[:8000]}

### LOGICAL LAYER
{logical_md[:8000]}
---

SOURCE TEXT (complete mission case study document):
---
{text}
---

Extract the CoSMA TECHNICAL LAYER from the source text.
This layer answers: "How is the system physically built?"

Generate ALL of the following sections:

## 1. Technical Components by Platform/System
For EACH logical component identified in the Logical layer, list its
technical realization(s). Group by platform or system type.
Use sub-headings: ### Platform: [name] ([configuration label])
Table: | TC-ID | Component Name | Key Specs | Realizes LC-ID | Configuration | Source |

## 2. Technical Components — Threat Entities
If threat systems are described with technical detail:
Table: | TC-ID | Threat Type | Key Specs | Source |

## 3. Technical Ports
Table: | Port Name | Owner TC-ID | Direction (in/out/inout) | Item Type | Connected To | Source |

## 4. Mission Requirements
High-level requirements tracing to mission goals.
Table: | MR-ID | Requirement Text | Rationale (WHY — what drives this requirement) | Traces to GOAL-ID | Source |
For "Rationale": 1-2 sentences explaining WHY this requirement exists.
Derive from context if not explicitly stated.

## 5. Technical Requirements
Implementation-level requirements tracing to mission or functional requirements.
Table: | TR-ID | Requirement Text | Rationale (WHY — what drives this requirement) | Traces to MR-ID or FR-ID | Source |
For "Rationale": 1-2 sentences explaining WHY this requirement exists.
Derive from context if not explicitly stated.

## 6. Measures of Success (MOSs)
Table: | MOS-ID | Name | Description | Unit | Direction (higher=better?) | Threshold/Target (e.g., ">= 85%", "< 45s") | Formula | Variables | Source |
For "Threshold/Target": extract the success criterion if stated. If not explicit,
derive from context (e.g., "mission success requires all UAS neutralized" → ">= 100%").
If truly unknown, write "TBD".
For "Formula": extract the mathematical expression if defined in the document
(e.g., "Nn / Nt"). Write the formula as a single-line expression. If no formula, write "N/A".
For "Variables": list each variable as "symbol: description (unit)" separated by semicolons.
Example: "Nn: UAS neutralized before 80 nmi (count); Nt: total incursions (count)"

## 7. Measures of Effectiveness (MOEs)
Table: | MOE-ID | Name | Description | Unit | Formula | Variables | Traces to MOS-ID | Source |
For "Formula": extract the mathematical expression if defined (e.g.,
"1 - (1/(N * Tmax)) * sum(tef_i)"). Write as single-line expression. If no formula, write "N/A".
For "Variables": list each variable as "symbol: description (unit)" separated by semicolons.
Include sub-formulas if they define intermediate variables (e.g., "tef_i: effective
engagement time, see Eq.6 (s); Tmax: mean available time, see Eq.7 (s)").

## 8. Measures of Performance (MOPs)
For EACH configuration, list the MOP values. Use columns per configuration.
Table: | MOP-ID | Name | Description | Unit | Baseline Value | Alt Value(s) | Threshold/Range | Traces to MOE-ID | Source |
For "Threshold/Range": extract the performance criterion or valid range per configuration
(e.g., "[1, 10] s", "[5, 60] s", ">= 80%", "2 to 14 km"). If not stated, write "TBD".

## 9. Modeling Parameters and Sensitivity Ranges
Table: | Param | Description | Baseline Value | Alt Value(s) | Unit | Source |

## 10. Named Personnel and Operators
If the document names specific individuals (pilots, operators, commanders,
crew members) with roles or qualifications, list them.
Table: | Name | Role | Unit/Organization | Qualifications | Source |
If no named personnel are mentioned (common in military documents due to
operational security), write "No named personnel identified".
