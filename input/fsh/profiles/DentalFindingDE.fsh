Profile: DentalFindingDE
Parent: Observation
Id: dental-finding
Title: "Zahnärztlicher Befund (DE)"
Description: "Base profile for dental findings (Observation). Covers tooth chart entries and serves as the parent for specialized finding profiles. Implemented specializations: periodontal indices (PSI, BOP, probing depth) via PeriodontalObservationDE, prophylaxis scores (API, QHI, gingivitis index) via ProphylaxisObservationDE. Not yet specialized: vitality testing, oral mucosal findings (planned as separate sister profiles). Corresponds to DentalFinding (Observation) in the HL7 Dental Data Exchange IG."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Category: dental
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"

// Code: what kind of finding (LOINC or SNOMED-CT)
* code 1..1 MS
* code from DentalFindingCodesVS (extensible)

// Subject
* subject 1..1 MS
* subject only Reference(Patient)

// Timing
* effective[x] 1..1 MS

// Value: the finding result
* value[x] MS

// Tooth/site identification
* bodySite MS
* bodySite from ToothIdentificationFDI_VS (preferred)

// Components for multi-value findings (e.g., 6 probing depths per tooth)
* component MS
* component.code MS
* component.value[x] MS
