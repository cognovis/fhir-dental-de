Instance: ExampleAlignerCarePlan
InstanceOf: AlignerCarePlanDE
Usage: #example
Title: "Aligner Planning with Attachments and Interproximal Reduction"
Description: "Vendor-neutral KFO plan with FDI tooth positions and a measured reduction amount."
* identifier[0].system = "https://example-dental-practice.de/kfo-plan"
* identifier[0].value = "ALIGNER-2026-01"
* status = #active
* intent = #plan
* subject = Reference(Patient/pat-pkv-01)
* created = "2026-07-15"
* title = "Aligner care plan"
* extension[plannedAttachment][0].extension[tooth].valueCode = #13
* extension[plannedAttachment][1].extension[tooth].valueCode = #23
* extension[plannedReduction][0].extension[firstTooth].valueCode = #11
* extension[plannedReduction][0].extension[secondTooth].valueCode = #12
* extension[plannedReduction][0].extension[amount].valueQuantity = 0.3 'mm'

Instance: ExampleAlignerProgress
InstanceOf: AlignerProgressObservationDE
Usage: #example
Title: "Aligner Progress at Stage 8"
Description: "Clinical follow-up records the assessed stage and tracking deviation without vendor staging semantics."
* status = #final
* subject = Reference(Patient/pat-pkv-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-25"
* component[assessedStage].valueInteger = 8
* component[trackingOutcome].valueCodeableConcept = AlignerTrackingOutcomeCS#tracking-deviation
* basedOn = Reference(ExampleAlignerCarePlan)
