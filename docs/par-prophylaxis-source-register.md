# PAR and Prophylaxis Source Register

Status: reviewed for the Stream 2 implementation on 2026-07-26.

This register separates source-backed clinical statements from FHIR modeling
decisions. It is not a substitute for clinical judgment or legal advice.

## Authoritative sources

1. [G-BA PAR-Richtlinie, current consolidated version](https://www.g-ba.de/richtlinien/124/)
   (version dated 2024-12-19, effective in full from 2025-07-01).
2. [G-BA overview of systematic periodontal treatment](https://www.g-ba.de/themen/zahnaerztliche-versorgung/parodontalerkrankungen/).
3. [KZBV PSI patient form](https://www.kzbv.de/wp-content/uploads/BMV-Z_Anlage14a_Vordruck_11_PSI_Muster_2021-07-01_PDF-A.pdf).
4. [KZBV PSI guidance](https://www.kzbv.de/patienten/medizinische-infos/parodontitis/der-parodontale-screening-index-psi/).
5. [DG PARO staging and grading table](https://dgparo.de/wp-content/uploads/2022/02/dg-paro-tabelle-staging-und-grading-parodontitis-2021.pdf),
   based on the 2018 consensus classification.
6. The released FHIR package
   `de.cognovis.terminology.dental.par-richtlinie@1.1.0`, produced from the
   KZBV/G-BA source audit in `fhir-terminology-de` (`fhir-term-57p` and
   `fhir-term-hzr`).

## Decisions by implementation bead

### fdde-6dt: PAR terminology

- Stage is I, II, III, or IV. Grade is A, B, or C. These are distinct axes.
- The package in source 6 is authoritative for PAR stage, grade, mobility,
  furcation, treatment need, and treatment phase. The dental IG must not
  reproduce those CodeSystems or wrapper ValueSets.
- ATG, BEV, and UPT are treatment phases. They are not periodontal
  measurement-site concepts.

### fdde-4i9: periodontal measurement sites

- G-BA PAR-RL sections 3, 11, and 13 require probing depth and bleeding on
  probing at at least two sites per tooth, including mesioapproximal and
  distoapproximal sites.
- A six-site chart is a vendor-neutral exchange superset, not a claim that the
  G-BA requires six sites. The canonical site set is mesiobuccal, buccal,
  distobuccal, mesiolingual, lingual, and distolingual.
- Clinical attachment loss is represented explicitly at the same site.
  Implementers may derive it from probing depth and recession only when their
  sign convention and inputs are known; the IG does not infer it silently.

### fdde-pky: PSI

- The KZBV form divides the dentition into six sextants and assigns the highest
  observed code 0 through 4 to each sextant.
- The star is an additional finding marker, not a replacement score. It marks
  findings such as recession or mobility.
- The reviewed KZBV sources do not define `X` as a PSI result. A sextant that
  cannot be assessed is represented with FHIR `dataAbsentReason`, not a local
  clinical result code.
- `ProphylaxisObservationDE` remains the one canonical PSI carrier.

### fdde-9ty: whole-mouth index methods

- API, QHI, PI, SBI, PBI, and GI identify different assessment methods and
  must remain machine-readable.
- The IG records the producer-selected method. It does not convert values
  between methods or claim that their scales are interchangeable.
- API and SBI are percentage-valued in the supported examples. Other methods
  retain their source scale and are not forced into percentages.

### fdde-o0m: clinical deposits

- G-BA PAR-RL section 8 refers to plaque disclosure. Sections 9 and 13
  distinguish supragingival/gingival cleaning from subgingival
  instrumentation and distinguish soft biofilm from hard deposits.
- Deposit type and anatomical location are clinical observations. Billing
  eligibility and fee codes are explicitly outside the clinical terminology.
- Tooth, implant, and pontic examples are interoperability examples; the G-BA
  source does not prescribe their FHIR representation.

### fdde-ah2: caries risk

- The existing four qualitative levels are an IG-owned exchange scale with no
  diagnostic thresholds. The prior claim that they were DG PARO-defined is
  unsupported and must be removed.
- A caries-risk assessment is distinct from a caries lesion or diagnosis.
  The IG does not derive recall or treatment recommendations from the level.

### fdde-021: mobility and suppuration

- G-BA PAR-RL section 3 defines mobility grades 0 through III. The authoritative
  package ValueSet remains the only mobility value model.
- Section 9 states that bleeding or suppuration on probing should be largely
  eliminated by anti-infective therapy. This supports an optional,
  site-identified suppuration finding, but not a claim that suppuration is a
  mandatory Parodontalstatus field.

### fdde-ktj: performer and delegation

- The exchange model preserves who performed a measurement and who asserted a
  diagnosis. It does not infer authorization or qualification from an isolated
  Observation.
- Qualification checks require resolved references plus application or server
  policy. Billing provider identity is a separate concern.
- The internal `docs/delegation-matrix.md` remains advisory and requires
  jurisdiction-specific review before operational use.

### fdde-094: CarePlan linkage

- G-BA PAR-RL section 5 requires prior payer approval for systematic PAR
  treatment and section 3 defines the supporting clinical status.
- The reviewed current PAR-RL does not establish a general hard prerequisite
  that PSI or MHU must have occurred within the previous six months.
- `CarePlan.supportingInfo` may preserve observations supporting the plan.
  `CarePlan.activity.outcomeReference` may preserve UPT follow-up findings.
  No six-month invariant is added.

### fdde-0l5: radiographic bone loss

- G-BA PAR-RL sections 3, 11, and 13 require radiographic bone loss and the
  ratio bone loss percent divided by age.
- The DG PARO grading table confirms the indirect-evidence thresholds:
  grade A below 0.25, grade B from 0.25 through 1.0, and grade C above 1.0.
- The IG exchanges measured bone-loss percentage and the derived ratio. It
  does not calculate age from the current date or assign a grade automatically.

## Open domain-review boundaries

- No hard qualification matrix is encoded in FHIR.
- No billing entitlement is inferred from deposits, indices, or performers.
- No PSI/MHU six-month application rule is encoded without a separate,
  current contractual source.
- No caries-risk thresholds, recall intervals, or treatment recommendations
  are inferred from the qualitative exchange level.
