Profile: DentalFindingDE
Parent: Observation
Id: dental-finding
Title: "Zahnärztlicher Befund (DE)"
Description: """
Profil für beobachtete zahnärztliche Einzelbefunde, zum Beispiel Zahnschema-Einträge,
Parodontalindices, Vitalitätsprüfungen und Mundschleimhautbefunde. DentalFindingDE ist
der kanonische Träger für beobachtete Zahn- und Flächendetails. Eine bestätigte
Diagnose wird separat als DentalConditionDE abgebildet und referenziert den
zugrunde liegenden Befund bei Bedarf über evidence.detail.
"""
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Category: dental
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"

// Code: curated public SNOMED CT pick list; the extensible strength permits
// additional codes from the gated General Dentistry validation universe.
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
