<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_execution.md
  Role   : P4 refinement prompt for **MissionExecutionPackage**.
  Variables: {skeleton}, {rag_context}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

Prompt for MissionExecutionPackage.
    Few-Shot ICL via RAG: Apollo 11 timeslice/snapshot patterns as exemplars.
    Least-to-Most: generates timeline (missionTime) + docs + safe attributes first,
    then perform actions where LogicalComponent names are known from the skeleton.
