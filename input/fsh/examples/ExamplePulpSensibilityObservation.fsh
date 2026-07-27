Instance: ExamplePulpSensibilityObservation36
InstanceOf: PulpSensibilityObservationDE
Usage: #example
Title: "Pulp Sensibility Observation at Tooth 36"
Description: "Cold testing produced a lingering response and electric testing produced a qualitative response."
* status = #final
* code = DentalAssessmentTypeCS#pulp-sensibility-assessment
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-27"
* bodySite = $fdiCS#36
* component[coldTest].valueCodeableConcept = PulpSensibilityResponseCS#lingering-response
* component[electricPulpTest].valueCodeableConcept = PulpSensibilityResponseCS#normal-response
