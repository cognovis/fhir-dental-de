// 3-Layer-Chain: ChargeItem → ChargeItemPraxisDe → BemaChargeItemDE
//
// Extensions used in this profile (already defined in input/fsh/extensions/):
// fdi-tooth-number   → https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number
// tooth-surfaces     → https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces
// bema-befundklasse  → https://fhir.cognovis.de/dental/StructureDefinition/bema-befundklasse
//
// Tax-Pattern (via ChargeItemPraxisDe inheritance — praxis@0.61.0):
// The praxis-de TaxCategoryExt and TaxExemptionReasonExt are now available via
// inheritance. BEMA charges are GKV (statutory) services and are generally exempt
// from VAT under § 4 Nr. 14a UStG (Trennungsprinzip). Concrete tax-pattern
// application (default: TaxCategoryExt=E + TaxExemptionReasonExt=para4-nr14a) is
// implemented in bead fdde-8vf. This profile only inherits the structural ability
// to carry these extensions; no Tax slicing is added here.

Profile: BemaChargeItemDE
Parent: ChargeItemPraxisDe
Id: bema-charge-item
Title: "BEMA Leistungsposition (DE)"
Description: "Profil für kassenzahnärztliche Leistungen nach BEMA (Bewertungsmaßstab Zahnärzte). Bildet SWS 2.0 Satzart 6 ab."
* ^status = #active
* ^experimental = false
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
* context only Reference(DentalEncounterDE)
* context ^short = "Klinischer Behandlungskontakt (DentalEncounterDE)"

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
* account 1..1 MS
* account only Reference(AccountPraxisSchein)
* account ^short = "Abrechnungs-Schein (AccountPraxisSchein)"

// --- Extensions: FDI-Zahnnummer, Zahnflächen, Befundklasse, Tax-Pattern ---
* extension contains
    FdiToothNumberExt named fdiToothNumber 0..1 MS and
    ToothSurfacesExt named toothSurfaces 0..* MS and
    BemaBefundklasseExt named bemaBefundklasse 0..1 MS and
    $TaxCategoryExt named taxCategory 1..1 MS and
    $TaxExemptionReasonExt named taxExemptionReason 1..1 MS

* extension[fdiToothNumber] ^short = "FDI-Zahnnummer (SWS: Zahnnummer)"
* extension[toothSurfaces] ^short = "Betroffene Zahnflächen (SWS: Flächen)"
* extension[bemaBefundklasse] ^short = "BEMA Befundklasse c/k/f/e/b (SWS: Befundklasse)"

// --- USt-Pattern (fdde-8vf): BEMA = GKV-Heilbehandlung, immer steuerfrei nach § 4 Nr. 14a UStG ---
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#E "Steuerfrei"
* extension[taxCategory] ^short = "USt-Kategorie (EN 16931 / UN-CEFACT-5305: für BEMA fix = E steuerfrei)"
* extension[taxExemptionReason].valueCodeableConcept = $UStBefreiungsgrundCS#para4-nr14a "§ 4 Nr. 14a UStG"
* extension[taxExemptionReason] ^short = "USt-Befreiungsgrund (für BEMA fix = § 4 Nr. 14a UStG Heilbehandlung)"
