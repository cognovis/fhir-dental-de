Extension: EhkpIdExt
Id: ehkp-id
Title: "eHKP Referenznummer"
Description: "EBZ-Referenznummer für den elektronischen Heil- und Kostenplan (eHKP)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ehkp-id"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only string
* value[x] ^short = "EBZ-Referenznummer des elektronischen HKP"
