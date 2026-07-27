Extension: SupportingImplantDeviceExt
Id: supporting-implant-device
Title: "Supporting Implant Device"
Description: "Reference from an implant-supported suprastructure to one supporting dental implant Device."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/supporting-implant-device"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Device"

* value[x] only Reference(DentalImplantDE)
* value[x] ^short = "Supporting dental implant"
