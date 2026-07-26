Extension: ZeBonusProzentExt
Id: ze-bonus-prozent
Title: "ZE Bonus-Prozent"
Description: "Festzuschuss level under §55(1) SGB V: 60% standard, 70% after the five-year evidence period, or 75% after the ten-year evidence period."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-bonus-prozent"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Claim"

* value[x] only integer
* valueInteger 1..1
* value[x] ^short = "Festzuschuss percentage (60, 70, or 75)"
* obeys ze-current-benefit-percentage

Invariant: ze-current-benefit-percentage
Description: "The Festzuschuss percentage is a current statutory level."
Severity: #error
Expression: "valueInteger = 60 or valueInteger = 70 or valueInteger = 75"
