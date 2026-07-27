Alias: $v3ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $ihePracticeSetting = http://ihe-d.de/CodeSystems/AerztlicheFachrichtungen
Alias: $dipagParticipantRole = https://gematik.de/fhir/dipag/CodeSystem/dipag-participant-role-cs
Alias: $dipagInvoiceIdentifierType = https://gematik.de/fhir/dipag/CodeSystem/dipag-rechnung-identifier-type-cs

RuleSet: GozInvoiceHeader(number, issuedOn)
* extension[Behandlungsart].valueCoding = $v3ActCode#AMB "ambulatory"
* extension[Fachrichtung].valueCoding = $ihePracticeSetting#MZKH "Zahnmedizin"
* identifier[Rechnungsnummer].type.coding[0] = $dipagInvoiceIdentifierType#invoice "Rechnungsnummer"
* identifier[Rechnungsnummer].system = "https://example.org/fhir/sid/dental-invoice"
* identifier[Rechnungsnummer].value = "{number}"
* status = #issued
* subject = Reference(Patient/pat-pkv-01)
* recipient = Reference(Patient/pat-pkv-01)
* recipient.identifier.system = "http://fhir.de/sid/gkv/kvid-10"
* recipient.identifier.value = "B123456789"
* recipient.display = "Private dental patient"
* date = "{issuedOn}"
* participant[Leistungserbringer].role = $dipagParticipantRole#leistungserbringer "Leistungserbringer"
* participant[Leistungserbringer].actor = Reference(Practitioner/prac-schoell)
* issuer = Reference(Organization/org-dental-mvz)
* account = Reference(Account/acct-dental-02-pkv-q1)

Instance: ExampleGozHealingInvoice
InstanceOf: GozInvoiceDE
Usage: #example
Title: "GOZ healing-treatment invoice"
Description: "Tax-exempt medically indicated GOZ treatment using the DiPag gross and total contract."
* insert GozInvoiceHeader(GOZ-2026-0001, 2026-02-01T10:00:00+01:00)
* lineItem[0].sequence = 1
* lineItem[0].chargeItemReference = Reference(ChargeItem/ExampleGozChargeItem)
* lineItem[0].priceComponent[BruttoBetrag].type = #base
* lineItem[0].priceComponent[BruttoBetrag].amount.value = 187.45
* lineItem[0].priceComponent[BruttoBetrag].amount.currency = #EUR
* totalNet.value = 187.45
* totalNet.currency = #EUR
* totalGross.value = 187.45
* totalGross.currency = #EUR

Instance: ExampleGozMixedTaxInvoice
InstanceOf: GozInvoiceDE
Usage: #example
Title: "GOZ mixed-tax elective-service invoice"
Description: "A tax-exempt treatment and a requested elective service with 19 percent VAT included in the DiPag gross amount."
* insert GozInvoiceHeader(GOZ-2026-0002, 2026-02-20T10:00:00+01:00)
* lineItem[0].sequence = 1
* lineItem[0].chargeItemReference = Reference(ChargeItem/ExampleGozChargeItem)
* lineItem[0].priceComponent[BruttoBetrag].type = #base
* lineItem[0].priceComponent[BruttoBetrag].amount.value = 187.45
* lineItem[0].priceComponent[BruttoBetrag].amount.currency = #EUR
* lineItem[1].sequence = 2
* lineItem[1].chargeItemReference = Reference(ChargeItem/ExampleGozChargeItemVerlangens)
* lineItem[1].priceComponent[BruttoBetrag].type = #base
* lineItem[1].priceComponent[BruttoBetrag].amount.value = 178.50
* lineItem[1].priceComponent[BruttoBetrag].amount.currency = #EUR
* lineItem[1].priceComponent[Steuern].type = #tax
* lineItem[1].priceComponent[Steuern].amount.value = 28.50
* lineItem[1].priceComponent[Steuern].amount.currency = #EUR
* totalNet.value = 337.45
* totalNet.currency = #EUR
* totalGross.value = 365.95
* totalGross.currency = #EUR

Instance: ExampleGozAgreementInvoice
InstanceOf: GozInvoiceDE
Usage: #example
Title: "GOZ section 2 fee-agreement invoice"
Description: "Invoice whose GOZ service position carries the structured reimbursement notice and the reference to the written fee agreement."
* insert GozInvoiceHeader(GOZ-2026-0003, 2026-06-10T10:00:00+02:00)
* lineItem[0].sequence = 1
* lineItem[0].chargeItemReference = Reference(ChargeItem/ExampleGozChargeItemWithAgreement)
* lineItem[0].priceComponent[BruttoBetrag].type = #base
* lineItem[0].priceComponent[BruttoBetrag].amount.value = 180.00
* lineItem[0].priceComponent[BruttoBetrag].amount.currency = #EUR
* totalNet.value = 180.00
* totalNet.currency = #EUR
* totalGross.value = 180.00
* totalGross.currency = #EUR
