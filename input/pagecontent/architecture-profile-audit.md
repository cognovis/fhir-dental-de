# Profile Architecture Audit — Praxis*DE Migration (v0.31.0)

## Overview

This document records the architecture decision and rationale for which dental profiles
have been migrated to use `Praxis*DE` parent profiles and which remain on raw FHIR R4 base resources.

The 3-Layer-Chain pattern is: **KBV → praxis-de → dental-de**

- **Layer 1 (KBV):** KBV base profiles (`kbv.basis`) — German GKV interoperability constraints
- **Layer 2 (praxis-de):** `Praxis*DE` wrapper profiles (`de.cognovis.fhir.praxis`) — shared practice-level constraints reusable across cognovis IGs
- **Layer 3 (dental-de):** `Dental*DE` profiles (this IG) — dental-domain specific constraints

## Migrated Profiles (v0.31.0)

| Dental Profile | New Parent | Replaces |
|---|---|---|
| `DentalConditionDE` | `PraxisConditionDE` | `Condition` (raw FHIR R4) |
| `DentalOrganizationDE` | `PraxisOrganizationDE` | `Organization` (raw FHIR R4) |

## Non-Migrated Profiles — Rationale

The following 10 dental profiles remain on raw FHIR R4 base resources. This is intentional.

**Root Cause:** `de.cognovis.fhir.praxis` (v0.61.0) only defines `Praxis*DE` wrapper profiles for:
`PraxisConditionDE`, `PraxisOrganizationDE`, `PraxisPatientDE`, `PraxisPractitionerDE`.

No `Praxis*DE` wrappers exist for the resource types used by the following profiles.
Until praxis-de provides corresponding wrappers, migration is not possible.

| Dental Profile | Base Resource | Missing Praxis*DE Wrapper | Notes |
|---|---|---|---|
| `DentalEncounterDE` | `Encounter` | `PraxisEncounterDE` | Encounter structure is dental-specific (Behandlungsfall / Quartalschein); a generic praxis wrapper would add little value |
| `DentalCarePlanDE` | `CarePlan` | `PraxisCarePlanDE` | HKP, KFO, PAR plans are dental-domain artifacts with no shared praxis pattern |
| `DentalCommunicationDE` | `Communication` | *(PraxisCommunicationDE exists but targets different use case)* | Dental communication (referral letters, lab orders) differs from praxis-level messaging |
| `DentalFindingDE` | `Observation` | `PraxisObservationDE` | Zahnschema/FDI findings are dental-specific; no generic practice observation wrapper defined |
| `DentalLabServiceRequestDE` | `ServiceRequest` | `PraxisServiceRequestDE` | Dental lab orders (ZTL) are domain-specific; no shared praxis wrapper |
| `DentalImagingStudyDE` | `ImagingStudy` | `PraxisImagingStudyDE` | Dental radiology profiles (OPG, DVT, Intraoral) have no shared praxis template |
| `DentalImagingDiagnosticReportDE` | `DiagnosticReport` | `PraxisDiagnosticReportDE` | Radiology reports are dental-specific; see also praxis-de radiology extensions |
| `DentalProcedureDE` | `Procedure` | `PraxisProcedureDE` | Dental procedures (BEMA/GOZ execution context) have no shared praxis wrapper |
| `DentalClinicalImpressionDE` | `ClinicalImpression` | `PraxisClinicalImpressionDE` | PAR/KFO clinical impressions are domain-specific |
| `DentalAtfBundleDE` | `Bundle` | `PraxisBundleDE` | ATF MessageBundle structure is specified by de.gematik.fhir.atf; wrapping not appropriate |

## Migration Trigger

If `de.cognovis.fhir.praxis` publishes a new `Praxis*DE` wrapper for any resource type in the
table above, a migration bead should be created to update the corresponding `Dental*DE` profile.

## Related

- Bead `fdde-pax.2` — implements DentalConditionDE + DentalOrganizationDE migration
- `sushi-config.yaml` — dependency `de.cognovis.fhir.praxis: 0.61.0`
- `input/fsh/profiles/DentalConditionDE.fsh` — Layer 3 condition profile
- `input/fsh/profiles/DentalOrganizationDE.fsh` — Layer 3 organization profile
