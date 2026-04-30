// SWS 2.0 Satzart 0: Praxisstammdaten / Behandlerstammdaten
// Primary FHIR resource: Organization
// Fields: Praxisname, Stempelnummer, BSNR, Adresse, Telefon/Fax
//
// Identifier slicing:
//   - bsnr  : Betriebsstättennummer  (System: https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR)
//   - kzv   : KZV-Stempelnummer (Abrechnungsnummer)
//             (System: https://fhir.cognovis.de/dental/identifier/kzv-stempelnummer)

Profile: DentalOrganizationDE
Parent: Organization
Id: dental-organization
Title: "Zahnarztpraxis / Organisation (DE)"
Description: "Profil für Zahnarztpraxen und beteiligte Organisationen (z.B. Dentallabore). Bildet SWS 2.0 Satzart 0 (Praxisstammdaten) ab. Enthält BSNR, KZV-Stempelnummer, Adresse und Kontaktdaten."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Identifier slicing: BSNR + KZV-Stempelnummer ---
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "Praxis-Identifier (BSNR, KZV-Stempelnummer)"

* identifier contains
    bsnr 0..1 MS and
    kzv 0..1 MS

* identifier[bsnr].system 1..1 MS
* identifier[bsnr].system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR"
* identifier[bsnr].value 1..1 MS
* identifier[bsnr] ^short = "Betriebsstättennummer (BSNR)"
* identifier[bsnr] ^definition = "Neunstellige Betriebsstättennummer der Zahnarztpraxis, vergeben von der KZV."

* identifier[kzv].system 1..1 MS
* identifier[kzv].system = "https://fhir.cognovis.de/dental/identifier/kzv-stempelnummer"
* identifier[kzv].value 1..1 MS
* identifier[kzv] ^short = "KZV-Stempelnummer (Abrechnungsnummer)"
* identifier[kzv] ^definition = "KZV-Abrechnungsnummer der Praxis (SWS: Stempelnummer). Wird als Dateinamensuffix in SWS_DATA.nnn verwendet."

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
