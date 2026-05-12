// 3-Layer-Chain: KBV → praxis-de → dental-de
//
// Layer 1 (KBV): KBV_PR_Base_Organization (kbv.basis) — German base organization constraints.
//   Provides identifier slicing with discriminator type=value, path=type.
//   Pre-defined slices: Institutionskennzeichen (IK), Betriebsstaettennummer (BSNR),
//   VKNR, KZV-Abrechnungsnummer, Telematik-ID.
// Layer 2 (praxis-de): PraxisOrganizationDE (de.cognovis.fhir.praxis) — shared practice-level
//   constraints applicable across all cognovis IGs (not dental-specific).
// Layer 3 (dental-de): DentalOrganizationDE (this profile) — dental-specific constraints:
//   SWS 2.0 Satzart 0 (Praxisstammdaten) mapping.
//
// Identifier slicing inherited from KBV_PR_Base_Organization (via PraxisOrganizationDE):
//   discriminator: type=value, path=type
//   DO NOT redefine the slicing discriminator here — child profiles inherit parent slicing.
//
//   KBV-inherited slices (use as-is via inheritance):
//     identifier:Betriebsstaettennummer    — BSNR (KBV_NS_Base_BSNR)
//     identifier:KZV-Abrechnungsnummer     — KZV billing/stamp number (identifier-kzva profile)
//     identifier:Institutionskennzeichen, identifier:VKNR, identifier:Telematik-ID
//
//   The KZV-Stempelnummer (SWS Dateinamensuffix) is the same 9-digit KZV number as
//   KZV-Abrechnungsnummer. Use identifier:KZV-Abrechnungsnummer (inherited from
//   KBV_PR_Base_Organization) — no separate dental slice is needed or defined here.
//
// SWS 2.0 Satzart 0: Praxisstammdaten / Behandlerstammdaten
// Fields: Praxisname, Stempelnummer (= KZV-Abrechnungsnummer), BSNR, Adresse, Telefon/Fax

Profile: DentalOrganizationDE
Parent: PraxisOrganizationDE
Id: dental-organization
Title: "Zahnarztpraxis / Organisation (DE)"
Description: "Profil für Zahnarztpraxen und beteiligte Organisationen (z.B. Dentallabore). Bildet SWS 2.0 Satzart 0 (Praxisstammdaten) ab. Enthält BSNR (via KBV-Vererbung), KZV-Stempelnummer, Adresse und Kontaktdaten."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Identifier: inherited slices used as-is ---
// BSNR: identifier:Betriebsstaettennummer — inherited from KBV_PR_Base_Organization.
// KZV-Stempelnummer: use identifier:KZV-Abrechnungsnummer — the KZV 9-digit number is
//   the same identifier used as the SWS Dateinamensuffix. Inherited from KBV_PR_Base_Organization.
//   No additional dental-specific slice is required.
* identifier MS
* identifier ^short = "Praxis-Identifier (BSNR und KZV-Abrechnungsnummer via KBV-Vererbung)"

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
