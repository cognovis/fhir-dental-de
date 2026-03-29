# German Dental FHIR Profiles (R4)

FHIR R4 Implementation Guide for German dental practice data.

## Scope

Profiles, CodeSystems, and ValueSets for:
- **DentalProcedureDE** — dental procedures with BEMA/GOZ billing codes
- **DentalConditionDE** — dental conditions with ICD-10-GM and FDI tooth identification
- **DentalFindingDE** — clinical findings (Zahnschema, periodontal indices)
- **DentalCommunicationDE** — clinical communication and instructions

## Design Principles

- Based on **German base profiles** (`de.basisprofil.r4`, KBV) — not US Core
- Tooth numbering uses **FDI/ISO 3950** (FHIR's native system)
- Procedure codes bind to **BEMA** (GKV) and **GOZ** (PKV) — not CDT
- Diagnoses use **ICD-10-GM** — not ICD-10-CM
- Inspired by [HL7 Dental Data Exchange IG v2.0.0](https://build.fhir.org/ig/HL7/dental-data-exchange/) but adapted for the German healthcare system

## Build

```bash
npm install -g fsh-sushi
sushi .
```

## License

CC-BY-4.0 — see [LICENSE](LICENSE)
