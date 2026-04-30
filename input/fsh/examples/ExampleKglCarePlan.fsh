// Example: KGL-Plan (Kiefergelenk-Behandlung)
// BEMA U-Serie — Kiefergelenk-Erkrankungen und kraniomandibulare Dysfunktionen

Instance: ExampleKglCarePlan
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel KGL-Behandlungsplan Kiefergelenk CMD"
Description: "Behandlungsplan für Kiefergelenk-Erkrankung (CMD) nach BEMA U-Serie. Kraniomandibulare Dysfunktion mit Myoarthropathie. Patient Klaus Bergmann (GKV). Inkl. Funktionsanalyse als unterstützende Information."

* identifier[0].system = "https://example-dental-practice.de/kgl-plan"
* identifier[0].value = "KGL-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#kgl "Kiefergelenk-Behandlung (KGL)"

* subject = Reference(Patient/pat-gkv-01)

* created = "2026-02-20"

* period.start = "2026-03-01"
* period.end = "2026-09-30"

* title = "KGL-Behandlungsplan: CMD / Myoarthropathie Kiefergelenk"

* description = "Kiefergelenk-Behandlung nach BEMA U-Serie. Diagnose: Kraniomandibulare Dysfunktion (CMD) mit Myoarthropathie (ICD-10: K07.6). Therapieplanung: instrumentelle Funktionsanalyse (U10), Aufbissschiene (U11), Physiotherapiekooperation. Behandlungszeitraum 6 Monate mit Verlaufskontrolle."

// Funktionsanalyse als unterstützende Information
* supportingInfo[0] = Reference(ExampleFunktionsanalyseDiagnose)

// -----------------------------------------------------------------------
// Inline Diagnose für Funktionsanalyse (referenced by KGL CarePlan)
// -----------------------------------------------------------------------
Instance: ExampleFunktionsanalyseDiagnose
InstanceOf: Condition
Usage: #example
Title: "Beispiel CMD-Diagnose Myoarthropathie"
Description: "Kraniomandibulare Dysfunktion mit Myoarthropathie als Grundlage für KGL-Behandlungsplan."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"

* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = http://fhir.de/CodeSystem/bfarm/icd-10-gm#K07.6 "Kiefergelenkkrankheiten"
* code.text = "Kraniomandibulare Dysfunktion (CMD) mit Myoarthropathie"

* subject = Reference(Patient/pat-gkv-01)

* recordedDate = "2026-02-20"
