Extension: ToothSurfacesExt
Id: tooth-surfaces
Title: "Zahnflächen"
Description: "Betroffene Zahnflächen (Mesial, Distal, Okklusal, etc.)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"
* ^context[+].type = #element
* ^context[=].expression = "Observation"

* extension 0..0
* value[x] only CodeableConcept
* value[x] from ToothSurfacesVS (required)
* value[x] ^short = "Zahnfläche (M, D, O, I, B, V, L, P)"
