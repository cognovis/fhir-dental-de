Instance: prac-dental-recorder
InstanceOf: Practitioner
Usage: #example
Title: "Beispiel dokumentierende Praxismitarbeiterin"
Description: "Praxismitarbeiterin, die einen Diagnosedatensatz erfasst, ohne ihn fachlich zu verantworten."

* active = true
* name[0].use = #official
* name[0].family = "Muster"
* name[0].given[0] = "Eva"

Instance: ExampleDentalConditionAuthored
InstanceOf: Condition
Usage: #example
Title: "Beispiel Zahn-Diagnose mit getrennter Urheberschaft"
Description: "Diagnose, die von einem Zahnarzt festgestellt und von einer anderen Praxismitarbeiterin erfasst wurde."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental
* code = $icd10gm#K02.1
* subject = Reference(Patient/pat-gkv-01)
* encounter = Reference(Encounter/enc-dental-01-kassenschein)
* recordedDate = "2026-01-10"
* bodySite[0] = $fdiCS#46
* asserter = Reference(Practitioner/prac-schoell)
* recorder = Reference(Practitioner/prac-dental-recorder)

Instance: ExampleDentalConditionAuthorshipBundle
InstanceOf: Bundle
Usage: #example
Title: "Beispiel Diagnose-Bundle mit Asserter und Recorder"
Description: "Bundle mit fachlich verantwortlichem Zahnarzt, getrennter dokumentierender Person und der zugehörigen Diagnose."

* type = #collection
* entry[0].fullUrl = "https://example-dental-practice.de/fhir/Condition/ExampleDentalConditionAuthored"
* entry[0].resource = ExampleDentalConditionAuthored
* entry[1].fullUrl = "https://example-dental-practice.de/fhir/Practitioner/prac-schoell"
* entry[1].resource = prac-schoell
* entry[2].fullUrl = "https://example-dental-practice.de/fhir/Practitioner/prac-dental-recorder"
* entry[2].resource = prac-dental-recorder
