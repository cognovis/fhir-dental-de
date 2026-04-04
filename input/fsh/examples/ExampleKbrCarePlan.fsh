// Example: KBR-Plan (Kieferbruch-Behandlung)
// BEMA W-Serie — Kieferbruch und -verletzungen

Instance: ExampleKbrCarePlan
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel KBR-Behandlungsplan Kieferbruch"
Description: "Behandlungsplan fuer Kieferbruch-Behandlung nach BEMA W-Serie. Fraktur Unterkiefer (Symphysenbereich). Patient Klaus Bergmann (GKV). Behandlungszeitraum 6 Wochen inkl. Schienentherapie."

* identifier[0].system = "https://mira-demo-mvz.de/kbr-plan"
* identifier[0].value = "KBR-2026-0001"

* status = #draft
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#kbr "Kieferbruch-Behandlung (KBR)"

* subject = Reference(Patient/pat-gkv-01)

* created = "2026-03-10"

* period.start = "2026-03-10"
* period.end = "2026-04-21"

* title = "KBR-Behandlungsplan: Unterkieferfraktur Symphysenbereich"

* description = "Kieferbruch-Behandlung nach BEMA W-Serie. Diagnose: Fraktur des Unterkiefers im Symphysenbereich (ICD-10: S02.6). Geplante Therapie: Drahtschienung (W10), intermaxillaere Fixierung (W11), Retentionskontrolle (W25). Voraussichtliche Behandlungsdauer 6 Wochen."
