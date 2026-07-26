Extension: ParTreatmentPhaseExt
Id: par-treatment-phase
Title: "PAR Treatment Phase"
Description: "Current treatment phase in the PAR workflow, using the authoritative PAR-Richtlinie terminology package."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-treatment-phase"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only CodeableConcept
* value[x] from https://fhir.cognovis.de/dental/ValueSet/par-behandlungs-phase (required)
* value[x] ^short = "ATG, MHU, AIT, BEV, CPT, UPT, or another authoritative PAR phase"
