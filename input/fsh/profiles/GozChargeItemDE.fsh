// Extensions used in this profile (already defined in input/fsh/extensions/)
// fdi-tooth-number                → https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number
// tooth-surfaces                  → https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces
// privatgebuehr-steigerungsfaktor → https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-steigerungsfaktor
// privatgebuehr-analog-reference  → https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-analog-reference

Profile: GozChargeItemDE
Parent: ChargeItem
Id: de-mira-goz-charge-item
Title: "GOZ Leistungsposition (DE)"
Description: "Profil für privatzahnärztliche Leistungen nach GOZ 2012 (Gebührenordnung für Zahnärzte). Bildet SWS 2.0 Satzart 7 ab."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Note: ChargeItem R4 has no category element. The dental/private-fee category is expressed
// via the code system binding and the profile type itself.

// --- GOZ code (Pflichtfeld, 1..1) ---
* code 1..1 MS
* code from GozCodesVS (extensible)
* code ^short = "GOZ-Leistungskennzeichen (z.B. 2080, 5050)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)

// --- Encounter-Kontext (Behandlungsfall) ---
* context MS
* context only Reference(Encounter)
* context ^short = "Behandlungsfall (Encounter)"

// --- Behandler (PractitionerRole) ---
* performer MS
* performer.actor only Reference(PractitionerRole)
* performer ^short = "Erbringender Behandler"

// --- Leistungsdatum ---
* occurrence[x] only dateTime
* occurrenceDateTime MS
* occurrenceDateTime ^short = "Leistungsdatum (SWS: Erbringungsdatum)"

// --- Steigerungsfaktor (GOZ-Faktor 1,0–3,5) ---
// FHIR-native factorOverride für den Dezimalfaktor.
// Strukturierte Begründung (Schwellenwert, Begründungstext) via Extension privatgebuehr-steigerungsfaktor.
* factorOverride MS
* factorOverride ^short = "Steigerungsfaktor (SWS: Faktor 1,0–3,5; Regelfall 2,3)"

// --- Eurobetrag (Einfachsatz x Steigerungsfaktor) ---
* priceOverride MS
* priceOverride ^short = "Berechneter Eurobetrag (Einfachsatz × Steigerungsfaktor)"

// --- Zahnnummer nach FDI (bodysite + Extension) ---
// ChargeItem R4 uses 'bodysite' (lowercase) for anatomical location.
* bodysite MS
* bodysite from ToothIdentificationFDI_VS (preferred)
* bodysite ^short = "Bezugszahn nach FDI-Zahnschema"

// --- Abrechnungsreferenz (Rechnung/Account) ---
* account MS
* account only Reference(Account)
* account ^short = "Zugehörige Privatrechnung (SWS: Rechnung-Ref)"

// --- Extensions: FDI-Zahnnummer, Zahnflächen, Steigerungsfaktor, Analogleistung ---
* extension contains
    FdiToothNumberExt named fdiToothNumber 0..1 MS and
    ToothSurfacesExt named toothSurfaces 0..* MS and
    PrivatgebuehrSteigerungsfaktorExt named steigerungsfaktor 0..1 MS and
    PrivatgebuehrAnalogReferenceExt named analogReference 0..1 MS

* extension[fdiToothNumber] ^short = "FDI-Zahnnummer (SWS: Zahnnummer)"
* extension[toothSurfaces] ^short = "Betroffene Zahnflächen (SWS: Flächen)"
* extension[steigerungsfaktor] ^short = "Steigerungsfaktor-Begründung §5 GOZ (SWS: Begründung >2,3)"
* extension[analogReference] ^short = "Analogleistung §6 GOZ (SWS: Analogleistung)"
