# International Interoperability

This page describes how the German Dental FHIR Profiles (fhir-dental-de) relate to international dental FHIR specifications and provides guidance for cross-border data exchange.

## European Dental FHIR Landscape

As of 2026, only two published dental FHIR Implementation Guides exist in Europe:

| IG | Country | Status | Profiles | Focus |
|---|---|---|---|---|
| **fhir-dental-de** (this IG) | Germany | v0.12 Trial Use | 16 profiles, 22 extensions | Full dental workflow: clinical + billing + care plans + imaging + lab |
| [**MedMij Dental Care**](https://simplifier.net/guide/medmij-r4-dentalcare-ig/) | Netherlands | v1.0.0-beta.2 | 6 profiles, 0 extensions | Clinical findings + procedures |

No dedicated dental FHIR IGs have been published for Austria, Switzerland, the UK, Norway, or any other European country. The Nordic countries (Norway, Sweden, Denmark) have advanced general eHealth infrastructure but no dental-specific FHIR work. The [FDI World Dental Federation](https://www.fdiworlddental.org/) published a [consensus statement on integrated EHRs](https://www.fdiworlddental.org/sites/default/files/2025-03/FDI_EHR_Consensus%20Statement_Web.pdf) in March 2025 advocating FHIR-based interoperability but does not author FHIR IGs.

## Comparison with MedMij Dental Care IG (Netherlands)

The [MedMij R4 Dental Care IG](https://simplifier.net/guide/medmij-r4-dentalcare-ig/) is maintained by Stichting MedMij and Nictiz. It takes a fundamentally different architectural approach: minimal dental-specific profiles with heavy reliance on shared nl-core base profiles.

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
| Observation codes | LOINC + SNOMED CT (extensible) | SNOMED CT (fixed per profile) |
| Tooth numbering | FDI (ISO 3950) with dual SNOMED coding | Not explicitly exposed in IG |
| Tooth surfaces | Custom + SNOMED CT dual coding | Not profiled |

### Architectural Comparison

| Dimension | fhir-dental-de | MedMij Dental Care |
|---|---|---|
| **Philosophy** | Self-contained dental specification | Inherit common, define only dental-unique |
| **Base profiles** | Extends FHIR R4 directly | Extends nl-core (Dutch national base) |
| **Extensions** | 22 custom (billing, insurance, specialty-specific) | None (uses nl-core patterns) |
| **Treatment types** | Category-based routing in unified CarePlan | Meta-tags + generic Goal |
| **Billing integration** | Dedicated ChargeItem profiles | Embedded in procedure codes |
| **Maturity** | v0.12.1 (stable, validated against PVS data) | v1.0.0-beta.2 (unstable) |

### Harmonization Opportunities

Despite their different architectures, the two IGs share a common clinical foundation that can be harmonized:

1. **SNOMED CT dental mapping** — Both IGs use SNOMED CT for clinical concepts. A shared European SNOMED CT dental value set (covering caries risk, oral hygiene, periodontal findings, parafunctional habits) would benefit both IGs and any future European dental IG.

2. **Periodontal assessment** — fhir-dental-de's granular PeriodontalObservationDE (6-point probing, BOP, recession, furcation) and MedMij's aggregate PeriodicPeriodontalScreeningScore are complementary. An aligned approach could define a base screening level (NL-style PSI) with an optional detailed level (DE-style per-tooth components).

3. **Procedure coding bridge** — Neither BEMA/GOZ nor Vektis Mondzorg codes are internationally portable. SNOMED CT procedure concepts could serve as a European lingua franca, with national codes as primary bindings and SNOMED CT as secondary (similar to fhir-dental-de's dual-coding strategy for tooth identification).

4. **FDI tooth identification** — fhir-dental-de already uses FDI (ISO 3950) as the international standard. MedMij does not currently expose tooth-level data. Adopting FDI across both IGs would enable tooth-level data exchange without code system translation.

## Profile Correspondence

The following table maps fhir-dental-de profiles to their closest equivalents in the HL7 Dental Data Exchange IG.

| fhir-dental-de Profile | Base Resource | HL7 Dental Data Exchange Equivalent | Notes |
|---|---|---|---|
| DentalFindingDE | Observation | Dental Finding | Both Observation-based. DE uses FDI tooth numbering + SNOMED dual-coding in `bodySite`. |
| DentalConditionDE | Condition | Dental Condition | Both Condition-based. DE binds `code` to ICD-10-GM; US binds to ICD-10-CM / SNOMED CT. |
| DentalProcedureDE | Procedure | *(no direct equivalent)* | DE uses BEMA/GOZ procedure codes; US IG relies on CDT. No 1:1 mapping exists. |
| DentalCommunicationDE | Communication | Dental Communication | Structurally aligned. Both carry dental-category payload. |
| BemaChargeItemDE | ChargeItem | *(no US equivalent)* | GKV billing (BEMA). US uses Claim directly; ChargeItem is not profiled in the US IG. |
| GozChargeItemDE | ChargeItem | *(no US equivalent)* | PKV billing (GOZ) with fee multiplier (`Steigerungsfaktor`). No US counterpart. |
| DentalCarePlanDE (type: hkp) | CarePlan | *(no US equivalent)* | Treatment plan / prior authorization. US handles prior auth via [Da Vinci PAS](https://hl7.org/fhir/us/davinci-pas/). |
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

Dental surfaces use different code sets across jurisdictions. The concepts are clinically identical but the code systems differ.

| Surface | FDI Abbreviation (DE) | ADA Tooth Surface Code (US) | SNOMED CT |
|---|---|---|---|
| Mesial | M | M | `245647007` |
| Distal | D | D | `245645004` |
| Occlusal | O | O | `245653009` |
| Incisal | I | I | `245652004` |
| Buccal / Vestibular | B / V | B | `245649005` |
| Lingual | L | L | `362103001` |
| Palatal | P | *(not separate — mapped to L)* | `245651006` |

fhir-dental-de defines a `tooth-surfaces` extension (`0..*`, repeating CodeableConcept) to represent multi-surface findings and procedures (e.g., an MOD restoration). The US IG models multi-surface via multiple SNOMED `targetSiteCode` values on `bodySite`.

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

A system consuming data from fhir-dental-de can ignore the FDI coding and rely solely on the SNOMED CT coding to achieve compatibility with US IG expectations. Conversely, a German system can ignore the SNOMED coding and use FDI directly.

## Interoperability Assessment

### Compatible (convertible with dual-coding)

- **Clinical findings** (DentalFindingDE / Dental Finding) -- both are Observation-based with `bodySite` tooth identification. Dual-coded FDI+SNOMED ensures tooth references are interpretable in both directions.
- **Clinical conditions** (DentalConditionDE / Dental Condition) -- both are Condition-based. ICD-10-GM and ICD-10-CM share a common WHO stem; SNOMED CT can bridge remaining gaps.
- **Tooth identification** -- FDI and Universal Numbering both map to SNOMED CT anatomical concepts. The dual-coding strategy in `bodySite` makes this transparent.
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

- **DentalFindingDE** / **PeriodontalObservationDE** / **ProphylaxisObservationDE** — FDI tooth numbering (ISO 3950) is used in all three countries. SNOMED CT and LOINC observation codes are internationally valid.
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

The following table summarizes how the three existing dental FHIR IGs cover key clinical domains:

| Domain | fhir-dental-de (Germany) | MedMij Dental Care (Netherlands) | HL7 Dental Data Exchange (US) |
|---|---|---|---|
| **Tooth identification** | FDI (ISO 3950) + SNOMED dual coding | Not exposed | ADA Universal + SNOMED |
| **Tooth surfaces** | FDI + SNOMED dual coding | Not profiled | ADA Surface Codes + SNOMED |
| **Dental findings** | DentalFindingDE (Observation) | 5 specialized Observations | Dental Finding (Observation) |
| **Periodontal** | 6-point probing, BOP, recession, furcation | PSI/PSR aggregate score | General periodontal findings |
| **Conditions** | ICD-10-GM (Condition) | SNOMED CT (nl-core-Condition) | ICD-10-CM + SNODENT (Condition) |
| **Procedures** | BEMA/GOZ (Procedure) | Vektis Mondzorg (Procedure) | CDT (Procedure) |
| **Care plans** | DentalCarePlanDE (7 types) | Generic Goal | US Core CarePlan/Goal |
| **Billing** | ChargeItem (BEMA + GOZ) | Not profiled | Not profiled |
| **Imaging** | ImagingStudy (DICOM) | Not profiled | Referenced narratively |
| **Lab orders** | ServiceRequest (BEL II) | Not profiled | Not profiled |
| **Communication** | Communication | Not profiled | Dental Communication |
| **Referral notes** | *(via ATF Bundle)* | Not profiled | Dental Referral/Consult Note (C-CDA on FHIR) |

## References

- [HL7 Dental Data Exchange IG v2.0.0 (Ballot)](https://build.fhir.org/ig/HL7/dental-data-exchange/) -- US Realm profiles for dental data exchange
- [MedMij R4 Dental Care IG v1.0.0-beta.2](https://simplifier.net/guide/medmij-r4-dentalcare-ig/) -- Dutch dental FHIR profiles
- [ADA Tooth Surface Codes (HL7 THO)](https://terminology.hl7.org/CodeSystem-ADAToothSurfaceCodes.html) -- US tooth surface terminology
- [FDI Two-Digit Notation (ISO 3950)](https://www.fdiworlddental.org/) -- international tooth numbering standard
- [SNOMED CT Dental Concepts](http://snomed.info/sct) -- international clinical terminology with dental anatomy concepts
- [Da Vinci Prior Authorization Support (PAS)](https://hl7.org/fhir/us/davinci-pas/) -- US prior authorization IG
- [German Base Profiles (de.basisprofil.r4)](https://ig.fhir.de/basisprofile-de/1.0.0/) -- German FHIR foundation
- [FDI EHR Consensus Statement (2025)](https://www.fdiworlddental.org/sites/default/files/2025-03/FDI_EHR_Consensus%20Statement_Web.pdf) -- FDI advocacy for integrated dental EHRs
- [CH Core IG](https://fhir.ch/ig/ch-core) -- Swiss FHIR base profiles
