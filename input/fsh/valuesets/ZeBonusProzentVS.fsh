ValueSet: ZeBonusProzentVS
Id: ze-bonus-prozent
Title: "ZE Bonus-Prozent"
Description: "Bonusstufen für den ZE-Festzuschuss nach §55 Abs. 1 SGB V basierend auf lückenloser Bonusheft-Dokumentation."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/ze-bonus-prozent"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// The simple extension uses integer values; this ValueSet documents the same
// current levels as codes for terminology discovery.
* include codes from system https://fhir.cognovis.de/dental/CodeSystem/ze-bonus-prozent
