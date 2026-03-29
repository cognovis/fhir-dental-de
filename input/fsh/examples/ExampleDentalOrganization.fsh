// Example: Zahnarztpraxis mit BSNR und KZV-Stempelnummer
// SWS 2.0 Satzart 0 — Praxisstammdaten

Instance: ExampleDentalOrganization
InstanceOf: DentalOrganizationDE
Usage: #example
Title: "Beispiel Zahnarztpraxis"
Description: "Zahnarztpraxis Mustermann in München mit BSNR und KZV-Stempelnummer (Bayern)."

* identifier[bsnr].system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR"
* identifier[bsnr].value = "721234500"

* identifier[kzv].system = "https://mira.cognovis.de/fhir/identifier/kzv-stempelnummer"
* identifier[kzv].value = "K720001234"

* name = "Zahnarztpraxis Dr. Anna Mustermann"

* type[0] = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"

* address[0].use = #work
* address[0].type = #physical
* address[0].line[0] = "Maximilianstraße 42"
* address[0].city = "München"
* address[0].postalCode = "80538"
* address[0].country = "DE"

* telecom[0].system = #phone
* telecom[0].value = "+49 89 1234560"
* telecom[0].use = #work

* telecom[1].system = #fax
* telecom[1].value = "+49 89 1234561"
* telecom[1].use = #work

* telecom[2].system = #email
* telecom[2].value = "praxis@dr-mustermann-zahnarzt.de"
* telecom[2].use = #work
