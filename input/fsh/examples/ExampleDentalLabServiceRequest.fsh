// Example: Laborauftrag an Dentallabor für Krone Zahn 46
// SWS 2.0 Satzart 13 — Zahntechnischer Laborauftrag

Instance: ExampleDentalLabServiceRequest
InstanceOf: DentalLabServiceRequestDE
Usage: #example
Title: "Beispiel Laborauftrag Krone Zahn 46"
Description: "Zahntechnischer Laborauftrag an Dentallabor Zahntechnik Schmidt GmbH für VMK-Krone Zahn 46. Verknüpft mit dem ZE-Behandlungsplan."

* identifier[0].system = "https://mira.cognovis.de/fhir/identifier/labor-id"
* identifier[0].value = "LAB-2026-000046"

* status = #active
* intent = #order

* subject = Reference(ExamplePatient)

// Link zum ZE-Behandlungsplan
* basedOn[0] = Reference(ExampleZeCarePlan)

// Ausführendes Dentallabor
* performer[0] = Reference(ExampleDentallabor)

* authoredOn = "2026-02-16"

* code.text = "VMK-Krone Zahn 46 (Verblendmetallkeramik). Farbe: VITA A3. Präparation: Hohlkehlpräparation. Modell: Gipsmodell aus Abformung vom 2026-02-15."

* note[0].text = "Bitte Zahnfarbe VITA A3 einhalten. Okklusale Keramikverblendung. Kontaktpunkte nach Wachsmodell. Rückgabe bis 2026-03-01."

// -----------------------------------------------------------------------
// Inline Dentallabor (DentalOrganizationDE)
// -----------------------------------------------------------------------
Instance: ExampleDentallabor
InstanceOf: DentalOrganizationDE
Usage: #example
Title: "Beispiel Dentallabor Zahntechnik Schmidt"
Description: "Dentallabor als Auftragnehmer für zahntechnische Leistungen."

* name = "Zahntechnik Schmidt GmbH"

* type[0] = http://terminology.hl7.org/CodeSystem/organization-type#other "Other"
* type[0].text = "Dentallabor"

* address[0].use = #work
* address[0].type = #physical
* address[0].line[0] = "Gewerbestraße 7"
* address[0].city = "München"
* address[0].postalCode = "81379"
* address[0].country = "DE"

* telecom[0].system = #phone
* telecom[0].value = "+49 89 9876540"
* telecom[0].use = #work

* telecom[1].system = #email
* telecom[1].value = "labor@zahntechnik-schmidt.de"
* telecom[1].use = #work
