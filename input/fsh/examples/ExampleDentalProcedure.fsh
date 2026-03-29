// Example: Kompositfüllung BEMA 13c, Zahn 36, MOD (mesial-okklusal-distal)
// SWS 2.0 Satzart 5 — Zahnärztliche Behandlung

Alias: $fdi   = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $sct   = http://snomed.info/sct

Instance: ExampleDentalProcedure
InstanceOf: DentalProcedureDE
Usage: #example
Title: "Beispiel Kompositfüllung BEMA 13c Zahn 36"
Description: "Dreiflächige Kompositfüllung (MOD) nach BEMA 13c an Zahn 36. Durchgeführt am 2026-01-15 im Rahmen des GKV-Abrechnungsfalls."

* status = #completed

* category = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// BEMA 13c — Kompositfüllung dreiflächig
* code.coding[0].system = "http://fhir.de/CodeSystem/kzbv/bema"
* code.coding[0].code = #13c
* code.coding[0].display = "Kompositfüllung dreiflächig"
* code.text = "Kompositfüllung BEMA 13c — MOD Zahn 36"

* subject = Reference(ExamplePatient)

* performedDateTime = "2026-01-15"

// Tooth: FDI 36 (lower-left first molar)
* bodySite[0] = $fdi#36 "36"
* bodySite[0].text = "Zahn 36, Flächen MOD (mesial-okklusal-distal)"

// Link to encounter
* encounter = Reference(ExampleDentalEncounter)

// Reason: Kariesbefund K02.1
* reasonReference[0] = Reference(ExampleDentalCondition)
