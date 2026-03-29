Extension: ParStadiumExt
Id: par-stadium
Title: "PAR Stadium"
Description: "Parodontitis-Stadium nach BSP/EFP-Klassifikation 2018 (Tonetti et al.): A (langsame Progression), B (moderate Progression), C (schnelle Progression). Ergänzt die Stadien I–IV auf Condition."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/par-stadium"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* value[x] only code
* value[x] from ParStadiumVS (required)
* value[x] ^short = "PAR-Stadium nach BSP-Klassifikation 2018 (A|B|C)"
