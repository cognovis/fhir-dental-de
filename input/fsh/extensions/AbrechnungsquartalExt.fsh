Extension: AbrechnungsquartalExt
Id: abrechnungsquartal
Title: "Abrechnungsquartal"
Description: "GKV-Abrechnungsquartal im Format JJJJQ (z.B. 2026Q1). Das Quartal hat kein natives FHIR-Äquivalent und wird als Extension auf Encounter und Account abgebildet."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/abrechnungsquartal"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Encounter"
* ^context[+].type = #element
* ^context[=].expression = "Account"

* value[x] only string
* value[x] ^short = "Abrechnungsquartal im Format JJJJQ (z.B. 2026Q1, 2025Q4)"
