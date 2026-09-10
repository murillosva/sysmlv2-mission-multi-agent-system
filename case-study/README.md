# Case Study: Continental ZIDA Shield Operation

## Status

The mission case study document used as pipeline input in the accompanying
paper is currently **reserved** and is not included in this repository.

## Reason

The Continental ZIDA Shield Operation is a hypothetical Brazilian Air Force
(FAB) counter-UAS mission scenario developed as part of an ongoing **Master's
thesis** at the Aeronautics Institute of Technology (ITA). Publishing
the document prior to thesis defense would compromise the originality and
novelty of the thesis contribution.

## What the paper provides

Section III.A of the paper ("Mission case study: Continental ZIDA Shield
Operation") describes the scenario in full, including:

- Mission Engineering purpose: A-29 vs. A-29N C-UAS capability comparison
- Area of operations: Continental ZIDA boundary (80 nmi), Porto Velho (SBPV)
- Red Force archetypes: multi-rotor and fixed-wing UAS
- Blue Force assets: A-29 (baseline) and A-29N (modernized, with M3AR datalink,
  Star SAFIRE II EO/IR, APKWS laser-guidance kit)
- MOS/MOE/MOP hierarchy and satisfy matrix (Table I of the case study document)
- CAP point geometry and FARP optimization

This description is sufficient to understand the pipeline inputs and to assess
the quality of the 27-package SysML v2 outputs in `../models/case-study/`.

## Availability

The case study document will be made publicly available under an open license
after the thesis is defended and deposited in the institutional repository.
The `CITATION.cff` and this file will be updated at that time with the thesis
DOI and a direct download link. This is independent of the DASC 2026 paper,
which has been accepted and will be indexed in IEEE Xplore after the conference
(see the root `README.md`).

## Running the pipeline with a different input

The pipeline (P1–P6) is not tied to this particular scenario: other
mission-engineering PDFs describing a system-of-systems (SoS), its stakeholders,
capabilities, and operational concept can be used as input. Generalization beyond
the case study reported in the paper was not empirically evaluated. To run an
end-to-end reproduction:

1. Prepare a mission PDF following the structure described in the U. S. Department of Defense, "Mission Engineering Guide," Washington, DC, 2023. [Online]. Available: https://ac.cto.mil/wp-content/uploads/2023/11/MEG_2_Oct2023.pdf
2. Set `LLM_MODEL` in Cell 2 of the notebook to your desired backbone.
3. Execute the notebook; Cell 11 will prompt you to upload the PDF.
4. The pipeline will produce a 27-package SysML v2 model in `COSME_BASE_DIR`.

## Contact

For academic collaboration requests related to the case study, please contact
the corresponding author, Murillo Szvaticsek (szvaticsek@ita.br).
