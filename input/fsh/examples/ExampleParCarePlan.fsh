// Example: PAR-Plan, UPT-Intervall 3 Monate
// SWS 2.0 Satzart 9 — PAR-Behandlungsplan

Alias: $icd10gm = http://fhir.de/CodeSystem/bfarm/icd-10-gm

Instance: ExampleParCarePlan
InstanceOf: ParCarePlanDE
Usage: #example
Title: "Beispiel PAR-Behandlungsplan UPT 3 Monate"
Description: "Parodontologischer Behandlungsplan (PAR-Richtlinie 07/2021) für generalisierten Parodontitis-Befund. UPT-Recall-Intervall 3 Monate. Behandlungszeitraum: 2026-02-10 bis 2028-02-09. Patient Friedrich Hartmann (Beihilfe)."

* extension[parUptIntervall].valueInteger = 3

* identifier[0].system = "https://mira-demo-mvz.de/par-plan"
* identifier[0].value = "PAR-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(Patient/pat-beihilfe-01)

* created = "2026-02-05"

* period.start = "2026-02-10"
* period.end = "2028-02-09"

* title = "PAR-Behandlungsplan: Parodontitis generalisiert, Stadium II, Grad B"

* description = "PAR-Behandlung nach PAR-Richtlinie (07/2021). Diagnose: Generalisierte Parodontitis Stadium II, Grad B. Aktive Phase: Mundhygieneunterweisung, subgingivales Debridement, Reevaluation nach 8–12 Wochen. UPT: 3-Monats-Intervall für 2 Jahre. Antibiotikatherapie nicht indiziert."

// Link to Parodontitis-Diagnose (Condition mit par-stadium)
* addresses[0] = Reference(ExampleParodontitisCondition)

// PA-Statuserhebung (DentalFinding)
* supportingInfo[0] = Reference(ExampleDentalFinding)

// UPT-Recall-Aktivität: alle 3 Monate
* activity[0].detail.status = #scheduled
* activity[0].detail.code = http://snomed.info/sct#63963009 "Dental prophylaxis, adult"
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

* code = $icd10gm#K05.31 "Chronische Parodontitis, generalisiert"
* code.text = "Generalisierte chronische Parodontitis, Stadium II, Grad B"

* subject = Reference(Patient/pat-beihilfe-01)

* onsetDateTime = "2026-02-05"
* recordedDate = "2026-02-05"
