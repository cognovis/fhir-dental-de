Extension: DentalDepositVerticalLocationExt
Id: dental-deposit-vertical-location
Title: "Dental Deposit Vertical Location"
Description: "Identifies a deposit location relative to the gingival margin."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/dental-deposit-vertical-location"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Observation"

* value[x] only CodeableConcept
* value[x] from DentalDepositVerticalLocationVS (required)
