// Example: PMB-Plan (Professionelle Mundgesundheitsberatung)
// Präventive Maßnahmen und professionelle Mundgesundheitsberatung inkl. PZR-Recall

Instance: ExamplePmbCarePlan
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel PMB-Plan PZR-Recall 6 Monate"
Description: "Präventionsplan für professionelle Mundgesundheitsberatung mit PZR-Recall alle 6 Monate. Patient Aylin Özdemir (GKV+ZZV). Recall-Aktivität halbjährlich geplant."

* identifier[0].system = "https://mira-demo-mvz.de/pmb-plan"
* identifier[0].value = "PMB-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#pmb "Professionelle Mundgesundheitsberatung (PMB)"

* subject = Reference(Patient/pat-gkv-dental-01)

* created = "2026-01-10"

* period.start = "2026-01-10"
* period.end = "2028-01-09"

* title = "PMB-Plan: PZR-Recall-Programm halbjährlich"

* description = "Professionelle Mundgesundheitsberatung und präventive Zahnarztbehandlung. Regelmäßige professionelle Zahnreinigung (PZR) im 6-Monats-Intervall. Mundhygieneunterweisung, Fluoridierung, Kariesprophylaxe. Individuelle Präventionsmaßnahmen entsprechend Risikobewertung."

// PZR-Recall-Aktivität: alle 6 Monate
* activity[0].detail.status = #scheduled
* activity[0].detail.code = http://snomed.info/sct#70762009 "Professional dental prophylaxis"
* activity[0].detail.code.text = "PZR — Professionelle Zahnreinigung"
* activity[0].detail.scheduledTiming.repeat.period = 6
* activity[0].detail.scheduledTiming.repeat.periodUnit = #mo
* activity[0].detail.description = "PZR-Recall alle 6 Monate: Professionelle Zahnreinigung, Mundhygieneunterweisung, Fluoridierung."
