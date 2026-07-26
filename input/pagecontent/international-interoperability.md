# International Interoperability

This page describes how the German Dental FHIR Profiles (fhir-dental-de) relate to international dental FHIR specifications and provides guidance for cross-border data exchange.

## Version Baseline

This crosswalk is version-bound. The following releases were checked for this
IG version:

| IG | Country | Status | Profiles | Focus |
|---|---|---|---|---|
| **fhir-dental-de** (this IG) | Germany | v0.40.0 Trial Use | 28 profiles, 43 extensions | Full dental workflow: clinical + billing + care plans + imaging + lab |
| [**MedMij Dental Care**](https://simplifier.net/guide/medmij-r4-dentalcare-ig/Home?version=1.0.0-rc.1) | Netherlands | v1.0.0-rc.1 Release Candidate | 6 profiles, 0 extensions | Clinical findings + procedures |
| [**HL7 Dental Data Exchange**](https://hl7.org/fhir/us/dental-data-exchange/) | United States | v1.0.0 STU 1, current published release | 7 profiles | Referral and consultation exchange |
| [**HL7 Dental Data Exchange**](https://build.fhir.org/ig/HL7/dental-data-exchange/) | United States | v2.0.0-ballot CI build, mutable and not an authorized publication | 7 profiles | Crosswalk target used on this page |
| [**Da Vinci PAS**](https://hl7.org/fhir/us/davinci-pas/) | United States | v2.2.1 STU 2, current published release | n/a | Prior authorization |

DDEx 1.0.0 remains the stable package registry release. The crosswalk below
uses DDEx 2.0.0-ballot as requested because it reflects the current ballot
model, but implementations must not treat the CI output as stable. Producers
and transformation specifications should record the exact DDEx version they
target.

The local build is pinned to `de.basisprofil.r4` 1.5.4, `kbv.basis` 1.9.0,
and `de.cognovis.fhir.praxis` 0.85.0. These are the tested compatibility
versions for fhir-dental-de 0.40.0; they are not claims about the newest release
available in every upstream registry.

The [FDI World Dental Federation](https://www.fdiworlddental.org/) published a
[consensus statement on integrated EHRs](https://www.fdiworlddental.org/sites/default/files/2025-03/FDI_EHR_Consensus%20Statement_Web.pdf)
in March 2025 advocating FHIR-based interoperability but does not author a FHIR
IG.

## Comparison with MedMij Dental Care IG (Netherlands)

The [MedMij R4 Dental Care IG v1.0.0-rc.1](https://simplifier.net/guide/medmij-r4-dentalcare-ig/Home?version=1.0.0-rc.1)
is maintained by Stichting MedMij and Nictiz. It takes a fundamentally
different architectural approach: minimal dental-specific profiles with heavy
reliance on shared nl-core base profiles. The release is explicitly still in
its release-candidate phase.

### Profile Correspondence

| Clinical Domain | fhir-dental-de | MedMij Dental Care | Assessment |
|---|---|---|---|
| **Dental findings** | DentalFindingDE (Observation) | *(no generic finding profile)* | DE is more comprehensive |
| **Caries risk** | *(covered by DentalFindingDE)* | mz-CariesRisk (Observation, SNOMED 74024006) | NL has dedicated profile |
| **Oral hygiene** | ProphylaxisObservationDE (Observation) | mz-OralHygiene (Observation, SNOMED 364126007) | Comparable; DE includes plaque/gingivitis indices |
| **Periodontal screening** | PeriodontalObservationDE (Observation) | mz-PeriodicPeriodontalScreeningScore (Observation) | DE significantly more granular (6-point probing, BOP, recession, furcation per tooth); NL captures aggregate PSI/PSR only |
| **Parafunctional habits** | OralHealthScreeningDE (Observation, SNOMED 110353005) | mz-ParafunctionalActivity (Observation, SNOMED 110353005) | Both profiled; DE extends beyond habits to include oral risk factors and systemic screening |
| **Dental fitness** | *(not profiled)* | mz-DentalFitness (Observation) | NL-specific (military screening) |
| **Procedures** | DentalProcedureDE (Procedure, BEMA/GOZ) | mz-Procedure (Procedure, Vektis Mondzorg 010) | Both use single unified profile; different national code systems |
| **Conditions** | DentalConditionDE (Condition, ICD-10-GM) | *(uses nl-core-Condition)* | DE has dedicated dental profile; NL uses generic |
| **Care plans** | DentalCarePlanDE (CarePlan, 7 category types) | *(uses nl-core-TreatmentObjective/Goal)* | DE significantly richer; NL defers to generic Goal |
| **Imaging** | DentalImagingStudyDE (ImagingStudy, DICOM) | *(not profiled)* | Only in DE |
| **Lab orders** | DentalLabServiceRequestDE (ServiceRequest) | *(not profiled)* | Only in DE |
| **Billing** | BemaChargeItemDE + GozChargeItemDE | *(not profiled; billing via procedure codes)* | Only in DE |
| **Communication** | DentalCommunicationDE | *(not profiled)* | Only in DE |

### Terminology Comparison

| Domain | fhir-dental-de | MedMij Dental Care |
|---|---|---|
| Procedure codes | BEMA + GOZ (German statutory/private) | Vektis Prestatiecodelijst Mondzorg 010 (Dutch) |
| Diagnosis codes | ICD-10-GM (required) | SNOMED CT (via nl-core-Condition) |
| Observation codes | Curated SNOMED CT pick list (extensible; additional codes such as LOINC remain permitted) | SNOMED CT (fixed per profile) |
| Tooth numbering | FDI (ISO 3950) with dual SNOMED coding | Not explicitly exposed in IG |
| Tooth surfaces | Custom + SNOMED CT dual coding | Not profiled |

### Architectural Comparison

| Dimension | fhir-dental-de | MedMij Dental Care |
|---|---|---|
| **Philosophy** | Self-contained dental specification | Inherit common, define only dental-unique |
| **Base profiles** | Extends FHIR R4 directly | Extends nl-core (Dutch national base) |
| **Extensions** | 43 custom (billing, insurance, specialty-specific) | None (uses nl-core patterns) |
| **Treatment types** | Category-based routing in unified CarePlan | Meta-tags + generic Goal |
| **Billing integration** | Dedicated ChargeItem profiles | Embedded in procedure codes |
| **Maturity** | v0.40.0 Trial Use | v1.0.0-rc.1 Release Candidate |

### Harmonization Opportunities

Despite their different architectures, the two IGs share a common clinical foundation that can be harmonized:

1. **SNOMED CT dental mapping** — Both IGs use SNOMED CT for clinical concepts. A shared European SNOMED CT dental value set (covering caries risk, oral hygiene, periodontal findings, parafunctional habits) would benefit both IGs and any future European dental IG.

2. **Periodontal assessment** — fhir-dental-de's granular PeriodontalObservationDE (6-point probing, BOP, recession, furcation) and MedMij's aggregate PeriodicPeriodontalScreeningScore are complementary. An aligned approach could define a base screening level (NL-style PSI) with an optional detailed level (DE-style per-tooth components).

3. **Procedure coding bridge** — Neither BEMA/GOZ nor Vektis Mondzorg codes are internationally portable. SNOMED CT procedure concepts could serve as a European lingua franca, with national codes as primary bindings and SNOMED CT as secondary (similar to fhir-dental-de's dual-coding strategy for tooth identification).

4. **FDI tooth identification** — fhir-dental-de already uses FDI (ISO 3950) as the international standard. MedMij does not currently expose tooth-level data. Adopting FDI across both IGs would enable tooth-level data exchange without code system translation.

## DDEx 2.0.0-ballot Profile Correspondence

The following table maps fhir-dental-de profiles to their closest equivalents
in DDEx 2.0.0-ballot. The same seven profile families are present in the
published DDEx 1.0.0 release, but implementers must validate differences
against the release they actually exchange.

| fhir-dental-de Profile | Base Resource | HL7 Dental Data Exchange Equivalent | Notes |
|---|---|---|---|
| DentalFindingDE | Observation | Dental Finding | Both are Observation-based, but terminology breadth and multi-site representation differ. See the transformation rules below. |
| DentalConditionDE | Condition | Dental Condition | Both are Condition-based. DE binds `code` to ICD-10-GM; DDEx uses US-oriented diagnosis and finding terminologies. |
| DentalProcedureDE | Procedure | US Core Procedure used by DDEx examples | DE uses BEMA/GOZ procedure codes; DDEx does not define a dental Procedure profile. No 1:1 billing-code mapping exists. |
| DentalCommunicationDE | Communication | Dental Communication | Structurally aligned. Both carry dental-category payload. |
| BemaChargeItemDE | ChargeItem | *(no US equivalent)* | GKV billing (BEMA). US uses Claim directly; ChargeItem is not profiled in the US IG. |
| GozChargeItemDE | ChargeItem | *(no US equivalent)* | PKV billing (GOZ) with fee multiplier (`Steigerungsfaktor`). No US counterpart. |
| DentalCarePlanDE (type: hkp) | CarePlan | *(no DDEx equivalent)* | Treatment plan / prior authorization. US authorization uses [Da Vinci PAS 2.2.1](https://hl7.org/fhir/us/davinci-pas/), not DDEx. |
| DentalCarePlanDE (type: kfo) | CarePlan | *(no US equivalent)* | Orthodontic treatment plan with KIG classification. |
| DentalCarePlanDE (type: par) | CarePlan | *(no US equivalent)* | Periodontal treatment plan (PAR-Richtlinie). |
| DentalCarePlanDE (type: ze) | CarePlan | *(no US equivalent)* | Dental prosthetics plan (Zahnersatz HKP). |

## Terminology Mapping

### Tooth Identification

Germany and most countries use the FDI two-digit notation (ISO 3950). The US uses ADA Universal Numbering. Both can be bridged via SNOMED CT anatomical tooth concepts.

| System | Example (lower left first molar) | CodeSystem URI |
|---|---|---|
| FDI (ISO 3950) | `36` | `http://terminology.hl7.org/CodeSystem/ex-tooth` |
| ADA Universal Numbering | `19` | Used in US IG via SNOMED mapping |
| SNOMED CT | `38671000` "Permanent lower left first molar" | `http://snomed.info/sct` |

fhir-dental-de uses FDI as the primary coding in `bodySite` and adds SNOMED CT as a secondary coding where a corresponding concept exists. This dual-coding strategy enables US IG consumers to interpret tooth references without understanding FDI notation.

### Tooth Surfaces

Dental surfaces use different code sets and representation models across
jurisdictions. Some concepts align exactly; others require a context-sensitive,
potentially lossy transformation.

| Surface | FDI Abbreviation (DE) | ADA Tooth Surface Code (US) | SNOMED CT |
|---|---|---|---|
| Mesial | M | M | `245647007` |
| Distal | D | D | `245645004` |
| Occlusal | O | O | `245653009` |
| Incisal | I | I | `245652004` |
| Buccal / Vestibular | B / V | B | `245649005` |
| Lingual | L | L | `362103001` |
| Palatal | P | *(not separate — often represented as L)* | `245651006` |

fhir-dental-de attaches a repeatable `tooth-surfaces` extension to the
tooth-bearing `bodySite` CodeableConcept. DDEx does **not** represent multiple
surfaces as repeated `targetSiteCode` values. DDEx 2.0.0-ballot keeps the FHIR
R4 `Observation.bodySite` cardinality at `0..1` and instructs producers to use
a single post-coordinated SNOMED CT expression when several teeth, surfaces, or
oral areas apply.

### Tooth Surface Transformation Matrix

| Direction | Source representation | Target representation | Rule and loss handling |
|---|---|---|---|
| fhir-dental-de to DDEx | One FDI/SNOMED tooth in `bodySite`, plus repeated `tooth-surfaces` extensions | One post-coordinated SNOMED CT concept in `Observation.bodySite` | Compose the tooth and every surface into one expression. Preserve the original codings or source resource for audit. |
| DDEx to fhir-dental-de | One post-coordinated SNOMED CT expression | Tooth coding in `bodySite`, one extension per surface | Parse only expressions supported by the receiving terminology service. If decomposition is not lossless, retain the original expression and emit a mapping warning. |
| B/V or L/P exchange | Jurisdiction-specific surface distinction | Broader or differently partitioned target code | Never collapse silently. Mark the mapping as potentially lossy because vestibular versus buccal and palatal versus lingual may depend on tooth position and source convention. |

This is a structural transformation, not a terminology-only ConceptMap. A
StructureMap or adapter transformation may implement it, while a ConceptMap can
only support the individual code correspondences.

### Procedure Codes

| Germany | US | Scope |
|---|---|---|
| BEMA (Bewertungsmassstab Zahnaerzte) | CDT (Current Dental Terminology, ADA) | Public insurance procedures |
| GOZ (Gebuehrenordnung fuer Zahnaerzte) | CDT | Private fee-schedule procedures |

There is no 1:1 mapping between BEMA/GOZ and CDT. The procedure concepts overlap clinically (e.g., "two-surface composite restoration" exists in both systems), but the code structures, numbering, and granularity differ fundamentally. Cross-system mapping requires clinical concept matching, not code translation.

### Diagnosis Codes

| Germany | US | International |
|---|---|---|
| ICD-10-GM (BfArM) | ICD-10-CM (CDC/CMS) | SNOMED CT |

Both ICD-10 variants share a common stem (WHO ICD-10) but diverge at the extension level. SNOMED CT can serve as a bridge terminology for clinical concepts, though coverage of dental diagnoses varies.

## Clinical Semantics Transformation

### Periodontal and Prophylaxis Crosswalk

The following correspondences are transformation guidance, not claims of
profile equivalence. Direct terminology coding is used only where the
international concept represents the same measurement or finding.

| German model | International target | Relationship and transformation |
|---|---|---|
| Caries risk | MedMij `mz-CariesRisk`, SNOMED CT `74024006` | The high-level concept is shared. Risk levels are only partially equivalent and require a value-by-value mapping. |
| Oral hygiene | MedMij `mz-OralHygiene`, SNOMED CT `364126007` | The concept is shared. Local values must be mapped to the applicable SNOMED CT qualifiers. |
| PSI | MedMij `mz-PeriodicPeriodontalScreeningScore` (PPS) | Lossy screening crosswalk, not equivalence. PSI 0, 1, or 2 may map to PPS 1; PSI 3 to PPS 2; and PSI 4 to PPS 3. Bleeding, calculus, the star marker, excluded sextants, and sextant structure are not preserved by that reduction. |
| Probing depth | LOINC `32910-2` "Probing depth {Tooth}.{probe site} Measured" | Direct international coding. Preserve the tooth, one of the six canonical probe sites, value, and UCUM unit. |
| Radiographic alveolar bone loss | SNOMED CT `109706009` "Alveolar bone loss" | Direct international coding. Preserve the measured percentage and the reference tooth separately from the finding code. |
| API, QHI, or PI | LOINC `32953-2` "Plaque index Dentition Calculated" | `related-to` unless the source and target methods, denominator, and scoring rules are demonstrably identical. Do not relabel a method-specific local index as an exact LOINC match. |
| SBI, PBI, or BOP index | LOINC `32951-6` "Bleeding on probing index Gingiva Calculated" | `related-to` unless method and calculation are identical. A site-level BOP boolean is not the calculated whole-gingiva index. |
| PAR or other dental finding | DDEx 2.0.0-ballot Dental Finding | Profile and element crosswalk only. Resource boundary, code breadth, and body-site representation require the rules in this page. |

This IG deliberately does not add package dependencies on the MedMij release
candidate or the mutable DDEx ballot build. Version-bound narrative mappings
remain stable for publication; future executable transformations may add
governed ConceptMaps for terminology and StructureMaps for resource shape.

### Finding Codes

`DentalFindingCodesVS` is a curated, extensible set of common dental findings.
The DDEx `Dental Observation Codes` value set includes all concepts below
Clinical Finding from SNOMED CT and SNODENT and is therefore much broader.
Identical SCTIDs map directly and do not require a ConceptMap. A code accepted
by DDEx but absent from the curated local list may still be valid under the
local extensible binding, provided its terminology edition and meaning are
validated.

### Observation and Condition Boundary

fhir-dental-de uses `DentalFindingDE` for raw measurements, odontogram states,
plaque, risk observations, and other findings. `DentalConditionDE` is reserved
for an asserted diagnosis and may reference supporting Observations through
`evidence.detail`.

DDEx 2.0.0-ballot describes the same general Observation/Condition distinction,
but its examples include plaque and caries risk as Conditions. Importers must
therefore classify the source meaning rather than copy the DDEx resource type:

| Source meaning | fhir-dental-de target | Transform rule |
|---|---|---|
| Measurement, raw finding, risk score, plaque, or odontogram state without an asserted diagnosis | `DentalFindingDE` or a specialized Observation profile | Preserve the source coding and measurement; do not promote it to a diagnosis. |
| Clinician-asserted diagnosis | `DentalConditionDE` | Preserve verification, clinical status, authorship, encounter, and supporting evidence when present. |
| Ambiguous DDEx Condition example | No automatic profile assignment | Require a domain rule or human-reviewed mapping; record a warning if the source does not establish diagnosis semantics. |

### Lifecycle and Authorship

The lifecycle values and invariant `con-5` come from FHIR R4 Condition. This IG
adds Must Support expectations but does not redefine the core semantics. The
Praxis-DE
[diagnosis certainty contract](https://fhir.cognovis.de/praxis/claim-diagnosis-contract.html)
is the shared mapping for the German `G`, `V`, `Z`, and `A` certainty markers;
this IG does not duplicate that table.

`DentalConditionDE.asserter` is the dental professional responsible for the
diagnosis, while `recorder` is the person or role that entered it. DDEx and KBV
base profiles do not provide the same dental qualification restriction. For
legacy AW-SST export, `KBV_PR_AW_Diagnose` requires `encounter` and prohibits
both `asserter` and `recorder`. An exporter must therefore:

1. omit authorship fields only in the archive projection and record that loss;
2. populate the required encounter only from source-supported context; and
3. retain the original `DentalConditionDE` or equivalent provenance for audit.

The Praxis-DE
[AW-SST and WeST crosswalk](https://fhir.cognovis.de/praxis/aw-sst-crosswalk.html)
remains authoritative for the German practice export targets. This page only
adds the dental-specific source-to-Praxis projection.

## Dual-Coding Strategy

fhir-dental-de uses a dual-coding approach to maintain compatibility with the HL7 Dental Data Exchange IG while preserving native German coding:

1. **FDI as primary coding** -- the standard in German dental practice and internationally (outside the US).
2. **SNOMED CT as secondary coding** -- enables interoperability with the US IG, which uses SNOMED tooth concepts.

### Example: bodySite with dual coding

```json
{
  "bodySite": [
    {
      "coding": [
        {
          "system": "http://terminology.hl7.org/CodeSystem/ex-tooth",
          "code": "36",
          "display": "Lower left first molar (FDI 36)"
        },
        {
          "system": "http://snomed.info/sct",
          "code": "38671000",
          "display": "Permanent lower left first molar"
        }
      ]
    }
  ]
}
```

### Example: tooth-surfaces extension with dual coding

```json
{
  "extension": [
    {
      "url": "https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces",
      "valueCodeableConcept": {
        "coding": [
          {
            "system": "https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces",
            "code": "M",
            "display": "Mesial"
          },
          {
            "system": "http://snomed.info/sct",
            "code": "245647007",
            "display": "Structure of mesial surface of tooth"
          }
        ]
      }
    }
  ]
}
```

A system consuming data from fhir-dental-de can use the SNOMED CT tooth coding
instead of the FDI coding when it needs US-oriented tooth identification.
However, dual-coding alone is not sufficient for DDEx conformance when several
teeth or surfaces are present; the representation transformation described
above is still required.

## Authorization and Billing Crosswalk

### Selected Plan to Da Vinci PAS

`DentalCarePlanDE.intent = option` represents an unselected alternative. Only
the selected `intent = plan` instance is eligible to become authorization
input. Da Vinci PAS 2.2.1 uses a preauthorization `Claim` and
`ClaimResponse`; DDEx does not define this workflow.

FHIR R4 `Claim` has no `basedOn` element. Consequently, documentation or
implementations must not claim a `DentalCarePlanDE` to `PASClaimDE.basedOn`
mapping. A future dental authorization profile can add a required
`Claim.supportingInfo.valueReference` slice for the selected CarePlan or use a
separately governed linkage extension. Until that contract is profiled,
exporters should preserve the selected plan as supporting information without
stamping an unsupported `basedOn` path.

### Festzuschuss Adjudication

| Lifecycle stage | Source | Target | Meaning |
|---|---|---|---|
| Requested or calculated amount | `DentalClaimDE.item.extension[festzuschussAmount]` | Authorization or submitted Claim item | Finding, percentage, amount, effective period, and source edition asserted by the submitting system |
| Payer decision | `ClaimResponse.item.adjudication` | Approved, reduced, or denied amount and reason | Payer-owned result; it must not overwrite the submitted extension |
| Downstream explanation | `ExplanationOfBenefit.item.adjudication` | Patient-facing or persisted adjudication view | Copy the payer decision with traceable Claim/ClaimResponse references |

These are structural mappings. `StructureDefinition.mapping`, a narrative
mapping table, or an executable StructureMap is appropriate. ConceptMap is
reserved for terminology correspondences.

### DentalClaimDE to Praxis, AW-SST, and WeST

`DentalClaimDE` is an operational, position-bearing mixed claim. The Praxis-DE
package provides the shared Account, Coverage, preliminary/final Claim, and
WeST/AW-SST export contracts. The dental projection is:

| Dental source | Praxis projection | Export rule |
|---|---|---|
| `AccountPraxisSchein` | Reuse unchanged | Keep the billing-case anchor separate from clinical encounters. |
| GKV plus supplementary/private Coverage | `FPDECoverageGKV` plus `FPDECoveragePrivat` | Preserve payer order through Claim insurance sequence and Account coverage priority. |
| Position-bearing `DentalClaimDE` | `PraxisPreliminaryBillingClaimDE` | Preserve the itemized operational claim before payer-specific finalization. |
| Final mixed-payer result | `PraxisGKVClaimDE` plus `PraxisPrivateClaimDE` or supplementary-payer Claim | Split by payer where the target contract requires it and link final Claims to the preliminary Claim. |
| Legacy AW-SST archive | Matching preliminary/final AW Claim projections | Record loss for dental-only BEMA/GOZ mixture, Festzuschuss details, typed ChargeItem links, and multi-coverage adjudication that the target cannot carry. |
| WeST | Use the Praxis-DE WeST Schein/Claim crosswalk | Do not duplicate the WeST model here. Per-service dental settlement remains outside the current WeST scope. |

Export loss must be visible in adapter audit output or Provenance; an exporter
must not silently discard dental-specific semantics.

## Interoperability Assessment

### Closely aligned

- **Clinical findings** (DentalFindingDE / Dental Finding) -- both are Observation-based, but terminology breadth and multi-site representation require the rules above.
- **Clinical conditions** (DentalConditionDE / Dental Condition) -- both are Condition-based, but importers must preserve the local finding-versus-diagnosis boundary.
- **Tooth identification** -- FDI and Universal Numbering can map to SNOMED CT anatomical concepts; compound site expressions still require transformation.
- **Communications** (DentalCommunicationDE / Dental Communication) -- structurally aligned, both based on Communication with dental category.

### Partially compatible (same concepts, different code systems)

- **Procedures** -- a two-surface composite restoration is clinically the same concept in BEMA, GOZ, and CDT. The procedure *codes* differ and cannot be translated mechanically. Cross-border exchange requires mapping at the clinical concept level (e.g., via SNOMED procedure concepts), not code-to-code translation.
- **Diagnosis codes** -- ICD-10-GM and ICD-10-CM diverge at extension digits. Mapping is feasible for common dental diagnoses (e.g., K02.x caries codes share the same stem) but not guaranteed for all codes.

### Not compatible (fundamentally different systems)

- **Billing** -- German dental billing (BEMA for GKV, GOZ for PKV) and US dental billing (CDT + insurance claims) are structurally incompatible. Fee calculation (German point values / multiplier factors vs. US fee schedules), insurance workflows (KZV clearing vs. direct payer submission), and authorization processes (HKP Genehmigung vs. prior authorization) have no meaningful overlap. The ChargeItem-based profiles in fhir-dental-de (BemaChargeItemDE, GozChargeItemDE) have no equivalent in the US IG.
- **Treatment plan authorization** -- German HKP/KV workflows (CarePlan-based with KZBV approval) differ fundamentally from US prior authorization (typically modeled via [Da Vinci PAS](https://hl7.org/fhir/us/davinci-pas/) or X12 278).

## DACH Region Compatibility

This IG is scoped to the German healthcare system (`jurisdiction: DE`). However, the clinical profiles are designed to be extensible to the DACH region (Germany, Austria, Switzerland).

### What is already DACH-compatible

The following profiles use international coding systems and can be adopted in Austria and Switzerland without modification:

- **DentalFindingDE** / **PeriodontalObservationDE** / **ProphylaxisObservationDE** — FDI tooth numbering (ISO 3950) is used in all three countries. DentalFindingDE exposes an SCTID-only SNOMED CT pick list; its extensible binding and the specialized profiles still permit internationally valid codes such as LOINC where the curated list does not represent the observation.
- **DentalConditionDE** — ICD-10-GM (German modification) shares a common WHO ICD-10 stem with the Austrian and Swiss variants. Dental diagnoses (K00-K14) are largely identical across all three national ICD-10 editions.
- **DentalProcedureDE** — The Procedure resource structure is country-neutral. Only the `code` binding (BEMA/GOZ) is Germany-specific.
- **DentalImagingStudyDE** — DICOM modality codes are international. FDI tooth numbering in `series.bodySite` works across DACH.
- **DentalCommunicationDE** — Structurally country-neutral.

### What requires national adaptation

| Profile / Extension | Germany | Austria adaptation | Switzerland adaptation |
|---|---|---|---|
| **Procedure codes** | BEMA (GKV) + GOZ (PKV) | Austrian dental tariff system | TARMED / SSO Tarif |
| **Billing profiles** | BemaChargeItemDE, GozChargeItemDE | New profiles needed | New profiles needed |
| **Insurance workflow** | HKP-Genehmigung, eHKP-ID | Different approval process | Different approval process |
| **Encounter** | Abrechnungsquartal (from praxis-de) | Different billing period model | Different billing period model |
| **Organization identifiers** | BSNR, KZV-Abrechnungsnummer | Austrian provider IDs | Swiss GLN / ZSR-Nummer |
| **Base profiles** | de.basisprofil.r4 | HL7 Austria base | CH Core (fhir.ch) |
| **Infrastructure** | gematik TI, KIM, ePA | ELGA | Swiss EPR |

### Extension strategy

A future DACH dental IG could be structured as:

```
dach-dental-core (clinical profiles, FDI, SNOMED CT)
├── de-dental (German billing, insurance, TI)
├── at-dental (Austrian billing, ELGA)
└── ch-dental (Swiss billing, EPR)
```

This IG (fhir-dental-de) could serve as the basis for `dach-dental-core` by extracting the clinical profiles into a country-neutral layer and keeping the billing/insurance profiles as the `de-dental` specialization.

## Three-Way Comparison

The following table summarizes how the three compared dental FHIR IGs cover key
clinical domains at the version baseline above:

| Domain | fhir-dental-de 0.40.0 (Germany) | MedMij Dental Care 1.0.0-rc.1 (Netherlands) | DDEx 2.0.0-ballot (US) |
|---|---|---|---|
| **Tooth identification** | FDI (ISO 3950) + SNOMED dual coding | Not exposed | ADA Universal + SNOMED |
| **Tooth surfaces** | Repeated local/SNOMED-coded extensions on the tooth `bodySite` | Not profiled | One post-coordinated SNOMED expression in `bodySite` |
| **Dental findings** | DentalFindingDE (Observation) | 5 specialized Observations | Dental Finding (Observation) |
| **Periodontal** | 6-point probing, BOP, recession, furcation | PSI/PSR aggregate score | General periodontal findings |
| **Conditions** | ICD-10-GM plus extensible coding (Condition) | SNOMED CT (nl-core-Condition) | US Core condition coding plus dental examples |
| **Procedures** | BEMA/GOZ (Procedure) | Vektis Mondzorg (Procedure) | US Core Procedure examples; no DDEx dental Procedure profile |
| **Care plans** | DentalCarePlanDE (7 types) | Generic Goal | US Core CarePlan/Goal |
| **Billing** | ChargeItem (BEMA + GOZ) | Not profiled | Not profiled |
| **Imaging** | ImagingStudy (DICOM) | Not profiled | Referenced narratively |
| **Lab orders** | ServiceRequest (BEL II) | Not profiled | Not profiled |
| **Communication** | Communication | Not profiled | Dental Communication |
| **Referral notes** | *(via ATF Bundle)* | Not profiled | Dental Referral/Consult Note (C-CDA on FHIR) |

## References

- [HL7 Dental Data Exchange IG v1.0.0 STU 1](https://hl7.org/fhir/us/dental-data-exchange/) -- current published US Realm release
- [HL7 Dental Data Exchange IG v2.0.0-ballot CI build](https://build.fhir.org/ig/HL7/dental-data-exchange/) -- mutable ballot crosswalk target
- [FHIR Package Registry: hl7.fhir.us.dental-data-exchange](https://packages.fhir.org/hl7.fhir.us.dental-data-exchange) -- published package versions
- [MedMij R4 Dental Care IG v1.0.0-rc.1](https://simplifier.net/guide/medmij-r4-dentalcare-ig/Home?version=1.0.0-rc.1) -- Dutch dental FHIR release candidate
- [ADA Tooth Surface Codes (HL7 THO)](https://terminology.hl7.org/CodeSystem-ADAToothSurfaceCodes.html) -- US tooth surface terminology
- [FDI Two-Digit Notation (ISO 3950)](https://www.fdiworlddental.org/) -- international tooth numbering standard
- [SNOMED CT Dental Concepts](http://snomed.info/sct) -- international clinical terminology with dental anatomy concepts
- [Da Vinci Prior Authorization Support (PAS) v2.2.1](https://hl7.org/fhir/us/davinci-pas/) -- current published US prior authorization IG
- [German Base Profiles package registry (de.basisprofil.r4)](https://packages.fhir.org/de.basisprofil.r4) -- this IG is pinned to v1.5.4
- [KBV Base Profiles v1.9.0](https://fhir.kbv.de/StructureDefinition/KBV_PR_Base_Condition_Diagnosis) -- pinned Condition base profile
- [FDI EHR Consensus Statement (2025)](https://www.fdiworlddental.org/sites/default/files/2025-03/FDI_EHR_Consensus%20Statement_Web.pdf) -- FDI advocacy for integrated dental EHRs
- [CH Core IG](https://fhir.ch/ig/ch-core) -- Swiss FHIR base profiles
