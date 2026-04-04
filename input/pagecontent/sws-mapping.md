# SWS 2.0 → FHIR R4 Mapping

This chapter describes how German dental practice management data — structured according to the **Systemwechselschnittstelle (SWS) 2.0** — maps to FHIR R4 resources and profiles in this IG.

---

## 1. What is SWS 2.0?

The **Systemwechselschnittstelle (SWS) 2.0** is a standardized data export interface for German dental practice management systems (PVS — Praxisverwaltungssysteme). It was specified jointly by **KZBV** (Kassenzahnärztliche Bundesvereinigung) and **gematik** to enable vendor-neutral patient data migration between systems.

- **Version:** 2.0 (published 08 February 2024 by KZBV Vertragsinformatik)
- **Builds on:** VDDS Transfer Format v2.20 and AzP interface v2.0
- **New in v2.0:** EBZ procedure data (elektronischer Zahnersatz-Befund, in use since 2023)
- **File naming:** `SWS_DATA.nnn` where `nnn` is the KZV registration number (Stempelnummer)
- **Field separator:** `^` between fields within a record type (Satzart)

### Satzarten Overview

SWS 2.0 organizes dental practice data into 14 record types (Satzarten, numbered 0–13):

| Satzart | Name | Description |
|---------|------|-------------|
| **0** | Praxisstammdaten / Behandlerstammdaten | Practice and practitioner master data |
| **1** | Patientenstammdaten | Patient demographics and insurance |
| **2** | Abrechnungsfall / Behandlungsfall | Billing case / treatment episode |
| **3** | Krankenblatt / Behandlungsjournal | Clinical journal / treatment notes |
| **4** | Diagnose | Diagnoses (ICD-10) |
| **5** | Zahnschema / Odontogramm | Dental chart / tooth status |
| **6** | BEMA-Leistungen | Statutory dental services (GKV) |
| **7** | GOZ-/GOÄ-Leistungen | Private dental fee services |
| **8** | HKP / KV | Treatment and cost plan (Heil- und Kostenplan) |
| **9** | PAR-Plan | Periodontal treatment plan |
| **10** | KFO | Orthodontic treatment plan |
| **11** | ZE / Festzuschüsse | Dental prosthetics / fixed subsidies |
| **12** | Röntgendiagnostik | Radiological imaging |
| **13** | Labordaten / ZTL-Daten | Dental laboratory data |

**Note:** KBR (Kieferbruch, BEMA W-Serie) and KGL (Kiefergelenk, BEMA U-Serie) do not have separate SWS Satzarten. Their treatment plans are documented as `CarePlan` resources with `category[planType]` from `DentalCarePlanTypeCS` and their BEMA services are recorded as `ChargeItem` resources under Satzart 6.

---

## 2. Satzart → FHIR Resource Mapping

### Overview Table

| Satzart | Primary FHIR Resource | Secondary FHIR Resources |
|---------|----------------------|--------------------------|
| **0** Praxisstammdaten | `Organization` + `Practitioner` | `PractitionerRole`, `Location` |
| **1** Patientenstammdaten | `Patient` | `Coverage`, `RelatedPerson` |
| **2** Abrechnungsfall | `Encounter` | `EpisodeOfCare`, `Account` |
| **3** Krankenblatt | `ClinicalImpression` | `Observation`, `Annotation` |
| **4** Diagnose | `Condition` | — |
| **5** Zahnschema | `Observation` (Odontogram) | `BodyStructure` |
| **6** BEMA-Leistungen | `ChargeItem` | `ChargeItemDefinition`, `Claim` |
| **7** GOZ-/GOÄ-Leistungen | `ChargeItem` | `ChargeItemDefinition`, `Invoice` |
| **8** HKP / KV | `CarePlan` (`DentalCarePlanDE`, planType=#hkp) | `RequestGroup`, `Claim`, `ClaimResponse` |
| **9** PAR-Plan | `CarePlan` (`DentalCarePlanDE`, planType=#par) | `ServiceRequest`, `Observation` |
| **10** KFO | `CarePlan` (`DentalCarePlanDE`, planType=#kfo) | `ServiceRequest`, `Claim` |
| **11** ZE / Festzuschüsse | `CarePlan` (`DentalCarePlanDE`, planType=#ze) | `Claim`, `ClaimResponse`, `ChargeItem` |
| **KBR** (BEMA W-Serie) | `CarePlan` (`DentalCarePlanDE`, planType=#kbr) | `ChargeItem` (W10–W25), `Condition` |
| **KGL** (BEMA U-Serie) | `CarePlan` (`DentalCarePlanDE`, planType=#kgl) | `ChargeItem` (U10–U15), `Condition` |
| **12** Röntgendiagnostik | `ImagingStudy` | `Observation`, `DiagnosticReport` |
| **13** Labordaten / ZTL | `ServiceRequest` + `ChargeItem` | `Organization` (Lab) |

---

### Satzart 0: Praxisstammdaten / Behandlerstammdaten

Practice and practitioner master data. Contains practice address, KZV registration number, BSNR, and for each practitioner: LANR, title, specialty.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Praxisname | Practice name | `Organization` | `Organization.name` | |
| Stempelnummer | KZV registration number | `Organization` | `Organization.identifier` | System: `https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR` |
| BSNR | Site number | `Organization` | `Organization.identifier` | |
| Adresse | Practice address | `Organization` | `Organization.address` | FHIR Address type |
| Telefon/Fax | Contact details | `Organization` | `Organization.telecom` | |
| Bankverbindung | IBAN/BIC | `Organization` | Extension `bank-account` | No native FHIR type |
| LANR | Lifelong practitioner number | `Practitioner` | `Practitioner.identifier` | System: `https://fhir.kbv.de/NamingSystem/KBV_NS_Base_ANR` |
| Titel / Name | Practitioner name | `Practitioner` | `Practitioner.name` | HumanName |
| Fachgebiet | Dental specialty | `PractitionerRole` | `PractitionerRole.specialty` | SNOMED CT (e.g. 160274005 for general dentist) |

One practice → one `Organization`. Each practitioner → one `Practitioner` + one `PractitionerRole` linked to the `Organization`.

---

### Satzart 1: Patientenstammdaten

Demographic and insurance data. Distinguishes GKV patients (with statutory insurance number, KK-IK) from private/self-pay patients.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Patientennummer | Internal patient ID | `Patient` | `Patient.identifier` | |
| Versichertennummer | GKV insurance number | `Patient` | `Patient.identifier` | System per health insurer |
| Name | Patient name | `Patient` | `Patient.name` | HumanName |
| Geburtsdatum | Date of birth | `Patient` | `Patient.birthDate` | YYYY-MM-DD |
| Geschlecht | Gender | `Patient` | `Patient.gender` | male/female/other/unknown |
| Adresse | Address | `Patient` | `Patient.address` | |
| Krankenkasse | Health insurer (name, IK) | `Coverage` | `Coverage.payor` → `Organization` | Insurer as Organization with IK identifier |
| IK-Nummer | Institutionskennzeichen | `Organization` (insurer) | `Organization.identifier` | System: `http://fhir.de/NamingSystem/arge-ik/iknr` |
| Versicherungsart | GKV / PKV / self-pay | `Coverage` | `Coverage.type` | ValueSet: `http://fhir.de/ValueSet/versicherungsart-de-basis` |
| Versicherungszeitraum | Coverage period | `Coverage` | `Coverage.period` | |
| Familienangehöriger | Dependent | `RelatedPerson` + `Coverage` | `Coverage.subscriber` | Family insurance |

---

### Satzart 2: Abrechnungsfall / Behandlungsfall

Billing-relevant treatment episode per quarter (GKV) or per episode (GOZ). Links patient, practitioner, period, and insurance context.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Fall-ID | Internal case number | `Encounter` | `Encounter.identifier` | |
| Patient-Ref | Patient reference | `Encounter` | `Encounter.subject` | → Patient |
| Behandler-Ref | Practitioner reference | `Encounter` | `Encounter.participant` | → PractitionerRole |
| Quartal/Jahr | Billing quarter | `Encounter` | `Encounter.period` + Extension `abrechnungsquartal` | Quarter has no native FHIR equivalent → Extension |
| Behandlungsart | GKV / GOZ / emergency | `Encounter` | `Encounter.class` | ValueSet AMB/EMER |
| Scheintyp | Referral type | `Encounter` | `Encounter.type` + Extension `scheintyp` | |
| Abrechnungsstatus | Billed / open | `Account` | `Account.status` | active/inactive |

---

### Satzart 3: Krankenblatt / Behandlungsjournal

Free-text entries and structured findings from the clinical journal. Includes anamnesis, progress documentation, and clinical notes.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Eintrags-Datum | Entry date | `ClinicalImpression` | `ClinicalImpression.date` | |
| Freitext | Note/entry | `ClinicalImpression` | `ClinicalImpression.note` | Annotation |
| Behandler-Ref | Documenting practitioner | `ClinicalImpression` | `ClinicalImpression.assessor` | → Practitioner |
| Medikation | Prescribed medications | `MedicationRequest` | Separate resource | Linked to Encounter |
| Röntgenhinweis | X-ray reference | `ImagingStudy` | Reference in ClinicalImpression.finding | |

---

### Satzart 4: Diagnose

Structured diagnoses with ICD-10-GM coding. Dentally relevant for PAR (periodontal status), KFO (jaw anomalies), and systemic conditions.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| ICD-10-Code | Diagnosis code | `Condition` | `Condition.code.coding` | System: `http://fhir.de/CodeSystem/bfarm/icd-10-gm` |
| Diagnosetext | Free-text description | `Condition` | `Condition.code.text` | |
| Diagnosesicherheit | Certainty (V/G/Z/A) | `Condition` | `Condition.verificationStatus` + Extension `diagnosesicherheit` | KBV extension |
| Lokalisation | Tooth reference | `Condition` | `Condition.bodySite` | FDI tooth number → Extension `fdi-tooth-number` |
| Diagnose-Datum | Date of diagnosis | `Condition` | `Condition.recordedDate` | |

---

### Satzart 5: Zahnschema / Odontogramm

FDI dental chart with finding classes per tooth and surface. Covers all 32 permanent teeth (11–18, 21–28, 31–38, 41–48), deciduous teeth (51–55, 61–65, 71–75, 81–85), and supernumerary teeth (19, 29, 39, 49). Periodontal measurements are transmitted as 32-character strings without separators.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Zahnnummer | FDI tooth number (e.g. 36) | `Observation` | `Observation.bodySite` | Extension `fdi-tooth-number` (see Gap 3) |
| Befundklasse | c/k/f/e/b | `Observation` | `Observation.code` + Extension | BEMA-specific — Extension required (see Gap 1) |
| Zahnstatus | present/missing/implant | `Observation` | `Observation.valueCodeableConcept` | SNOMED CT: 278894000 (absent tooth) |
| Flächen | mesial/distal/occlusal/buccal/lingual | `Observation` | Extension `tooth-surfaces` | `bodySite` is single-valued (see Gap 4) |
| Füllungstyp | Amalgam, composite, gold, ceramic | `Observation` | `Observation.component` | SNOMED CT materials |
| Parodontalstatus | Pocket depth, recession, furcation | `Observation` | `Observation.component` (per parameter) | Multiple component entries per tooth |
| Messsequenz (PAR) | 32-char measurement string | `Observation` | Component array | Sequence: 18...11, 21...28, 38...31, 41...48 |

**Recommended profile:** One `Observation` per tooth (odontogram-observation), with `component` entries for each surface and each finding parameter.

---

### Satzart 6: BEMA-Leistungen (kassenzahnärztlich)

Statutory dental services rendered under BEMA (Bewertungsmaßstab Zahnärzte). Each item contains BEMA code, point value, performing practitioner, date, and tooth reference.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| BEMA-Nummer | Service code (e.g. 01a, 13c) | `ChargeItem` | `ChargeItem.code.coding` | System: `https://fhir.cognovis.de/dental/CodeSystem/bema` |
| Punktzahl | BEMA point value | `ChargeItem` | `ChargeItem.quantity` | |
| Betrag (EUR) | Calculated euro amount | `ChargeItem` | `ChargeItem.priceOverride` | Points × KZV point rate |
| Leistungsdatum | Service date | `ChargeItem` | `ChargeItem.occurrenceDateTime` | |
| Zahnnummer | FDI tooth reference | `ChargeItem` | `ChargeItem.bodySite` + Extension `fdi-tooth-number` | |
| Flächen | Affected tooth surfaces | `ChargeItem` | Extension `tooth-surfaces` | |
| Behandler-Ref | Performing practitioner | `ChargeItem` | `ChargeItem.performer` | → PractitionerRole |
| Encounter-Ref | Treatment case | `ChargeItem` | `ChargeItem.context` | → Encounter |
| Befundklasse | c/k/f/e/b (BEMA-specific) | `ChargeItem` | Extension `bema-befundklasse` | No FHIR equivalent |

Catalog entries for all BEMA codes are stored as separate `ChargeItemDefinition` resources.

---

### Satzart 7: GOZ-/GOÄ-Leistungen (privat)

Private dental services under GOZ 2012 (Gebührenordnung für Zahnärzte) and GOÄ (medical fees for dental procedures such as anaesthesia). Contains fee code, point value, scaling factor applied, and justification text (required when factor > 2.3).

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| GOZ-Nummer | Service code (e.g. 2080) | `ChargeItem` | `ChargeItem.code.coding` | System: `https://fhir.cognovis.de/dental/CodeSystem/goz` |
| Steigerungsfaktor | Scaling factor (1.0–3.5) | `ChargeItem` | `ChargeItem.factorOverride` + Extension `privatgebuehr-steigerungsfaktor` | Native FHIR field for factor; Extension for justification + threshold |
| Begründung (>2.3) | Written justification | `ChargeItem` | Extension `privatgebuehr-steigerungsfaktor` (sub: `begruendungstext`) | Required when factor > threshold |
| Betrag (EUR) | Calculated euro amount | `ChargeItem` | `ChargeItem.priceOverride` | Base fee × scaling factor |
| Leistungsdatum | Service date | `ChargeItem` | `ChargeItem.occurrenceDateTime` | |
| Zahnnummer | FDI tooth reference | `ChargeItem` | Extension `fdi-tooth-number` | |
| Analogleistung | Analogous service (§ 6 Abs. 1 GOZ) | `ChargeItem` | Extension `privatgebuehr-analog-reference` | Reference to analogous code + justification |

---

### Satzart 8: HKP / KV (Heil- und Kostenplan)

Treatment and cost plans for dental prosthetics (HKP, form KCH 4/5) and cost estimates (KV). Contains plan items (mixed BEMA+GOZ), fixed subsidies, patient co-payment, approval status, and E-HKP data (electronic since 2023 via EBZ procedure).

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Plan-ID | Internal plan ID | `CarePlan` | `CarePlan.identifier` | |
| Planart | HKP / KV / PAR / KFO | `CarePlan` | `CarePlan.category` + Extension `planart` | |
| Erstelldatum | Plan creation date | `CarePlan` | `CarePlan.created` | |
| Status | Draft / approved / rejected | `CarePlan` | `CarePlan.status` | draft/active/revoked |
| Genehmigungsstatus | Insurer approval | `ClaimResponse` | `ClaimResponse.outcome` | queued/partial/complete/error |
| Planpositionen | BEMA/GOZ items in plan | `RequestGroup` | `RequestGroup.action` (per item) | |
| Festzuschuss | Insurer fixed subsidy (EUR) | `Claim` / `ClaimResponse` | `ClaimResponse.item.adjudication` | |
| Eigenanteil | Patient co-payment types | `Claim` | Extensions `eigenanteil-regelversorgung`, `eigenanteil-gleichartig`, `eigenanteil-andersartig` | |
| E-HKP-ID | EBZ electronic HKP reference | `CarePlan` | Extension `ehkp-id` | EBZ procedure since 2023 |
| Befundkürzel (ZE) | Finding/therapy abbreviation | `CarePlan` | Extension `ze-befundkuerzel` | KZBV DPF abbreviation key |

Approval workflow modelled on the Da Vinci PAS pattern: `Claim` (use=prior-authorization) + `ClaimResponse` (insurer response) + `Task` (asynchronous status tracking). See [Design Decisions](#4-design-decisions) and Gap 2 below.

---

### Satzart 9: PAR-Plan (Parodontologie)

Periodontal treatment plans per PAR guideline (in effect since July 2021). Contains ATG finding (antibiotic testing/overall status), PA status assessment, UPT plan (supportive periodontal therapy), and CPT/AIT items (closed/open curettage).

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| PAR-Plan-ID | Internal PAR plan ID | `CarePlan` | `CarePlan.identifier` | |
| PAR-Grad | Grade (A/B/C) | `Condition` | `Condition.severity` | SNOMED CT: Periodontitis grades |
| PAR-Stadium | Stage (I/II/III/IV) | `Condition` | Extension `par-stadium` | BSP classification 2018 |
| Taschentiefe | Pocket depth per tooth (mm) | `Observation` | `Observation.component` | Measurement sequence (32 chars) |
| Blutung (BOP) | Bleeding on probing (%) | `Observation` | `Observation.valueQuantity` | |
| UPT-Intervall | Recall interval (months) | `CarePlan` | `CarePlan.activity.detail.scheduledTiming` | |
| CPT/AIT-Positionen | BEMA services (4a–4e, 107–112) | `ChargeItem` | → Satzart 6 mapping | PAR-specific BEMA codes |

---

### Satzart 10: KFO (Kieferorthopädie)

Orthodontic treatment plans and applications. Contains bite classification (Angle class, KIG points), treatment phases (active/retention), fixed/removable appliances, and KFO completion reports.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| KFO-Plan-ID | Internal KFO plan ID | `CarePlan` | `CarePlan.identifier` | |
| Angle-Klasse | Angle class I/II/III | `Condition` | Extension `kfo-angle-klasse` | No SNOMED CT code available |
| KIG-Punkte | Orthodontic indication grade | `Condition` | Extension `kfo-kig-punkte` | KIG 1–5 per BEMA §29 SGB V |
| Behandlungsphase | Active / retention / completion | `CarePlan` | Extension `kfo-behandlungsphase` | |
| Apparaturtyp | Fixed / removable | `CarePlan` | Extension `kfo-apparatus-type` | |
| Behandlungszeitraum | Treatment period | `CarePlan` | `CarePlan.period` | |
| KFO-Antrag | Application to KZV | `Claim` | `Claim.type` = KFO | |
| KIG-Genehmigung | KZV approval | `ClaimResponse` | `ClaimResponse.outcome` | |

---

### Satzart 11: ZE / Festzuschüsse (Zahnersatz)

Dental prosthetics documentation with fixed subsidy calculation. Contains finding/therapy abbreviations (KZBV DPF key), standard vs. equivalent/non-standard provision, fixed subsidy decision, and laboratory costs.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| ZE-ID | Internal ZE ID | `CarePlan` | `CarePlan.identifier` | |
| Befundkürzel | KZBV finding abbreviation (e.g. 1.1, 2.3) | `CarePlan` | Extension `ze-befundkuerzel` | DPF abbreviation key KZBV |
| Therapiekürzel | Provision type abbreviation | `CarePlan` | Extension `ze-therapiekuerzel` | |
| Versorgungsart | Standard / equivalent / non-standard | `CarePlan` | Extension `ze-versorgungsart` | |
| Festzuschuss | Fixed subsidy (EUR) | `ClaimResponse` | `ClaimResponse.item.adjudication` | |
| Bonus (50%/60%/70%) | Bonus entitlement (Bonusheft) | `Claim` | Extension `ze-bonus-prozent` | |
| Eigenanteil | Patient co-payment (EUR) | `Claim` | Extension `eigenanteil-gesamt` | |
| Laborkosten | Lab invoice amount | `ChargeItem` | Separate ChargeItem → Satzart 13 | Linked via Account |

---

### KBR: Kieferbruch-Behandlung (BEMA W-Serie)

Treatment plans for jaw fracture and injuries. Not a formal SWS Satzart, but maps to BEMA W-Serie procedures (W10–W25). Modelled as a generic `DentalCarePlanDE` instance with `category[planType] = #kbr`.

| SWS / BEMA Field | Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------------|-----------|---------------|-----------|-------|
| Plan-ID | Interne Plan-ID | `CarePlan` | `CarePlan.identifier` | |
| Plantyp | Kieferbruch (W-Serie) | `CarePlan` | `CarePlan.category[planType]` | code: `#kbr` |
| Diagnose | Kieferbruch-Diagnose (ICD-10) | `Condition` | `CarePlan.addresses` | e.g. S02.6 Unterkieferfraktur |
| Erstelldatum | Plan creation date | `CarePlan` | `CarePlan.created` | |
| Behandlungszeitraum | Treatment period (typ. 6 weeks) | `CarePlan` | `CarePlan.period` | |
| W-Positionen | BEMA W-Serie services (W10–W25) | `ChargeItem` | → Satzart 6 mapping | Kieferbruch/Schienentherapie |

---

### KGL: Kiefergelenk-Behandlung (BEMA U-Serie)

Treatment plans for temporomandibular joint (TMJ) disorders and craniomandibular dysfunction (CMD). Maps to BEMA U-Serie procedures (U10–U15). Modelled as a generic `DentalCarePlanDE` instance with `category[planType] = #kgl`.

| SWS / BEMA Field | Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------------|-----------|---------------|-----------|-------|
| Plan-ID | Interne Plan-ID | `CarePlan` | `CarePlan.identifier` | |
| Plantyp | Kiefergelenk (U-Serie) | `CarePlan` | `CarePlan.category[planType]` | code: `#kgl` |
| Funktionsanalyse | Instrumental function analysis | `CarePlan` | `CarePlan.supportingInfo` | Reference to Condition/Observation |
| Schiene | Occlusal splint therapy | `CarePlan` | `CarePlan.activity` | U11 (Aufbissschiene) |
| Erstelldatum | Plan creation date | `CarePlan` | `CarePlan.created` | |
| Behandlungszeitraum | Treatment period | `CarePlan` | `CarePlan.period` | |
| U-Positionen | BEMA U-Serie services (U10–U15) | `ChargeItem` | → Satzart 6 mapping | CMD/Kiefergelenk-Behandlung |

---

### Satzart 12: Röntgendiagnostik

Radiological imaging and findings. Covers single-tooth X-rays (EZA), panoramic (OPG/DVT), bitewing, and cephalometric (FRS). Contains radiation exposure, acquisition data, and finding text.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Röntgen-ID | Internal image ID | `ImagingStudy` | `ImagingStudy.identifier` | |
| Aufnahmedatum | Acquisition date | `ImagingStudy` | `ImagingStudy.started` | |
| Aufnahmetyp | EZA / OPG / DVT / FRS | `ImagingStudy` | `ImagingStudy.series.modality` | DICOM: DX, IO, PX, CT |
| Zahnnummer | Reference tooth (EZA) | `ImagingStudy` | `ImagingStudy.series.bodySite` | Extension `fdi-tooth-number` |
| Befundtext | Radiological finding | `DiagnosticReport` | `DiagnosticReport.conclusion` | |
| Strahlendosis | Effective dose (μSv) | `ImagingStudy` | Extension `radiation-dose` | |
| Bilddaten | DICOM reference | `ImagingStudy` | `ImagingStudy.series.instance` | DICOM UID |

---

### Satzart 13: Labordaten / ZTL-Daten

Dental laboratory services (BEL II / beb'97). Contains lab invoices, dental technician service items, material costs, and reference to the laboratory.

| SWS Field | SWS Name (DE) | FHIR Resource | FHIR Path | Notes |
|-----------|---------------|---------------|-----------|-------|
| Labor-ID | Internal lab reference | `ServiceRequest` | `ServiceRequest.identifier` | |
| Labor-Name | Dental lab name | `Organization` | `Organization.name` | Separate Organization resource |
| Laborrechnung-Nr. | Invoice number | `Invoice` | `Invoice.identifier` | |
| BEL-II-Positionen | Lab service items (BEL II) | `ChargeItem` | `ChargeItem.code.coding` | System: `https://fhir.cognovis.de/dental/CodeSystem/bel-ii` |
| beb'97-Positionen | Private lab service items | `ChargeItem` | `ChargeItem.code.coding` | System: `https://fhir.cognovis.de/dental/CodeSystem/beb97` |
| Arbeitswert | BEL II point value | `ChargeItem` | Extension `bel-punkte` | |
| Materialart | Alloy class, material | `ChargeItem` | Extension `ztl-material` | |
| Bezug ZE-Plan | Reference to ZE treatment plan | `ServiceRequest` | `ServiceRequest.basedOn` | → CarePlan (Satzart 11) |

---

## 3. Gap Analysis

This section documents where SWS 2.0 data has no direct FHIR R4 equivalent, and the recommended solution in each case.

### Gap 1 — BEMA Finding Classes (c, k, f, e, b)

**Problem:** The BEMA billing system uses finding classes that describe the billing context of a service:
- `c` = conservative (tooth worth preserving)
- `k` = statutory insurance context
- `f` = missing tooth
- `e` = extracted/removed
- `b` = bridge pontic

This is a German-specific concept with no international FHIR equivalent. SNOMED CT provides "absent tooth" (278894000) but does not cover billing logic.

**Solution:** Custom extension on `ChargeItem` and `Observation`:

```
URL: https://fhir.cognovis.de/dental/StructureDefinition/bema-befundklasse
ValueType: code
Binding: bema-befundklasse ValueSet (c|k|f|e|b)
```

---

### Gap 2 — HKP/KV Approval Workflow

**Problem:** The HKP approval process is a multi-step, asynchronous workflow:
1. Practice creates HKP
2. Patient consents
3. HKP is submitted electronically to insurer (E-HKP via EBZ)
4. Insurer reviews (days to weeks, may request changes)
5. Insurer approves / rejects / approves with modifications
6. Practice implements the approved plan

The same pattern applies to PAR plan approval and KFO applications (KIG approval by KZV).

**Status in FHIR/gematik:** FHIR R5/R6 introduces no new dedicated resource type for prior authorization — `Claim` + `ClaimResponse` remains the core pattern across all FHIR versions. Gematik has **not** published a FHIR IG for prior authorization or HKP submission as of 2026. The electronic HKP process (E-HKP via EBZ) runs over proprietary PVS interfaces, not a FHIR standard.

**Solution:** Adapted from the [Da Vinci Prior Authorization Support (PAS) IG v2.1](https://hl7.org/fhir/us/davinci-pas/):

```
CarePlan (HKP plan, draft)
  └── Claim (use=prior-authorization)     ← Submission to insurer
        └── ClaimResponse                 ← Insurer response
              └── Task (status tracking)  ← Asynchronous workflow, iterations
```

Workflow states via `Task.status`:

| Task Status | Meaning |
|-------------|---------|
| `requested` | HKP submitted |
| `in-progress` | Insurer reviewing |
| `on-hold` | Insurer has questions / change request |
| `completed` | Approved |
| `rejected` | Rejected |
| `failed` | Technical error |

Extension for approval status snapshot on `CarePlan`:

```
URL: https://fhir.cognovis.de/dental/StructureDefinition/hkp-genehmigungsstatus
ValueType: complex extension
Sub-Extensions:
  - status: code (eingereicht|in-pruefung|genehmigt|abgelehnt|geaendert-genehmigt)
  - eingereicht-am: dateTime
  - genehmigt-am: dateTime
  - aenderungsgrund: string
  - ehkp-id: string (EBZ reference number)
```

---

### Gap 3 — FDI Tooth Numbering

**Problem:** The FDI tooth numbering system (ISO 3950) is the international standard in Germany and most countries outside the US (11–18, 21–28, 31–38, 41–48 for permanent; 51–55, 61–65, 71–75, 81–85 for deciduous). FHIR R4 provides no normative CodeSystem for FDI tooth numbers.

In `Observation.bodySite` and `Procedure.bodySite`, only SNOMED CT body sites are available. SNOMED CT does include teeth as anatomical structures (e.g. 38671000 for tooth 36 in FDI notation), but coverage is incomplete across all FDI codes.

**International context:** The [HL7 Dental Data Exchange IG v2.0.0](https://build.fhir.org/ig/HL7/dental-data-exchange/) (ballot, April 2025) uses exclusively SNOMED CT tooth codes (e.g. `28480000` = "Permanent lower right first molar") — not FDI numbers. SNOMED CT does not have a concept for every FDI tooth number. In Germany (and internationally outside the US), FDI is the standard.

**Solution:** Custom CodeSystem + Extension with dual-coding:

```
CodeSystem URL: https://fhir.cognovis.de/dental/CodeSystem/fdi-tooth-number
Extension URL:  https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number
ValueType: code
Codes: 11-18, 21-28, 31-38, 41-48 (permanent),
       51-55, 61-65, 71-75, 81-85 (deciduous),
       19, 29, 39, 49 (supernumerary)
```

Dual-coding strategy: FDI as primary coding, SNOMED CT tooth code as additional coding where available. This maintains compatibility with the HL7 Dental Data Exchange IG:

```json
"bodySite": {
  "coding": [
    { "system": "https://fhir.cognovis.de/dental/CodeSystem/fdi-tooth-number", "code": "36" },
    { "system": "http://snomed.info/sct", "code": "38671000",
      "display": "Permanent lower left first molar" }
  ]
}
```

---

### Gap 4 — Multi-Surface Findings

**Problem:** Dental findings and services frequently apply to multiple tooth surfaces simultaneously (e.g. "mesio-occlusal" for a 2-surface filling). FHIR R4 `Observation.bodySite` is a **single element** (0..1) — there is no native support for multiple surfaces.

Tooth surface nomenclature: mesial (M), distal (D), occlusal/incisal (O/I), buccal/vestibular (B/V), oral/lingual/palatal (O/L/P).

**International context:** The HL7 Dental Data Exchange IG solves multi-surface via SNOMED CT `targetSiteCode` attributes or models multi-surface findings as separate Observations per surface. [ADA Tooth Surface Codes](https://terminology.hl7.org/CodeSystem-ADAToothSurfaceCodes.html) are available in HL7 THO for HIPAA 837D claims.

For billing purposes, a MOD filling is **one** service on **three** surfaces, not three separate findings — a repeating extension more naturally represents this.

**Solution:** Repeating extension on `ChargeItem` and `Observation`:

```
URL: https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces
ValueType: CodeableConcept (repeating, 0..*)
Codes: M (mesial), D (distal), O (occlusal), I (incisal),
       B (buccal), V (vestibular), L (lingual), P (palatal)
```

Dual-coding: dental CodeSystem as primary, SNOMED CT surface codes as additional coding for interoperability with the US IG.

---

### Gap 5 — KFO Classification Data

**Problem:** Orthodontic diagnostics uses classification systems without FHIR equivalents:
- **Angle class** (I/II/III): Sagittal bite classification
- **KIG points** (1–5): Kieferorthopädischer Indikationsgrad per §29 SGB V — determines GKV reimbursability
- **Treatment phase** (active/retention/aftercare): Therapy stage

SNOMED CT has partial concepts for malocclusions but not for the specific German KIG system.

**Solution:**
- Angle class → Extension `kfo-angle-klasse` (code: I|II-1|II-2|III) on `Condition`
- KIG points → Extension `kfo-kig-punkte` (integer: 1–5) on `Condition` / `Claim`
- Treatment phase → Extension `kfo-behandlungsphase` (code: aktiv|retention|abschluss) on `CarePlan`

```
Extension URLs (base: https://fhir.cognovis.de/dental/StructureDefinition/):
  kfo-angle-klasse
  kfo-kig-punkte
  kfo-behandlungsphase
  kfo-apparatus-type
```

---

### Gap 6 — Regional KZV Context (HVM Rules, Point Values)

**Problem:** BEMA point values and HVM rules (Honorarverteilungsmaßstab) are **KZV-specific**: each of Germany's 17 KZVs has its own point rates and budget rules. FHIR R4 has no mechanism for regional billing rules.

**Solution:** Modelled using standard FHIR resources rather than custom extensions:
- `InsurancePlan` with `coverageArea` → `Location` (KZV region), `period` (quarterly), and `specificCost` for point rates
- `ChargeItemDefinition` with `propertyGroup.priceComponent` and `applicability` FHIRPath conditions
- Supplementary extension `kzv-kontext` on `Organization` for lightweight quick access to KZV region and current point rate

---

### Gap Summary Table

| Gap | Solution | Priority | Required Extension(s) |
|-----|----------|----------|----------------------|
| BEMA finding classes (c/k/f/e/b) | Extension on ChargeItem/Observation | P1 | `bema-befundklasse` |
| HKP approval workflow | Da Vinci PAS pattern: Claim + ClaimResponse + Task | P1 | `hkp-genehmigungsstatus`, `ehkp-id` |
| FDI tooth numbering | Custom CodeSystem + Extension with dual FDI/SNOMED coding | P1 | `fdi-tooth-number` |
| Multi-surface findings | Repeating Extension on ChargeItem/Observation | P1 | `tooth-surfaces` |
| KFO classification (Angle/KIG) | Extensions on Condition/CarePlan | P2 | `kfo-angle-klasse`, `kfo-kig-punkte`, `kfo-behandlungsphase` |
| KZV regional context | InsurancePlan + supplementary extension | P2 | `kzv-kontext` |
| Private fee scaling (GOZ/GOÄ) | Extensions on ChargeItem | P2 | `privatgebuehr-steigerungsfaktor`, `privatgebuehr-analog-reference` |
| PAR classification | Extensions on Condition/CarePlan | P2 | `par-stadium`, `par-upt-intervall` |
| Lab data (BEL II) | Extensions on ChargeItem | P2 | `bel-punkte`, `ztl-material` |

---

## 4. Design Decisions

### CarePlan for HKP/KV/PAR/KFO/KBR/KGL/PMB

`CarePlan` is the correct FHIR resource for treatment plans — it represents the clinical plan that drives care delivery. The billing aspects (authorization submission, insurer response) are handled by `Claim` and `ClaimResponse` as companions. This keeps the clinical and financial concerns separated while allowing navigation between them.

All dental treatment plans are modelled as `DentalCarePlanDE` instances. The plan type is distinguished via `category[planType]` with a required binding to `DentalCarePlanTypeVS` (codes: ze, hkp, par, kfo, kbr, kgl, pmb). This replaces the earlier approach of separate profiles per plan type (ZeCarePlanDE, HkpCarePlanDE, ParCarePlanDE, KfoCarePlanDE) and avoids code duplication when new plan types (KBR, KGL, PMB) are added.

Alternatives considered: `RequestGroup` alone (too coarse, loses plan lifecycle), `ServiceRequest` alone (single service, not a multi-step plan), separate profile per plan type (95% code duplication, rejected).

### ChargeItem Instead of Procedure for Billing

Both `Procedure` and `ChargeItem` could carry service data. `ChargeItem` is chosen because:
1. It is semantically correct for billing-centric data — it represents a charge, not a clinical procedure record
2. It natively carries `factorOverride` (critical for GOZ scaling factors), `priceOverride`, and `account` linkage
3. `ChargeItemDefinition` provides the catalog reference pattern needed for BEMA/GOZ code lookups
4. The HL7 Germany base profile already defines a `ChargeItem` profile for EBM; BEMA/GOZ follows the same model

Where a richer clinical record is needed (e.g. surgical procedure documentation), a `Procedure` resource can be added alongside the `ChargeItem`.

### Da Vinci PAS Pattern for Approval Workflows

Germany's HKP approval process is structurally identical to US prior authorization: multi-step, asynchronous, insurer as decision-maker, with possible iteration. The [Da Vinci PAS IG](https://hl7.org/fhir/us/davinci-pas/) is the most complete FHIR specification for this pattern. No German FHIR IG covers this workflow (as of 2026). Adapting Da Vinci PAS rather than inventing a proprietary pattern maximizes future interoperability.

The `Claim` (use=prior-authorization) + `ClaimResponse` + `Task` trio maps cleanly onto:
- `Claim` = the HKP submission to the insurer
- `ClaimResponse` = the insurer's decision snapshot
- `Task` = asynchronous tracking of the workflow state

### Dual-Coding FDI + SNOMED

FDI tooth numbers are the de facto standard in Germany (and internationally outside the US). However, the HL7 Dental Data Exchange IG uses SNOMED CT tooth codes. By storing both — FDI as primary, SNOMED as additional coding — this IG:
- Correctly represents the German practice context (FDI-first)
- Maintains compatibility with the HL7 Dental Data Exchange IG for cross-border data exchange
- Covers all FDI tooth numbers, including those SNOMED CT does not have concepts for (FDI is complete; SNOMED CT coverage is partial)

### Observation for Dental Chart (Odontogram)

Tooth status and surface findings are clinical measurements/findings — `Observation` is the correct resource. Each tooth receives its own `Observation` instance, with FHIR `component` entries for surfaces, finding parameters, and periodontal measurements. This allows granular querying and updating of individual tooth status without replacing the whole chart.

### ClinicalImpression for Treatment Journal

Free-text journal entries are clinical impressions — the practitioner's documented assessment. `ClinicalImpression` is semantically more accurate than `DocumentReference` (which is for documents) or `Observation` (which implies structured, measurable data).

---

## 5. Coverage and Data Completeness

| Satzart | FHIR Coverage | Data Loss Risk | Mitigation |
|---------|--------------|----------------|------------|
| 0 Praxis/Practitioner | Full | Bank account | Extension `bank-account` |
| 1 Patient | Full | — | — |
| 2 Billing case | Full | Quarter reference | Extension `abrechnungsquartal` |
| 3 Clinical journal | Good (free text) | Structure loss in free text | ClinicalImpression.note |
| 4 Diagnosis | Full | — | — |
| 5 Dental chart | Good | Multi-surface, FDI | Extensions `fdi-tooth-number`, `tooth-surfaces` |
| 6 BEMA services | Full | Finding class, billing bundles | Extension `bema-befundklasse`, ChargeItemDefinition.partOf |
| 7 GOZ/GOÄ services | Full | Scaling factor justification, analogous services | Extensions `privatgebuehr-steigerungsfaktor`, `privatgebuehr-analog-reference` |
| 8 HKP/KV | Good | Approval workflow | Da Vinci PAS: Claim + ClaimResponse + Task |
| 9 PAR plan | Good | PAR stage | Extension `par-stadium` |
| 10 KFO | Partial | Angle class, KIG | Extensions `kfo-angle-klasse`, `kfo-kig-punkte` |
| 11 ZE/Prosthetics | Good | Finding abbreviation system | Extensions `ze-befundkuerzel`, `ze-versorgungsart` |
| 12 X-ray | Full (DICOM) | — | — |
| 13 Lab data | Good | BEL points, material class | Extensions `bel-punkte`, `ztl-material` |

---

## 6. Extension URL Reference

All custom extensions for this IG use the canonical namespace `https://fhir.cognovis.de/dental/StructureDefinition/`.

### Core Extensions (P1)

| Extension (suffix) | ValueType | Purpose | Extends |
|--------------------|-----------|---------|---------|
| `fdi-tooth-number` | `code` | FDI tooth number (11–85, supernumerary) | `ChargeItem`, `Observation`, `Condition`, `Procedure` |
| `tooth-surfaces` | `CodeableConcept` (0..*) | Tooth surfaces (M/D/O/I/B/V/L/P) | `ChargeItem`, `Observation` |
| `bema-befundklasse` | `code` (c\|k\|f\|e\|b) | BEMA finding class for billing context | `ChargeItem`, `Observation` |
| `hkp-genehmigungsstatus` | complex | HKP approval workflow status | `CarePlan` |
| `ehkp-id` | `string` | EBZ electronic HKP reference number | `CarePlan` |

### Billing Extensions (P2)

| Extension (suffix) | ValueType | Purpose | Extends |
|--------------------|-----------|---------|---------|
| `privatgebuehr-steigerungsfaktor` | complex | GOZ/GOÄ §5 scaling factor with justification | `ChargeItem` |
| `privatgebuehr-analog-reference` | complex | GOZ §6 / GOÄ §6 analogous service reference | `ChargeItem` |
| `ze-befundkuerzel` | `code` | KZBV DPF finding abbreviation (e.g. 1.1, 2.3) | `CarePlan` |
| `ze-therapiekuerzel` | `code` | KZBV DPF therapy abbreviation | `CarePlan` |
| `ze-versorgungsart` | `code` | Provision type: standard\|equivalent\|non-standard | `CarePlan` |
| `ze-bonus-prozent` | `integer` | Bonus entitlement % (50\|60\|70) | `Claim` |
| `eigenanteil-regelversorgung` | `Money` | Patient co-payment — standard provision | `Claim` |
| `eigenanteil-gleichartig` | `Money` | Patient co-payment — equivalent provision | `Claim` |
| `eigenanteil-andersartig` | `Money` | Patient co-payment — non-standard provision | `Claim` |
| `abrechnungsquartal` | `string` | Billing quarter (format: YYYYQN, e.g. 2026Q1) | `Encounter`, `Account` |
| `kzv-kontext` | complex | KZV region, point rate, HVM budget rules | `Organization` |

### KFO Extensions (P2)

| Extension (suffix) | ValueType | Purpose | Extends |
|--------------------|-----------|---------|---------|
| `kfo-angle-klasse` | `code` (I\|II-1\|II-2\|III) | Angle malocclusion classification | `Condition` |
| `kfo-kig-punkte` | `integer` (1–5) | Orthodontic indication grade | `Condition`, `Claim` |
| `kfo-behandlungsphase` | `code` (aktiv\|retention\|abschluss) | KFO treatment phase | `CarePlan` |
| `kfo-apparatus-type` | `code` (festsitzend\|herausnehmbar) | Appliance type | `CarePlan` |

### PAR Extensions (P2)

| Extension (suffix) | ValueType | Purpose | Extends |
|--------------------|-----------|---------|---------|
| `par-stadium` | `code` (I\|II\|III\|IV) | PAR stage per BSP classification 2018 | `Condition` |
| `par-grad` | `code` (A\|B\|C) | PAR grade per BSP classification 2018 | `Condition` |
| `par-upt-intervall` | `integer` | UPT recall interval in months | `CarePlan` |

### Lab Extensions (P2)

| Extension (suffix) | ValueType | Purpose | Extends |
|--------------------|-----------|---------|---------|
| `bel-punkte` | `integer` | BEL II point value for dental lab service | `ChargeItem` |
| `ztl-material` | `CodeableConcept` | Dental material / alloy class | `ChargeItem` |

---

## 7. References

### Official SWS 2.0 Specification

- **Spezifikation der Systemwechselschnittstelle Version 2.0** (08 February 2024)
  Publisher: KZBV Vertragsinformatik
  Download: <https://www.ina.gematik.de/fileadmin/user_upload/Systemwechselschnittstelle_Spezifikation_Version_2.0.pdf>
  INA entry: <https://www.ina.gematik.de/detailansicht/standard/spezifikation-der-systemwechselschnittstelle-10199>

- **Vesta Standards (gematik)** — SWS entry:
  <https://www.vesta-gematik.de/standards/detail/standards/spezifikation-der-systemwechselschnittstelle/>

### KZBV Sources

- **KZBV Programme Modules** (PVS manufacturer requirements):
  <https://www.kzbv.de/zahnaerzte/digitales/praxissoftware/programmmodule/>

- **KZBV BEMA and GOZ** (regulatory framework):
  <https://www.kzbv.de/zahnaerzte/rechtsgrundlagen/bema-und-goz/>

- **EBZ Annex 2 — Finding/Therapy Abbreviations HKP ZE** (DPF abbreviation key):
  <https://www.kzbv.de/wp-content/uploads/EBZ_Anlage-2_Befund_Therapiekuerzel_HKP_ZE_2022-05-25.pdf>

- **Fixed Subsidy Compendium KZBV 2025**:
  <https://www.kzbv.de/wp-content/uploads/KZBV_FZ-Kompendium_2025-01-01_2.pdf>

### VDDS Interfaces

- **AzP Interface** (exchange of dental patient data, basis for SWS):
  <https://www.vdds.de/schnittstellen/azp/>

- **VDDS Lab Interface** (dental lab → PVS):
  <https://www.vdds.de/schnittstellen/labor/>

### HL7 / FHIR Standards

- **HL7 FHIR Dental Data Exchange IG v2.0.0** (ballot, US Realm — reference for Gaps 3 and 4):
  <https://build.fhir.org/ig/HL7/dental-data-exchange/>

- **Da Vinci Prior Authorization Support (PAS) IG v2.1** (reference for Gap 2 — approval workflows):
  <https://hl7.org/fhir/us/davinci-pas/>

- **Da Vinci Coverage Requirements Discovery (CRD) IG** (pre-authorization requirements discovery):
  <https://hl7.org/fhir/us/davinci-crd/>

- **ADA Tooth Surface Codes** (HL7 THO — reference for Gap 4):
  <https://terminology.hl7.org/CodeSystem-ADAToothSurfaceCodes.html>

- **HL7 Germany Base Profile ChargeItem (EBM)**:
  <https://ig.fhir.de/basisprofile-de/1.0.0/Ressourcen-AbrechnungsdatenLeistungsziffernChargeItem.html>

- **KBV FHIR Interfaces**:
  <https://fhir.kbv.de/>

- **FHIR R4 ChargeItemDefinition** (EBM example):
  <https://www.hl7.org/fhir/chargeitemdefinition-ebm-example.html>

- **gematik INA — Interoperability Navigator**:
  <https://www.ina.gematik.de/>
