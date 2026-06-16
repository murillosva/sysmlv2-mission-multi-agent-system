<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/stakeholder.md
  Role   : P2 sub-agent: **Stakeholder** extraction (Purpose layer).
  Variables: {sec} — Purpose-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Purpose Layer — Stakeholders and Needs):
---
{sec}
---

Extract ALL stakeholders and their needs.
For each Stakeholder: SH-XXX ID, CamelCase name, full name, role, type, influence, concerns, need_ids.
For each StakeholderNeed: SHN-XXX ID, CamelCase name, SHALL text, stakeholder_ids, source.
  Additionally, for each StakeholderNeed provide a "rationale" field: a 1-2 sentence
  justification explaining WHY this need exists and what drives it (e.g., operational
  necessity, safety concern, national mandate). If the source text does not provide
  an explicit rationale, derive one from the stakeholder's concerns and mission context.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
