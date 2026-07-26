Extension: ParGradeExt
Id: par-grade
Title: "PAR Grade"
Description: "Periodontitis progression grade A through C using the authoritative PAR-Richtlinie terminology package."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-grade"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* value[x] only CodeableConcept
* value[x] from https://fhir.cognovis.de/dental/ValueSet/par-grad (required)
