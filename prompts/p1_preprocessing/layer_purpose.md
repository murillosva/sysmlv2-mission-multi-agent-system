<!--
  Agent  : P1
  File   : prompts/p1_preprocessing/layer_purpose.md
  Role   : P1 user prompt for the **Purpose** layer (index 0 in ordered set J).
  Variables: {text} — full PDF text extracted by T_pdf.
  
  This file is a versioned export of the prompt string used in
  FINAL_multiagent_system_DASC.ipynb. Template variables appear as
  {variable_name} placeholders (Python f-string syntax). Static system
  prompts have no such placeholders.
  
  Part of: sysmlv2-mission-multi-agent-system (DASC 2026)
-->

SOURCE TEXT (complete mission case study document):
---
{text}
---

Extract the CoSMA PURPOSE LAYER from the source text above.
This layer answers: "Why does this system exist?"

Scan the ENTIRE document for content related to: mission problem definition,
program identification, stakeholders and their concerns, mission engineering
purpose, mission context and scenario, and investigative questions.

Generate ALL of the following sections:

## 1. Program
- Name the overarching program or campaign this mission belongs to.
- Provide a 1-paragraph DESCRIPTION of the program's purpose and scope.
- List ALL related missions or operations mentioned in the document that
  belong to the same program/campaign (prior operations, exercises,
  parallel deployments, future phases). For each:
  Name | Description (1 sentence) | Is Current Mission? (yes/no)
- If no related missions are mentioned, list only the current mission.
- Identify the source section.

## 2. Stakeholders
For each stakeholder identified anywhere in the document:
- ID, Name (with original-language acronym if present), English description
- Role in the mission
- Influence level (high/medium/low) and kind (direct/indirect)
- Concerns (what they care about)
Table: | ID | Name | Role | Influence Level | Influence Kind | Concerns | Source |

## 3. Stakeholder Needs
Derive formal needs from stakeholder concerns.
Table: | ID (SHN-XXX) | Need Name | Text ("The mission shall...") | Stakeholder | Source |

## 4. Mission Goals
Refine stakeholder needs into mission goals.
Table: | ID (GOAL-XXX) | Goal Name | Description | Refines SHN-ID | Source |

## 5. Capabilities
What high-level abilities must the system possess to achieve its goals?
Table: | ID (CAP-XXX) | Capability Name | Description | Supports GOAL-ID | Source |

## 6. Mission Context
Extract ALL of the following that are present in the document:
- Scenario purpose and scope
- Epoch / time horizon
- Area of operations (coordinates, boundaries, geographic constraints)
- Geopolitical context (borders, treaties, agreements)
- Vignette scope (if applicable)
- Operating environment conditions:
  - Climate / weather (temperature ranges, visibility, precipitation)
  - Terrain type (jungle, desert, maritime, urban, mountainous)
  - Elevation / altitude ranges
  - Electromagnetic environment (if mentioned)
  Table: | Condition | Value/Description | Source |
If any of these are not stated, write "TBD — not stated in source".

## 7. External Systems and Participants
List all systems and actors that interact with the mission system of interest.
Classify each as: SystemOfInterest | ExternalSystem | ConstituentSystem | Threat
Table: | Name | Type | Role in Mission | Key Interactions | Source |

## 8. Mission Configurations (MEG §5.3)
If the document describes multiple system configurations (baseline vs. alternatives):
- Name each configuration and its key distinguishing features
- If only one configuration exists, state "Single configuration"
Table: | Config ID | Label | Key Features | Source |

## 9. Investigative Questions
List the research questions that drive the mission analysis (if stated).
Table: | IQ-ID | Question | Related MOS (if any) | Source |
