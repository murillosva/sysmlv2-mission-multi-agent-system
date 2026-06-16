<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_technical_ports.md
  Role   : P4 refinement prompt for **TechnicalPortsPackage**.
  Variables: {skeleton}, {rag_context}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

\
## TASK: Refine TechnicalPortsPackage

Convert every /* TODO[P4]: direction: DIR | item: ITEM | owner: TC-XXX */ comment
into a formal SysML v2 item declaration inside the enclosing `port def` block.

### PATTERN
```
port def RadioFrequencyPort {{
    doc /* RF signal port for C2 link */
    in item commandSignal   : ScalarValues::Real;
    out item telemetryData  : ScalarValues::Real;
}}
```

### PORT DATA (from MissionAgent P2)
{_json.dumps(ports_summary, ensure_ascii=False, indent=2)}

### SKELETON TO REFINE (output this file COMPLETE, from first line to last brace)
{skeleton}
