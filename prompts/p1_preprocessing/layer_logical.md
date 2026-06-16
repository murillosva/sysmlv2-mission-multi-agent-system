<!--
  Agent  : P1
  File   : prompts/p1_preprocessing/layer_logical.md
  Role   : P1 user prompt for the **Logical** layer.
  Variables: {text}, {purpose_md}, {operational_md}, {functional_md}
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

ACCUMULATED CONTEXT (Purpose + Operational + Functional layers):
---
### PURPOSE LAYER
{purpose_md[:8000]}

### OPERATIONAL LAYER
{operational_md[:8000]}

### FUNCTIONAL LAYER
{functional_md[:12000]}
---

SOURCE TEXT (complete mission case study document):
---
{text}
---

Extract the CoSMA LOGICAL LAYER from the source text.
This layer answers: "What abstract parts are responsible for which functions?"

Generate ALL of the following sections:

## 1. Logical Components
List all PLATFORM-LEVEL abstract system components (implementation-independent).
A Logical Component represents a major mission role or actor — NOT a subsystem,
sensor, weapon, or communication device.

ABSTRACTION PRINCIPLE: Ask "what major platform or actor is responsible for this
group of functions?" — not "what specific equipment does it use?"
Subsystems, sensors, weapons, and communication links belong in the Technical
Layer (as Technical Components, ports, or interfaces), not here.

CORRECT examples: an interceptor aircraft platform, an airborne surveillance
platform, a ground control network, a threat entity class, a logistics system.
WRONG examples: a specific radar, a specific sensor, a specific rocket type,
a datalink radio, a weapon guidance kit — these are Technical Components.

The number of Logical Components depends entirely on the mission's structure.
Simple missions may have 3-5; complex Systems-of-Systems may have 10+.
Let the source document drive the count — do not inflate or deflate artificially.

Include friendly forces, external systems, and threat entities.
Table: | LC-ID | Component Name | Mission Role | Type (Friendly/External/Threat) | Source |

## 2. Function Allocation (Leaf Functions Only)
Allocate ONLY leaf-level functions (those with NO sub-functions in §2 of the
Functional Layer) to logical components. Each leaf function must be allocated
to EXACTLY ONE logical component — no duplication across LCs.
Do NOT allocate orchestrating/parent functions (those that compose sub-functions).
Table: | LC-ID | Component Name | Performs FN-ID (leaf only) | Function Name |

## 3. Logical Interfaces
Table: | From LC-ID | To LC-ID | Information Flow | Type (Data/Command/Status) | Source |

## 4. Mission System Composition (SoS)
Describe the System of Systems structure: which logical components are
constituents, what is the governance model, which are threat entities.
