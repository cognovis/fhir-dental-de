Profile: DentalProsthesisDE
Parent: Device
Id: dental-prosthesis
Title: "Removable Dental Prosthesis Device (DE)"
Description: "Manufacturer-neutral identity of a removable dental prosthesis that can be referenced by technical findings."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* identifier 1..* MS
* status 1..1 MS
* type 1..1 MS
* type from RemovableProsthesisTypeVS (required)
* patient 1..1 MS
* patient only Reference(Patient)
* extension contains SupportingImplantDeviceExt named supportingImplant 0..* MS
* extension[supportingImplant] ^short = "Implant supporting an implant-retained removable prosthesis"
