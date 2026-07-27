### Profiles

This implementation guide defines the following profiles for German dental practice data:

#### Clinical Profiles
- [DentalFindingDE](StructureDefinition-dental-finding.html) — Zahnärztlicher Befund (Observation)
- [CariesObservationDE](StructureDefinition-caries-observation.html) — surface-specific ICDAS II lesion score
- [PulpSensibilityObservationDE](StructureDefinition-pulp-sensibility-observation.html) — thermal and electric pulp sensibility results
- [ProsthesisFindingDE](StructureDefinition-prosthesis-finding.html) — technical finding focused on a removable prosthesis Device
- [SuprastructureFindingDE](StructureDefinition-suprastructure-finding.html) — technical finding focused on an implant suprastructure Device
- [PeriodontalObservationDE](StructureDefinition-periodontal-observation.html) — Parodontalbefund (Observation)
- [PeriImplantObservationDE](StructureDefinition-peri-implant-observation.html) — site-level findings around one referenced implant
- [ProphylaxisObservationDE](StructureDefinition-prophylaxis-observation.html) — Prophylaxe-Befund (Observation)
- [DentalDepositObservationDE](StructureDefinition-dental-deposit-observation.html) — Klinischer Belagstyp und zweiachsige Lokalisation (Observation)
- [RadiographicBoneLossObservationDE](StructureDefinition-radiographic-bone-loss-observation.html) — Röntgenologischer Knochenabbau mit Grading-Evidenz (Observation)
- [OralHealthScreeningDE](StructureDefinition-oral-health-screening.html) — Oral Health Screening: parafunktionale Habits, orale Risikofaktoren, systemische Screening-Befunde (Observation)
- [AlignerProgressObservationDE](StructureDefinition-aligner-progress-observation.html) — stage-specific clinical tracking outcome
- [TraumaObservationDE](StructureDefinition-trauma-observation.html) — one published ICD-11 NA0D injury classification per tooth and event time
- [DentalConditionDE](StructureDefinition-dental-condition.html) — Zahnärztliche Diagnose (Condition)
- [DentalProcedureDE](StructureDefinition-dental-procedure.html) — Zahnärztliche Behandlung (Procedure)
- [PeriodontalAdjunctiveProcedureDE](StructureDefinition-periodontal-adjunctive-procedure.html) — laser, aPDT, aPTT, or local antimicrobial procedure with referenced Device and Substance
- [DentalCommunicationDE](StructureDefinition-dental-communication.html) — Zahnärztliche Kommunikation (Communication)
- [DentalClinicalImpressionDE](StructureDefinition-dental-clinical-impression.html) — Behandlungsjournal (ClinicalImpression)

#### Billing Profiles
- [BemaChargeItemDE](StructureDefinition-bema-charge-item.html) — BEMA Leistungsposition (ChargeItem)
- [GozChargeItemDE](StructureDefinition-goz-charge-item.html) — GOZ Leistungsposition (ChargeItem)
- [GozInvoiceDE](StructureDefinition-goz-invoice-de.html) — GOZ private invoice, derived directly from gematik DiPagRechnung
- [DentalEncounterDE](StructureDefinition-dental-encounter.html) — Behandlungskontakt (Encounter, billing-agnostic)
- [DentalClaimDE](StructureDefinition-dental-claim-de.html) — Abrechnungsanspruch (Claim, billing-case boundary)

Dental billing cases reuse [AccountPraxisSchein](https://fhir.cognovis.de/praxis/StructureDefinition-account-praxis-schein) from the Praxis-DE IG. ScheinNummer, Scheinart, servicePeriod, and coverage live on Account; `Encounter.account` and `ChargeItem.account` reference it.

`GozInvoiceDE` uses the official gematik
[`DiPagRechnung`](https://gematik.de/fhir/dipag/StructureDefinition/dipag-rechnung)
contract. Dental adds only the GOZ charge-item and account references; gross
amounts, included tax, deductions, laboratory services, payment details, and
correction invoices retain their DiPag meaning.

#### Treatment Plans
- [DentalCarePlanDE](StructureDefinition-dental-care-plan.html) — Dental Behandlungsplan: HKP, PAR, KFO, ZE, KBR, KGL, PMB (CarePlan, via category[planType])
- [PrimarySnoringCarePlanDE](StructureDefinition-primary-snoring-care-plan.html) — primary-snoring oral-appliance care with linked evidence and Device
- [OsasOralApplianceCarePlanDE](StructureDefinition-osas-oral-appliance-care-plan.html) — medically ordered OSAS oral-appliance pathway
- [AlignerCarePlanDE](StructureDefinition-aligner-care-plan.html) — KFO plan with tooth-specific attachments and interproximal reduction

The PAR and prophylaxis resource boundaries, measurement representation, workflow links, and delegation semantics are described in [PAR and Prophylaxis](par-prophylaxis.html).

#### Supporting Profiles
- [DentalImplantDE](StructureDefinition-dental-implant.html) — reusable dental implant Device identity
- [ImplantSuprastructureDE](StructureDefinition-implant-suprastructure.html) — implant-supported crown, bridge, or prosthesis identity
- [DentalProsthesisDE](StructureDefinition-dental-prosthesis.html) — removable prosthesis Device identity
- [OsasOralApplianceDeviceDE](StructureDefinition-osas-oral-appliance-device.html) — manufacturer-neutral OSAS oral appliance identity
- [OsasOralApplianceServiceRequestDE](StructureDefinition-osas-oral-appliance-service-request.html) — medical order initiating the dental OSAS pathway
- [DentalOrganizationDE](StructureDefinition-dental-organization.html) — Zahnarztpraxis (Organization)
- [DentalPractitionerDE](StructureDefinition-dental-practitioner.html) — Zahnärztlicher Behandler (Practitioner, ZANR)
- [DentalPractitionerRoleDE](StructureDefinition-dental-practitioner-role.html) — Zahnärztliche Rolle am Standort (`PractitionerRole.specialty` → SNOMED CT)
- [DentalImagingStudyDE](StructureDefinition-dental-imaging-study.html) — Röntgendiagnostik (ImagingStudy)
- [DentalLabServiceRequestDE](StructureDefinition-dental-lab-service-request.html) — Laborauftrag (ServiceRequest)
