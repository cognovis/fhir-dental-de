// Example: PAR-Plan, UPT-Intervall 3 Monate
// SWS 2.0 Satzart 9 — PAR-Behandlungsplan

Alias: $icd10gm = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $parStage = https://fhir.cognovis.de/dental/CodeSystem/par-stadium
Alias: $parPhase = https://fhir.cognovis.de/dental/CodeSystem/par-behandlungs-phase
Alias: $parGrade = https://fhir.cognovis.de/dental/CodeSystem/par-grad

Instance: ExampleParCarePlan
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel PAR-Behandlungsplan UPT 3 Monate"
Description: "Parodontologischer Behandlungsplan (PAR-Richtlinie 07/2021) für generalisierten Parodontitis-Befund. UPT-Recall-Intervall 3 Monate. Behandlungszeitraum: 2026-02-10 bis 2028-02-09. Patient Friedrich Hartmann (Beihilfe)."

* extension[parUptIntervall].valueInteger = 3
* extension[parTreatmentPhase].valueCodeableConcept = $parPhase#UPT

* identifier[0].system = "https://example-dental-practice.de/par-plan"
* identifier[0].value = "PAR-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#par "Parodontologie (PAR)"

* subject = Reference(Patient/pat-beihilfe-01)

* created = "2026-02-05"

* period.start = "2026-02-10"
* period.end = "2028-02-09"

* title = "PAR-Behandlungsplan: Parodontitis generalisiert, Stadium II, Grad B"

* description = "PAR-Behandlung nach PAR-Richtlinie (07/2021). Diagnose: Generalisierte Parodontitis Stadium II, Grad B. Aktive Phase: Mundhygieneunterweisung, subgingivales Debridement, Reevaluation nach 8–12 Wochen. UPT: 3-Monats-Intervall für 2 Jahre. Antibiotikatherapie nicht indiziert."

// Link to Parodontitis-Diagnose (Condition mit par-stadium)
* addresses[0] = Reference(ExampleParodontitisCondition)

// Source observations supporting the plan; no six-month invariant is inferred.
* supportingInfo[0] = Reference(ExampleProphylaxisObservation)
* supportingInfo[1] = Reference(ExamplePeriodontalObservationPAR)

// Authoritative treatment phases: ATG precedes the active treatment path
* activity[0].detail.status = #scheduled
* activity[0].detail.code = $parPhase#ATG
* activity[0].detail.description = "Periodontal information and treatment discussion."

// UPT recall activity every three months
* activity[1].detail.status = #scheduled
* activity[1].detail.code = $parPhase#UPT
* activity[1].detail.scheduledTiming.repeat.period = 3
* activity[1].detail.scheduledTiming.repeat.periodUnit = #mo
* activity[1].detail.description = "Supportive periodontal therapy recall."
* activity[1].outcomeReference[0] = Reference(ExampleProphylaxisObservationFollowUp)

// -----------------------------------------------------------------------
// Inline Parodontitis Condition (referenced by PAR CarePlan)
// -----------------------------------------------------------------------
Instance: ExampleParodontitisCondition
InstanceOf: DentalConditionDE
Usage: #example
Title: "Beispiel Parodontitis-Diagnose Stadium II Grad B"
Description: "Generalisierte Parodontitis, Stadium II, Grad B (BSP-Klassifikation 2018). PAR-Stadium-Extension auf Condition. Konform zu DentalConditionDE."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/par-stadium"
* extension[0].valueCodeableConcept = $parStage#II
* extension[1].url = "https://fhir.cognovis.de/dental/StructureDefinition/par-grade"
* extension[1].valueCodeableConcept = $parGrade#B

* evidence[0].detail[0] = Reference(ExampleRadiographicBoneLoss)
* evidence[0].detail[1] = Reference(ExampleHbA1cForParGrading)
* evidence[0].detail[2] = Reference(ExampleSmokingStatusForParGrading)

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $icd10gm#K05.3 "Chronische Parodontitis"
* code.text = "Generalisierte chronische Parodontitis, Stadium II, Grad B"

* subject = Reference(Patient/pat-beihilfe-01)

* onsetDateTime = "2026-02-05"
* recordedDate = "2026-02-05"
