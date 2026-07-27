Profile: PrimarySnoringCarePlanDE
Parent: DentalCarePlanDE
Id: primary-snoring-care-plan
Title: "Primary Snoring Oral-Appliance Care Plan (DE)"
Description: "Clinical oral-appliance plan for primary snoring, explicitly distinct from medically diagnosed or ordered OSAS care."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* category[planType] = DentalCarePlanTypeCS#sleep-appliance
* category contains sleepPathway 1..1 MS
* category[sleepPathway] from SleepAppliancePathwayVS (required)
* category[sleepPathway] = SleepAppliancePathwayCS#primary-snoring
* category[sleepPathway].coding.system ^fixedUri = "https://fhir.cognovis.de/dental/CodeSystem/sleep-appliance-pathway"
* addresses 1..1 MS
* addresses only Reference(Condition)
* supportingInfo 1..* MS
* supportingInfo only Reference(Observation or DiagnosticReport or ServiceRequest or DocumentReference or Consent or Device)
* activity 1..* MS
* activity.detail 1..1 MS
