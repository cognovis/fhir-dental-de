// Example: Kariesbefund K02.1, Zahn 46, Befundstatus "c" (kariös)
// SWS 2.0 — DentalCondition (Diagnosis)
//
// Note: InstanceOf uses base Condition to work around SUSHI snapshot resolution
// issues with KBV_PR_Base_Condition_Diagnosis code.coding slicing.
// The meta.profile assertion declares conformance to DentalConditionDE.

Instance: ExampleDentalCondition
InstanceOf: Condition
Usage: #example
Title: "Beispiel Kariesbefund Zahn 46"
Description: "Kariesdiagnose K02.1 (Karies des Dentins) an Zahn 46 (erster unterer rechter Molar), Befundstatus kariös (c). Patient Klaus Bergmann (AOK Bayern). Konform zu DentalConditionDE."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #46

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"

* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// ICD-10-GM K02.1 — Karies des Dentins
* code = $icd10gm#K02.1 "Karies des Dentins"
* code.text = "Dentinkaries, Zahn 46"

* subject = Reference(Patient/pat-gkv-01)

* onsetDateTime = "2026-01-10"
* recordedDate = "2026-01-10"

// Tooth: FDI 46 (lower-right first molar) — cognovis CodeSystem
* bodySite[0] = $fdiCS#46 "46"

// Befundstatus "c" = kariös
* stage[0].summary = https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status#c "kariös"

// Evidence: link to the PSI finding observation
* evidence[0].detail = Reference(ExampleDentalFinding)

// Surface-specific diagnosis. Surfaces are extensions of the tooth bodySite,
// never top-level Condition extensions.
Instance: ExampleDentalConditionSurfaceSpecific
InstanceOf: Condition
Usage: #example
Title: "Beispiel flächenspezifische Kariesdiagnose Zahn 36"
Description: "Bestätigte Dentinkaries an Zahn 36 mit mesialer und okklusaler Beteiligung. Konform zu DentalConditionDE."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental
* code = $icd10gm#K02.1
* subject = Reference(Patient/pat-gkv-01)
* recordedDate = "2026-07-26"
* bodySite[0] = $fdiCS#36
* bodySite[0].extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces"
* bodySite[0].extension[0].valueCodeableConcept = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces#M
* bodySite[0].extension[1].url = "https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces"
* bodySite[0].extension[1].valueCodeableConcept = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces#O
