// Minimal DentalClaimDE example: billing-tuple diagnosis + ChargeItems with Account context.
// Full BEMA/GOZ line-item slicing is out of scope for this example.

Alias: $bemaCS = http://fhir.de/CodeSystem/kzbv/bema

Instance: ExampleDentalClaimGkvQ1
InstanceOf: DentalClaimDE
Usage: #example
Title: "Beispiel GKV-Abrechnungsanspruch Q1/2026 mit BEMA-Position"
Description: "DentalClaimDE für Klaus Bergmann Q1/2026: Diagnose-Tupel aus ExampleDentalCondition, BEMA-Position auf item, ExampleBemaChargeItem mit Account acct-dental-01-gkv-q1 in supportingInfo."

* status = #active
* use = #claim
* type = http://terminology.hl7.org/CodeSystem/claim-type#professional
* priority = #normal
* created = "2026-01-31"
* billablePeriod.start = "2026-01-01"
* billablePeriod.end = "2026-03-31"

* patient = Reference(Patient/pat-gkv-01)
* provider = Reference(PractitionerRole/role-schoell-gibitzenhof)
* insurer.display = "AOK Bayern"

* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(cov-gkv-01-aok)

* diagnosis[0].sequence = 1
* diagnosis[0].diagnosisReference = Reference(ExampleDentalCondition)

* item[0].sequence = 1
* item[0].productOrService = $bemaCS#13c "Kompositfüllung dreiflächig"

* supportingInfo[0].sequence = 1
* supportingInfo[0].category = http://terminology.hl7.org/CodeSystem/claiminformationcategory#info
* supportingInfo[0].valueReference = Reference(ExampleBemaChargeItem)
