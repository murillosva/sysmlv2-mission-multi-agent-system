<!--
  Agent  : P1
  File   : prompts/p1_preprocessing/layer_operational.md
  Role   : P1 user prompt for the **Operational** layer. Receives Purpose context.
  Variables: {text}, {purpose_md} — PDF text + Purpose layer markdown.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

PURPOSE LAYER CONTEXT (already extracted — use for traceability):
---
{purpose_md}
---

SOURCE TEXT (complete mission case study document):
---
{text}
---

Extract the CoSMA OPERATIONAL LAYER from the source text.
This layer answers: "When do things happen and in what sequence?"

Scan the ENTIRE document for content related to: operational sequences,
mission phases, engagement procedures, rules of engagement, and
operational constraints.

Generate ALL of the following sections:

## 1. Mission Phases (State Machine)
Model the mission as a sequence of phases (state defs).
Table: | Phase ID (PH-XXX) | Phase Name | Entry Trigger | Do Actions | Exit Trigger | Next Phase | Estimated Duration | Source |
For "Estimated Duration": extract from document if stated (e.g., "2 hours",
"30 minutes"). If not stated, estimate based on context and mark as "~Xh (estimated)".

## 2. Operations
Define operational activities as CONCRETE SEQUENTIAL STEPS of the mission,
NOT as abstract doctrinal categories.

CRITICAL DISTINCTION — read carefully:
- WRONG approach: extracting generic capability categories like "Aerospace Control",
  "Airspace Policing", "Combat Sustainment". These are doctrinal LABELS, not operations.
- RIGHT approach: extracting the step-by-step actions that occur during the mission
  timeline. Each operation should describe a specific, observable action performed by
  a specific actor at a specific phase.

EXAMPLE of correct granularity (from Apollo 11 ground truth):
  OP-001 LoadConsumablesAndPropellants: "The process of fueling the rocket and loading all necessary consumables."
  OP-002 TransferCrewToVehicle: "The operation where the flight crew ingresses the Command Module."
  OP-003 PerformPreLaunchCountdown: "The synchronized sequence of checks in the final hours before liftoff."
  OP-004 ExecuteLaunchSequence: "The automated sequence of engine ignitions and staging events."
  OP-005 MonitorAscentTrajectory: "Continuous tracking of speed, altitude, and flight path during ascent."

Look for the OPERATIONAL SEQUENCE section in the source document (e.g., "Mission operational sequence", "Mission phases timeline"  or equivalent) and extract each step as an individual operation.

If a kill chain was identified in the Purpose layer, map each operation to its
corresponding step.
Table: | OP-ID | Operation Name | Description | Phase | Performer | Kill Chain Step (if applicable) | Source |
## 3. Engagement Sequences by Configuration
For EACH configuration identified in the Purpose layer (§8):
- Describe the step-by-step operational sequence
- If only one configuration exists, describe it once
Use sub-headings: ### Configuration: [label]

## 4. Rules of Engagement (ROE)
If ROE are described (even simplified or modeled), extract them.
If not stated, write "TBD — not stated in source".

## 5. Operational Constraints and Assumptions
Extract ALL constraints: fuel autonomy, range limits, timing, logistics,
idealized assumptions, spacing requirements, etc.
Table: | Category | Constraint | Source |
