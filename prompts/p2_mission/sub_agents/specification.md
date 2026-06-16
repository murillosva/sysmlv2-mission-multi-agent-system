<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/specification.md
  Role   : P2 sub-agent: **Specification** extraction (traceability consolidation).
  Variables: {traceability_ctx} — accumulated context from all preceding sub-agents.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

EXTRACTED DATA SUMMARY (traceability from all sub-agents):
---
{traceability_ctx}
---

Generate cross-cutting satisfy and refine links.

SATISFY links (requirement_id satisfied_by component/function):
  MR-XXX satisfied by OP-XXX ONLY (operations that fulfill mission requirements)
  FR-XXX satisfied by FN-XXX ONLY (leaf functions that fulfill functional requirements)
  TR-XXX satisfied by TC-XXX or LC-XXX (components that fulfill technical requirements)

SEMANTIC CORRELATION RULES for satisfy links:
  - Each requirement MUST have at least 1 satisfy link.
  - A requirement MAY have MULTIPLE satisfy links if multiple operations/functions/components
    jointly fulfill it (add one satisfy_links entry per correlation).
  - Example: MR-001 "Neutralize UAS before 80 nm boundary" may be satisfied by:
      OP-XXX "DetectIllicitUAS", OP-XXX "IdentifyUASThreat", OP-XXX "ExecuteFiring".
  - Use the descriptions and names to match semantics — do NOT correlate by ID patterns.
  - For methodological or stochastic requirements (e.g., "shall use Monte Carlo methodology",
    "shall model stochastically") that describe HOW the system is analyzed rather than a
    component/function behavior, OMIT the satisfy link entirely. These requirements are
    fulfilled by the modeling approach itself, not by a specific system feature.


REFINE links — use EXACTLY these relationship strings:
  "goal_refines_stakeholder_need": source_id=GOAL-XXX, target_id=SHN-XXX
  "capability_refines_goal": source_id=CAP-XXX, target_id=GOAL-XXX
  "mission_requirement_refines_capability": source_id=MR-XXX, target_id=CAP-XXX
  "functional_requirement_refines_mission_requirement": source_id=FR-XXX, target_id=MR-XXX
  "technical_requirement_refines_functional_requirement": source_id=TR-XXX, target_id=FR-XXX
  "function_refines_operation": source_id=FN-XXX, target_id=OP-XXX

Generate ALL applicable links. Every Goal MUST refine at least one SHN.
Every Capability MUST refine at least one Goal.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
