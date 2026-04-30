// Example: ZE-Plan, Befundkürzel x, gleichartige Versorgung
// SWS 2.0 Satzart 11 — Zahnersatz-Behandlungsplan

Instance: ExampleZeCarePlan
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel ZE-Plan Brücke Zahn 35-37 — gleichartige Versorgung"
Description: "Zahnersatz-Behandlungsplan für dreigliedrige Brücke Zahn 35-37. Befundkürzel: x (fehlender Zahn). Therapiekürzel: B (Brücke). Versorgungsart: gleichartig. Patient Aylin Özdemir (GKV+ZZV). Eigenanteile werden in der zugehörigen Claim-Ressource erfasst."

// ZE-Befundkürzel: Zahn 36 fehlend
* extension[zeBefundkuerzel].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel#x "fehlender Zahn"

// ZE-Therapiekürzel: B (Brücke)
* extension[zeTherapiekuerzel].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-therapiekuerzel#B "Brücke"

// ZE-Versorgungsart: gleichartig
* extension[zeVersorgungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-versorgungsart#gleichartig "gleichartige Versorgung"

* identifier[0].system = "https://example-dental-practice.de/hkp"
* identifier[0].value = "ZE-HKP-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#ze "Zahnersatz (ZE)"

* subject = Reference(Patient/pat-gkv-dental-01)

* created = "2026-01-15"

* period.start = "2026-01-15"
* period.end = "2026-06-30"

* title = "ZE-Plan: Brückenversorgung Zahn 35-37 — gleichartig"

* description = "Zahnersatz-Behandlungsplan gemäß Festzuschuss-Richtlinie §56 SGB V. Zahn 36 fehlend (Befundkürzel x). Geplante Versorgung: Keramikbrücke 35-37 (gleichartige Versorgung). Festzuschuss: 50% + 20% Bonus (10 Jahre Bonusheft lückenlos). Eigenanteil Regelversorgung 180 €, Eigenanteil gleichartig 320 €. Eigenanteile werden in der zugehörigen Claim-Ressource über eigenanteil-regelversorgung und eigenanteil-gleichartig Extensions erfasst."


// -----------------------------------------------------------------------
// Zugehörige Claim-Ressource: Demonstriert eigenanteil-* und ze-bonus-prozent Extensions
// -----------------------------------------------------------------------
Instance: ExampleZeEigenanteilClaim
InstanceOf: Claim
Usage: #example
Title: "Beispiel ZE-Eigenanteil Claim — Brücke Zahn 35-37"
Description: "Claim-Ressource für ZE-Abrechnung Brücke Zahn 35-37. Demonstriert eigenanteil-regelversorgung, eigenanteil-gleichartig und ze-bonus-prozent Extensions. Patientin Aylin Özdemir (GKV+ZZV)."

// ze-bonus-prozent: 70% (10 Jahre lückenlose Bonusheft-Dokumentation)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/ze-bonus-prozent].valueInteger = 70

// eigenanteil-regelversorgung: 180 EUR (Differenz Regelversorgung minus Festzuschuss)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-regelversorgung].valueMoney.value = 180.00
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-regelversorgung].valueMoney.currency = #EUR

// eigenanteil-gleichartig: 320 EUR (Mehrkosten gleichartige Versorgung)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-gleichartig].valueMoney.value = 320.00
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-gleichartig].valueMoney.currency = #EUR

* status = #active
* use = #claim
* type = http://terminology.hl7.org/CodeSystem/claim-type#oral "Oral"
* created = "2026-01-15"

* patient = Reference(Patient/pat-gkv-dental-01)

* provider = Reference(PractitionerRole/role-schoell-gibitzenhof)

* priority = http://terminology.hl7.org/CodeSystem/processpriority#normal

* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(Coverage/cov-gkv-dental-01-gkv)


// -----------------------------------------------------------------------
// Weiteres Claim-Beispiel: Demonstriert eigenanteil-andersartig Extension
// Andersartige Versorgung: Vollkeramikkrone statt NEM-Regelversorgung
// -----------------------------------------------------------------------
Instance: ExampleZeEigenanteilAndersartigClaim
InstanceOf: Claim
Usage: #example
Title: "Beispiel ZE-Eigenanteil Claim — andersartige Versorgung"
Description: "Claim-Ressource für ZE-Abrechnung mit andersartiger Versorgung (Vollkeramikkrone statt NEM-Regelversorgung). Demonstriert eigenanteil-andersartig Extension. Patientin Aylin Özdemir (GKV+ZZV)."

// ze-bonus-prozent: 70% (10 Jahre lückenlose Bonusheft-Dokumentation)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/ze-bonus-prozent].valueInteger = 70

// eigenanteil-regelversorgung: 180 EUR (Differenz Regelversorgung minus Festzuschuss)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-regelversorgung].valueMoney.value = 180.00
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-regelversorgung].valueMoney.currency = #EUR

// eigenanteil-andersartig: 580 EUR (volle Mehrkosten bei andersartiger Vollkeramikversorgung)
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-andersartig].valueMoney.value = 580.00
* extension[https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-andersartig].valueMoney.currency = #EUR

* status = #active
* use = #claim
* type = http://terminology.hl7.org/CodeSystem/claim-type#oral "Oral"
* created = "2026-02-10"

* patient = Reference(Patient/pat-gkv-dental-01)

* provider = Reference(PractitionerRole/role-schoell-gibitzenhof)

* priority = http://terminology.hl7.org/CodeSystem/processpriority#normal

* insurance[0].sequence = 1
* insurance[0].focal = true
* insurance[0].coverage = Reference(Coverage/cov-gkv-dental-01-gkv)
