<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/operation.md
  Role   : P2 sub-agent: **Operation** extraction (Operational layer).
  Variables: {sec} — Operational-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Operational Layer):
---
{sec}
---

Extract ALL operations, engagement sequences (baseline + modernized), ROE, constraints.

CRITICAL — Operation Granularity:
Each operation MUST represent a CONCRETE, SEQUENTIAL STEP in the mission timeline —
NOT a generic doctrinal category. Think of operations as "what happens next" in the
mission execution, from preparation through mission complete.

CORRECT examples (concrete steps):
  "PrepareAircraftForDeployment" — "Configure aircraft systems, load armament, and brief crew before departure"
  "TransitToForwardBase" — "Fly aircraft from main base to designated FARP for refueling"
  "RefuelAndRearmAtFarp" — "Replenish fuel and rocket armament at forward operating point"
  "EstablishPatrolOrbit" — "Navigate to assigned PAC point and enter holding pattern"
  "DetectAndCueTarget" — "Radar system detects UAS incursion and transmits cueing data to interceptor"
  "NavigateToIntercept" — "Adjust flight path from patrol orbit to intercept geometry"
  "AcquireTargetVisually" — "Pilot establishes visual or sensor contact with UAS"
  "EngageWithKineticWeapon" — "Fire rocket armament to neutralize UAS"
  "AssessBattleDamage" — "Determine if target neutralized or evaded"

INCORRECT examples (doctrinal categories — do NOT use):
  "AerospaceControl" — too abstract, describes a doctrinal concept not a step
  "AirspacePolicing" — a mission TYPE, not an operational step
  "CombatSustainment" — a logistics CATEGORY, not a concrete action

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
