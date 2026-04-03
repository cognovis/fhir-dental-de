// Beispiel-Behandlungsfälle aus den MIRA Seed-Daten
// Ergänzen den ExampleDentalEncounter.fsh um weitere Fälle

Alias: $v3-act-code = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $scheintyp   = https://fhir.cognovis.de/dental/CodeSystem/scheintyp

// ============================================================
// Encounter 1: GKV Kassenschein 2026-01-10, Klaus Bergmann
// (entspricht dem ExampleDentalEncounter, aber mit MIRA-Seed-ID)
// ============================================================
Instance: enc-dental-01-kassenschein
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel Abrechnungsfall GKV Kassenschein (enc-dental-01)"
Description: "GKV Kassenschein Q1/2026 für Klaus Bergmann bei Dr. Schöll (Gibitzenhof). Behandlung am 2026-01-10."

* extension[abrechnungsquartal].valueString = "2026Q1"

* identifier[0].system = "https://mira-demo-mvz.de/fall-id"
* identifier[0].value = "DENTAL-2026-0001"

* status = #finished

* class = $v3-act-code#AMB "ambulatory"

* type[0] = $scheintyp#kassenschein "Kassenschein"

* subject = Reference(Patient/pat-gkv-01)

* participant[0].individual = Reference(PractitionerRole/role-schoell-gibitzenhof)

* period.start = "2026-01-10"
* period.end = "2026-01-10"

// ============================================================
// Encounter 2: Privatschein 2026-01-22, Charlotte von Hohenstein
// ============================================================
Instance: enc-dental-02-privatschein
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel Abrechnungsfall Privatschein (enc-dental-02)"
Description: "Privatschein Q1/2026 für Charlotte von Hohenstein bei Lena Uselmann (Plärrer). Behandlung am 2026-01-22."

* extension[abrechnungsquartal].valueString = "2026Q1"

* identifier[0].system = "https://mira-demo-mvz.de/fall-id"
* identifier[0].value = "DENTAL-2026-0002"

* status = #finished

* class = $v3-act-code#AMB "ambulatory"

* type[0] = $scheintyp#privatschein "Privatschein"

* subject = Reference(Patient/pat-pkv-01)

* participant[0].individual = Reference(PractitionerRole/role-uselmann-plaerrer)

* period.start = "2026-01-22"
* period.end = "2026-01-22"

// ============================================================
// Encounter 3: ZE Kassenschein, Aylin Özdemir
// ============================================================
Instance: enc-dental-04-ze-kassenschein
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel ZE Kassenschein Aylin Özdemir (enc-dental-04)"
Description: "ZE Kassenschein Q1/2026 für Aylin Özdemir bei Dr. Schöll (Gibitzenhof). Behandlung ab 2026-01-15."

* extension[abrechnungsquartal].valueString = "2026Q1"

* identifier[0].system = "https://mira-demo-mvz.de/fall-id"
* identifier[0].value = "DENTAL-2026-0004"

* status = #in-progress

* class = $v3-act-code#AMB "ambulatory"

* type[0] = $scheintyp#kassenschein "Kassenschein"

* subject = Reference(Patient/pat-gkv-dental-01)

* participant[0].individual = Reference(PractitionerRole/role-schoell-gibitzenhof)

* period.start = "2026-01-15"
