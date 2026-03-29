// Example: GKV Abrechnungsfall Q1/2026
// SWS 2.0 Satzart 2 — Behandlungsfall

Alias: $v3-act-code = http://terminology.hl7.org/CodeSystem/v3-ActCode

Instance: ExampleDentalEncounter
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel GKV Abrechnungsfall Q1/2026"
Description: "Kassenzahnärztlicher Abrechnungsfall, Quartal 1/2026, Patient Max Mustermann."

* extension[abrechnungsquartal].valueString = "2026Q1"

* identifier[0].system = "https://mira.cognovis.de/fhir/identifier/fall-id"
* identifier[0].value = "FALL-2026-000042"

* status = #finished

* class = $v3-act-code#AMB "ambulatory"

* type[0] = https://fhir.cognovis.de/dental/CodeSystem/scheintyp#kassenschein "Kassenschein"

// Inline patient reference — placeholder for KBV_PR_FOR_Patient
* subject = Reference(ExamplePatient)

* period.start = "2026-01-15"
* period.end = "2026-01-15"

// -----------------------------------------------------------------------
// Inline Patient (KBV_PR_FOR_Patient) — minimal valid instance
// -----------------------------------------------------------------------
Instance: ExamplePatient
InstanceOf: Patient
Usage: #example
Title: "Beispiel Patient"
Description: "Testpatient Max Mustermann, GKV (AOK Bayern), geboren 1978-06-21. (Profil: KBV_PR_FOR_Patient)"

* meta.profile[0] = "https://fhir.kbv.de/StructureDefinition/KBV_PR_FOR_Patient|1.3.1"

* identifier[0].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[0].value = "A123456789"

* name[0].use = #official
* name[0].family = "Mustermann"
* name[0].given[0] = "Max"

* birthDate = "1978-06-21"
