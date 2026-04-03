// Example: PAR-Plan, UPT-Intervall 3 Monate
// SWS 2.0 Satzart 9 — PAR-Behandlungsplan

Instance: ExampleParCarePlan
InstanceOf: ParCarePlanDE
Usage: #example
Title: "Beispiel PAR-Behandlungsplan UPT 3 Monate"
Description: "Parodontologischer Behandlungsplan (PAR-Richtlinie 07/2021) für generalisierten Parodontitis-Befund. UPT-Recall-Intervall 3 Monate. Behandlungszeitraum: 2026-Q1 bis 2027-Q4."

* extension[parUptIntervall].valueInteger = 3

* identifier[0].system = "https://mira.cognovis.de/fhir/identifier/par-plan-id"
* identifier[0].value = "PAR-2026-000005"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(ExamplePatient)

* created = "2026-01-15"

* period.start = "2026-02-01"
* period.end = "2027-12-31"

* title = "PAR-Behandlungsplan: Parodontitis generalisiert, Stadium II, Grad B"

* description = "PAR-Behandlung nach PAR-Richtlinie (07/2021). Diagnose: Generalisierte Parodontitis Stadium II, Grad B. Aktive Phase: Mundhygieneunterweisung, subgingivales Debridement, Reevaluation nach 8–12 Wochen. UPT: 3-Monats-Intervall für 2 Jahre. Antibiotikatherapie nicht indiziert."

// Link to Parodontitis-Diagnose (Condition mit par-stadium)
* addresses[0] = Reference(ExampleParodontitisCondition)

// PA-Statuserhebung (DentalFinding)
* supportingInfo[0] = Reference(ExampleDentalFinding)

// UPT-Recall-Aktivität: alle 3 Monate
* activity[0].detail.status = #scheduled
* activity[0].detail.code = http://snomed.info/sct#86477000 "Subgingival curettage"
* activity[0].detail.code.text = "UPT — Unterstützende Parodontitistherapie"
* activity[0].detail.scheduledTiming.repeat.period = 3
* activity[0].detail.scheduledTiming.repeat.periodUnit = #mo
* activity[0].detail.description = "UPT-Recall alle 3 Monate: subgingivales Reinstrumentieren, Remotivation, Dokumentation."

// -----------------------------------------------------------------------
// Inline Parodontitis Condition (referenced by PAR CarePlan)
// -----------------------------------------------------------------------
Instance: ExampleParodontitisCondition
InstanceOf: Condition
Usage: #example
Title: "Beispiel Parodontitis-Diagnose Stadium II Grad B"
Description: "Generalisierte Parodontitis, Stadium II, Grad B (BSP-Klassifikation 2018). PAR-Stadium-Extension auf Condition. Konform zu DentalConditionDE."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/de-mira-dental-condition"

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/par-stadium"
* extension[0].valueCode = https://fhir.cognovis.de/dental/CodeSystem/par-stadium#B "Stadium B (moderate Progression)"

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"

* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = http://fhir.de/CodeSystem/bfarm/icd-10-gm#K05.3 "Chronische Parodontitis"
* code.text = "Generalisierte chronische Parodontitis, Stadium II, Grad B"

* subject = Reference(ExamplePatient)

* onsetDateTime = "2026-01-15"
* recordedDate = "2026-01-15"
