Extension: FdiToothNumberExt
Id: fdi-tooth-number
Title: "FDI Zahnnummer"
Description: "Zahnnummer nach dem FDI-Zahnschema (ISO 3950)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"
* ^context[+].type = #element
* ^context[=].expression = "Observation"
* ^context[+].type = #element
* ^context[=].expression = "Condition"
* ^context[+].type = #element
* ^context[=].expression = "Procedure"

* value[x] only code
* value[x] from ToothIdentificationFDI_VS (preferred)
* value[x] ^short = "FDI-Zahnnummer (z.B. 11, 21, 36)"
