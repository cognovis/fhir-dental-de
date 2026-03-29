Extension: ZeVersorgungsartExt
Id: ze-versorgungsart
Title: "ZE Versorgungsart"
Description: "Art der Zahnersatz-Versorgung: Regelversorgung (kassenüblich), gleichartige Versorgung (anderes Material, gleichwertige Funktion) oder andersartige Versorgung (höherwertiger ZE). Bestimmt die Festzuschuss-Berechnung nach §56 SGB V."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from ZeVersorgungsartVS (required)
* value[x] ^short = "ZE-Versorgungsart (regelversorgung|gleichartig|andersartig)"
