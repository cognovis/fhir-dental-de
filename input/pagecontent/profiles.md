### Profiles

This implementation guide defines the following profiles for German dental practice data:

#### Clinical Profiles
- [DentalFindingDE](StructureDefinition-dental-finding.html) — Zahnärztlicher Befund (Observation)
- [PeriodontalObservationDE](StructureDefinition-periodontal-observation.html) — Parodontalbefund (Observation)
- [ProphylaxisObservationDE](StructureDefinition-prophylaxis-observation.html) — Prophylaxe-Befund (Observation)
- [DentalDepositObservationDE](StructureDefinition-dental-deposit-observation.html) — Klinischer Belagstyp und zweiachsige Lokalisation (Observation)
- [RadiographicBoneLossObservationDE](StructureDefinition-radiographic-bone-loss-observation.html) — Röntgenologischer Knochenabbau mit Grading-Evidenz (Observation)
- [OralHealthScreeningDE](StructureDefinition-oral-health-screening.html) — Oral Health Screening: parafunktionale Habits, orale Risikofaktoren, systemische Screening-Befunde (Observation)
- [DentalConditionDE](StructureDefinition-dental-condition.html) — Zahnärztliche Diagnose (Condition)
- [DentalProcedureDE](StructureDefinition-dental-procedure.html) — Zahnärztliche Behandlung (Procedure)
- [DentalCommunicationDE](StructureDefinition-dental-communication.html) — Zahnärztliche Kommunikation (Communication)
- [DentalClinicalImpressionDE](StructureDefinition-dental-clinical-impression.html) — Behandlungsjournal (ClinicalImpression)

#### Billing Profiles
- [BemaChargeItemDE](StructureDefinition-bema-charge-item.html) — BEMA Leistungsposition (ChargeItem)
- [GozChargeItemDE](StructureDefinition-goz-charge-item.html) — GOZ Leistungsposition (ChargeItem)
- [DentalEncounterDE](StructureDefinition-dental-encounter.html) — Behandlungskontakt (Encounter, billing-agnostic)
- [DentalClaimDE](StructureDefinition-dental-claim-de.html) — Abrechnungsanspruch (Claim, billing-case boundary)

Dental billing cases reuse [AccountPraxisSchein](https://fhir.cognovis.de/praxis/StructureDefinition-account-praxis-schein) from the Praxis-DE IG. ScheinNummer, Scheinart, servicePeriod, and coverage live on Account; `Encounter.account` and `ChargeItem.account` reference it.

#### Treatment Plans
- [DentalCarePlanDE](StructureDefinition-dental-care-plan.html) — Dental Behandlungsplan: HKP, PAR, KFO, ZE, KBR, KGL, PMB (CarePlan, via category[planType])

The PAR and prophylaxis resource boundaries, measurement representation, workflow links, and delegation semantics are described in [PAR and Prophylaxis](par-prophylaxis.html).

#### Supporting Profiles
- [DentalOrganizationDE](StructureDefinition-dental-organization.html) — Zahnarztpraxis (Organization)
- [DentalPractitionerDE](StructureDefinition-dental-practitioner.html) — Zahnärztlicher Behandler (Practitioner, ZANR)
- [DentalPractitionerRoleDE](StructureDefinition-dental-practitioner-role.html) — Zahnärztliche Rolle am Standort (`PractitionerRole.specialty` → SNOMED CT)
- [DentalImagingStudyDE](StructureDefinition-dental-imaging-study.html) — Röntgendiagnostik (ImagingStudy)
- [DentalLabServiceRequestDE](StructureDefinition-dental-lab-service-request.html) — Laborauftrag (ServiceRequest)
