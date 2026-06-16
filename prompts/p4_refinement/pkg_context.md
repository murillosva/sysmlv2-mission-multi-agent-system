<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_context.md
  Role   : P4 refinement prompt for **ContextPackage**.
  Variables: {skeleton}, {rag_context}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

\

## TASK: Refine ContextPackage

Enrich the external system `part def` blocks with:
1. Attributes for location (name, coordinates, description) where known
2. Environment `part def` blocks describing the physical operating environment

### CRITICAL RULES
- Do NOT modify imports or the Context part def structure.
- Do NOT remove any existing `part def` or `part` declarations.
- ADD attributes inside existing `part def` blocks using pattern:
    attribute name : ScalarValues::String = "value";
    attribute coordinates : ScalarValues::String = "lat, lon";
- ADD environment `part def` blocks BEFORE the Context part def, using pattern:
    part def OperatingEnvironment {{{{
        doc /* Physical environment description */
        attribute temperature :> ISQ::thermodynamicTemperature = 305 [K];
        attribute pressure :> ISQ::pressure = 101325 [Pa];
    }}}}
- Use ISQ types for physical quantities, ScalarValues::String for text.

### CORRECT PATTERN (Apollo 11 ground truth)

```
part def EarthEnvironment {{{{
    doc /* The starting and ending physical environment. */
    attribute surfaceGravity :> ISQ::acceleration = 1 [gn];
    attribute standardAtmosphericPressure :> ISQ::pressure = 101325 [Pa];
}}}}

part def LaunchSite :> System {{{{
    doc /* The ground facility from which the mission originates. */
    attribute name : ScalarValues::String = "Kennedy Space Center";
    attribute location : ScalarValues::String = "Merritt Island, Florida, USA";
    attribute geographicCoordinates : ScalarValues::String = "28.57 N, 80.65 W";
}}}}
```

### CONTEXT DATA
Geographic references: {_json.dumps(geo_refs, ensure_ascii=False, indent=2)}
Operational boundaries: {_json.dumps(boundaries, ensure_ascii=False, indent=2)}
External systems: {ext_json}

### SKELETON TO REFINE (output this file COMPLETE, from first line to last brace)
{skeleton}
