<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_mission.md
  Role   : P4 refinement prompt for **MissionPackage** and related purpose packages.
  Variables: {skeleton}, {rag_context}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

\
## TASK: Refine MissionPackage

Add `doc /* if "..." */` blocks to each transition in the exhibit state machine.

### CRITICAL RULES
- Do NOT modify any structural element (part def, requirements, parts, connections).
- Do NOT modify the state declarations or transition targets.
- ONLY add `doc` blocks to transitions that accept a notification.
- The doc should describe the conditions under which the transition fires.
- Use the phase entry/exit triggers from the data below.
- The first transition (initial -> first phase) has no doc.

### CORRECT PATTERN (Apollo 11 ground truth)

```
transition first preparation accept PreparationPhaseCompletedNotification then launch {{
    doc /* if "all preparations concluded successfully" */
}}

transition first launch accept LaunchPhaseCompletedNotification then tli {{
    doc /* if "Successful insertion into stable Earth parking orbit" and
        "All spacecraft systems verified nominal or go for TLI" */
}}
```

### PHASE TRANSITION DATA
{_json.dumps(phase_docs, ensure_ascii=False, indent=2)}

### SKELETON TO REFINE (output this file COMPLETE, from first line to last brace)
{skeleton}
