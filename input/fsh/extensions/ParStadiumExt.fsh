Extension: ParStadiumExt
Id: par-stadium
Title: "PAR Stadium"
Description: "Periodontitis stage I through IV according to the current classification. The authoritative terminology is supplied by de.cognovis.terminology.dental.par-richtlinie."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-stadium"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* value[x] only CodeableConcept
* value[x] from https://fhir.cognovis.de/dental/ValueSet/par-stadium (required)
* value[x] ^short = "Periodontitis stage I, II, III, or IV"
