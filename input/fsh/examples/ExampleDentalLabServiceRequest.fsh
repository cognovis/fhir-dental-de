// Example: Laborauftrag an Dentallabor für Keramik-Inlay Zahn 15
// SWS 2.0 Satzart 13 — Zahntechnischer Laborauftrag

Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi

Instance: ExampleDentalLabServiceRequest
InstanceOf: DentalLabServiceRequestDE
Usage: #example
Title: "Beispiel Laborauftrag Keramik-Inlay Zahn 15"
Description: "Zahntechnischer Laborauftrag an Dentallabor Zahntechnik Nürnberg GmbH für Keramik-Inlay Zahn 15 (CAD/CAM). Verknüpft mit dem ZE-Behandlungsplan. Patientin Charlotte von Hohenstein (DKV)."

* identifier[0].system = "https://mira-demo-mvz.de/labor-id"
* identifier[0].value = "LAB-2026-000015"

* status = #completed
* intent = #order

* code.text = "Keramik-Inlay Zahn 15, CAD/CAM"

* subject = Reference(Patient/pat-pkv-01)

// Link zum ZE-Behandlungsplan
* basedOn[0] = Reference(ExampleZeCarePlan)

// Encounter-Kontext
* encounter = Reference(Encounter/enc-dental-02-privatschein)

// Ausführendes Dentallabor
* performer[0] = Reference(ExampleDentallabor)

* requester = Reference(PractitionerRole/role-schoell-gibitzenhof)

* authoredOn = "2026-01-22"

* note[0].text = "Keramik-Inlay Zahn 15, Farbe A2, CAD/CAM. Abholung bis Freitag."

// -----------------------------------------------------------------------
// Inline Dentallabor (DentalOrganizationDE)
// -----------------------------------------------------------------------
Instance: ExampleDentallabor
InstanceOf: DentalOrganizationDE
Usage: #example
Title: "Beispiel Dentallabor Zahntechnik Nürnberg"
Description: "Dentallabor als Auftragnehmer für zahntechnische Leistungen."

* name = "Zahntechnik Nürnberg GmbH"

* type[0] = http://terminology.hl7.org/CodeSystem/organization-type#other "Other"
* type[0].text = "Dentallabor"

* address[0].use = #work
* address[0].type = #physical
* address[0].line[0] = "Gewerbestraße 7"
* address[0].city = "Nürnberg"
* address[0].postalCode = "90427"
* address[0].country = "DE"

* telecom[0].system = #phone
* telecom[0].value = "+49 911 9876540"
* telecom[0].use = #work

* telecom[1].system = #email
* telecom[1].value = "labor@zahntechnik-nuernberg.de"
* telecom[1].use = #work


// -----------------------------------------------------------------------
// Zusätzliches Beispiel: BEL II ChargeItem mit ztl-material und bel-punkte
// Demonstriert zahntechnische Leistungsabrechnung für das Labor
// -----------------------------------------------------------------------
Instance: ExampleBelChargeItemKeramikInlay
InstanceOf: BemaChargeItemDE
Usage: #example
Title: "Beispiel BEL II ChargeItem — Keramik-Inlay Zahn 15"
Description: "Zahntechnische Leistungsposition (BEL II) für Keramik-Inlay Zahn 15. Demonstriert bel-punkte und ztl-material Extension. Patientin Charlotte von Hohenstein (DKV)."

* extension[fdiToothNumber].valueCode = #15

// BEL II Punkte für zahntechnische Leistung
* extension[https://fhir.cognovis.de/dental/StructureDefinition/bel-punkte].valueInteger = 320

// ZTL Material: Keramik (vollkeramisch)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/ztl-material].valueCodeableConcept.text = "Vollkeramik (CAD/CAM, Lithiumdisilikat)"

* status = #billable

* code.coding[0] = https://fhir.cognovis.de/dental/CodeSystem/bema-codes#98c "Inlay, zweiflächig, vollkeramisch (BEL II)"

* subject = Reference(Patient/pat-pkv-01)

* context = Reference(Encounter/enc-dental-02-privatschein)

* occurrenceDateTime = "2026-01-22"

* quantity.value = 320
* quantity.unit = "BEL-Punkte"

* priceOverride.value = 198.40
* priceOverride.currency = #EUR

* bodysite = $fdiCS#15 "15"
