Extension: ParUptIntervallExt
Id: par-upt-intervall
Title: "PAR UPT-Intervall"
Description: "Recall-Intervall für die Unterstützende Parodontitistherapie (UPT) in Monaten. Nach PAR-Richtlinie (07/2021) besteht ein Anspruch auf UPT für bis zu 2 Jahre nach aktiver Therapie."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-upt-intervall"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only integer
* value[x] ^short = "UPT-Recall-Intervall in Monaten (typisch 3, 6 oder 12 Monate)"
