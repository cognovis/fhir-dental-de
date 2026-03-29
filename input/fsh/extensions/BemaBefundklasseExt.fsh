Extension: BemaBefundklasseExt
Id: bema-befundklasse
Title: "BEMA Befundklasse"
Description: "Befundklasse des Zahnes nach BEMA-Zahnschema (c/k/f/e/b)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/bema-befundklasse"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"
* ^context[+].type = #element
* ^context[=].expression = "Observation"

* value[x] only code
* value[x] from BemaBefundklasseVS (required)
* value[x] ^short = "BEMA Befundklasse (c, k, f, e, b)"
