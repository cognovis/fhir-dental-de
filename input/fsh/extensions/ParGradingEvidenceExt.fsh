Extension: ParGradingEvidenceExt
Id: par-grading-evidence
Title: "PAR Grading Evidence"
Description: "Deprecated compatibility extension. New resources SHALL use Condition.evidence.detail to reference periodontal grading evidence such as radiographic bone loss, HbA1c, or smoking status."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-grading-evidence"
* ^status = #retired
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^purpose = "Retained only so existing resources remain resolvable. Condition.evidence.detail provides the same reference semantics in FHIR R4 and is constrained to Observation references by DentalConditionDE."
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* value[x] only Reference(Observation)
