Extension: DentalDepositSurfaceExt
Id: dental-deposit-surface
Title: "Dental Deposit Surface"
Description: "Identifies the clinical surface or prosthetic structure affected by a deposit."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/dental-deposit-surface"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Observation"

* value[x] only CodeableConcept
* value[x] from DentalDepositSurfaceVS (required)
