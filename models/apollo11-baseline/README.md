# models/apollo11-baseline/

Apollo 11 SysML v2 model used as the RAG knowledge base (P4 `T_RAG` tool)
and as In-Context Learning examples (P1, P2) in the pipeline described in the
accompanying DASC 2026 paper.

## Upstream source

| Field | Value |
|-------|-------|
| Repository | https://github.com/airbus/apollo-11-sysml-v2 |
| Branch | `main` |
| Version tag | `v1.0.0` (per upstream `CITATION.cff`) |
| Retrieved | 2026-02-19 (date recorded in `.meta.json` workspace file) |
| Licence | Mozilla Public License 2.0 — see `LICENSE-MPL-2.0.md` |
| Copyright | © 2026 AIRBUS and its affiliates |

Original work: Helle, P. & Schramm, H. "Fly me to the Moon: Modeling Apollo 11
using SysML v2." Submitted to INCOSE Systems Engineering (unpublished at time of
retrieval). See also `../../NOTICE` for full attribution.

> **Note on upstream divergence.** The upstream repository received 3 additional
> commits after this version was retrieved, changing 5 of the 28 packages
> (`CoSMA/CoSMAPackage`, `Execution/Apollo11MissionExecutionPackage`,
> `Purpose/CapabilitiesPackage`, `Purpose/MissionPackage`,
> `Technical/TechnicalComponentsPackage`). The files in this folder are the
> version actually used in the paper's evaluation runs. The `MANIFEST.sha256`
> file provides SHA-256 checksums for all 28 packages for independent
> verification.

## Contents (28 packages)

```
apollo11-baseline/
├── Apollo11Model.sysml              ← Root model
├── Analysis/
│   ├── AnalysisPackage.sysml
│   └── CalculationsPackage.sysml
├── CoSMA/
│   ├── CoSMAPackage.sysml
│   ├── CoSMAQuantitiesAndUnitsPackage.sysml
│   └── CoSMAViewsPackage.sysml
├── Execution/
│   └── Apollo11MissionExecutionPackage.sysml
├── Function/
│   ├── FunctionSpecificationPackage.sysml
│   └── FunctionsPackage.sysml
├── Logical/
│   └── LogicalComponentsPackage.sysml
├── Operation/
│   └── OperationsPackage.sysml
├── Program/
│   └── ProgramPackage.sysml
├── Purpose/
│   ├── CapabilitiesPackage.sysml
│   ├── ContextPackage.sysml
│   ├── MissionPackage.sysml
│   ├── MissionPhasesPackage.sysml
│   ├── MissionSpecificationPackage.sysml
│   └── StakeholderPackage.sysml
├── Requirements/
│   ├── FunctionalRequirementsPackage.sysml
│   ├── MissionRequirementsPackage.sysml
│   ├── StakeholderNeedsPackage.sysml
│   └── TechnicalRequirementsPackage.sysml
└── Technical/
    ├── AstronautsPackage.sysml
    ├── SystemPackage.sysml
    ├── SystemSpecificationPackage.sysml
    ├── TechnicalComponentsPackage.sysml
    ├── TechnicalIndividualsPackage.sysml
    └── TechnicalPortsPackage.sysml
```

## Licence notice

These files are licensed under the Mozilla Public License 2.0.
The MPL 2.0 permits redistribution provided that:
- The original copyright notice is preserved (present in each `.sysml` file).
- The licence text accompanies any redistribution (`LICENSE-MPL-2.0.md`).
- Modifications, if any, are distributed under the same licence.

**No modifications have been made to any file in this folder.**
