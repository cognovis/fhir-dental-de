ValueSet: ZeBonusProzentVS
Id: ze-bonus-prozent
Title: "ZE Bonus-Prozent"
Description: "Bonusstufen für den ZE-Festzuschuss nach §55 Abs. 1 SGB V basierend auf lückenloser Bonusheft-Dokumentation."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/ze-bonus-prozent"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"

// Note: The VS uses integer binding on the Extension, so actual values are 50, 60, 70.
// For documentation, permitted values are 50 (Grundanspruch), 60 (5 Jahre lückenlos), 70 (10 Jahre lückenlos).
* include codes from system https://fhir.cognovis.de/dental/CodeSystem/ze-bonus-prozent
