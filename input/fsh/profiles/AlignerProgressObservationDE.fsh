Profile: AlignerProgressObservationDE
Parent: DentalFindingDE
Id: aligner-progress-observation
Title: "Aligner Progress Observation (DE)"
Description: "Clinical tracking result at one assessed aligner stage."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = AlignerProgressComponentCS#assessment
* bodySite 0..1
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component contains
    assessedStage 1..1 MS and
    trackingOutcome 1..1 MS
* component[assessedStage].code = AlignerProgressComponentCS#stage
* component[assessedStage].value[x] 1..1
* component[assessedStage].value[x] only integer
* component[assessedStage] obeys aligner-stage-positive
* component[trackingOutcome].code = AlignerProgressComponentCS#tracking-outcome
* component[trackingOutcome].value[x] 1..1
* component[trackingOutcome].value[x] only CodeableConcept
* component[trackingOutcome].valueCodeableConcept from AlignerTrackingOutcomeVS (required)

Invariant: aligner-stage-positive
Description: "The assessed aligner stage must be a positive integer."
Expression: "value.ofType(integer) > 0"
Severity: #error
