Extension: ParGradingEvidenceExt
Id: par-grading-evidence
Title: "PAR Grading Evidence"
Description: "References an Observation used as evidence for periodontal grading, such as radiographic bone loss, HbA1c, or smoking status."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-grading-evidence"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* value[x] only Reference(Observation)
