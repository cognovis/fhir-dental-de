Profile: ImplantSuprastructureDE
Parent: Device
Id: implant-suprastructure
Title: "Implant Suprastructure Device (DE)"
Description: "Manufacturer-neutral identity for an implant-supported crown, bridge, or prosthetic suprastructure."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* identifier 1..* MS
* status 1..1 MS
* type 1..1 MS
* patient 1..1 MS
* patient only Reference(Patient)
* extension contains
    FdiToothNumberExt named fdiPosition 1..* MS and
    SupportingImplantDeviceExt named supportingImplant 1..* MS
* extension[fdiPosition] ^short = "FDI position covered by the suprastructure"
* extension[supportingImplant] ^short = "Implant supporting this suprastructure"
