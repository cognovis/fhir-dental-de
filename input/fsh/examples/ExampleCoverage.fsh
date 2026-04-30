// Beispiel-Versicherungsverhältnisse (Demo-Daten)

// ============================================================
// Coverage: GKV Barmer für Aylin Özdemir
// ============================================================
Instance: cov-gkv-dental-01-gkv
InstanceOf: Coverage
Usage: #example
Title: "Beispiel GKV-Versicherung Aylin Özdemir (Barmer)"
Description: "Gesetzliche Krankenversicherung für Aylin Özdemir bei der Barmer (IKNR 104940005), gültig ab 2024-01-01."

* status = #active

* type.coding[0].system = "http://fhir.de/CodeSystem/versicherungsart-de-basis"
* type.coding[0].code = #GKV
* type.coding[0].display = "Gesetzliche Krankenversicherung"

* subscriber = Reference(Patient/pat-gkv-dental-01)

* beneficiary = Reference(Patient/pat-gkv-dental-01)

* payor[0].identifier.system = "http://fhir.de/sid/arge-ik/iknr"
* payor[0].identifier.value = "104940005"
* payor[0].display = "Barmer"

* period.start = "2024-01-01"
