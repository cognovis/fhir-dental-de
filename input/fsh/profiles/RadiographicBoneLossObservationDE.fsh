Profile: RadiographicBoneLossObservationDE
Parent: DentalFindingDE
Id: radiographic-bone-loss-observation
Title: "Radiographic Bone Loss Observation (DE)"
Description: "Radiographic alveolar bone loss percentage at a reference tooth, with explicit calculation inputs for an optional bone-loss-per-age ratio."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = http://snomed.info/sct#95570007
* bodySite 1..1 MS
* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component contains
    patientAgeAtMeasurement 1..1 MS and
    boneLossPerAge 0..1 MS

* component[patientAgeAtMeasurement].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#patient-age-at-measurement
* component[patientAgeAtMeasurement].value[x] only integer

* component[boneLossPerAge].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#bone-loss-per-age
* component[boneLossPerAge].value[x] only Ratio
* component[boneLossPerAge] ^short = "Radiographic bone-loss percentage divided by age in completed years"

* performer MS
* performer only Reference(Practitioner or PractitionerRole or Organization)
