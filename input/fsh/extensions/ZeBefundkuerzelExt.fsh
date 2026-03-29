Extension: ZeBefundkuerzelExt
Id: ze-befundkuerzel
Title: "ZE Befundkürzel"
Description: "Befundkürzel für den Zahnersatz-Ist-Zustand gemäß KZBV Digitaler Planungsbogen für Zahnersatz (DPF). Beschreibt die vorhandene Versorgung zum Zeitpunkt der Befunderhebung (z.B. 'k'=Krone, 'x'=fehlend)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-befundkuerzel"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from ZeBefundkuerzelVS (required)
* value[x] ^short = "ZE-Befundkürzel nach KZBV DPF (z.B. k, x, e, bg, impl)"
