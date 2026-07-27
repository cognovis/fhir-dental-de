Profile: TraumaObservationDE
Parent: DentalFindingDE
Id: trauma-observation
Title: "Dental Trauma Observation (DE)"
Description: "One ICD-11 NA0D injury classification for one tooth and one injury occurrence time."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = DentalTraumaFindingCS#injury-classification
* bodySite 1..1 MS
* effective[x] only dateTime
* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from $icd11Na0dTraumaVS (required)
