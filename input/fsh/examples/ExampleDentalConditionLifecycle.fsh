// Lifecycle examples intentionally use base Condition plus meta.profile because
// the KBV parent profile's code slicing cannot be resolved reliably by SUSHI
// when examples directly declare DentalConditionDE as InstanceOf.

Instance: ExampleDentalConditionProvisional
InstanceOf: Condition
Usage: #example
Title: "Beispiel vorläufige aktive Zahn-Diagnose"
Description: "Vorläufig verifizierte aktive Dentinkaries mit quellenbelegtem Behandlungskontakt."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#provisional
* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental
* code = $icd10gm#K02.1
* subject = Reference(Patient/pat-gkv-01)
* encounter = Reference(Encounter/enc-dental-01-kassenschein)
* recordedDate = "2026-01-10"
* bodySite[0] = $fdiCS#46

Instance: ExampleDentalConditionResolved
InstanceOf: Condition
Usage: #example
Title: "Beispiel bestätigte abgeklungene Zahn-Diagnose"
Description: "Bestätigte und abgeklungene Dentinkaries ohne erfundenen Behandlungskontakt."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#resolved
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental
* code = $icd10gm#K02.1
* subject = Reference(Patient/pat-gkv-01)
* abatementDateTime = "2026-02-14"
* recordedDate = "2026-01-10"
* bodySite[0] = $fdiCS#46

Instance: ExampleDentalConditionEnteredInError
InstanceOf: Condition
Usage: #example
Title: "Beispiel irrtümlich erfasste Zahn-Diagnose"
Description: "Irrtümlich erfasste Diagnose ohne clinicalStatus gemäß FHIR-Invariante con-5."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#entered-in-error
* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental
* code = $icd10gm#K02.1
* subject = Reference(Patient/pat-gkv-01)
* recordedDate = "2026-01-10"
* bodySite[0] = $fdiCS#46
