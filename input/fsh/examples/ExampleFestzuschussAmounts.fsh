// Synthetic lookup fixtures for the public versioned-amount contract.
// These amounts are deliberately not KZBV billing values.

Instance: ExampleFestzuschussAmount2025
InstanceOf: DentalClaimDE
Usage: #example
Title: "Synthetischer Festzuschuss-Betrag 2025"
Description: "Public schema fixture for finding 1.1 at the standard 60 percent benefit level. The amount is synthetic and must not be used for billing."

* status = #active
* use = #claim
* type = http://terminology.hl7.org/CodeSystem/claim-type#professional
* priority = #normal
* created = "2025-06-01"
* patient = Reference(Patient/pat-gkv-01)
* provider = Reference(PractitionerRole/role-schoell-gibitzenhof)
* insurer.display = "Example statutory insurer"
* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(cov-gkv-01-aok)
* item[0].sequence = 1
* item[0].productOrService = http://fhir.de/CodeSystem/kzbv/bema#91d "BEMA-91d"
* item[0].extension[festzuschussAmount].extension[finding].valueCoding = https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund#1.1 "Festzuschuss-Befund 1.1"
* item[0].extension[festzuschussAmount].extension[benefitPercentage].valuePositiveInt = 60
* item[0].extension[festzuschussAmount].extension[amount].valueMoney.value = 120.00
* item[0].extension[festzuschussAmount].extension[amount].valueMoney.currency = #EUR
* item[0].extension[festzuschussAmount].extension[effectivePeriod].valuePeriod.start = "2025-01-01"
* item[0].extension[festzuschussAmount].extension[effectivePeriod].valuePeriod.end = "2025-12-31"
* item[0].extension[festzuschussAmount].extension[source].valueUri = "https://example.org/festzuschuss/synthetic/2025"

Instance: ExampleFestzuschussAmount2026
InstanceOf: DentalClaimDE
Usage: #example
Title: "Synthetischer Festzuschuss-Betrag 2026"
Description: "Public schema fixture for the same finding and benefit level in a later effective period. The changed synthetic amount proves date-versioned selection."

* status = #active
* use = #claim
* type = http://terminology.hl7.org/CodeSystem/claim-type#professional
* priority = #normal
* created = "2026-06-01"
* patient = Reference(Patient/pat-gkv-01)
* provider = Reference(PractitionerRole/role-schoell-gibitzenhof)
* insurer.display = "Example statutory insurer"
* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(cov-gkv-01-aok)
* item[0].sequence = 1
* item[0].productOrService = http://fhir.de/CodeSystem/kzbv/bema#91d "BEMA-91d"
* item[0].extension[festzuschussAmount].extension[finding].valueCoding = https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund#1.1 "Festzuschuss-Befund 1.1"
* item[0].extension[festzuschussAmount].extension[benefitPercentage].valuePositiveInt = 60
* item[0].extension[festzuschussAmount].extension[amount].valueMoney.value = 125.00
* item[0].extension[festzuschussAmount].extension[amount].valueMoney.currency = #EUR
* item[0].extension[festzuschussAmount].extension[effectivePeriod].valuePeriod.start = "2026-01-01"
* item[0].extension[festzuschussAmount].extension[effectivePeriod].valuePeriod.end = "2026-12-31"
* item[0].extension[festzuschussAmount].extension[source].valueUri = "https://example.org/festzuschuss/synthetic/2026"
