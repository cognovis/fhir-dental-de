Alias: $loinc = http://loinc.org
Alias: $icd10gm = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $fdiCS = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $periodontalSite = https://fhir.cognovis.de/dental/CodeSystem/periodontal-measurement-site

Instance: ExampleDelegatedPeriodontalAssistant
InstanceOf: Practitioner
Usage: #inline
Title: "Delegated Periodontal Measurement Practitioner"
* id = "delegated-periodontal-assistant"
* active = true
* name.text = "Delegated periodontal measurement practitioner"
* qualification.code.text = "Dental hygienist"

Instance: ExampleDelegatedPeriodontalRole
InstanceOf: PractitionerRole
Usage: #inline
Title: "Delegated Periodontal Measurement Role"
* id = "delegated-periodontal-role"
* active = true
* practitioner = Reference(urn:uuid:cf78cc18-3ec7-4c65-a270-de7546bc14ee)
* organization = Reference(Organization/org-dental-mvz)
* code.text = "Delegated periodontal measurement"

Instance: ExampleDelegatedPeriodontalMeasurement
InstanceOf: PeriodontalObservationDE
Usage: #inline
Title: "Delegated Periodontal Measurement"
* id = "delegated-periodontal-measurement"
* status = #final
* code = $loinc#8704-9
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(urn:uuid:4818fbd5-a2b1-47ec-9870-0d23e9b8ef6d)
* effectiveDateTime = "2026-02-05T12:00:00+01:00"
* bodySite = $fdiCS#16
* component[probingDepth].code = $loinc#32910-2
* component[probingDepth].extension[measurementSite].valueCodeableConcept = $periodontalSite#mesiobuccal
* component[probingDepth].valueQuantity = 4 'mm'

Instance: ExampleDentistAssertedPeriodontalDiagnosis
InstanceOf: Condition
Usage: #inline
Title: "Dentist-Asserted Periodontal Diagnosis"
* id = "dentist-asserted-periodontal-diagnosis"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* code = $icd10gm#K05.3
* subject = Reference(Patient/pat-beihilfe-01)
* asserter = Reference(urn:uuid:1d34d04e-3bad-4b97-b9a4-e988d20fb21a)
* recordedDate = "2026-02-05"

Instance: ExampleDelegationDentist
InstanceOf: Practitioner
Usage: #inline
Title: "Dentist Diagnosis Asserter"
* id = "delegation-dentist"
* active = true
* name.text = "Dentist diagnosis asserter"
* qualification.code.text = "Dentist"

Instance: ExampleDelegatedPeriodontalBundle
InstanceOf: Bundle
Usage: #example
Title: "Delegated Periodontal Assessment Bundle"
Description: "A resolved audit example that separates the measurement performer from the diagnosis asserter."
* type = #collection
* timestamp = "2026-02-05T12:05:00+01:00"
* entry[0].fullUrl = "urn:uuid:cf78cc18-3ec7-4c65-a270-de7546bc14ee"
* entry[0].resource = ExampleDelegatedPeriodontalAssistant
* entry[1].fullUrl = "urn:uuid:4818fbd5-a2b1-47ec-9870-0d23e9b8ef6d"
* entry[1].resource = ExampleDelegatedPeriodontalRole
* entry[2].fullUrl = "urn:uuid:9d82aa31-10c4-4193-a4cc-e90ba7430749"
* entry[2].resource = ExampleDelegatedPeriodontalMeasurement
* entry[3].fullUrl = "urn:uuid:89aab8f9-8968-4dc2-886e-a8dd8fca6329"
* entry[3].resource = ExampleDentistAssertedPeriodontalDiagnosis
* entry[4].fullUrl = "urn:uuid:1d34d04e-3bad-4b97-b9a4-e988d20fb21a"
* entry[4].resource = ExampleDelegationDentist
