# templates/

Jinja2 templates (`.j2`) for the 24 SysML v2 packages generated deterministically
by `TemplateGeneratorClass` (P3), plus the 3 static CoSMA Framework packages
(`.sysml`) licensed under MPL 2.0 from Airbus.

P3 is a **deterministic** stage: given the same `PipelineState` (output of P2),
`generate_all()` always produces bit-identical SysML v2 skeletons. These skeletons
are then refined by P4 (RefinementAgent) and validated/corrected by P5 ⇌ P6.

## Folder structure

Each subfolder corresponds to a CoSMA layer or cross-cutting package family:

| Folder | Packages |
|--------|----------|
| `purpose/` | StakeholderPackage, CapabilitiesPackage, MissionPackage, MissionPhasesPackage, MissionSpecificationPackage, ContextPackage |
| `operation/` | OperationsPackage |
| `function/` | FunctionsPackage, FunctionSpecificationPackage |
| `logical/` | LogicalComponentsPackage |
| `technical/` | SystemPackage, SystemSpecificationPackage, TechnicalComponentsPackage, TechnicalPortsPackage, TechnicalIndividualsPackage |
| `requirements/` | StakeholderNeedsPackage, MissionRequirementsPackage, FunctionalRequirementsPackage, TechnicalRequirementsPackage |
| `analysis/` | AnalysisPackage, CalculationsPackage |
| `program/` | ProgramPackage |
| `execution/` | MissionExecutionPackage |
| `root/` | RootModel |
| `cosma_framework/` | CoSMAPackage, CoSMAQuantitiesAndUnitsPackage, CoSMAViewsPackage (**MPL 2.0**, Airbus) |

## Template variables

Jinja2 templates receive a context dict prepared by the corresponding `_prep_*`
method in `TemplateGeneratorClass`. Common variables:

| Variable | Type | Description |
|----------|------|-------------|
| `mission_name` | `str` | SysML-safe identifier derived from the mission name |
| `stakeholders` | `list[dict]` | Extracted stakeholder records from P2 |
| `capabilities` | `list[dict]` | Capability records with `refine` links |
| `operations` | `list[dict]` | Operational records |
| `functions` | `list[dict]` | Functional records |
| `requirements` | `list[dict]` | Requirement records with `satisfy` links |
| `measures` | `list[dict]` | MOS/MOE/MOP records |

See `TemplateGeneratorClass._prep_*()` methods in the notebook for the full
context prepared for each template.

## License note

Files in `cosma_framework/` are © 2026 AIRBUS and its affiliates, licensed
under the **Mozilla Public License 2.0**. See `../NOTICE` for full attribution.
All other files are © 2026 Murillo S. Szvaticsek, MIT license.
