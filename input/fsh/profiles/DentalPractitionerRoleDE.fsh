// Dental PractitionerRole — specialty via SNOMED CT (no KZBV BAR2 equivalent for dental).
// Analogous to human/practice KBV BAR2-WBO on PractitionerRole.specialty.
Profile: DentalPractitionerRoleDE
Parent: KBV_PR_Base_PractitionerRole
Id: dental-practitioner-role
Title: "Dental PractitionerRole (DE)"
Description: """PractitionerRole for dental practitioners at a practice site.
Binds specialty to DentalPractitionerSpecialtyVS (SNOMED CT). Dental has no KZBV equivalent to KBV BAR2-WBO; do not introduce a local dental specialty CodeSystem while SNOMED CT covers the concepts."""
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* practitioner MS
* practitioner only Reference(DentalPractitionerDE)
* practitioner ^short = "Dental practitioner (ZANR)"

* organization MS
* organization only Reference(DentalOrganizationDE)
* organization ^short = "Dental practice / organization"

* specialty 1..* MS
* specialty from DentalPractitionerSpecialtyVS (required)
* specialty ^short = "Dental specialty (SNOMED CT)"
* specialty ^definition = "Dental specialty coded with SNOMED CT via DentalPractitionerSpecialtyVS. Runtime displays are supplied by de.cognovis.terminology.dental.snomed; public IG artifacts remain display-neutral."
