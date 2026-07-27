Instance: ExampleOsasCondition
InstanceOf: Condition
Usage: #example
Title: "Medically Assessed OSAS"
Description: "Condition referenced by the medical order and the dental care plan."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* code.text = "Obstructive sleep apnea"
* subject = Reference(Patient/pat-pkv-01)
* recordedDate = "2026-07-20"

Instance: ExampleOsasDentalFinding
InstanceOf: DentalFindingDE
Usage: #example
Title: "Dental Finding Informing OSAS Appliance Eligibility"
Description: "A dental finding referenced by the eligibility assessment."
* status = #final
* code.text = "Dental support and retention assessment"
* subject = Reference(Patient/pat-pkv-01)
* effectiveDateTime = "2026-07-22"
* valueCodeableConcept.text = "Sufficient support and retention available"

Instance: ExampleOsasOralApplianceOrder
InstanceOf: OsasOralApplianceServiceRequestDE
Usage: #example
Title: "Medical Order for OSAS Oral Appliance Therapy"
Description: "A medical order initiating the dental oral appliance pathway."
* identifier.system = "https://example-sleep-clinic.de/order"
* identifier.value = "OSAS-ORDER-2026-0042"
* status = #active
* intent = #order
* code = SleepApplianceServiceCS#oral-appliance-therapy
* subject = Reference(Patient/pat-pkv-01)
* authoredOn = "2026-07-20"
* requester = Reference(Practitioner/prac-schoell)
* reasonReference = Reference(ExampleOsasCondition)

Instance: ExampleOsasOralApplianceEligibility
InstanceOf: OsasOralApplianceEligibilityObservationDE
Usage: #example
Title: "Eligible for OSAS Oral Appliance Therapy"
Description: "Dental eligibility assessment linked to the findings that informed it."
* status = #final
* code = DentalAssessmentTypeCS#osas-oral-appliance-eligibility
* subject = Reference(Patient/pat-pkv-01)
* performer = Reference(Practitioner/prac-schoell)
* effectiveDateTime = "2026-07-22"
* valueCodeableConcept = OsasOralApplianceEligibilityCS#eligible
* hasMember = Reference(ExampleOsasDentalFinding)

Instance: ExampleOsasOralAppliance
InstanceOf: OsasOralApplianceDeviceDE
Usage: #example
Title: "OSAS Oral Appliance"
Description: "An identified manufacturer-neutral oral appliance used by the care plan and complication observation."
* identifier.system = "https://example-dental-practice.de/device"
* identifier.value = "OSAS-APPLIANCE-2026-0042"
* status = #active
* type.text = "Mandibular advancement oral appliance"
* patient = Reference(Patient/pat-pkv-01)

Instance: ExampleOsasOralApplianceCarePlan
InstanceOf: OsasOralApplianceCarePlanDE
Usage: #example
Title: "OSAS Oral Appliance Care Plan"
Description: "Care plan linking medical order, dental eligibility, appliance, and planned clinical service stages."
* identifier.system = "https://example-dental-practice.de/care-plan"
* identifier.value = "OSAS-CARE-2026-0042"
* status = #active
* intent = #plan
* category[planType] = DentalCarePlanTypeCS#sleep-appliance
* category[sleepPathway] = SleepAppliancePathwayCS#osas-medical-order
* subject = Reference(Patient/pat-pkv-01)
* created = "2026-07-22"
* addresses = Reference(ExampleOsasCondition)
* supportingInfo[medicalOrder] = Reference(ExampleOsasOralApplianceOrder)
* supportingInfo[eligibility] = Reference(ExampleOsasOralApplianceEligibility)
* supportingInfo[appliance] = Reference(ExampleOsasOralAppliance)
* activity[0].detail.status = #scheduled
* activity[0].detail.code = SleepApplianceServiceCS#initial-dental-assessment
* activity[1].detail.status = #scheduled
* activity[1].detail.code = SleepApplianceServiceCS#impression-and-registration
* activity[2].detail.status = #scheduled
* activity[2].detail.code = SleepApplianceServiceCS#appliance-insertion
* activity[3].detail.status = #scheduled
* activity[3].detail.code = SleepApplianceServiceCS#follow-up-adjustment

Instance: ExampleOsasOralApplianceComplication
InstanceOf: OsasOralApplianceComplicationObservationDE
Usage: #example
Title: "Retention Loss during OSAS Oral Appliance Therapy"
Description: "A manufacturer-neutral complication focused on the identified appliance."
* status = #final
* code = DentalAssessmentTypeCS#osas-oral-appliance-complication
* subject = Reference(Patient/pat-pkv-01)
* effectiveDateTime = "2026-08-19"
* focus = Reference(ExampleOsasOralAppliance)
* valueCodeableConcept = OsasOralApplianceComplicationCS#retention-loss
