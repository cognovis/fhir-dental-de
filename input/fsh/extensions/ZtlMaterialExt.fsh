Extension: ZtlMaterialExt
Id: ztl-material
Title: "ZTL Material"
Description: "Zahntechnisches Material oder Legierungsklasse für zahntechnische Leistungen (ZTL). Enthält die Materialbezeichnung und ggf. die Legierungsklasse nach DIN EN ISO 22674 (z.B. Klasse 4 für Aufbrennlegierungen)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ztl-material"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* value[x] only CodeableConcept
* value[x] from ZtlMaterialVS (preferred)
* value[x] ^short = "Zahntechnisches Material / Legierungsklasse (z.B. NEM, Keramik, Titan)"
