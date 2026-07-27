Instance: ExamplePrimarySnoringCondition
InstanceOf: Condition
Usage: #example
Title: "Primary Snoring Indication"
Description: "Clinical indication without inferring that screening alone excludes OSAS."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#provisional
* code.text = "Primary snoring"
* subject = Reference(Patient/pat-pkv-01)
* recordedDate = "2026-07-14"

Instance: ExampleSleepAssessmentReport
InstanceOf: DiagnosticReport
Usage: #example
Title: "Available Sleep-Medicine Assessment"
Description: "Referenced evidence supplied by the sleep-medicine pathway; it is not interpreted as an automatic OSAS exclusion."
* status = #final
* code.text = "Sleep-medicine assessment report"
* subject = Reference(Patient/pat-pkv-01)
* effectiveDateTime = "2026-07-10"
* issued = "2026-07-11T09:00:00+02:00"
* conclusion = "Assessment evidence available for clinical review."

Instance: ExamplePrimarySnoringAppliance
InstanceOf: Device
Usage: #example
Title: "Oral Appliance for Primary Snoring"
Description: "Manufacturer-neutral oral-appliance identity."
* identifier[0].system = "https://example-dental-practice.de/device"
* identifier[0].value = "SLEEP-APPLIANCE-2026-01"
* status = #active
* type.text = "Mandibular advancement oral appliance"
* patient = Reference(Patient/pat-pkv-01)

Instance: ExamplePrimarySnoringDisclosure
InstanceOf: DocumentReference
Usage: #example
Title: "Primary Snoring Disclosure Documentation"
Description: "Documentation reference for recorded consent or disclosure evidence without a local legal-compliance verdict."
* status = #current
* type.text = "Consent and disclosure documentation"
* subject = Reference(Patient/pat-pkv-01)
* date = "2026-07-14T11:00:00+02:00"
* content[0].attachment.contentType = #application/pdf
* content[0].attachment.url = "https://example-dental-practice.de/documents/snoring-disclosure-2026-01"

Instance: ExamplePrimarySnoringCarePlan
InstanceOf: PrimarySnoringCarePlanDE
Usage: #example
Title: "Primary Snoring Oral-Appliance Plan"
Description: "Complete clinical graph linking indication, available sleep evidence, appliance, and documentation."
* identifier[0].system = "https://example-dental-practice.de/care-plan"
* identifier[0].value = "SNORING-2026-01"
* status = #active
* intent = #plan
* category[planType] = DentalCarePlanTypeCS#kgl
* category[sleepPathway] = SleepAppliancePathwayCS#primary-snoring
* subject = Reference(Patient/pat-pkv-01)
* created = "2026-07-14"
* addresses = Reference(ExamplePrimarySnoringCondition)
* supportingInfo[0] = Reference(ExampleSleepAssessmentReport)
* supportingInfo[1] = Reference(ExamplePrimarySnoringDisclosure)
* supportingInfo[2] = Reference(ExamplePrimarySnoringAppliance)
* activity[0].detail.status = #scheduled
* activity[0].detail.description = "Supply and clinically review the oral appliance."
