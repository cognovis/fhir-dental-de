// Dental practitioner profile for dentist identifiers.
//
// KBV_PR_Base_Practitioner already defines identifier[ZANR] using
// IdentifierZanr. This profile marks that inherited slice as Must Support for
// dental billing and keeps the canonical KBV parent unchanged.
Profile: DentalPractitionerDE
Parent: KBV_PR_Base_Practitioner
Id: dental-practitioner
Title: "Dental Practitioner (DE)"
Description: "Profil fuer zahnaerztliche Behandler. Basiert direkt auf KBV_PR_Base_Practitioner und markiert die ZANR fuer die KZV-Abrechnung als Must Support."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* identifier[ZANR] MS
* identifier[ZANR] ^short = "Zahnarzt-Nummer (ZANR, KZV)"
* identifier[ZANR] ^definition = "Zahnarzt-Nummer (ZANR) gemaess KZV-Abrechnungsstandard. Systemfixierung erfolgt durch IdentifierZanr aus de.basisprofil.r4."
