Extension: ZeVersorgungsartExt
Id: ze-versorgungsart
Title: "ZE Versorgungsart"
Description: "Art der Zahnersatz-Versorgung: Regelversorgung, gleichartige Versorgung oder andersartige Versorgung. Auf Claim.item klassifiziert sie die maschinenlesbare Abrechnungszeile."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"
* ^context[+].type = #element
* ^context[=].expression = "Claim.item"

* value[x] only code
* value[x] from ZeVersorgungsartVS (required)
* value[x] ^short = "ZE-Versorgungsart (regelversorgung|gleichartig|andersartig)"
