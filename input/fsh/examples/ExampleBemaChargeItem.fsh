// Example: BEMA 13c Leistungsposition, Zahn 36, 25 Punkte
// SWS 2.0 Satzart 6 — BEMA-Leistungsabrechnung

Alias: $fdiCS    = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $bemaCS   = http://fhir.de/CodeSystem/kzbv/bema
Alias: $surfaceCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces

Instance: ExampleBemaChargeItem
InstanceOf: BemaChargeItemDE
Usage: #example
Title: "Beispiel BEMA 13c Leistungsposition Zahn 36"
Description: "BEMA-Leistungsposition 13c (Kompositfüllung dreiflächig) für Zahn 36, 25 Punkte. Verknüpft mit dem GKV-Abrechnungsfall Q1/2026 (Patient Klaus Bergmann, AOK Bayern)."

* extension[fdiToothNumber].valueCode = #36

* extension[toothSurfaces][0].valueCodeableConcept = $surfaceCS#M "Mesial"
* extension[toothSurfaces][1].valueCodeableConcept = $surfaceCS#O "Okklusal"
* extension[toothSurfaces][2].valueCodeableConcept = $surfaceCS#D "Distal"

* extension[bemaBefundklasse].valueCode = https://fhir.cognovis.de/dental/CodeSystem/bema-befundklasse#c "Erhaltungswürdig (konservierende Behandlung)"

* status = #billable

// BEMA 13c — Kompositfüllung dreiflächig
* code.coding[0] = $bemaCS#13c "Kompositfüllung dreiflächig"

* subject = Reference(Patient/pat-gkv-01)

// Encounter (Abrechnungsfall)
* context = Reference(Encounter/enc-dental-01-kassenschein)

* occurrenceDateTime = "2026-01-10"

// Punktzahl: 25 Punkte (BEMA 13c)
* quantity.value = 25
* quantity.unit = "Punkte"

// Eurobetrag (25 Punkte × KZV-Bayern-Punktwert 1,0660 €)
* priceOverride.value = 26.65
* priceOverride.currency = #EUR

// Bodyside: FDI 36
* bodysite = $fdiCS#36 "36"
* bodysite.text = "Zahn 36"


// -----------------------------------------------------------------------
// Zusätzliches Beispiel: BEMA ChargeItem mit BEL-Punkte Extension (Zahntechnik)
// Demonstriert die bel-punkte Extension für zahntechnische Leistungsanteile
// -----------------------------------------------------------------------
Instance: ExampleBemaChargeItemBelPunkte
InstanceOf: BemaChargeItemDE
Usage: #example
Title: "Beispiel BEMA ChargeItem mit BEL-Punkte (Krone Zahn 46)"
Description: "BEMA-Leistungsposition für Krone (BEMA 99a Aufbaufüllung) Zahn 46 mit BEL-II-Punkte Extension für den zahntechnischen Anteil. Patient Aylin Özdemir, GKV+ZZV."

* extension[fdiToothNumber].valueCode = #46

* extension[https://fhir.cognovis.de/dental/StructureDefinition/bel-punkte].valueInteger = 250

* status = #billable

// BEMA 99a — Aufbaufüllung (Stumpfaufbau)
* code.coding[0] = $bemaCS#99a "Aufbaufüllung (Stumpfaufbau)"

* subject = Reference(Patient/pat-gkv-dental-01)

* context = Reference(Encounter/enc-dental-04-ze-kassenschein)

* occurrenceDateTime = "2026-01-15"

* quantity.value = 35
* quantity.unit = "Punkte"

* priceOverride.value = 37.31
* priceOverride.currency = #EUR

* bodysite = $fdiCS#46 "46"
* bodysite.text = "Zahn 46"
