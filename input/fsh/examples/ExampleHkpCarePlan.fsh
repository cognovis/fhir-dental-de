// Example: HKP für Krone Zahn 46, Status genehmigt
// SWS 2.0 Satzart 8 — Heil- und Kostenplan

Instance: ExampleHkpCarePlan
InstanceOf: HkpCarePlanDE
Usage: #example
Title: "Beispiel HKP Krone Zahn 46 — genehmigt"
Description: "Heil- und Kostenplan (HKP) für Kronenversorgung an Zahn 46 (stark zerstört). Status: genehmigt durch AOK Bayern am 2026-01-20."

* extension[hkpGenehmigungsstatus].extension[status].valueCode = https://fhir.cognovis.de/dental/CodeSystem/hkp-genehmigungsstatus#genehmigt "Genehmigt"
* extension[hkpGenehmigungsstatus].extension[eingereicht-am].valueDateTime = "2026-01-10T10:00:00+01:00"
* extension[hkpGenehmigungsstatus].extension[genehmigt-am].valueDateTime = "2026-01-20T14:30:00+01:00"

* extension[ehkpId].valueString = "EBZ-2026-HKP-00099234"

// ZE-Befundkürzel: Zahn 46 — kariös/zerstört, Krone geplant
* extension[zeBefundkuerzel].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel#pw "erhaltungswürdiger Zahn mit partieller Zerstörung"

* identifier[0].system = "https://mira.cognovis.de/fhir/identifier/hkp-id"
* identifier[0].value = "HKP-2026-000099"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(ExamplePatient)

* created = "2026-01-10"

* period.start = "2026-01-20"
* period.end = "2026-06-30"

* title = "HKP: Kronenversorgung Zahn 46"

* description = "Kronenversorgung für stark zerstörten Zahn 46 (Dentinkaries K02.1 MOD, Restsubstanz für Aufbaufüllung ausreichend). Geplant: BEMA 99a (Aufbaufüllung) + BEMA Krone VMK. Kostenvoranschlag wurde bei AOK Bayern eingereicht und genehmigt."
