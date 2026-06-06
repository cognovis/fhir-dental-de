// 3-Layer-Chain: KBV → praxis-de → dental-de
//
// Layer 1 (KBV): KBV_PR_Base_Condition_Diagnosis (kbv.basis) — German base condition/diagnosis
//   constraints mandated by the KBV for GKV interoperability.
// Layer 2 (praxis-de): PraxisConditionDE (de.cognovis.fhir.praxis) — shared practice-level
//   constraints applicable across all cognovis IGs (not dental-specific).
// Layer 3 (dental-de): DentalConditionDE (this profile) — dental-specific constraints:
//   ICD-10-GM binding, FDI tooth identification, KZBV Zahnschema Befundstatus.
//
// KZBV Gap: KZBV does not publish a formal FHIR base profile for dental conditions.
//   Until KZBV publishes a canonical dental Condition profile, this profile fulfills
//   the KBV/GKV constraints through PraxisConditionDE and adds dental-domain extensions directly.
//
// Reusability: PraxisConditionDE can be extended by any cognovis IG (e.g. a future
//   praxis-intern IG or an orthodontic sub-IG) without re-implementing KBV constraints.
Profile: DentalConditionDE
Parent: PraxisConditionDE
Id: dental-condition
Title: "Zahnärztliche Diagnose (DE)"
Description: "Profil für zahnärztliche Diagnosen und Befunde. Nutzt ICD-10-GM und FDI-Zahnschema. Orientiert sich am HL7 Dental Data Exchange IG DentalCondition. Kompatibel mit KBV_PR_Base_Condition_Diagnosis."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Category: dental (zusätzlich zu encounter-diagnosis etc.)
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"

// Code: ICD-10-GM binding (extensible to allow SNOMED CT etc.)
* code 1..1 MS
* code from http://fhir.de/ValueSet/bfarm/icd-10-gm|1.5.4 (extensible)

// Subject
* subject 1..1 MS
* subject only Reference(Patient)

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
