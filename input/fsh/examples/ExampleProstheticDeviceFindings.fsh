Instance: ExampleRemovableProsthesis
InstanceOf: DentalProsthesisDE
Usage: #example
Title: "Removable Partial Prosthesis"
Description: "An identified removable partial prosthesis used as the focus of a technical finding."
* identifier.system = "https://example-dental-practice.de/device"
* identifier.value = "PROSTHESIS-2024-017"
* status = #active
* type = RestorationTypeCS#teilprothese
* patient = Reference(Patient/pat-beihilfe-01)

Instance: ExampleProsthesisBaseFracture
InstanceOf: ProsthesisFindingDE
Usage: #example
Title: "Prosthesis Base Fracture"
Description: "A base fracture documented against the identified removable prosthesis."
* status = #final
* code = DentalAssessmentTypeCS#prosthetic-device-finding
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-27"
* focus = Reference(ExampleRemovableProsthesis)
* valueCodeableConcept = ProstheticDeviceFindingCS#base-fracture

Instance: ExampleSuprastructureScrewLoosening
InstanceOf: SuprastructureFindingDE
Usage: #example
Title: "Suprastructure Screw Loosening"
Description: "A loose screw documented against an identified implant-supported crown."
* status = #final
* code = DentalAssessmentTypeCS#prosthetic-device-finding
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-27"
* focus = Reference(ExampleImplantCrown36)
* bodySite = $fdiCS#36
* valueCodeableConcept = ProstheticDeviceFindingCS#screw-loosening
