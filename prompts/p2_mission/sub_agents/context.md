<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/context.md
  Role   : P2 sub-agent: **Context** extraction (Purpose layer).
  Variables: {sec} — Purpose-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Purpose Layer — Context):
---
{sec}
---

Extract Mission Context: scenario, epoch, area of operations, geopolitical context,
bases of operation, patrol/waypoints, logistics points, operational boundaries, external systems.
Use exact coordinates from source tables when available.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
