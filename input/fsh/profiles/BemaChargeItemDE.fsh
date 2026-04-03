// Extensions used in this profile (already defined in input/fsh/extensions/)
// fdi-tooth-number   → https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number
// tooth-surfaces     → https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces
// bema-befundklasse  → https://fhir.cognovis.de/dental/StructureDefinition/bema-befundklasse

Profile: BemaChargeItemDE
Parent: ChargeItem
Id: de-mira-bema-charge-item
Title: "BEMA Leistungsposition (DE)"
Description: "Profil für kassenzahnärztliche Leistungen nach BEMA (Bewertungsmaßstab Zahnärzte). Bildet SWS 2.0 Satzart 6 ab."
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"

// Note: ChargeItem R4 has no category element. The dental category is expressed
// via the code system binding and the profile type itself.

// --- BEMA code (Pflichtfeld, 1..1) ---
* code 1..1 MS
* code from BemaCodesVS (extensible)
* code ^short = "BEMA-Leistungskennzeichen (z.B. 01a, 13c)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)

// --- Encounter-Kontext (Behandlungsfall) ---
* context MS
* context only Reference(Encounter)
* context ^short = "Abrechnungsfall (Encounter)"

// --- Behandler (PractitionerRole) ---
* performer MS
* performer.actor only Reference(PractitionerRole)
* performer ^short = "Erbringender Behandler"

// --- Leistungsdatum ---
* occurrence[x] only dateTime
* occurrenceDateTime MS
* occurrenceDateTime ^short = "Leistungsdatum (SWS: Erbringungsdatum)"

// --- Punktzahl (BEMA-Punktwert) ---
* quantity MS
* quantity ^short = "BEMA-Punktzahl der erbrachten Leistung"

// --- Eurobetrag (Punktzahl x KZV-Punktwert) ---
* priceOverride MS
* priceOverride ^short = "Berechneter Eurobetrag (Punktzahl × KZV-Punktwert)"

// --- Zahnnummer nach FDI (bodysite + Extension) ---
// ChargeItem R4 uses 'bodysite' (lowercase) for anatomical location.
* bodysite MS
* bodysite from ToothIdentificationFDI_VS (preferred)
* bodysite ^short = "Bezugszahn nach FDI-Zahnschema"

// --- Abrechnungsreferenz (Sammelabrechnung/Account) ---
* account MS
* account only Reference(Account)
* account ^short = "Sammelabrechnung (SWS: Abrechnung-Ref)"

// --- Extensions: FDI-Zahnnummer, Zahnflächen, Befundklasse ---
* extension contains
    FdiToothNumberExt named fdiToothNumber 0..1 MS and
    ToothSurfacesExt named toothSurfaces 0..* MS and
    BemaBefundklasseExt named bemaBefundklasse 0..1 MS

* extension[fdiToothNumber] ^short = "FDI-Zahnnummer (SWS: Zahnnummer)"
* extension[toothSurfaces] ^short = "Betroffene Zahnflächen (SWS: Flächen)"
* extension[bemaBefundklasse] ^short = "BEMA Befundklasse c/k/f/e/b (SWS: Befundklasse)"
