Extension: PsiAdditionalFindingExt
Id: psi-additional-finding
Title: "PSI Additional Finding"
Description: "True when the KZBV PSI star modifier applies because an additional finding such as recession or mobility was observed."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/psi-additional-finding"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Observation.component"

* value[x] only boolean
