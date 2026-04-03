Extension: KfoAngleKlasseExt
Id: kfo-angle-klasse
Title: "KFO Angle-Klasse"
Description: "Klassifikation der Malokkusion nach Angle (Klasse I, II/1, II/2, III). SNOMED CT bietet keine vollständigen Codes für alle Angle-Unterklassen — daher eigene Extension auf Condition."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-angle-klasse"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* value[x] only code
* value[x] from KfoAngleKlasseVS (required)
* value[x] ^short = "Angle-Klasse (I|II-1|II-2|III)"
