# prompts/

Versioned exports of all system and user prompts used by the P1–P6 agents.
Each file is a plain-text Markdown file whose body is the exact string passed
to the LLM. Template variables appear as `{variable_name}` placeholders
(Python f-string syntax). A metadata comment block at the top of each file
documents the agent, role, and variables.

## Structure

```
prompts/
├── p1_preprocessing/
│   ├── system_prompt.md          # Shared system prompt for all 5 layer calls
│   ├── layer_purpose.md          # User prompt — Purpose layer   (J index 0)
│   ├── layer_operational.md      # User prompt — Operational layer (J index 1)
│   ├── layer_functional.md       # User prompt — Functional layer  (J index 2)
│   ├── layer_logical.md          # User prompt — Logical layer     (J index 3)
│   └── layer_technical.md        # User prompt — Technical layer   (J index 4)
├── p2_mission/
│   ├── system_prompt.md          # Shared system prompt for all 11 sub-agents
│   └── sub_agents/
│       ├── stakeholder.md
│       ├── capability.md
│       ├── mission.md
│       ├── context.md
│       ├── operation.md
│       ├── function.md
│       ├── logical.md
│       ├── technical.md
│       ├── requirements.md
│       ├── measures.md
│       └── specification.md
├── p4_refinement/
│   ├── system_prompt.md          # Shared system prompt for all refinement calls
│   ├── pkg_technical_components.md
│   ├── pkg_technical_ports.md
│   ├── pkg_analysis.md
│   ├── pkg_calculations.md
│   ├── pkg_context.md
│   ├── pkg_mission.md
│   ├── pkg_requirements.md
│   └── pkg_execution.md
└── p6_fixer/
    └── system_prompt.md          # Used by Tier 2 (Targeted) and Tier 3 (LLM full-rewrite)
```

## Design notes

- **Static system prompts** (`system_prompt.md` in each folder) are passed as
  the `system` parameter in every `client.messages.create()` call for that
  agent. They contain no template variables.
- **Layer/sub-agent/package prompts** are f-string templates evaluated at
  runtime with agent-specific context. Variables are listed in the metadata
  comment block of each file.
- **P3 (TemplateGeneratorClass)** and **P5 (ValidatorAgent)** are
  deterministic stages that do not call the LLM and therefore have no prompts.
  See `../templates/` for P3 Jinja2 templates.
- **P6 user prompts** are constructed dynamically by `_build_targeted_prompt()`
  (Tier 2) and `_build_user_prompt()` (Tier 3) inside `FixerAgent`. The
  system prompt in `p6_fixer/system_prompt.md` is shared by both tiers.
