Instance: ExampleAvulsionObservation11
InstanceOf: TraumaObservationDE
Usage: #example
Title: "Avulsion of Tooth 11"
Description: "ICD-11 NA0D avulsion finding at the injury occurrence time."
* status = #final
* subject = Reference(Patient/pat-gkv-dental-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-18T16:20:00+02:00"
* issued = "2026-07-18T17:05:00+02:00"
* bodySite = $fdiCS#11
* valueCodeableConcept = $icd11Mms#NA0D.15 "Avulsion of tooth"

Instance: ExampleAvulsionReplantation11
InstanceOf: DentalProcedureDE
Usage: #example
Title: "Replantation after Avulsion of Tooth 11"
Description: "Treatment is represented separately from the trauma classification."
* status = #completed
* code.text = "Replantation and splinting of avulsed tooth"
* subject = Reference(Patient/pat-gkv-dental-01)
* performedDateTime = "2026-07-18T17:20:00+02:00"
* bodySite = $fdiCS#11
* reasonReference = Reference(ExampleAvulsionObservation11)

Instance: ExampleAvulsionDiagnosis11
InstanceOf: DentalConditionDE
Usage: #example
Title: "Confirmed Avulsion Diagnosis for Tooth 11"
Description: "The diagnosis references the trauma observation as evidence."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* code = $icd11Mms#NA0D.15 "Avulsion of tooth"
* subject = Reference(Patient/pat-gkv-dental-01)
* bodySite = $fdiCS#11
* recordedDate = "2026-07-18"
* evidence[0].detail = Reference(ExampleAvulsionObservation11)

Instance: ExampleCombinedRootFracture21
InstanceOf: TraumaObservationDE
Usage: #example
Title: "Root Fracture of Tooth 21"
Description: "First of two separate injuries for tooth 21 at the same event time."
* status = #final
* subject = Reference(Patient/pat-gkv-dental-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-19T09:10:00+02:00"
* issued = "2026-07-19T09:45:00+02:00"
* bodySite = $fdiCS#21
* valueCodeableConcept = $icd11Mms#NA0D.06 "Root fracture"

Instance: ExampleCombinedLateralLuxation21
InstanceOf: TraumaObservationDE
Usage: #example
Title: "Lateral Luxation of Tooth 21"
Description: "Second injury for tooth 21, sharing the same event time without combining classifications in one CodeableConcept."
* status = #final
* subject = Reference(Patient/pat-gkv-dental-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-19T09:10:00+02:00"
* issued = "2026-07-19T09:45:00+02:00"
* bodySite = $fdiCS#21
* valueCodeableConcept = $icd11Mms#NA0D.13 "Lateral luxation of tooth"

Instance: ExampleCombinedDentalTraumaBundle
InstanceOf: Bundle
Usage: #example
Title: "Combined Dental Trauma Event"
Description: "Collection of two independently classified injuries for one tooth and event time."
* type = #collection
* timestamp = "2026-07-19T09:45:00+02:00"
* entry[0].fullUrl = "https://example-dental-practice.de/fhir/Observation/ExampleCombinedRootFracture21"
* entry[0].resource = ExampleCombinedRootFracture21
* entry[1].fullUrl = "https://example-dental-practice.de/fhir/Observation/ExampleCombinedLateralLuxation21"
* entry[1].resource = ExampleCombinedLateralLuxation21
