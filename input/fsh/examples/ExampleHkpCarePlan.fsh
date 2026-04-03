// Example: HKP für Brücke Zahn 35-37, Status genehmigt
// SWS 2.0 Satzart 8 — Heil- und Kostenplan

Instance: ExampleHkpCarePlan
InstanceOf: HkpCarePlanDE
Usage: #example
Title: "Beispiel HKP Brücke Zahn 35-37 — genehmigt"
Description: "Heil- und Kostenplan (HKP) für Brückenversorgung Zahn 35-37 (Zahn 36 fehlt). Status: genehmigt durch Barmer am 2026-02-01. Patient Aylin Özdemir (GKV+ZZV)."

* extension[hkpGenehmigungsstatus].extension[status].valueCode = https://fhir.cognovis.de/dental/CodeSystem/hkp-genehmigungsstatus#genehmigt "Genehmigt"
* extension[hkpGenehmigungsstatus].extension[eingereicht-am].valueDateTime = "2026-01-16"
* extension[hkpGenehmigungsstatus].extension[genehmigt-am].valueDateTime = "2026-02-01"

* extension[ehkpId].valueString = "eHKP-2026-00123"

// ZE-Befundkürzel: Zahn 36 fehlend, Brücke geplant
* extension[zeBefundkuerzel].valueCode = https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel#x "fehlender Zahn"

* identifier[0].system = "https://mira-demo-mvz.de/hkp"
* identifier[0].value = "HKP-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(Patient/pat-gkv-dental-01)

* created = "2026-01-15"

* period.start = "2026-01-15"
* period.end = "2026-06-30"

* title = "HKP: Brückenversorgung Zahn 35-37"

* description = "Heil- und Kostenplan für dreigliedrige Brücke (Zahn 35-37, Zahn 36 fehlend). Befundkürzel: x (fehlender Zahn). Geplante Versorgung: Regelversorgung VMK-Brücke. Festzuschuss 50% + 20% Bonus (10 Jahre Bonusheft). Genehmigt durch Barmer am 2026-02-01. eHKP-Referenz: eHKP-2026-00123."
