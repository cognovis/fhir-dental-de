# International Interoperability

This page describes how the German Dental FHIR Profiles (fhir-dental-de) relate to the [HL7 Dental Data Exchange IG v2.0.0](https://build.fhir.org/ig/HL7/dental-data-exchange/) (US Realm) and provides guidance for cross-border data exchange.

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
| HkpCarePlanDE | CarePlan | *(no US equivalent)* | Treatment plan / prior authorization. US handles prior auth via [Da Vinci PAS](https://hl7.org/fhir/us/davinci-pas/). |
| KfoCarePlanDE | CarePlan | *(no US equivalent)* | Orthodontic treatment plan with KIG classification. |
| ParCarePlanDE | CarePlan | *(no US equivalent)* | Periodontal treatment plan (PAR-Richtlinie). |
| ZeCarePlanDE | CarePlan | *(no US equivalent)* | Dental prosthetics plan (Zahnersatz HKP). |

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

## References

- [HL7 Dental Data Exchange IG v2.0.0 (Ballot)](https://build.fhir.org/ig/HL7/dental-data-exchange/) -- US Realm profiles for dental data exchange
- [ADA Tooth Surface Codes (HL7 THO)](https://terminology.hl7.org/CodeSystem-ADAToothSurfaceCodes.html) -- US tooth surface terminology
- [FDI Two-Digit Notation (ISO 3950)](https://www.fdiworlddental.org/) -- international tooth numbering standard
- [SNOMED CT Dental Concepts](http://snomed.info/sct) -- international clinical terminology with dental anatomy concepts
- [Da Vinci Prior Authorization Support (PAS)](https://hl7.org/fhir/us/davinci-pas/) -- US prior authorization IG
- [German Base Profiles (de.basisprofil.r4)](https://ig.fhir.de/basisprofile-de/1.0.0/) -- German FHIR foundation
