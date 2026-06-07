# Profile Architecture Audit — Praxis*DE Migration

## Overview

This document records the architecture decision and rationale for which dental profiles
have been migrated to use `Praxis*DE` parent profiles and which remain on raw FHIR R4 base resources.

The 3-Layer-Chain pattern is: **KBV → praxis-de → dental-de** (or, for resources without
KBV base, **FHIR R4 → praxis-de → dental-de**).

- **Layer 1:** German base profile (`kbv.basis` or raw FHIR R4) — German GKV / German base constraints
- **Layer 2 (praxis-de):** `Praxis*DE` / `*PraxisDe` wrapper profiles (`de.cognovis.fhir.praxis`) — shared practice-level constraints reusable across cognovis IGs
- **Layer 3 (dental-de):** `Dental*DE` profiles (this IG) — dental-domain specific constraints

## Migrated Profiles

| Dental Profile | New Parent | Replaces | Released |
|---|---|---|---|
| `DentalConditionDE` | `PraxisConditionDE` | `Condition` (raw FHIR R4) | v0.31.0 |
| `DentalOrganizationDE` | `PraxisOrganizationDE` | `Organization` (raw FHIR R4) | v0.31.0 |
| `BemaChargeItemDE` | `ChargeItemPraxisDe` | `ChargeItem` (raw FHIR R4) | v0.32.0 |
| `GozChargeItemDE` | `ChargeItemPraxisDe` | `ChargeItem` (raw FHIR R4) | v0.32.0 |

## New Sub-Profiles (Tax-Pattern)

| Dental Profile | Parent | Purpose | Released |
|---|---|---|---|
| `GozZahntechWerkstueckChargeItemDE` | `GozChargeItemDE` | Eigenlabor-Werkstücke 7 % USt (Anlage 2 Nr. 52 UStG) | v0.34.0 |

## Non-Migrated Profiles — Status & Rationale

The classifications below are correct against `de.cognovis.fhir.praxis@0.69.1`.

## Account Model (billing-case boundary)

Dental adopts the same Account-centered billing-case model as the Praxis-DE IG:

| Concern | Dental model | Notes |
|---|---|---|
| Clinical contact | `DentalEncounterDE` (parents `Encounter` directly) | Billing-agnostic: `class` AMB/HH only; no Scheintyp, coverage, or Abrechnungsquartal on Encounter |
| Billing case (Schein) | **Reuse** `AccountPraxisSchein` from `de.cognovis.fhir.praxis` | No `AccountDentalSchein` — identical shape (ScheinNummer, Scheinart gkv/pkv, servicePeriod, coverage, active/inactive) |
| Encounter → Account | `DentalEncounterDE.account` → `AccountPraxisSchein` | Must-support |
| ChargeItem → Account | `BemaChargeItemDE.account` / `GozChargeItemDE.account` → `AccountPraxisSchein` | 1..1 must-support |
| Abrechnungsstatus | `DentalClaimDE.status` / `ClaimResponse` | **Not** `Account.status` (only open/closed Schein) |
| Gebührenordnung (BEMA/GOZ/KZBV) | ChargeItem code system + Claim lines | Distinct from `Account.type` (Versicherungs-/Scheinart gkv/pkv) |
| AW-SST export | `DentalEncounterDE` → `KBV_PR_AW_Begegnung` crosswalk | Account has no AW equivalent; decomposes into its AW constituents on export |

### Praxis wrapper exists — migration candidate

| Dental Profile | Available Praxis Wrapper | Why deferred / what to evaluate |
|---|---|---|
| `DentalEncounterDE` | `EncounterPraxis` | **Not adopted as parent**: dental profile mirrors the same billing-case contact semantics on base `Encounter` + `AccountPraxisSchein` reference; avoids inheriting praxis-only extensions (e.g. Wegegeld) until needed. |
| `DentalCarePlanDE` | `PraxisCarePlanDE` (← CarePlan) | praxis wrapper exists but its constraint shape was not designed against dental HKP/KFO/PAR plans; needs a fit analysis before adopting as parent. |
| `DentalImagingStudyDE` | `ImagingStudyPraxisDe` (← `ImagingStudy-uv-ips`) | Inherits IPS (International Patient Summary) constraints which add cardinality/binding requirements potentially incompatible with dental Intraoral/OPG/DVT modeling. Needs careful diff before migrating. |
| `DentalImagingDiagnosticReportDE` | `ImagingDiagnosticReportPraxisDe` (← `imr-diagnosticreport`) | praxis wrapper slices `category` into roentgen/CT/MRT — dental radiology mostly aligns with the roentgen slice; viable migration candidate. |
| `DentalCbctImagingStudyDE` | (inherits from `DentalImagingStudyDE`) | Sub-profile of `DentalImagingStudyDE`; migrates transitively when its parent migrates. |

### Wrapper exists but is the wrong fit — not migration candidates

| Dental Profile | Available Praxis Wrapper | Why NOT a migration candidate |
|---|---|---|
| `DentalCommunicationDE` | `PraxisCommunication` (← Communication) | praxis wrapper targets internal practice-to-practice messaging, not the dental referral / lab order use case. Inheritance would import constraints that don't fit. |
| `DentalFindingDE` | `PraxisLabObservation` (← Observation) | praxis wrapper is specifically for lab Observations (LOINC-bound, lab category). Dental Zahnschema/FDI findings are a different Observation semantic — inheritance would force incorrect category. |
| `DentalLabServiceRequestDE` | `ImagingServiceRequestPraxisDe` (← `imr-servicerequest`) | praxis wrapper is for *imaging* service requests. Dental lab orders (ZTL) are a different domain — no fit. |
| `DentalProcedureDE` | `ProcedureAmbulantDE` (← Procedure, OPS-coded) or `RoentgenProcedurePraxisDe` (← `Procedure-uv-ips`) | praxis wrappers are OPS-coded (medical) or radiology-specific (Roentgen). Dental procedures use BEMA/GOZ coding — no parent-fit. |

### No praxis wrapper exists

| Dental Profile | Base Resource | Status |
|---|---|---|
| `DentalClinicalImpressionDE` | `ClinicalImpression` | No `PraxisClinicalImpressionDE` in praxis@0.64.0. |
| `DentalAtfBundleDE` | `Bundle` | No `PraxisBundleDE` (and not appropriate — ATF MessageBundle structure is specified by `de.gematik.fhir.atf`). |
| `OralHealthScreeningDE` | `Observation` | No generic `PraxisObservationDE` wrapper (only `PraxisLabObservation`, which is lab-specific). |
| `PeriodontalObservationDE` | `Observation` | Same as above. |
| `ProphylaxisObservationDE` | `Observation` | Same as above. |

## Migration Trigger

Re-evaluate this table whenever `de.cognovis.fhir.praxis` publishes a new minor version.
Each new `Praxis*DE` wrapper potentially unlocks a 3-Layer-Chain migration for the
corresponding `Dental*DE` profile when the new parent is a structural fit.

## Tax Pattern (ChargeItem)

Since v0.32.0, both `BemaChargeItemDE` and `GozChargeItemDE` inherit from
`ChargeItemPraxisDe`, which makes the praxis-de tax extensions available via inheritance:

- `TaxCategoryExt` (UN/CEFACT 5305 codes: `S`=19% / `AA`=7% / `E`=steuerfrei / `AE`=Reverse-Charge / `Z`=Nullsatz)
- `TaxExemptionReasonExt` (CodeSystem `ust-befreiungsgrund`: `para4-nr14a`, `para4-nr14b`, `para4-nr16`, `para4-nr17a`, `para4-nr23`, `kleinunternehmer-para19`)

Since v0.34.0 the concrete tax-pattern is implemented as:

- `BemaChargeItemDE` fixes both extensions to `E` + `para4-nr14a` (BEMA = ausnahmslos GKV-Heilbehandlung)
- `GozChargeItemDE` carries both as MS with two invariants `goz-tax-iff-e` (Befreiungsgrund iff E) and `goz-tax-verlangens-s` (Verlangens → S)
- `GozZahntechWerkstueckChargeItemDE` fixes `TaxCategory=AA` for Eigenlabor-Werkstücke

See [USt-Modellierung](ust-modellierung.html) for the full design.
