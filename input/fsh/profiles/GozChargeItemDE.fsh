// Extensions used in this profile (already defined in input/fsh/extensions/)
// fdi-tooth-number   → https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number
// tooth-surfaces     → https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces
//
// P2-Extensions (not yet created — referenced by URL only, not structurally required):
// privatgebuehr-steigerungsfaktor → https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-steigerungsfaktor
// privatgebuehr-analog-reference  → https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-analog-reference

Profile: GozChargeItemDE
Parent: ChargeItem
Id: de-mira-goz-charge-item
Title: "GOZ Leistungsposition (DE)"
Description: "Profil für privatzahnärztliche Leistungen nach GOZ 2012 (Gebührenordnung für Zahnärzte). Bildet SWS 2.0 Satzart 7 ab."
* ^status = #draft
* ^publisher = "cognovis GmbH"

// Note: ChargeItem R4 has no category element. The dental/private-fee category is expressed
// via the code system binding and the profile type itself.

// --- GOZ code (Pflichtfeld, 1..1) ---
* code 1..1 MS
* code from GozCodesVS (extensible)
* code ^short = "GOZ-Leistungskennzeichen (z.B. 2080, 5050)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(KBV_PR_FOR_Patient)

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
// Begründungstext und Schwellenwert-Metadaten folgen via P2-Extension privatgebuehr-steigerungsfaktor.
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

// --- Extensions: FDI-Zahnnummer, Zahnflächen ---
// Note: privatgebuehr-steigerungsfaktor and privatgebuehr-analog-reference are P2-Extensions.
// They are not yet defined in this IG. They will be added in bead fhir-dental-de-p2 (P2-Extensions).
// References to their canonical URLs are documented above for forward-compatibility.
* extension contains
    FdiToothNumberExt named fdiToothNumber 0..1 MS and
    ToothSurfacesExt named toothSurfaces 0..* MS

* extension[fdiToothNumber] ^short = "FDI-Zahnnummer (SWS: Zahnnummer)"
* extension[toothSurfaces] ^short = "Betroffene Zahnflächen (SWS: Flächen)"
