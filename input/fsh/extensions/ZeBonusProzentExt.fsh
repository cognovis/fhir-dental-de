Extension: ZeBonusProzentExt
Id: ze-bonus-prozent
Title: "ZE Bonus-Prozent"
Description: "Bonusheft-Zuschlag auf den Festzuschuss gemäß §55 Abs. 1 SGB V: 50% (Grundanspruch), 60% (5 Jahre lückenlose Dokumentation) oder 70% (10 Jahre lückenlose Dokumentation)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-bonus-prozent"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Claim"

* value[x] only integer
* value[x] ^short = "Bonus-Prozentsatz auf Festzuschuss (50, 60 oder 70)"
