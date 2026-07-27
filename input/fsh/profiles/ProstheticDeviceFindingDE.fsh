Profile: ProstheticDeviceFindingDE
Parent: DentalFindingDE
Id: prosthetic-device-finding
Title: "Prosthetic Device Finding (DE)"
Description: "A technical finding focused on an identified removable prosthesis or implant suprastructure Device."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = DentalAssessmentTypeCS#prosthetic-device-finding
* focus 1..1 MS
* focus only Reference(Device)
* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from ProstheticDeviceFindingVS (required)
* bodySite 0..1 MS
* component 0..0

Profile: ProsthesisFindingDE
Parent: ProstheticDeviceFindingDE
Id: prosthesis-finding
Title: "Removable Prosthesis Finding (DE)"
Description: "A technical finding focused on an identified removable dental prosthesis."
* focus only Reference(DentalProsthesisDE)
* valueCodeableConcept from ProsthesisFindingVS (required)

Profile: SuprastructureFindingDE
Parent: ProstheticDeviceFindingDE
Id: suprastructure-finding
Title: "Implant Suprastructure Finding (DE)"
Description: "A technical finding focused on an identified implant suprastructure."
* focus only Reference(ImplantSuprastructureDE)
* valueCodeableConcept from SuprastructureFindingVS (required)
