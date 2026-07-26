// Example: a requested service with the written plan required by GOZ section 2(3).

Alias: $gozCS = http://fhir.de/CodeSystem/bzaek/goz

Instance: ExampleGozChargeItemVerlangens
InstanceOf: GozChargeItemDE
Usage: #example
Title: "Beispiel GOZ Bleaching als Verlangensleistung"
Description: "Externe Zahnaufhellung ohne medizinische Indikation. Die DocumentReference verweist auf den vor der Leistung erstellten schriftlichen Heil- und Kostenplan nach § 2 Abs. 3 GOZ."

// Verlangensleistung-Markierung mit Patientenverlangen-Beleg
* extension[verlangensleistung].extension[verlangensleistung].valueBoolean = true
* extension[verlangensleistung].extension[verlangensleistungBeleg].valueReference = Reference(DocumentReference/doc-verlangens-aufklaerung-bleaching-01)

// The requested-service path is separate from the section 2(1)-(2) factor agreement.
* extension[steigerungsfaktor].extension[faktor].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[schwellenwert].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[leistungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/privatgebuehr-leistungsart#persoenlich "Persönliche Leistung"

// USt-Pattern: Verlangensleistung = keine Heilbehandlung, Regelsatz 19%
// (Invariant goz-tax-verlangens-s greift: VerlangensleistungExt=true → TaxCategory=S)
// (Invariant goz-tax-iff-e greift: TaxCategory!=E → kein TaxExemptionReason)
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#S "Normaler Steuersatz"

* status = #billable

// GOZ-analoge Position für Bleaching (häufig analog abgerechnet nach §6 GOZ)
* code.coding[0] = $gozCS#2197 "Adhäsive Befestigung"
* code.text = "Externes Bleaching, analoge Abrechnung"

* subject = Reference(Patient/pat-pkv-01)
* context = Reference(Encounter/enc-dental-02-privatschein)
* occurrenceDateTime = "2026-02-14"
* factorOverride = 2.3

// Bruttopreis inkl. 19 % USt
* priceOverride.value = 178.50
* priceOverride.currency = #EUR

* account = Reference(acct-dental-02-pkv-q1)

Instance: doc-verlangens-aufklaerung-bleaching-01
InstanceOf: DocumentReference
Usage: #example
Title: "Beispiel Heil- und Kostenplan für eine Verlangensleistung"
Description: "Document metadata for the written treatment and cost plan required by GOZ §2(3)."
* status = #current
* type = GozVereinbarungDokumentTypCS#verlangensleistung-hkp-2-3 "Heil- und Kostenplan nach § 2 Abs. 3 GOZ"
* subject = Reference(Patient/pat-pkv-01)
* date = "2026-02-10T10:00:00+01:00"
* content[0].attachment.contentType = #application/pdf
* content[0].attachment.url = "https://example.org/documents/requested-service-plan-2026-001.pdf"
* content[0].attachment.title = "Heil- und Kostenplan Verlangensleistung 2026-001"
