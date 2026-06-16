<!--
  Agent  : P4
  File   : prompts/p4_refinement/pkg_technical_components.md
  Role   : P4 refinement prompt for **TechnicalComponentsPackage**.
  Variables: {skeleton}, {rag_context} — Jinja2-rendered skeleton + RAG examples.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

\
## TASK: Refine TechnicalComponentsPackage

Convert every /* TODO[P4]: attribute NAME = VALUE [UNIT]; */ comment into a
formal SysML v2 attribute declaration inside the enclosing `part def` block.

### PATTERNS (from Apollo 11 ground truth)
```
part def LunarModuleDescentStage :> PropelledSpacecraft, PowerConsumer, PowerProvider {{
    doc /* The lower portion of the Lunar Module. */
    attribute :>> dryMass = 2100 [kg];
    attribute :>> propellantMass = 8250 [kg];
    attribute :>> maxThrust = 45 [kN];
    attribute :>> specificImpulse = 305 ['s'];
    attribute :>> powerGenerated = 1500 [W];
    attribute :>> powerLoad = 1000 [W];
    attribute :>> failureRate = 3.0E-6 [1/h];
    port upperStagePort : LMStagingPort;
}}

part def SaturnV :> MultistageRocket, LaunchSystem {{
    attribute height :> ISQ::length = 110.6 [m];
    attribute launchMass :> ISQ::mass = 2970000 [kg];
}}
```
### IMPORTANT: Pattern selection for our model
Our components inherit from `System` or `HardwareComponent` — these do NOT declare
pre-existing attributes. Therefore, use `:>` (subsetting) for ALL new attributes:
    attribute maxSpeed :> ISQ::speed = 320 [kn];
    attribute mass :> ISQ::mass = 5840 [kg];
Do NOT use `:>>` (redefinition) unless the parent type explicitly declares that attribute.
The `:>>` examples above (dryMass, powerLoad, failureRate) apply ONLY to components that
inherit from abstract types like PropelledSpacecraft or PowerConsumer.

### UNIT MAPPING — use ONLY these symbols
Speed: [kn] for knots, [m/s] for metres per second
Length: [m], [km], [nmi] for nautical miles
Duration: [s], [min], [h]
Mass: [kg]
Force: [kN], [N]
Pressure: [kPa], [Pa]
Frequency: [Hz] ONLY (convert MHz → value×1E6, GHz → value×1E9)
Angle: ['°'] for degrees, [rad] for radians, ['arcmin'] for arcminutes
Dimensionless: use ScalarValues::Real (no unit brackets)
Boolean: use ScalarValues::Boolean
String: use ScalarValues::String = "value"

WRONG unit examples → CORRECT:
  ['knot'] → [kn]
  ['ft'/'min'] → [m/s]  (convert to SI or use defined unit)
  ['nmi'] → [nmi]
  ['arcmin'] → ['arcmin']

If a value is in non-SI units (feet, statute miles), convert to the nearest
defined unit (m, km, nmi, kn) and add // converted from X inline.

### TECHNICAL COMPONENTS DATA (from MissionAgent P2)
{_json.dumps(specs_summary, ensure_ascii=False, indent=2)}

### SKELETON TO REFINE (output this file COMPLETE, from first line to last brace)
{skeleton}
