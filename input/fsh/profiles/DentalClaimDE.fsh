// Billing-boundary profile: billing-tuple diagnoses and ChargeItem-backed lines.
// Full BEMA/GOZ line-item slicing, versorgungsart constraints, and gleichartig mix
// rules are out of scope for this profile.

Profile: DentalClaimDE
Parent: Claim
Id: dental-claim-de
Title: "Zahnärztlicher Abrechnungsanspruch (DE)"
Description: "Dental billing claim (BEMA/GOZ/KZBV). Claim.diagnosis carries the billing-tuple diagnosis list. Claim.supportingInfo links BemaChargeItemDE/GozChargeItemDE resources that must set ChargeItem.account → AccountPraxisSchein. Abrechnungsstatus is Claim.status (and ClaimResponse), not Account.status — Account.status is only active/inactive for open vs closed Schein."

* status 1..1 MS
* status ^short = "Abrechnungsstatus des Anspruchs (active, cancelled, …)"
* status ^comment = "Operational billing lifecycle (Abrechnungsstatus) lives here and on ClaimResponse, not on Account.status."

* use = #claim
* use MS

* type 1..1 MS
* type = http://terminology.hl7.org/CodeSystem/claim-type#professional

* priority MS

* patient 1..1 MS
* patient only Reference(Patient)

* created MS

* provider MS
* provider only Reference(PractitionerRole or Organization)

* insurer MS
* insurer only Reference(Organization)

* billablePeriod MS
* billablePeriod ^short = "Abrechnungszeitraum (z. B. Quartal oder Rechnungsperiode)"

* insurance MS
* insurance.sequence MS
* insurance.focal MS
* insurance.coverage MS

// Billing-tuple diagnoses (ICD + Diagnosesicherheit + …); full line-item slicing is out of scope here.
* diagnosis 0..* MS
* diagnosis ^short = "Behandlungsdiagnosen als Abrechnungs-Tupel"
* diagnosis ^definition = "Quarterly or episode diagnoses for billing. Dedupe is over the exact billing tuple: ICD code, Diagnosesicherheit, Seitenlokalisation, and Mehrfachcodierungskennzeichen. Full tuple constraints align with the Praxis-DE claim-diagnosis contract."
* diagnosis.sequence MS
* diagnosis.diagnosisReference MS
* diagnosis.diagnosisReference only Reference(DentalConditionDE)
* diagnosis.diagnosisCodeableConcept MS

// Line items are sliced by their single billing-system coding.
* item 1..* MS
* item ^short = "Abrechnungspositionen (BEMA/GOZ-Codes)"
* item ^slicing.discriminator.type = #value
* item ^slicing.discriminator.path = "productOrService.coding.system"
* item ^slicing.rules = #open
* item ^slicing.ordered = false
* item contains
    bema 0..* MS and
    goz 0..* MS

* item[bema].productOrService.coding 1..1
* item[bema].productOrService.coding.system = "http://fhir.de/CodeSystem/kzbv/bema"
* item[bema].productOrService from BemaCodesVS (required)

* item[goz].productOrService.coding 1..1
* item[goz].productOrService.coding.system = "http://fhir.de/CodeSystem/bzaek/goz"
* item[goz].productOrService from GozCodesVS (required)

* item.sequence MS
* item.productOrService MS
* item.extension contains FestzuschussBetragExt named festzuschussAmount 0..1 MS
* item.extension contains ZeVersorgungsartExt named careType 0..1 MS
* item.extension[festzuschussAmount] ^short = "Versioned applied subsidy amount for the referenced Festzuschuss finding"
* item.extension[careType] ^short = "Regelversorgung, gleichartig, or andersartig classification for this claim line"
* item.informationSequence MS

* obeys dental-claim-equal-type-mix and dental-claim-equal-type-systems

// Account-context ChargeItems (must set ChargeItem.account → AccountPraxisSchein).
* supportingInfo 0..* MS
* supportingInfo ^short = "Verknüpfte ChargeItems mit AccountPraxisSchein-Kontext"
* supportingInfo.sequence MS
* supportingInfo.category MS
* supportingInfo.valueReference MS
* supportingInfo.valueReference only Reference(BemaChargeItemDE or GozChargeItemDE)

Invariant: dental-claim-equal-type-mix
Description: "Within DentalClaimDE, a claim containing an equal-type care line carries both a BEMA line and a GOZ line."
Severity: #error
Expression: "item.where(extension.where(url='https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart').valueCode = 'gleichartig').exists() implies (item.where(productOrService.coding.system = 'http://fhir.de/CodeSystem/kzbv/bema').exists() and item.where(productOrService.coding.system = 'http://fhir.de/CodeSystem/bzaek/goz').exists())"

Invariant: dental-claim-equal-type-systems
Description: "Every equal-type line in DentalClaimDE is explicitly a BEMA or GOZ line."
Severity: #error
Expression: "item.where(extension.where(url='https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart').valueCode = 'gleichartig').all(productOrService.coding.system = 'http://fhir.de/CodeSystem/kzbv/bema' or productOrService.coding.system = 'http://fhir.de/CodeSystem/bzaek/goz')"
