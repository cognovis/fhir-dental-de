Profile: DentalEncounterDE
Parent: Encounter
Id: dental-encounter
Title: "Zahnärztlicher Abrechnungsfall (DE)"
Description: "Profil für den zahnärztlichen Abrechnungsfall (Behandlungsfall) nach SWS 2.0 Satzart 2. Verbindet Patient, Behandler, Abrechnungsquartal und Versicherungskontext."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Fall-ID (SWS: Fall-ID) ---
* identifier MS
* identifier ^short = "Fall-ID (SWS: interne Fallnummer)"

// --- Status (Pflichtfeld in Encounter base, immer angeben) ---
* status MS

// --- Behandlungsart (GKV=AMB / Notfall=EMER) ---
* class MS
* class from http://terminology.hl7.org/ValueSet/v3-ActEncounterCode (extensible)
* class ^short = "Behandlungsart: AMB (kassenzahnärztlich) oder EMER (Notfallschein)"

// --- Scheintyp (SWS: Scheintyp) ---
* type MS
* type from ScheintypVS (extensible)
* type ^short = "Scheintyp (Kassenschein, Überweisungsschein, Notfallschein, Privatschein)"

// --- Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Behandelter Patient"

// --- Behandler (PractitionerRole) ---
* participant MS
* participant.individual MS
* participant.individual only Reference(PractitionerRole)
* participant ^short = "Erbringender Behandler (SWS: Behandler-Ref)"

// --- Behandlungszeitraum + Abrechnungsquartal ---
* period MS
* period ^short = "Behandlungszeitraum des Falls"

// --- Diagnosen ---
* diagnosis MS
* diagnosis.condition MS
* diagnosis.condition only Reference(Condition)
* diagnosis ^short = "Verknüpfte Diagnosen (SWS: Diagnose-Ref)"

// --- Abrechnung (Account mit Coverage-Referenz) ---
* account MS
* account only Reference(Account)
* account ^short = "Sammelabrechnung (SWS: Abrechnungsstatus / Kostenstelle)"

// --- Extensions ---
* extension contains
    https://fhir.cognovis.de/praxis/StructureDefinition/abrechnungsquartal named abrechnungsquartal 0..1 MS

* extension[abrechnungsquartal] ^short = "GKV-Abrechnungsquartal im Format JJJJQ (z.B. 2026Q1)"
