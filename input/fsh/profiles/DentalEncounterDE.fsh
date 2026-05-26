Profile: DentalEncounterDE
Parent: Encounter
Id: dental-encounter
Title: "Zahnärztlicher Behandlungskontakt (DE)"
Description: "Billing-agnostic clinical contact in dental practice (consultation, treatment visit). One contact = one Encounter. Encounter.class = AMB (ambulatory) or HH (home visit). Encounter.account references the billing case (AccountPraxisSchein). ScheinNummer, Scheinart, coverage, and billing quarter live on the Account, not the Encounter."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Kontakt-ID (interne Fallnummer pro Behandlungskontakt) ---
* identifier MS
* identifier ^short = "Kontakt-ID (interne Fallnummer des Behandlungskontakts)"

// --- Status ---
* status 1..1 MS

// --- Behandlungskontakt-Art (AMB / HH) ---
* class 1..1 MS
* class from https://fhir.cognovis.de/praxis/ValueSet/encounter-praxis-class (required)
* class ^short = "AMB | HH — ambulanter Behandlungskontakt oder Hausbesuch"
* class ^comment = "Billing-agnostic contact class. GKV/GOZ/KZBV billing case type is on AccountPraxisSchein.type, not Encounter."

// --- Patient ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Behandelter Patient"

// --- Behandler ---
* participant MS
* participant.individual MS
* participant.individual only Reference(PractitionerRole)
* participant ^short = "Erbringender Behandler (SWS: Behandler-Ref)"

// --- Behandlungszeitraum des Kontakts ---
* period MS
* period ^short = "Zeitraum des klinischen Behandlungskontakts"

// --- Abrechnungsfall (Schein) ---
* account 0..* MS
* account only Reference(AccountPraxisSchein)
* account ^short = "Zugehöriger Abrechnungs-Schein (AccountPraxisSchein aus fhir-praxis-de)"
