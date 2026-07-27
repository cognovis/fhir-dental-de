Instance: ExamplePeriodontalLaserDevice
InstanceOf: Device
Usage: #example
Title: "Periodontal Laser Device"
Description: "Manufacturer-neutral laser Device referenced by adjunctive procedures."
* identifier[0].system = "https://example-dental-practice.de/device"
* identifier[0].value = "LASER-2026-01"
* status = #active
* type.text = "Dental laser device"

Instance: ExamplePeriodontalPhotosensitizer
InstanceOf: Substance
Usage: #example
Title: "Locally Applied Photosensitizing Substance"
Description: "Substance identity used in the aPDT example without a proprietary product catalog."
* status = #active
* code.text = "Photosensitizing substance for local periodontal application"

Instance: ExampleDirectLaserProcedure
InstanceOf: PeriodontalAdjunctiveProcedureDE
Usage: #example
Title: "Direct Periodontal Laser Procedure"
Description: "Device-only procedure graph for direct laser therapy."
* status = #completed
* code = PeriodontalAdjunctiveProcedureTypeCS#direct-laser
* subject = Reference(Patient/pat-beihilfe-01)
* performedDateTime = "2026-07-22T10:00:00+02:00"
* bodySite = $fdiCS#36
* basedOn = Reference(ExampleParCarePlan)
* reasonReference = Reference(ExampleParodontitisCondition)
* usedReference = Reference(ExamplePeriodontalLaserDevice)

Instance: ExampleApdtProcedure
InstanceOf: PeriodontalAdjunctiveProcedureDE
Usage: #example
Title: "Antimicrobial Photodynamic Periodontal Procedure"
Description: "aPDT procedure graph references both the laser Device and locally applied Substance."
* status = #completed
* code = PeriodontalAdjunctiveProcedureTypeCS#apdt
* subject = Reference(Patient/pat-beihilfe-01)
* performedDateTime = "2026-07-22T10:30:00+02:00"
* bodySite = $fdiCS#37
* basedOn = Reference(ExampleParCarePlan)
* reasonReference = Reference(ExampleParodontitisCondition)
* usedReference[0] = Reference(ExamplePeriodontalLaserDevice)
* usedReference[1] = Reference(ExamplePeriodontalPhotosensitizer)
