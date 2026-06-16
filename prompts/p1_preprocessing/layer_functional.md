<!--
  Agent  : P1
  File   : prompts/p1_preprocessing/layer_functional.md
  Role   : P1 user prompt for the **Functional** layer. Receives Purpose+Operational context.
  Variables: {text}, {purpose_md}, {operational_md}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

ACCUMULATED CONTEXT (Purpose + Operational layers):
---
### PURPOSE LAYER
{purpose_md[:12000]}

### OPERATIONAL LAYER
{operational_md[:12000]}
---

SOURCE TEXT (complete mission case study document):
---
{text}
---

Extract the CoSMA FUNCTIONAL LAYER from the source text.
This layer answers: "What does the system need to do?" — implementation-agnostic.

Generate ALL of the following sections:

## 1. Top-Level Function
Define the single top-level function (FN-001) that encompasses the entire mission.

## 2. Functional Decomposition
Decompose into a MULTI-LEVEL HIERARCHY of sub-functions.
Do NOT make all functions direct children of FN-001 — create intermediate
grouping levels that organize related functions.

REQUIRED STRUCTURE (follow this principle):
- Level 1: FN-001 (top-level mission function) — NO Refines OP-ID
- Level 2: Major functional areas that group related sub-functions
  (e.g., logistics, surveillance, engagement, assessment) — NO Refines OP-ID
- Level 3+: Further decomposition as needed until reaching leaf functions
  — intermediate levels have NO Refines OP-ID
- Leaf level: Concrete, atomic actions that are each allocatable to a single
  logical component and each refines exactly ONE operation — MUST have Refines OP-ID

STRUCTURAL RULES:
- Aim for 3-4 levels of depth. Flat hierarchies (all children of FN-001) are WRONG.
- Only LEAF functions (those with no children) should have Refines OP-ID filled.
- Orchestrating functions (those with children) must have Refines OP-ID = "" (empty).
- The number of functions per level depends on the mission complexity — let the
  source document drive the decomposition, not a fixed count.

EXAMPLE PATTERN (Apollo 11 ground truth):
  FN-001 PerformLunarMission (Level 1, parent=None)
    FN-002 ExecuteOutboundJourney (Level 2, parent=FN-001)
      FN-010 ProvideStage1Thrust (leaf, parent=FN-002, refines OP-004)
      FN-011 GuideAscentTrajectory (leaf, parent=FN-002, refines OP-005)
    FN-003 ConductLunarOperations (Level 2, parent=FN-001)
      FN-020 ExecuteDescentBurn (leaf, parent=FN-003, refines OP-012)

If a kill chain was identified, map each leaf function to its step.
Table: | FN-ID | Function Name | Description | Inputs | Outputs | Parent FN-ID | Refines OP-ID | Kill Chain Step | Source |

## 2.5 Data Item Definitions
List all distinct data items that flow between functions (inputs/outputs
from §2). These become `item def` in SysML v2.
Table: | Item Name (CamelCase) | Description | Produced by FN-ID | Consumed by FN-ID | Data Type (signal/message/stream/physical) | Source |
Examples: TargetCueingData, RadarTrack, EngagementAuthorization,
WeaponReleaseCommand, SurveillanceImagery, BDAReport

## 3. Functional Differences by Configuration
If multiple configurations exist, describe how each function differs.
Table: | FN-ID | Function Name | Baseline Behavior | Alternative Behavior | Notes |
If single configuration, write "Single configuration — no differences".

## 4. Functional Requirements
Table: | FR-ID | Requirement Text (\"The system shall...\") | Rationale (WHY) | Traces to FN-ID | Source |
For "Rationale": 1-2 sentences explaining WHY. Derive from context if not stated.
