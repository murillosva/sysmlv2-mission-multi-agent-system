<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/logical.md
  Role   : P2 sub-agent: **Logical** extraction (Logical layer).
  Variables: {sec} — Logical-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Logical Layer):
---
{sec}
---

Extract ALL logical components, interfaces, SoS structure.
Set is_threat=true for adversary entities.

CRITICAL — performs_fn_ids:
- Include ONLY leaf-level function IDs (those with no sub-functions).
- Each leaf FN-ID must appear in EXACTLY ONE logical component.
- Do NOT include orchestrating/parent function IDs.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
