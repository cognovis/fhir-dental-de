// Example: an unselected HKP alternative represented with the standard R4 option intent.

Instance: ExampleHkpCarePlanOption
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel HKP-Versorgungsalternative"
Description: "Noch nicht ausgewählte Versorgungsalternative für eine Brücke Zahn 35-37. Die Alternative verwendet CarePlan.intent = option und kann ohne Profilwechsel zu einem plan werden, wenn sie ausgewählt wird."

* identifier[0].system = "https://example-dental-practice.de/hkp"
* identifier[0].value = "HKP-2026-0001-OPTION-B"
* status = #draft
* intent = #option
* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#hkp "Heil- und Kostenplan (HKP)"
* subject = Reference(Patient/pat-gkv-dental-01)
* created = "2026-01-15"
* period.start = "2026-01-15"
* period.end = "2026-06-30"
* title = "HKP-Alternative: Brückenversorgung Zahn 35-37"
* description = "Alternative Versorgung, die noch nicht als ausführbarer Behandlungsplan ausgewählt wurde."
