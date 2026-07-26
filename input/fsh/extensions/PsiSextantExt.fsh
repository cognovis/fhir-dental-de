Extension: PsiSextantExt
Id: psi-sextant
Title: "PSI Sextant"
Description: "Identifies the dentition sextant for one PSI result independently of component order."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/psi-sextant"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Observation.component"

* value[x] only CodeableConcept
* value[x] from PSISextantVS (required)
