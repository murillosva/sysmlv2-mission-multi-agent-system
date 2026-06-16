<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/requirements.md
  Role   : P2 sub-agent: **Requirements** extraction (Technical layer).
  Variables: {sec_tech}, {sec_req} — Technical + accumulated sections.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN — Technical Layer (Requirements):
---
{sec_tech}
---

SOURCE MARKDOWN — Functional Layer:
---
{sec_func}
---

Extract ALL requirements: MR-XXX, FR-XXX, TR-XXX.

For EACH requirement, provide:
  1. "id": Standard prefix (MR-001, FR-001, TR-001)
  2. "descriptive_name": A CamelCase name that describes what the requirement is about.
     WRONG: "MR001Requirement", "FR002Requirement", "TR003Requirement"
     RIGHT: "UASDetectionCoverageRequirement", "TargetCueingLatencyRequirement",
            "APKWSEngagementEnvelopeRequirement"
     The name should convey the requirement's subject without reading the full text.
  3. "text": Full SHALL statement in English.
  4. "rationale": 1-2 sentences explaining WHY this requirement exists — what drives it,
     what risk it mitigates, or what capability it enables. Derive from context if not
     explicitly stated.
  5. "traces_to": IDs of upper-layer elements this requirement traces to.
     MR traces to GOAL-XXX or CAP-XXX.
     FR traces to MR-XXX.
     TR traces to FR-XXX.

Example (Apollo 11 ground truth):
  MR: id="MR-001", descriptive_name="CrewReturnSafetyRequirement",
      text="The mission shall safely return all crew members to Earth.",
      rationale="This is paramount for fulfilling the core mission objective and addresses the primary concern of all stakeholders regarding human life safety.",
      traces_to=["CAP-006", "CAP-005"]

  FR: id="FR-001", descriptive_name="PropellantLoadingRequirement",
      text="The system shall enable the loading of all required propellants.",
      rationale="All propulsive stages must be fully supplied to perform their functions.",
      traces_to=["MR-001"]

  TR: id="TR-001", descriptive_name="DatalinkUpdateRateRequirement",
      text="The A-29N shall receive target coordinates via datalink at [1,10]s latency.",
      rationale="Instantaneous cueing data is critical for reducing engagement timeline vs voice baseline.",
      traces_to=["FR-003"]

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
