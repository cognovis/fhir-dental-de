// End-to-end equal-type prosthesis example with typed BEMA and GOZ lines.

Instance: cov-zzv-dental-01
InstanceOf: FPDECoveragePrivat
Usage: #example
Title: "Beispiel Zahnzusatzversicherung Aylin Özdemir"
Description: "Secondary private dental coverage used by the mixed-claim example."
* status = #active
* type.coding[VersicherungsArtDeBasis].system = "http://fhir.de/CodeSystem/versicherungsart-de-basis"
* type.coding[VersicherungsArtDeBasis].code = #PKV
* type.coding[VersicherungsArtDeBasis].display = "private Krankenversicherung"
* type.text = "Zahnzusatzversicherung"
* subscriber = Reference(Patient/pat-gkv-dental-01)
* beneficiary = Reference(Patient/pat-gkv-dental-01)
* payor[0].display = "Example supplementary insurer"
* period.start = "2024-01-01"

Instance: ExampleMixedDentalCondition
InstanceOf: Condition
Usage: #example
Title: "Beispiel Kariesdiagnose Zahn 36 für Mischrechnung"
Description: "Confirmed dentinal caries on tooth 36 referenced by the mixed claim."
* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"
* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* code = $icd10gm#K02.1 "Karies des Dentins"
* subject = Reference(Patient/pat-gkv-dental-01)
* onsetDateTime = "2026-05-10"
* recordedDate = "2026-05-10"
* bodySite[0] = $fdiCS#36 "36"

Instance: ExampleMixedBemaChargeItem
InstanceOf: BemaChargeItemDE
Usage: #example
Title: "Beispiel BEMA-Anteil einer gleichartigen Versorgung"
Description: "Performed BEMA standard-care component linked from the mixed DentalClaimDE."
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#E "Steuerfrei"
* extension[taxExemptionReason].valueCodeableConcept = $UStBefreiungsgrundCS#para4-nr14a "§ 4 Nr. 14a UStG"
* status = #billable
* code = http://fhir.de/CodeSystem/kzbv/bema#91d "BEMA-91d"
* subject = Reference(Patient/pat-gkv-dental-01)
* context = Reference(Encounter/enc-dental-04-ze-kassenschein)
* occurrenceDateTime = "2026-05-20"
* quantity.value = 150
* quantity.unit = "Punkte"
* priceOverride.value = 210.00
* priceOverride.currency = #EUR
* account = Reference(acct-dental-04-gkv-q1)

Instance: ExampleMixedGozChargeItem
InstanceOf: GozChargeItemDE
Usage: #example
Title: "Beispiel GOZ-Mehrleistungsanteil einer gleichartigen Versorgung"
Description: "Performed GOZ additional-service component linked from the mixed DentalClaimDE."
* extension[steigerungsfaktor].extension[faktor].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[schwellenwert].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[leistungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/privatgebuehr-leistungsart#persoenlich "Persönliche Leistung"
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#E "Steuerfrei"
* extension[taxExemptionReason].valueCodeableConcept = $UStBefreiungsgrundCS#para4-nr14a "§ 4 Nr. 14a UStG"
* status = #billable
* code = http://fhir.de/CodeSystem/bzaek/goz#5040 "GOZ-5040"
* subject = Reference(Patient/pat-gkv-dental-01)
* context = Reference(Encounter/enc-dental-04-ze-kassenschein)
* occurrenceDateTime = "2026-05-20"
* factorOverride = 2.3
* priceOverride.value = 480.00
* priceOverride.currency = #EUR
* account = Reference(acct-dental-04-gkv-q1)

Instance: ExampleDentalClaimMixed
InstanceOf: DentalClaimDE
Usage: #example
Title: "Beispiel DentalClaimDE Mischrechnung BEMA und GOZ"
Description: "Equal-type bridge claim with one BEMA standard-care line, one GOZ additional-service line, GKV and supplementary coverage, typed ChargeItem links, and a synthetic versioned Festzuschuss amount."

* status = #active
* use = #claim
* type = http://terminology.hl7.org/CodeSystem/claim-type#professional
* priority = #normal
* created = "2026-05-31"
* billablePeriod.start = "2026-05-01"
* billablePeriod.end = "2026-05-31"
* patient = Reference(Patient/pat-gkv-dental-01)
* provider = Reference(PractitionerRole/role-schoell-gibitzenhof)
* insurer.display = "Barmer"

* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(cov-gkv-dental-01-gkv)
* insurance[1].sequence = 2
* insurance[1].focal = false
* insurance[1].coverage = Reference(cov-zzv-dental-01)

* diagnosis[0].sequence = 1
* diagnosis[0].diagnosisReference = Reference(ExampleMixedDentalCondition)

* supportingInfo[0].sequence = 1
* supportingInfo[0].category = http://terminology.hl7.org/CodeSystem/claiminformationcategory#info
* supportingInfo[0].valueReference = Reference(ExampleMixedBemaChargeItem)
* supportingInfo[1].sequence = 2
* supportingInfo[1].category = http://terminology.hl7.org/CodeSystem/claiminformationcategory#info
* supportingInfo[1].valueReference = Reference(ExampleMixedGozChargeItem)

* item[bema][0].sequence = 1
* item[bema][0].productOrService = http://fhir.de/CodeSystem/kzbv/bema#91d "BEMA-91d"
* item[bema][0].informationSequence[0] = 1
* item[bema][0].extension[careType].valueCode = #gleichartig
* item[bema][0].unitPrice.value = 210.00
* item[bema][0].unitPrice.currency = #EUR
* item[bema][0].net.value = 210.00
* item[bema][0].net.currency = #EUR
* item[bema][0].extension[festzuschussAmount].extension[finding].valueCoding = https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund#1.1 "Festzuschuss-Befund 1.1"
* item[bema][0].extension[festzuschussAmount].extension[benefitPercentage].valuePositiveInt = 75
* item[bema][0].extension[festzuschussAmount].extension[amount].valueMoney.value = 125.00
* item[bema][0].extension[festzuschussAmount].extension[amount].valueMoney.currency = #EUR
* item[bema][0].extension[festzuschussAmount].extension[effectivePeriod].valuePeriod.start = "2026-01-01"
* item[bema][0].extension[festzuschussAmount].extension[effectivePeriod].valuePeriod.end = "2026-12-31"
* item[bema][0].extension[festzuschussAmount].extension[source].valueUri = "https://example.org/festzuschuss/synthetic/2026"

* item[goz][0].sequence = 2
* item[goz][0].productOrService = http://fhir.de/CodeSystem/bzaek/goz#5040 "GOZ-5040"
* item[goz][0].informationSequence[0] = 2
* item[goz][0].extension[careType].valueCode = #gleichartig
* item[goz][0].unitPrice.value = 480.00
* item[goz][0].unitPrice.currency = #EUR
* item[goz][0].factor = 1
* item[goz][0].net.value = 480.00
* item[goz][0].net.currency = #EUR
* total.value = 690.00
* total.currency = #EUR
