// ADR-039 boundary profile: billing-tuple diagnoses and ChargeItem-backed lines.
// Full BEMA/GOZ line-item slicing, versorgungsart constraints, and gleichartig mix
// rules remain in bead fdde-xht.

Profile: DentalClaimDE
Parent: Claim
Id: dental-claim-de
Title: "Zahnärztlicher Abrechnungsanspruch (DE)"
Description: "Dental billing claim (BEMA/GOZ/KZBV). Claim.diagnosis carries the billing-tuple diagnosis list. Claim.supportingInfo links BemaChargeItemDE/GozChargeItemDE resources that must set ChargeItem.account → AccountPraxisSchein. Abrechnungsstatus is Claim.status (and ClaimResponse), not Account.status — Account.status is only active/inactive for open vs closed Schein."

* status 1..1 MS
* status ^short = "Abrechnungsstatus des Anspruchs (active, cancelled, …)"
* status ^comment = "Operational billing lifecycle (Abrechnungsstatus) lives here and on ClaimResponse, not on Account.status (ADR-039)."

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

// Billing-tuple diagnoses (ICD + Diagnosesicherheit + …); fdde-xht extends slicing.
* diagnosis 0..* MS
* diagnosis ^short = "Behandlungsdiagnosen als Abrechnungs-Tupel"
* diagnosis ^definition = "Quarterly or episode diagnoses for billing. Dedupe is over the exact billing tuple: ICD code, Diagnosesicherheit, Seitenlokalisation, and Mehrfachcodierungskennzeichen. Full tuple constraints align with fhir-praxis-de claim-diagnosis-contract."
* diagnosis.sequence MS
* diagnosis.diagnosisReference MS
* diagnosis.diagnosisReference only Reference(DentalConditionDE)
* diagnosis.diagnosisCodeableConcept MS

// Line items (codes on Claim.item); linked ChargeItems carry Account context.
* item 1..* MS
* item ^short = "Abrechnungspositionen (BEMA/GOZ-Codes)"
* item.sequence MS
* item.productOrService MS

// Account-context ChargeItems (must set ChargeItem.account → AccountPraxisSchein).
* supportingInfo 0..* MS
* supportingInfo ^short = "Verknüpfte ChargeItems mit AccountPraxisSchein-Kontext"
* supportingInfo.sequence MS
* supportingInfo.category MS
* supportingInfo.valueReference MS
* supportingInfo.valueReference only Reference(BemaChargeItemDE or GozChargeItemDE)
