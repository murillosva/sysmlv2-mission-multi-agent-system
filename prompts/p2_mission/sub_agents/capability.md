<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/capability.md
  Role   : P2 sub-agent: **Capability** extraction (Purpose layer).
  Variables: {sec} — Purpose-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Purpose Layer — Capabilities):
---
{sec}
---

Extract ALL capabilities. CAP-XXX IDs, CamelCase names, descriptions, GOAL IDs.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
