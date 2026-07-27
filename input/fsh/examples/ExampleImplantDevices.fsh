Instance: ExampleDentalImplant36
InstanceOf: DentalImplantDE
Usage: #example
Title: "Dental Implant at FDI Position 36"
Description: "Manufacturer-neutral dental implant identity used by findings and a suprastructure."
* identifier[0].system = "https://example-dental-practice.de/device"
* identifier[0].value = "IMPLANT-36-2024"
* status = #active
* type.text = "Endosseous dental implant"
* manufacturer = "Example manufacturer"
* modelNumber = "IMPLANT-MODEL-A"
* patient = Reference(Patient/pat-beihilfe-01)
* extension[fdiPosition].valueCode = #36
* property[diameter].valueQuantity = 4.1 'mm'
* property[length].valueQuantity = 10 'mm'

Instance: ExampleDentalImplant37
InstanceOf: DentalImplantDE
Usage: #example
Title: "Dental Implant at FDI Position 37"
Description: "Second manufacturer-neutral implant supporting the same bridge."
* identifier[0].system = "https://example-dental-practice.de/device"
* identifier[0].value = "IMPLANT-37-2024"
* status = #active
* type.text = "Endosseous dental implant"
* manufacturer = "Example manufacturer"
* modelNumber = "IMPLANT-MODEL-A"
* patient = Reference(Patient/pat-beihilfe-01)
* extension[fdiPosition].valueCode = #37
* property[diameter].valueQuantity = 4.1 'mm'
* property[length].valueQuantity = 10 'mm'

Instance: ExampleImplantCrown36
InstanceOf: ImplantSuprastructureDE
Usage: #example
Title: "Implant-Supported Crown at Position 36"
Description: "A single crown Device with its own identity and one supporting implant reference."
* identifier[0].system = "https://example-dental-practice.de/device"
* identifier[0].value = "SUPRA-CROWN-36-2024"
* status = #active
* type.text = "Implant-supported dental crown"
* patient = Reference(Patient/pat-beihilfe-01)
* extension[fdiPosition].valueCode = #36
* extension[supportingImplant].valueReference = Reference(ExampleDentalImplant36)

Instance: ExampleImplantBridge36To37
InstanceOf: ImplantSuprastructureDE
Usage: #example
Title: "Implant-Supported Bridge at Positions 36 and 37"
Description: "A bridge Device that references both supporting implant identities."
* identifier[0].system = "https://example-dental-practice.de/device"
* identifier[0].value = "SUPRA-36-37-2024"
* status = #active
* type.text = "Implant-supported dental bridge"
* patient = Reference(Patient/pat-beihilfe-01)
* extension[fdiPosition][0].valueCode = #36
* extension[fdiPosition][1].valueCode = #37
* extension[supportingImplant][0].valueReference = Reference(ExampleDentalImplant36)
* extension[supportingImplant][1].valueReference = Reference(ExampleDentalImplant37)
