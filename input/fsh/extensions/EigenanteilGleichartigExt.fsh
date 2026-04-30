Extension: EigenanteilGleichartigExt
Id: eigenanteil-gleichartig
Title: "Eigenanteil gleichartige Versorgung"
Description: "Patientenanteil bei gleichartiger Versorgung (anderes Material, gleiche Funktion wie Regelversorgung). Enthält die Differenz zwischen tatsächlichen Kosten und dem Festzuschuss der Krankenkasse."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-gleichartig"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Claim"

* value[x] only Money
* value[x] ^short = "Patientenanteil bei gleichartiger Versorgung (EUR)"
