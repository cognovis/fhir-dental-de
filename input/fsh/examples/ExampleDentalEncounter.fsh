// Example: GKV Abrechnungsfall Q1/2026
// SWS 2.0 Satzart 2 — Behandlungsfall

Alias: $v3-act-code = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $scheintyp  = https://fhir.cognovis.de/dental/CodeSystem/scheintyp

Instance: ExampleDentalEncounter
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel GKV Abrechnungsfall Q1/2026"
Description: "Kassenzahnärztlicher Abrechnungsfall, Quartal 1/2026, Patient Klaus Bergmann (AOK Bayern). Scheintyp: Kassenschein."

* extension[abrechnungsquartal].valueString = "2026Q1"

* identifier[0].system = "https://mira-demo-mvz.de/fall-id"
* identifier[0].value = "DENTAL-2026-0001"

* status = #finished

* class = $v3-act-code#AMB "ambulatory"

* type[0] = $scheintyp#kassenschein "Kassenschein"

// Patient: Klaus Bergmann (GKV, AOK Bayern)
* subject = Reference(Patient/pat-gkv-01)

* participant[0].individual = Reference(PractitionerRole/role-schoell-gibitzenhof)

* period.start = "2026-01-10"
* period.end = "2026-01-10"
