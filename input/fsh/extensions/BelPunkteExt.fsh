Extension: BelPunkteExt
Id: bel-punkte
Title: "BEL II Punkte"
Description: "Punktzahl für zahntechnische Leistungen nach BEL II (Bewertungsmaßstab für zahntechnische Leistungen). Die Punktzahl multipliziert mit dem KZV-Punktwert ergibt den Abrechnungsbetrag."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/bel-punkte"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* value[x] only integer
* value[x] ^short = "BEL II Punktzahl der zahntechnischen Leistungsposition"
