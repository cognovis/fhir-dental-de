// Example: GOZ Bleaching als Verlangensleistung (§ 1 Abs. 2 Satz 2 GOZ)
// USt-Pflicht 19 % wird in fdde-8vf via TaxCategoryExt=S modelliert.
// Hier demonstriert: VerlangensleistungExt mit boolean=true und Beleg-DocumentReference.

Alias: $gozCS = http://fhir.de/CodeSystem/bzaek/goz

Instance: ExampleGozChargeItemVerlangens
InstanceOf: GozChargeItemDE
Usage: #example
Title: "Beispiel GOZ Bleaching als Verlangensleistung"
Description: "Externe Zahnaufhellung (Bleaching) ohne medizinische Indikation, ausdrücklich vom Patienten verlangt. Konsequenzen: § 2 GOZ-Vereinbarungspflicht entfällt; USt-pflichtig 19 %. Faktor 2,3 frei vereinbart. Beleg-DocumentReference verweist auf das schriftliche Aufklärungsprotokoll."

// Verlangensleistung-Markierung mit Patientenverlangen-Beleg
* extension[verlangensleistung].extension[verlangensleistung].valueBoolean = true
* extension[verlangensleistung].extension[verlangensleistungBeleg].valueReference = Reference(DocumentReference/doc-verlangens-aufklaerung-bleaching-01)

// Steigerungsfaktor 2,3 — bei Verlangensleistung frei vereinbart (§ 2 Abs. 3 GOZ)
* extension[steigerungsfaktor].extension[faktor].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[schwellenwert].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[leistungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/privatgebuehr-leistungsart#persoenlich "Persönliche Leistung"

* status = #billable

// GOZ-analoge Position für Bleaching (häufig analog abgerechnet nach §6 GOZ)
* code.coding[0] = $gozCS#2197 "Adhäsive Befestigung"
* code.text = "Externes Bleaching, analoge Abrechnung"

* subject = Reference(Patient/pat-pkv-01)
* context = Reference(Encounter/enc-dental-02-privatschein)
* occurrenceDateTime = "2026-02-14"
* factorOverride = 2.3

// Bruttopreis inkl. 19 % USt (USt-Modellierung selbst kommt in fdde-8vf)
* priceOverride.value = 178.50
* priceOverride.currency = #EUR
