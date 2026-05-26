// 3-Layer-Chain: ChargeItem → ChargeItemPraxisDe → GozChargeItemDE
//
// Extensions used in this profile (already defined in input/fsh/extensions/):
// fdi-tooth-number                → https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number
// tooth-surfaces                  → https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces
// privatgebuehr-steigerungsfaktor → https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-steigerungsfaktor
// privatgebuehr-analog-reference  → https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-analog-reference
//
// Tax-Pattern (via ChargeItemPraxisDe inheritance — praxis@0.61.0):
// The praxis-de TaxCategoryExt and TaxExemptionReasonExt are now available via
// inheritance. GOZ charges are private (PKV) services. Tax handling depends on
// indication:
//   - Medizinisch indizierte Heilbehandlung: TaxCategoryExt=E + TaxExemptionReasonExt=para4-nr14a
//   - Verlangensleistung (privatgebuehr-leistungsart=#verlangensleistung): TaxCategoryExt=S (19%)
//   - Zahntechnisches Eigenlabor-Werkstück (Anlage 2 Nr. 52 UStG): TaxCategoryExt=AA (7%)
//   - Kleinunternehmerregelung § 19 UStG: inherited via DentalOrganizationDE.KleinunternehmerregelungExt
// Concrete patterns + invariants implemented in bead fdde-8vf. This profile only
// inherits the structural ability to carry the tax extensions.

Profile: GozChargeItemDE
Parent: ChargeItemPraxisDe
Id: goz-charge-item
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
* account 1..1 MS
* account only Reference(AccountPraxisSchein)
* account ^short = "Abrechnungs-Schein (AccountPraxisSchein, ADR-039)"

// --- Extensions: FDI-Zahnnummer, Zahnflächen, Steigerungsfaktor, Analogleistung, Verlangensleistung, Tax-Pattern ---
* extension contains
    FdiToothNumberExt named fdiToothNumber 0..1 MS and
    ToothSurfacesExt named toothSurfaces 0..* MS and
    PrivatgebuehrSteigerungsfaktorExt named steigerungsfaktor 0..1 MS and
    PrivatgebuehrAnalogReferenceExt named analogReference 0..1 MS and
    VerlangensleistungExt named verlangensleistung 0..1 MS and
    $TaxCategoryExt named taxCategory 1..1 MS and
    $TaxExemptionReasonExt named taxExemptionReason 0..1 MS

* extension[fdiToothNumber] ^short = "FDI-Zahnnummer (SWS: Zahnnummer)"
* extension[toothSurfaces] ^short = "Betroffene Zahnflächen (SWS: Flächen)"
* extension[steigerungsfaktor] ^short = "Steigerungsfaktor-Begründung §5 GOZ (SWS: Begründung >2,3)"
* extension[analogReference] ^short = "Analogleistung §6 GOZ (SWS: Analogleistung)"
* extension[verlangensleistung] ^short = "Verlangensleistung-Markierung § 1 Abs. 2 Satz 2 GOZ (boolean + optionaler Beleg). Wenn verlangensleistung.verlangensleistung=true: § 2 GOZ-Vereinbarungspflicht entfällt; USt-Pflicht 19% (Constraint goz-tax-verlangens-s)."

// --- USt-Pattern (fdde-8vf): GOZ je nach Indikation/Verlangens/Eigenlabor (E/S/AA) ---
// Default (medizinisch indizierte Heilbehandlung): TaxCategory=E + TaxExemptionReason=para4-nr14a
// Bei Verlangensleistung:                          TaxCategory=S (kein Befreiungsgrund) — siehe Constraint goz-tax-verlangens-s
// Bei Eigenlabor-Werkstück:                        siehe Sub-Profil GozZahntechWerkstueckChargeItemDE (AA)
// Binding der valueCodeableConcept-Codes übernommen aus den praxis-de Extension-Definitionen.
* extension[taxCategory] ^short = "USt-Kategorie (EN 16931 / UN-CEFACT-5305) — E steuerfrei (Default Heilbehandlung), S 19% (Verlangens), AA 7% (Eigenlabor-Werkstück)"
* extension[taxExemptionReason] ^short = "USt-Befreiungsgrund — Pflicht wenn-und-nur-wenn taxCategory=E (Constraint goz-tax-iff-e)"

* obeys goz-tax-iff-e
* obeys goz-tax-verlangens-s

Invariant: goz-tax-iff-e
Description: "TaxExemptionReason MUSS vorhanden sein wenn-und-nur-wenn TaxCategory=E (steuerfrei). Bei jedem anderen TaxCategory-Wert (S/AA/AE/Z) DARF kein Befreiungsgrund gesetzt sein, da nur tatsächliche Steuerbefreiung einen Grund braucht."
Severity: #error
Expression: "(extension.where(url='https://fhir.cognovis.de/praxis/StructureDefinition/ext-tax-category').valueCodeableConcept.coding.where(system='urn:un:unece:uncefact:codelist:standard:5305').code = 'E') = extension.where(url='https://fhir.cognovis.de/praxis/StructureDefinition/ext-tax-exemption-reason').exists()"

Invariant: goz-tax-verlangens-s
Description: "Wenn VerlangensleistungExt.verlangensleistung=true gesetzt, MUSS TaxCategory=S (Regelsatz 19%) sein. Verlangensleistungen sind keine Heilbehandlung i.S. § 4 Nr. 14a UStG und daher USt-pflichtig."
Severity: #error
Expression: "extension.where(url='https://fhir.cognovis.de/dental/StructureDefinition/verlangensleistung').extension.where(url='verlangensleistung').valueBoolean = true implies extension.where(url='https://fhir.cognovis.de/praxis/StructureDefinition/ext-tax-category').valueCodeableConcept.coding.where(system='urn:un:unece:uncefact:codelist:standard:5305').code = 'S'"
