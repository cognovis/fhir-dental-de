Instance: ExampleCariesObservation16Occlusal
InstanceOf: CariesObservationDE
Usage: #example
Title: "ICDAS Caries Observation at Tooth 16"
Description: "A distinct visual enamel change on the occlusal surface of tooth 16."
* status = #final
* code = DentalAssessmentTypeCS#icdas-caries-assessment
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-27"
* bodySite = $fdiCS#16
* bodySite.extension[surface].valueCodeableConcept = ToothSurfacesCS#O
* valueCodeableConcept = ICDASCariesScoreCS#2
