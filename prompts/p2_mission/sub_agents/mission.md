<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/mission.md
  Role   : P2 sub-agent: **Mission** extraction (Purpose layer).
  Variables: {sec_purpose}, {sec_op} — Purpose + Operational sections.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN — Purpose Layer (Program, Goals):
---
{sec_purpose}
---

SOURCE MARKDOWN — Operational Layer (Mission Phases):
---
{sec_operational}
---

Extract Mission definition, Goals, and Mission Phases.
Mission is part def (structural), NOT action def.
Phases: capture branching (e.g., PH-005 can go to PH-006 or PH-008).

For the Mission, also extract:
  - "program_name": Name of the overarching program or campaign this mission belongs to.
  - "program_description": One paragraph describing the program's purpose and scope.
  - "related_missions": Other missions or operations mentioned in the source document that
    belong to the same program/campaign. These may include prior operations, parallel
    deployments, exercises, or future phases. Mark the current mission with is_current=true.
    If no related missions are mentioned, include only the current mission.

Example (Apollo 11 ground truth):
  program_name: "ApolloProgram"
  program_description: "The United States human spaceflight program led by NASA..."
  related_missions: [
    {{"name": "Apollo1", "description": "Not flown. Crew died in launch pad fire.", "is_current": false}},
    {{"name": "Apollo7", "description": "First crewed Earth orbital CSM test.", "is_current": false}},
    {{"name": "Apollo11", "description": "First crewed lunar landing.", "is_current": true}},
    {{"name": "Apollo12", "description": "Second lunar landing.", "is_current": false}}
  ]

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
