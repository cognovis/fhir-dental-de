// Example: GOZ 2150 Einlagefüllung (Inlay), Faktor 2.3, Zahn 15
// SWS 2.0 Satzart 7 — GOZ-Leistungsabrechnung (Privatpatient)

Alias: $fdiCS     = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $gozCS     = http://fhir.de/CodeSystem/bzaek/goz
Alias: $surfaceCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces

Instance: ExampleGozChargeItem
InstanceOf: GozChargeItemDE
Usage: #example
Title: "Beispiel GOZ 2150 Einlagefüllung (Inlay) Zahn 15"
Description: "GOZ-Leistungsposition 2150 (Einlagefüllung, zweiflächig) für Zahn 15 (zweiter oberer rechter Prämolar). Steigerungsfaktor 2,3 (Regelsatz). Privatpatientin Charlotte von Hohenstein (DKV). Analogleistung-Extension demonstriert."

* extension[fdiToothNumber].valueCode = #15

* extension[toothSurfaces][0].valueCodeableConcept = $surfaceCS#M "Mesial"
* extension[toothSurfaces][1].valueCodeableConcept = $surfaceCS#O "Okklusal"

// Steigerungsfaktor-Extension: Faktor 2,3 (Regelsatz, keine Begründungspflicht)
* extension[steigerungsfaktor].extension[faktor].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[schwellenwert].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[leistungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/privatgebuehr-leistungsart#persoenlich "Persönliche Leistung"

// Analogleistung-Reference: §6 GOZ — Bezug auf Analoggebührenposition
* extension[analogReference].extension[analoge-nummer].valueString = "2150"
* extension[analogReference].extension[gebuehrenordnung].valueCode = #goz
* extension[analogReference].extension[begruendung].valueString = "Keramik-Inlay CAD/CAM, Analogabrechnung nach §6 GOZ"

* status = #billable

// GOZ 2150 — Einlagefüllung zweiflächig (Keramik-Inlay)
* code.coding[0] = $gozCS#2150 "Einlagefüllung, zweiflächig"

* subject = Reference(Patient/pat-pkv-01)

* context = Reference(Encounter/enc-dental-02-privatschein)

* occurrenceDateTime = "2026-01-22"

// Steigerungsfaktor GOZ (factorOverride = 2.3)
* factorOverride = 2.3

// Eurobetrag
* priceOverride.value = 187.45
* priceOverride.currency = #EUR

// Bodyside: FDI 15
* bodysite = $fdiCS#15 "15"
* bodysite.text = "Zahn 15 — zweiter oberer rechter Prämolar"
