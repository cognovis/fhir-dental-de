Profile: CariesObservationDE
Parent: DentalFindingDE
Id: caries-observation
Title: "ICDAS Caries Observation (DE)"
Description: "Surface-specific visual caries assessment using an ICDAS II coronal lesion score from 0 through 6."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = DentalAssessmentTypeCS#icdas-caries-assessment
* bodySite 1..1 MS
* bodySite.extension contains ToothSurfacesExt named surface 0..* MS
* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from ICDASCariesScoreVS (required)
* component 0..0
