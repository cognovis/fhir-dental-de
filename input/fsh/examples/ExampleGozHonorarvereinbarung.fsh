Instance: ExampleGozHonorarvereinbarung
InstanceOf: DocumentReference
Usage: #example
Title: "Beispiel GOZ-Honorarvereinbarung"
Description: "Document metadata for a written GOZ §2(1)-(2) agreement made before the service."

* status = #current
* type = GozVereinbarungDokumentTypCS#honorarvereinbarung-2-1-2 "Honorarvereinbarung nach § 2 Abs. 1 und 2 GOZ"
* subject = Reference(Patient/pat-pkv-01)
* date = "2026-05-20T10:00:00+02:00"
* content[0].attachment.contentType = #application/pdf
* content[0].attachment.url = "https://example.org/documents/goz-agreement-2026-001.pdf"
* content[0].attachment.title = "GOZ-Honorarvereinbarung 2026-001"

Instance: ExampleGozChargeItemWithAgreement
InstanceOf: GozChargeItemDE
Usage: #example
Title: "Beispiel GOZ 2080 mit Faktor 4,5 und Honorarvereinbarung"
Description: "GOZ service with a factor above 3.5, linked to a written agreement made before treatment."

* extension[steigerungsfaktor].extension[faktor].valueDecimal = 4.5
* extension[steigerungsfaktor].extension[schwellenwert].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[leistungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/privatgebuehr-leistungsart#persoenlich "Persönliche Leistung"
* extension[steigerungsfaktor].extension[begruendungstext].valueString = "Besondere Schwierigkeit und erhöhter Zeitaufwand"
* extension[honorAgreement].extension[document].valueReference = Reference(ExampleGozHonorarvereinbarung)
* extension[honorAgreement].extension[agreedOn].valueDate = "2026-05-20"
* extension[honorAgreement].extension[agreedAmount].valueMoney.value = 180.00
* extension[honorAgreement].extension[agreedAmount].valueMoney.currency = #EUR
* extension[honorAgreement].extension[reimbursementNoticeGiven].valueBoolean = true
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#E "Steuerfrei"
* extension[taxExemptionReason].valueCodeableConcept = $UStBefreiungsgrundCS#para4-nr14a "§ 4 Nr. 14a UStG"
* status = #billable
* code = http://fhir.de/CodeSystem/bzaek/goz#2080 "GOZ-2080"
* subject = Reference(Patient/pat-pkv-01)
* context = Reference(Encounter/enc-dental-02-privatschein)
* occurrenceDateTime = "2026-06-01"
* factorOverride = 4.5
* priceOverride.value = 180.00
* priceOverride.currency = #EUR
* account = Reference(acct-dental-02-pkv-q1)
