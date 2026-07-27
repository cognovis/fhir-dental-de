Profile: DentalImplantDE
Parent: Device
Id: dental-implant
Title: "Dental Implant Device (DE)"
Description: "Manufacturer-neutral identity for a dental implant at one FDI position. Product details remain ordinary Device properties."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* identifier 1..* MS
* status 1..1 MS
* type 1..1 MS
* patient 0..1 MS
* patient only Reference(Patient)
* extension contains FdiToothNumberExt named fdiPosition 1..1 MS
* extension[fdiPosition] ^short = "FDI position occupied by the implant"

* property ^slicing.discriminator.type = #pattern
* property ^slicing.discriminator.path = "type"
* property ^slicing.rules = #open
* property contains
    diameter 0..1 MS and
    length 0..1 MS
* property[diameter].type = DentalImplantPropertyCS#diameter
* property[diameter].valueQuantity 1..1
* property[diameter].valueQuantity.system = "http://unitsofmeasure.org"
* property[diameter].valueQuantity.code = #mm
* property[diameter].valueCode 0..0
* property[length].type = DentalImplantPropertyCS#length
* property[length].valueQuantity 1..1
* property[length].valueQuantity.system = "http://unitsofmeasure.org"
* property[length].valueQuantity.code = #mm
* property[length].valueCode 0..0
