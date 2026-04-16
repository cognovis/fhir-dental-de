// Example: Zahnarztpraxis mit BSNR und KZV-Stempelnummer
// SWS 2.0 Satzart 0 — Praxisstammdaten

Instance: org-dental-mvz
InstanceOf: DentalOrganizationDE
Usage: #example
Title: "Beispiel MIRA Demo-Zahnarztpraxis (MVZ)"
Description: "MIRA Demo-Zahnarztpraxis (MVZ) in Nürnberg mit BSNR und KZV-Stempelnummer (Bayern). Entspricht org-dental-mvz aus den MIRA Seed-Daten."

* identifier[bsnr].system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR"
* identifier[bsnr].value = "721234500"

* identifier[kzv].system = "https://fhir.cognovis.de/dental/identifier/kzv-stempelnummer"
* identifier[kzv].value = "K720001234"

* name = "MIRA Demo-Zahnarztpraxis"

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
* telecom[2].value = "praxis@mira-demo-mvz.de"
* telecom[2].use = #work
