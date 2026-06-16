<!--
  Agent  : P2
  File   : prompts/p2_mission/sub_agents/technical.md
  Role   : P2 sub-agent: **Technical** extraction (Technical layer — components and ports).
  Variables: {sec} — Technical-layer markdown section.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE MARKDOWN (Technical Layer — Components and Ports):
---
{sec}
---

Extract technical components, port architecture, interface definitions, and named individuals.

=== STEP 1: Technical Components ===
Extract ALL technical components with their specifications.
Capture EVERY numerical parameter from source tables.

=== STEP 2: Port Flow Item Definitions (port_flow_item_defs) ===
Define 5-10 concise domain flow types representing data/energy/material exchanged between
systems. These type ALL items inside port definitions.

Example flow item defs (Apollo 11 ground truth):
  CommandSignal: "Represents a discrete command or electrical signal."
  TelemetryData: "Represents a flow of vehicle health and status data."
  ElectricalPower: "Represents a flow of electrical energy."

For a C-UAS mission, appropriate flow types might include:
  RadarTrackData, TargetCueingData, VoiceCommData, DatalinkData,
  SensorImagery, WeaponCommand, FuelFlowData, NavigationData

CRITICAL: Reuse types across ports. Do NOT create a unique type per port.

=== STEP 3: Port Definitions (port_defs) ===
Define port types as connection points on components. Each port has multiple
directional items typed by the flow item defs from Step 2.

Example (Apollo 11 ground truth):
  PayloadInterfacePort:
    inout loads: StructuralLoad
    out commands: CommandSignal
    in telemetry: TelemetryData
    out power: ElectricalPower

Each port represents a LOGICAL CONNECTION POINT, not a physical connector.
Name ports by their function: DatalinkPort, SensorDataPort, VoiceCommPort, etc.

=== STEP 4: Interface Definitions (interface_defs) ===
Define contracts for how ports connect. Each interface has two ends.
The second end is typically conjugated (~), meaning flows reverse direction.

Example (Apollo 11 ground truth):
  StagingInterface: end source: StagingPort, end target: ~StagingPort
  DockingInterface: end vehicle1: DockingPort, end vehicle2: DockingPort (symmetric)

=== STEP 5: Ports on Components ===
For each technical component, list which ports it owns in the existing "ports" field.
Use owner_tc_id to associate ports with components.
CRITICAL: For each port, set port_def_name to the name of the PortDef from Step 3
that best matches this port's function. This creates the type reference.

Ground truth pattern (Apollo 11):
  TechnicalPortsPackage defines: StagingPort, ControlPort, UmbilicalPort, DockingPort
  TechnicalComponentsPackage references them:
    SaturnVInstrumentUnit has port stageControlPort → port_def_name: "ControlPort"
    ApolloServiceModule has port umbilicalPort → port_def_name: "UmbilicalPort"
    ApolloCommandModule has port dockingPort → port_def_name: "DockingPort"

The port instance name is descriptive (e.g., "stageControlPort"), but the port_def_name
MUST match exactly one of the port defs defined in Step 3.
Every port MUST have a port_def_name referencing a port_def from Step 3.

=== STEP 6: Technical Individuals (technical_individuals) ===
Extract specifically NAMED instances of components from the source document.
These are individual, identifiable items (not types/classes).

Examples: specific bases (SBCZ, SWKU), specific aircraft (if tail numbers given),
specific radar installations. Each references the TC-ID of its type.

OUTPUT JSON SCHEMA:
{s}

Respond with a single valid JSON object matching this schema.
