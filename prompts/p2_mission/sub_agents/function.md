<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/function.md
  Role   : P2 sub-agent: **Function** extraction (Functional layer).
  Variables: {sec} — Functional-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Functional Layer):
---
{sec}
---

Extract item definitions, functions (in a hierarchy), and functional requirements.

=== STEP 1: Define Domain Item Definitions (item_defs) ===
Define 5-10 concise item types representing the key DATA FLOWS in this mission.
These will type ALL function inputs and outputs. Choose generic, reusable names.

Example item defs (from Apollo 11 ground truth):
  VehicleStatus: "Represents the complete state of a vehicle system, including configuration, resources, and trajectory."
  CrewStatus: "Represents the state of the crew, including health and readiness."
  MissionPlan: "Contains the overall objectives and parameters for the mission."
  MissionReport: "A comprehensive report detailing the outcomes of the mission."
  LunarSamples: "Represents the collected geological materials from the Moon."

CRITICAL: Do NOT create a unique type for every input/output. Reuse types.
  WRONG: "DetectionAlertsFromDECEAGroundRadarsAndE99MAirborneRadar" (too specific)
  RIGHT: "SurveillanceAlert" or "TargetTrack" (reusable across functions)

=== STEP 2: Define Functions in a HIERARCHY ===
Functions MUST form a tree:
  Level 1: ONE top-level function (FN-001) representing the entire mission.
           parent_id = null. No refines_op_ids.
  Level 2: 3-6 orchestrating functions grouping major mission phases.
           parent_id = FN-001. No refines_op_ids.
  Level 3+: Leaf functions performing concrete actions.
            parent_id = their orchestrating parent. refines_op_ids = [OP-XXX].

Rules:
  - Every function's inputs/outputs type_desc MUST be one of the item_defs from Step 1.
  - parent_id is MANDATORY for all functions except FN-001.
  - ONLY leaf functions (no children) have refines_op_ids.
  - Include variant functions for different configurations as separate entries.

EXAMPLE hierarchy (Apollo 11 ground truth):
  FN-001 PerformLunarMission (top, parent=null)
    FN-002 ExecuteOutboundJourney (orchestrating, parent=FN-001)
      FN-010 PrepareForLaunch (orchestrating, parent=FN-002)
        FN-020 PerformPropellantLoading (leaf, parent=FN-010, refines OP-001)
        FN-021 PerformCrewIngress (leaf, parent=FN-010, refines OP-002)
      FN-011 LaunchToOrbit (orchestrating, parent=FN-002)
        FN-022 ProvideStage1Thrust (leaf, parent=FN-011, refines OP-004)
        FN-023 GuideAscentTrajectory (leaf, parent=FN-011, refines OP-005)

=== STEP 3: Functional Requirements ===
Extract ALL functional requirements with traces to function IDs.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
