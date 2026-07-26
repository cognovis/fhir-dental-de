Profile: DentalDepositObservationDE
Parent: DentalFindingDE
Id: dental-deposit-observation
Title: "Dental Deposit Observation (DE)"
Description: "A vendor-neutral clinical deposit finding with explicit type, vertical location, affected surface, and body site."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code from DentalDepositTypeVS (required)
* value[x] 0..0
* bodySite 1..1 MS
* extension contains
    DentalDepositVerticalLocationExt named verticalLocation 1..1 MS and
    DentalDepositSurfaceExt named depositSurface 1..1 MS

* performer MS
* performer only Reference(Practitioner or PractitionerRole or Organization)
