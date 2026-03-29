// Example: Kariesbefund K02.1, Zahn 46, Befundstatus "c" (kariös)
// SWS 2.0 — DentalCondition (Diagnosis)
//
// Note: InstanceOf uses base Condition to work around SUSHI snapshot resolution
// issues with KBV_PR_Base_Condition_Diagnosis code.coding slicing.
// The meta.profile assertion declares conformance to DentalConditionDE.

Alias: $icd10gm = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $fdi     = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $sct     = http://snomed.info/sct

Instance: ExampleDentalCondition
InstanceOf: Condition
Usage: #example
Title: "Beispiel Kariesbefund Zahn 46"
Description: "Kariesdiagnose K02.1 (Karies des Dentins) an Zahn 46 (erster unterer rechter Molar), Befundstatus kariös (c). Konform zu DentalConditionDE."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/de-mira-dental-condition"

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #46

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"

* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// ICD-10-GM K02.1 — Karies des Dentins
* code = $icd10gm#K02.1 "Karies des Dentins"
* code.text = "Dentinkaries, Zahn 46"

* subject = Reference(ExamplePatient)

* onsetDateTime = "2026-01-15"
* recordedDate = "2026-01-15"

// Tooth: FDI 46 (lower-right first molar)
* bodySite[0] = $fdi#46 "46"

// Befundstatus "c" = kariös
* stage[0].summary = https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status#c "kariös"

// Evidence: link to the PSI finding observation
* evidence[0].detail = Reference(ExampleDentalFinding)
