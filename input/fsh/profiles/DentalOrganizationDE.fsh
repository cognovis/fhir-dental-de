// 3-Layer-Chain: KBV → praxis-de → dental-de
//
// Layer 1 (KBV): KBV_PR_Base_Organization (kbv.basis) — German base organization constraints.
//   Provides identifier slicing with discriminator type=value, path=type.
//   Pre-defined slices: Institutionskennzeichen (IK), Betriebsstaettennummer (BSNR),
//   VKNR, KZV-Abrechnungsnummer, Telematik-ID.
// Layer 2 (praxis-de): PraxisOrganizationDE (de.cognovis.fhir.praxis) — shared practice-level
//   constraints applicable across all cognovis IGs (not dental-specific).
// Layer 3 (dental-de): DentalOrganizationDE (this profile) — dental-specific constraints:
//   KZV-Stempelnummer identifier, SWS 2.0 Satzart 0 (Praxisstammdaten) mapping.
//
// Identifier slicing inherited from KBV_PR_Base_Organization (via PraxisOrganizationDE):
//   discriminator: type=value, path=type
//   DO NOT redefine the slicing discriminator here — child profiles inherit parent slicing.
//
//   KBV-inherited slices (use as-is via inheritance):
//     identifier:Betriebsstaettennummer — BSNR (KBV_NS_Base_BSNR)
//     identifier:KZV-Abrechnungsnummer  — KZV billing number (identifier-kzva profile)
//     identifier:Institutionskennzeichen, identifier:VKNR, identifier:Telematik-ID
//
//   Dental-specific slice (new, compatible with type discriminator):
//     identifier:kzvStempelnummer — KZV-Stempelnummer (SWS Dateinamensuffix, system-based)
//       Distinguished from KZV-Abrechnungsnummer by custom type code.
//
// SWS 2.0 Satzart 0: Praxisstammdaten / Behandlerstammdaten
// Fields: Praxisname, Stempelnummer, BSNR, Adresse, Telefon/Fax

Profile: DentalOrganizationDE
Parent: PraxisOrganizationDE
Id: dental-organization
Title: "Zahnarztpraxis / Organisation (DE)"
Description: "Profil für Zahnarztpraxen und beteiligte Organisationen (z.B. Dentallabore). Bildet SWS 2.0 Satzart 0 (Praxisstammdaten) ab. Enthält BSNR (via KBV-Vererbung), KZV-Stempelnummer, Adresse und Kontaktdaten."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Identifier: KZV-Stempelnummer (dental-specific, not in KBV base) ---
// The BSNR (Betriebsstättennummer) is already provided by the inherited
// identifier:Betriebsstaettennummer slice from KBV_PR_Base_Organization.
// We add only the KZV-Stempelnummer as a new slice using a custom type coding,
// compatible with the parent's type=value, path=type discriminator.
* identifier MS
* identifier ^short = "Praxis-Identifier (BSNR via KBV-Vererbung, KZV-Stempelnummer)"

* identifier contains kzvStempelnummer 0..1 MS

// KZV-Stempelnummer slice: uses type discriminator (patternCodeableConcept on identifier.type)
// to be compatible with the parent's slicing discriminator (type=value, path=type).
// The custom type code "KZVSNR" (KZV-Stempelnummer) distinguishes this from the KBV-inherited
// KZV-Abrechnungsnummer slice (which uses code "KZVA" from http://terminology.hl7.org/CodeSystem/v2-0203).
* identifier[kzvStempelnummer].type 1..1 MS
* identifier[kzvStempelnummer].type = http://terminology.hl7.org/CodeSystem/v2-0203#KZVSNR "KZV-Stempelnummer"
* identifier[kzvStempelnummer].system 1..1 MS
* identifier[kzvStempelnummer].system = "https://fhir.cognovis.de/dental/identifier/kzv-stempelnummer"
* identifier[kzvStempelnummer].value 1..1 MS
* identifier[kzvStempelnummer] ^short = "KZV-Stempelnummer (Abrechnungsnummer)"
* identifier[kzvStempelnummer] ^definition = "KZV-Abrechnungsnummer der Praxis (SWS: Stempelnummer). Wird als Dateinamensuffix in SWS_DATA.nnn verwendet. Distinct from identifier:KZV-Abrechnungsnummer inherited from KBV_PR_Base_Organization."

// --- Name: Praxisbezeichnung ---
* name 1..1 MS
* name ^short = "Praxisbezeichnung (SWS: Praxisname)"

// --- Type: Praxis vs. Labor ---
* type MS
* type ^short = "Organisationstyp (z.B. Zahnarztpraxis, Dentallabor)"

// --- Address: Praxisanschrift ---
* address MS
* address ^short = "Praxisanschrift (SWS: Adresse)"

// --- Telecom: Telefon / Fax ---
* telecom MS
* telecom ^short = "Kontaktdaten (Telefon, Fax, E-Mail)"
