// Example: BEMA 13c Leistungsposition, Zahn 36, 25 Punkte
// SWS 2.0 Satzart 6 — BEMA-Leistungsabrechnung

Alias: $fdi     = http://terminology.hl7.org/CodeSystem/ex-tooth

Instance: ExampleBemaChargeItem
InstanceOf: BemaChargeItemDE
Usage: #example
Title: "Beispiel BEMA 13c Leistungsposition Zahn 36"
Description: "BEMA-Leistungsposition 13c (Kompositfüllung dreiflächig) für Zahn 36, 25 Punkte. Verknüpft mit dem GKV-Abrechnungsfall Q1/2026."

* extension[fdiToothNumber].valueCode = #36

* extension[toothSurfaces][0].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/FDI-surface#M "Mesial"
* extension[toothSurfaces][1].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/FDI-surface#O "Occlusal"
* extension[toothSurfaces][2].valueCodeableConcept = http://terminology.hl7.org/CodeSystem/FDI-surface#D "Distal"

* extension[bemaBefundklasse].valueCode = https://fhir.cognovis.de/dental/CodeSystem/bema-befundklasse#c "Erhaltungswürdig (konservierende Behandlung)"

* status = #billable

// BEMA 13c — Kompositfüllung dreiflächig
* code.coding[0].system = "http://fhir.de/CodeSystem/kzbv/bema"
* code.coding[0].code = #13c
* code.coding[0].display = "Kompositfüllung dreiflächig"

* subject = Reference(ExamplePatient)

// Encounter (Abrechnungsfall)
* context = Reference(ExampleDentalEncounter)

* occurrenceDateTime = "2026-01-15"

// Punktzahl: 25 Punkte (BEMA 13c)
* quantity.value = 25
* quantity.unit = "Punkte"
* quantity.system = "http://fhir.de/CodeSystem/kzbv/bema-punkte"
* quantity.code = #Punkte

// Eurobetrag (25 Punkte × KZV-Bayern-Punktwert 1,0660 €)
* priceOverride.value = 26.65
* priceOverride.currency = #EUR

// Bodyside: FDI 36
* bodysite = $fdi#36 "36"
* bodysite.text = "Zahn 36"
