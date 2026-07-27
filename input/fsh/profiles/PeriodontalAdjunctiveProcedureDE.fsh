Profile: PeriodontalAdjunctiveProcedureDE
Parent: DentalProcedureDE
Id: periodontal-adjunctive-procedure
Title: "Periodontal Adjunctive Procedure (DE)"
Description: "Focused procedure record for direct laser therapy, aPDT, aPTT, or local subgingival antimicrobial application."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code from PeriodontalAdjunctiveProcedureTypeVS (extensible)
* basedOn 0..* MS
* basedOn only Reference(CarePlan or ServiceRequest)
* reasonReference 0..* MS
* reasonReference only Reference(Condition or Observation)
* usedReference 1..* MS
* usedReference only Reference(Device or Medication or Substance)
* usedReference ^short = "Laser Device and any locally applied Medication or Substance"
