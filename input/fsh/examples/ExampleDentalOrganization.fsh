// Example: Zahnarztpraxis mit BSNR und KZV-Abrechnungsnummer (= Stempelnummer)
// SWS 2.0 Satzart 0 — Praxisstammdaten

Instance: org-dental-mvz
InstanceOf: DentalOrganizationDE
Usage: #example
Title: "Beispiel Zahnarztpraxis MVZ Nürnberg"
Description: "Demo-Zahnarztpraxis (MVZ) in Nürnberg mit BSNR und KZV-Abrechnungsnummer (Bayern)."

// BSNR: use inherited KBV slice name (from KBV_PR_Base_Organization via PraxisOrganizationDE)
* identifier[Betriebsstaettennummer].value = "721234500"

// KZV-Stempelnummer = KZV-Abrechnungsnummer: use inherited KBV slice (identifier-kzva profile)
// The 9-digit KZV number doubles as the SWS Dateinamensuffix (Stempelnummer).
* identifier[KZV-Abrechnungsnummer].value = "720001234"

* name = "Demo-Zahnarztpraxis MVZ Nürnberg"

* type[0] = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* type[0].text = "Zahnärztliches MVZ"

* address[0].use = #work
* address[0].type = #physical
* address[0].line[0] = "Breite Gasse 20"
* address[0].city = "Nürnberg"
* address[0].postalCode = "90402"
* address[0].country = "DE"

* telecom[0].system = #phone
* telecom[0].value = "+49 911 1234567"
* telecom[0].use = #work

* telecom[1].system = #fax
* telecom[1].value = "+49 911 1234568"
* telecom[1].use = #work

* telecom[2].system = #email
* telecom[2].value = "praxis@example-dental-practice.de"
* telecom[2].use = #work
