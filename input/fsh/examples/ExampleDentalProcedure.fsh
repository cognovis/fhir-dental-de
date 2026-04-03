// Example: Kompositfüllung BEMA 13c, Zahn 46, MO (mesial-okklusal)
// SWS 2.0 Satzart 5 — Zahnärztliche Behandlung

Alias: $fdiCS   = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $bemaCS  = http://fhir.de/CodeSystem/kzbv/bema

Instance: ExampleDentalProcedure
InstanceOf: DentalProcedureDE
Usage: #example
Title: "Beispiel Kompositfüllung BEMA 13c Zahn 46"
Description: "Zweiflächige Kompositfüllung (MO) nach BEMA 13c an Zahn 46. Durchgeführt am 2026-01-10 im Rahmen des GKV-Abrechnungsfalls. Patient Klaus Bergmann (AOK Bayern)."

* status = #completed

* category = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// BEMA 13c — Kompositfüllung dreiflächig
* code.coding[0] = $bemaCS#13c "Kompositfüllung dreiflächig"
* code.text = "Kompositfüllung BEMA 13c — Zahn 46"

* subject = Reference(Patient/pat-gkv-01)

* performedDateTime = "2026-01-10"

// Tooth: FDI 46 (lower-right first molar)
* bodySite[0] = $fdiCS#46 "46"
* bodySite[0].text = "Zahn 46, Flächen MO (mesial-okklusal)"

// Link to encounter
* encounter = Reference(Encounter/enc-dental-01-kassenschein)

// Reason: Kariesbefund K02.1
* reasonReference[0] = Reference(ExampleDentalCondition)
