### Use Cases

This page describes the primary workflows that this Implementation Guide supports. Each use case maps to one or more profiles defined in this IG.

---

#### 1. PVS Data Migration (SWS 2.0)

**Problem:** When a dental practice switches PVS (Praxisverwaltungssystem), patient data must be migrated. The KZBV/Gematik Systemwechselschnittstelle 2.0 defines 13 Satzarten for this, but there is no FHIR mapping.

**Solution:** This IG provides FHIR R4 target profiles for all clinically relevant SWS 2.0 Satzarten:

| SWS Satzart | Content | FHIR Profile |
|---|---|---|
| Satzart 5 | Zahnschema / Odontogramm | [DentalFindingDE](StructureDefinition-dental-finding.html) |
| Satzart 6 | BEMA-Leistungen (GKV) | [BemaChargeItemDE](StructureDefinition-bema-charge-item.html) |
| Satzart 7 | GOZ/GOÄ-Leistungen (PKV) | [GozChargeItemDE](StructureDefinition-goz-charge-item.html) |
| Satzart 8 | HKP / KV | [DentalCarePlanDE (planType: hkp)](StructureDefinition-dental-care-plan.html) |
| Satzart 9 | PAR-Plan | [DentalCarePlanDE (planType: par)](StructureDefinition-dental-care-plan.html) |
| Satzart 10 | KFO-Plan | [DentalCarePlanDE (planType: kfo)](StructureDefinition-dental-care-plan.html) |
| Satzart 11 | ZE / Festzuschüsse | [DentalCarePlanDE (planType: ze)](StructureDefinition-dental-care-plan.html) |
| Satzart 12 | Röntgendiagnostik | [DentalImagingStudyDE](StructureDefinition-dental-imaging-study.html) |
| Satzart 13 | Labordaten (BEL II / beb'97) | [DentalLabServiceRequestDE](StructureDefinition-dental-lab-service-request.html) |

See [SWS 2.0 Mapping](sws-mapping.html) for the complete field-level mapping.

**Actors:** Source PVS (exporting), Target PVS (importing), optional FHIR server as intermediary.

---

#### 2. Dental Billing (BEMA/GOZ)

**Problem:** German dental billing uses two parallel fee schedules — BEMA for GKV (statutory insurance) patients and GOZ for PKV (private insurance) patients. Billing data includes tooth references (FDI), surface codes, Befundklassen, and for GOZ additionally Steigerungsfaktoren with mandatory Begründungen above the threshold (2.3x).

**Solution:** Two dedicated ChargeItem profiles:

- [**BemaChargeItemDE**](StructureDefinition-bema-charge-item.html) — BEMA billing position with:
  - BEMA code (e.g. 01, 13a, Ä925)
  - Befundklasse (c=conserving, k=KCH, f=filling, e=endo, b=PAR)
  - FDI tooth reference and surface codes
  - Quantity, date, and encounter reference

- [**GozChargeItemDE**](StructureDefinition-goz-charge-item.html) — GOZ billing position with:
  - GOZ code (e.g. 2060, 5000)
  - Steigerungsfaktor (multiplier, default 2.3x, up to 3.5x with Begründung)
  - Begründungskategorie and Begründungstext
  - Analogleistung reference (§6 GOZ) for unlisted procedures
  - GOÄ positions for surgical components

**Workflow:**
1. Practitioner documents treatment in the PVS
2. PVS generates ChargeItem resources with billing codes, tooth references, and surfaces
3. For GKV: ChargeItems are aggregated per quarter and encounter for KZV submission
4. For PKV: ChargeItems form the basis of the patient invoice with Steigerungsfaktoren

---

#### 3. Heil- und Kostenplan (HKP)

**Problem:** Before major dental work (Zahnersatz), the dentist must create an HKP with planned procedures and costs. Since 2022, the E-HKP is submitted digitally to the insurer via the EBZ-Verfahren. The plan includes KZBV Befundkürzel, Therapiekürzel, Festzuschuss calculations, and Eigenanteil estimates.

**Solution:** The [DentalCarePlanDE (planType: hkp)](StructureDefinition-dental-care-plan.html) profile models the complete HKP lifecycle:

- **Befund:** Per-tooth findings using KZBV DPF Befundkürzel (e.g. "f" = fehlend, "k" = Krone, "ww" = erhaltenswürdiger Zahn)
- **Therapie:** Planned restorations using KZBV Therapiekürzel (e.g. "K" = Krone, "B" = Brückenglied, "TV" = Teleskop-Versorgung)
- **Festzuschüsse:** Calculated insurance contributions based on Befund-Therapie combinations
- **Bonus:** 20% (5 years) or 30% (10 years) bonus on Festzuschüsse for documented Vorsorge
- **Genehmigungsstatus:** eingereicht / in-pruefung / genehmigt / abgelehnt

**Workflow:**
1. Dentist documents Befund (clinical findings) per tooth
2. ZMV (dental office manager) creates HKP with therapy plan and cost estimate
3. E-HKP is submitted digitally to the insurer via EBZ
4. Insurer returns approval/rejection (ClaimResponse)
5. After approval, treatment can begin

---

#### 4. PAR-Behandlungsplan (Parodontologie)

**Problem:** Since the PAR-Richtlinie reform (July 2021), parodontal treatment requires a structured PAR-Status with documented pocket depths, BOP (Bleeding on Probing), and furcation involvement. The treatment plan covers antiinfektive Therapie, chirurgische Therapie, and UPT (Unterstützende Parodontitistherapie) over up to 2 years.

**Solution:** The [DentalCarePlanDE (planType: par)](StructureDefinition-dental-care-plan.html) profile covers:

- **PAR-Status:** Pocket depths (6 measurements per tooth), BOP, furcation grades (I-III)
- **PAR-Grading:** Stadium (I-IV) and Grad (A/B/C) per current classification
- **Treatment phases:** Mundhygienesitzung, subgingivale Instrumentierung, chirurgische Therapie, UPT
- **Approval workflow:** Status submission to insurer with structured clinical data

---

#### 5. KFO-Behandlungsplan (Kieferorthopädie)

**Problem:** Orthodontic treatment in Germany requires KIG (Kieferorthopädische Indikationsgruppen) classification for GKV coverage approval. Treatment spans multiple years with distinct phases (aktive Behandlung, Retention).

**Solution:** The [DentalCarePlanDE (planType: kfo)](StructureDefinition-dental-care-plan.html) profile models:

- **KIG classification:** Points 1-5 (GKV covers only KIG 3-5)
- **Angle classification:** Class I, II/1, II/2, III
- **Treatment phases:** Diagnostik, aktive Behandlung (Multiband/Aligner), Retention
- **Apparatus types:** Festsitzend (Brackets), herausnehmbar (Platten), Aligner, Retainer
- **Duration and cost planning** across multiple treatment years

---

#### 6. ZE-Versorgung (Zahnersatz)

**Problem:** Zahnersatz (dental prosthetics) in Germany follows a unique Festzuschuss system where the insurer pays a fixed subsidy per Befund regardless of the chosen therapy. The Regelversorgung defines the standard treatment; patients may choose gleichartige or andersartige Versorgung with private co-payment.

**Solution:** The [DentalCarePlanDE (planType: ze)](StructureDefinition-dental-care-plan.html) profile covers:

- **Befundkürzel:** Standardized KZBV codes for the clinical finding per tooth
- **Therapiekürzel:** Planned restoration type per tooth
- **Versorgungsart:** Regelversorgung / gleichartig / andersartig
- **Festzuschuss-Berechnung:** Based on Befund-Therapie-Zuordnung (FZ tables)
- **Bonus:** Percentage uplift based on documented Vorsorge history

---

#### 7. Dental Imaging and Lab Orders

**Problem:** Dental imaging (OPG, Einzelzahnaufnahmen, DVT) and lab work (Kronen, Brücken, Prothesen) require structured data exchange between practice, lab, and insurer. Internationally, no FHIR standard exists for **clinical** dental lab orders — existing standards (VDDS Laborschnittstelle, eLABZ) cover only billing data, while clinical information (shade, material, preparation type) is still communicated via free-text or paper.

**Solution:**

- [**DentalImagingStudyDE**](StructureDefinition-dental-imaging-study.html) — Dental radiograph metadata with modality (OPG/intraoral/DVT), tooth region (FDI), and findings reference
- [**DentalLabServiceRequestDE**](StructureDefinition-dental-lab-service-request.html) — Complete lab order combining:
  - **Administrative:** BEL II / beb'97 billing positions (via ChargeItem), lab and patient references
  - **Clinical:** Restoration type, tooth shade (VITA Classical), material specification, preparation form, occlusion concept, implant/abutment details, antagonist situation
  - **Digital assets:** References to intraoral scans (STL), photos, bite registrations via `supportingInfo`

This is analogous to FHIR's **VisionPrescription** for optometry — structured clinical parameters for a custom-manufactured medical device. See the dedicated [Clinical Lab Orders](lab-orders.html) page for full documentation.

**Workflow:**
1. Dentist prepares the tooth and documents clinical specifications (shade, material, preparation)
2. PVS generates a DentalLabServiceRequestDE with clinical extensions and references to digital impressions
3. Lab receives structured order — no ambiguity about shade (A3 not "yellowish"), material (Zirkon not "white ceramic"), or preparation (Stufe not "normal")
4. Lab delivers restoration with BEL II / beb'97 billing data linked to the same ServiceRequest

---

#### 8. AI-Assisted Dental Findings

**Problem:** Dental AI solutions (DentalXrai, Overjet, Pearl) analyze radiographs and produce structured findings (caries detection, bone loss measurement, periapical lesions). These findings need to be integrated into the clinical record using standardized FHIR resources.

**Solution:** The [DentalFindingDE](StructureDefinition-dental-finding.html) profile supports AI-generated findings through:

- **FDI tooth reference** and **surface codes** for precise localization
- **Befund-Status** (preliminary / differential / definitive) to distinguish AI suggestions from confirmed diagnoses
- **Category coding** via the dental-category CodeSystem (Befund, Diagnose, Verlauf)
- **Reference to imaging** via `derivedFrom` linking to DentalImagingStudyDE

This enables a workflow where AI analyzes an OPG, produces preliminary findings, and the dentist confirms or adjusts them before they become part of the official record.

---

#### 9. Inter-Practice Communication (KIM/TIM)

**Problem:** Dental referrals (Überweisungen), consultation requests, and treatment reports need to be exchanged between practices, specialists, and labs using the Gematik KIM (Kommunikation im Medizinwesen) or TIM (TI-Messenger) infrastructure.

**Solution:** The [DentalCommunicationDE](StructureDefinition-dental-communication.html) profile enables structured dental messages that can be wrapped in ATF MessageHeader bundles for KIM/TIM transport. Typical scenarios:

- **Referral to oral surgeon** with Zahnschema, relevant findings, and imaging
- **Lab order** with tooth specifications, material requirements, and shade selection
- **Treatment report** back to the referring dentist with procedure documentation
