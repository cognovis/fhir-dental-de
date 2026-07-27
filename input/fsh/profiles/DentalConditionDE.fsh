// Dental conditions inherit directly from the KBV diagnosis base.
//
// Layer 1 (KBV): KBV_PR_Base_Condition_Diagnosis (kbv.basis) provides the
//   German diagnosis constraints mandated for GKV interoperability.
// Layer 2 (dental-de): DentalConditionDE adds dental-domain constraints:
//   ICD-10-GM binding and FDI tooth identification.
//
// KZBV Gap: KZBV does not publish a formal FHIR base profile for dental conditions.
//   Until KZBV publishes a canonical dental Condition profile, this profile uses
//   the KBV diagnosis base directly and keeps only dental-specific constraints here.
Profile: DentalConditionDE
Parent: KBV_PR_Base_Condition_Diagnosis
Id: dental-condition
Title: "Zahnärztliche Diagnose (DE)"
Description: """
Profil für echte zahnärztliche Diagnosen. Es nutzt ICD-10-GM und die FDI-Zahnidentifikation
und basiert direkt auf KBV_PR_Base_Condition_Diagnosis. Beobachtete Rohbefunde,
Odontogrammzustände und Restaurationsdetails werden als DentalFindingDE abgebildet.
Flächen dürfen an einer Condition nur dann angegeben werden, wenn sie Bestandteil
einer bestätigten flächenspezifischen Diagnose sind; sie stehen ausschließlich als
ToothSurfacesExt am zugehörigen bodySite.
"""
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Lifecycle elements remain optional because producers must not invent values
// that are absent from the source. Inherited cardinalities, bindings, and
// Condition invariants (including con-5 for entered-in-error) remain unchanged.
* clinicalStatus MS
* clinicalStatus ^definition = "Klinischer Status der Diagnose, sofern im Quellsystem vorhanden. Bei verificationStatus = entered-in-error muss clinicalStatus gemäß der geerbten FHIR-Invariante con-5 fehlen."
* verificationStatus MS
* verificationStatus ^definition = "Verifikationsstatus der Diagnose, sofern im Quellsystem vorhanden. Ein fehlender Quellwert darf nicht synthetisiert werden."
* encounter MS
* encounter ^definition = "Behandlungskontakt, in dessen Kontext die Diagnose festgestellt wurde, sofern die Quelle diesen Zusammenhang führt. Für longitudinale Diagnosen darf encounter fehlen."

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
* bodySite.extension contains ToothSurfacesExt named toothSurfaces 0..* MS
* bodySite.extension[toothSurfaces] ^short = "Diagnostisch betroffene Zahnfläche"
* bodySite.extension[toothSurfaces] ^definition = "Optionale Fläche einer echten flächenspezifischen Diagnose. Beobachtete Flächendetails ohne Diagnosestatus gehören in DentalFindingDE."

// Diagnosis staging remains available for actual disease stages. Tooth-chart
// status is an observed finding and belongs in DentalFindingDE.
* stage MS
* stage ^short = "Clinical stage of the diagnosed disease, when applicable"

// Authorship is optional but auditable when present. Asserter identifies the
// diagnosing dental professional; recorder identifies the person who entered
// the record. Qualification cannot be proven by isolated Condition validation.
* asserter MS
* asserter only Reference(DentalPractitionerDE or DentalPractitionerRoleDE)
* asserter ^short = "Diagnoseverantwortliche zahnärztliche Person"
* asserter ^definition = "Person oder Rolle, die die Diagnose fachlich feststellt. Die zahnärztliche Qualifikation muss über aufgelöste Referenzen oder Anwendungs- beziehungsweise Serverrichtlinien geprüft werden; die isolierte Condition-Validierung garantiert sie nicht."
* recorder MS
* recorder only Reference(Practitioner or PractitionerRole)
* recorder ^short = "Dokumentierende Person oder Rolle"
* recorder ^definition = "Person oder Rolle, die den Datensatz erfasst. recorder ist semantisch von asserter zu unterscheiden und darf fehlen, wenn die Quelle keine dokumentierende Person führt."

// Evidence: link to DentalFinding observations
* evidence MS
* evidence.detail only Reference(Observation)
