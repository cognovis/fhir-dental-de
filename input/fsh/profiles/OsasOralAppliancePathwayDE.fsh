Profile: OsasOralApplianceServiceRequestDE
Parent: ServiceRequest
Id: osas-oral-appliance-service-request
Title: "OSAS Oral Appliance Service Request (DE)"
Description: "Medical order that initiates a dental OSAS oral appliance pathway."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* identifier 1..* MS
* status 1..1 MS
* intent 1..1 MS
* code 1..1 MS
* code = SleepApplianceServiceCS#oral-appliance-therapy
* subject 1..1 MS
* subject only Reference(Patient)
* requester 1..1 MS
* reasonReference 1..* MS
* reasonReference only Reference(Condition)
* supportingInfo MS
* supportingInfo only Reference(Observation or DiagnosticReport or DocumentReference)

Profile: OsasOralApplianceDeviceDE
Parent: Device
Id: osas-oral-appliance-device
Title: "OSAS Oral Appliance Device (DE)"
Description: "Manufacturer-neutral identity of a mandibular advancement oral appliance used in an OSAS pathway."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* identifier 1..* MS
* status 1..1 MS
* type 1..1 MS
* patient 1..1 MS
* patient only Reference(Patient)
* manufacturer MS
* modelNumber MS

Profile: OsasOralApplianceEligibilityObservationDE
Parent: DentalFindingDE
Id: osas-oral-appliance-eligibility-observation
Title: "OSAS Oral Appliance Eligibility Observation (DE)"
Description: "Dental eligibility disposition for an OSAS oral appliance pathway, linked to the findings that informed it."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = DentalAssessmentTypeCS#osas-oral-appliance-eligibility
* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from OsasOralApplianceEligibilityVS (required)
* hasMember 1..* MS
* hasMember only Reference(Observation)

Profile: OsasOralApplianceComplicationObservationDE
Parent: DentalFindingDE
Id: osas-oral-appliance-complication-observation
Title: "OSAS Oral Appliance Complication Observation (DE)"
Description: "Manufacturer-neutral complication observed during therapy and focused on an identified oral appliance."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = DentalAssessmentTypeCS#osas-oral-appliance-complication
* focus 1..1 MS
* focus only Reference(OsasOralApplianceDeviceDE)
* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from OsasOralApplianceComplicationVS (required)

Profile: OsasOralApplianceCarePlanDE
Parent: DentalCarePlanDE
Id: osas-oral-appliance-care-plan
Title: "OSAS Oral Appliance Care Plan (DE)"
Description: "Dental care plan for an OSAS oral appliance pathway initiated by a medical order."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* category[planType] = DentalCarePlanTypeCS#sleep-appliance
* category contains sleepPathway 1..1 MS
* category[sleepPathway] from SleepAppliancePathwayVS (required)
* category[sleepPathway] = SleepAppliancePathwayCS#osas-medical-order
* addresses 1..* MS
* addresses only Reference(Condition)

* supportingInfo 3..* MS
* supportingInfo ^slicing.discriminator.type = #type
* supportingInfo ^slicing.discriminator.path = "$this.resolve()"
* supportingInfo ^slicing.rules = #open
* supportingInfo contains
    medicalOrder 1..1 MS and
    eligibility 1..* MS and
    appliance 1..1 MS
* supportingInfo[medicalOrder] only Reference(OsasOralApplianceServiceRequestDE)
* supportingInfo[eligibility] only Reference(OsasOralApplianceEligibilityObservationDE)
* supportingInfo[appliance] only Reference(OsasOralApplianceDeviceDE)

* activity 1..* MS
* activity.detail 1..1 MS
* activity.detail.code 1..1 MS
* activity.detail.code from SleepApplianceServiceVS (required)
