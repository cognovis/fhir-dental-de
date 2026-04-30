Extension: ZeTherapiekuerzelExt
Id: ze-therapiekuerzel
Title: "ZE Therapiekürzel"
Description: "Therapiekürzel für die geplante Zahnersatz-Versorgung gemäß KZBV Digitaler Planungsbogen für Zahnersatz (DPF). Beschreibt die geplante Soll-Versorgung (z.B. 'K'=Krone, 'B'=Brücke, 'E'=Implantat)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-therapiekuerzel"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from ZeTherapiekuerzelVS (required)
* value[x] ^short = "ZE-Therapiekürzel nach KZBV DPF (z.B. K, B, T, V, E)"
