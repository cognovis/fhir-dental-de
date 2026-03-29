// Example: GOZ 2080 Kompositfüllung, Faktor 2.3, Zahn 16
// SWS 2.0 Satzart 7 — GOZ-Leistungsabrechnung (Privatpatient)

Alias: $fdi = http://terminology.hl7.org/CodeSystem/ex-tooth

Instance: ExampleGozChargeItem
InstanceOf: GozChargeItemDE
Usage: #example
Title: "Beispiel GOZ 2080 Kompositfüllung Zahn 16"
Description: "GOZ-Leistungsposition 2080 (einflächige dentinadhäsive Füllung, Komposit) für Zahn 16 (erster oberer rechter Molar). Steigerungsfaktor 2,3 (Regelsatz), Privatpatient."

* extension[fdiToothNumber].valueCode = #16

* extension[toothSurfaces][0].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/FDI-surface#O "Occlusal"

// Steigerungsfaktor-Extension: Faktor 2,3 (Regelsatz, keine Begründungspflicht)
* extension[steigerungsfaktor].extension[faktor].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[schwellenwert].valueDecimal = 2.3
* extension[steigerungsfaktor].extension[leistungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/privatgebuehr-leistungsart#persoenlich "Persönliche Leistung"

* status = #billable

// GOZ 2080 — Einflächige dentinadhäsive Füllung (Komposit)
* code.coding[0].system = "http://fhir.de/CodeSystem/bzaek/goz"
* code.coding[0].code = #2080
* code.coding[0].display = "Einflächige dentinadhäsive Füllung (Komposit)"

* subject = Reference(ExamplePatient)

* occurrenceDateTime = "2026-01-15"

// Steigerungsfaktor GOZ (factorOverride = 2.3)
* factorOverride = 2.3

// Eurobetrag: GOZ 2080 Einfachgebühr 17,49 € × 2,3 = 40,23 €
* priceOverride.value = 40.23
* priceOverride.currency = #EUR

// Bodyside: FDI 16
* bodysite = $fdi#16 "16"
* bodysite.text = "Zahn 16 — erster oberer rechter Molar"
