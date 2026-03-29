Profile: DentalFindingDE
Parent: Observation
Id: de-mira-dental-finding
Title: "Zahnärztlicher Befund (DE)"
Description: "Profil für zahnärztliche Einzelbefunde: Zahnschema-Einträge, Parodontalindices (PSI, BOP, Sondierungstiefe), Vitalitätsprüfungen, Mundschleimhautbefunde. Entspricht dem DentalFinding (Observation) im HL7 Dental Data Exchange IG."
* ^status = #draft
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
* subject only Reference(KBV_PR_FOR_Patient)

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
