Extension: EigenanteilRegelversorgungExt
Id: eigenanteil-regelversorgung
Title: "Eigenanteil Regelversorgung"
Description: "Patientenanteil bei Regelversorgung (Festzuschuss-Differenz). Der Eigenanteil ergibt sich aus den Gesamtkosten minus dem Festzuschuss der Krankenkasse gemäß §56 SGB V."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-regelversorgung"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Claim"

* value[x] only Money
* value[x] ^short = "Patientenanteil bei Regelversorgung (EUR)"
