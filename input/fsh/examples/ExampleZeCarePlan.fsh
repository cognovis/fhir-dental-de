// Example: ZE-Plan, Befundkürzel 1.1, Regelversorgung
// SWS 2.0 Satzart 11 — Zahnersatz-Behandlungsplan

Instance: ExampleZeCarePlan
InstanceOf: ZeCarePlanDE
Usage: #example
Title: "Beispiel ZE-Plan Krone Zahn 46 Regelversorgung"
Description: "Zahnersatz-Behandlungsplan für Krone an Zahn 46. Befundkürzel: pw (erhaltungswürdiger Zahn mit partieller Zerstörung). Therapiekürzel: K (Krone). Versorgungsart: Regelversorgung."

// ZE-Befundkürzel: Zahn 46 — pw (erhaltungswürdig, partiell zerstört)
* extension[zeBefundkuerzel].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel#pw "erhaltungswürdiger Zahn mit partieller Zerstörung"

// ZE-Therapiekürzel: K (Krone)
* extension[zeTherapiekuerzel].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-therapiekuerzel#K "Krone"

// ZE-Versorgungsart: Regelversorgung
* extension[zeVersorgungsart].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-versorgungsart#regelversorgung "Regelversorgung"

* identifier[0].system = "https://mira.cognovis.de/fhir/identifier/ze-id"
* identifier[0].value = "ZE-2026-000046"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(ExamplePatient)

* created = "2026-01-15"

* period.start = "2026-02-15"
* period.end = "2026-05-31"

* title = "ZE-Plan: Kronenversorgung Zahn 46 — Regelversorgung"

* description = "Zahnersatz-Behandlungsplan gemäß Festzuschuss-Richtlinie §56 SGB V. Zahn 46 zerstört (Befundklasse pw). Geplante Versorgung: VMK-Krone (Regelversorgung). Festzuschuss: 50% + 20% Bonus (10 Jahre Bonusheft). Eigenanteil nach Kassenberechnung: ca. 180 €."
