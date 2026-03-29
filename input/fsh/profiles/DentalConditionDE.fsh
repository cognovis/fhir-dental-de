Profile: DentalConditionDE
Parent: KBV_PR_Base_Condition_Diagnosis
Id: de-mira-dental-condition
Title: "Zahnärztliche Diagnose (DE)"
Description: "Profil für zahnärztliche Diagnosen und Befunde. Nutzt ICD-10-GM und FDI-Zahnschema. Orientiert sich am HL7 Dental Data Exchange IG DentalCondition."
* ^status = #draft
* ^publisher = "cognovis GmbH"

// Category: dental (zusätzlich zu encounter-diagnosis etc.)
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"

// Code: ICD-10-GM für Diagnosen (K00-K14 primär)
* code 1..1 MS
* code from http://fhir.de/ValueSet/bfarm/icd-10-gm (extensible)

// Subject
* subject 1..1 MS
* subject only Reference(KBV_PR_FOR_Patient)

// Tooth identification
* bodySite MS
* bodySite from ToothIdentificationFDI_VS (preferred)

// Befundstatus (f/z/c/k/b/i etc.)
* stage MS
* stage.summary from DentalBefundStatusVS (preferred)
* stage.summary ^short = "Befundstatus nach KZBV-Zahnschema (f, z, c, k, b, i, etc.)"

// Evidence: link to DentalFinding observations
* evidence MS
* evidence.detail only Reference(Observation)
