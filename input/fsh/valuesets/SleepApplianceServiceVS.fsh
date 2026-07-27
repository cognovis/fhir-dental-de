ValueSet: SleepApplianceServiceVS
Id: sleep-appliance-service
Title: "Sleep Appliance Service Stage"
Description: "Dental service stages used as CarePlan activities in an OSAS oral appliance pathway."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/sleep-appliance-service"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* SleepApplianceServiceCS#initial-dental-assessment
* SleepApplianceServiceCS#impression-and-registration
* SleepApplianceServiceCS#appliance-insertion
* SleepApplianceServiceCS#follow-up-adjustment
* SleepApplianceServiceCS#additional-adjustment
* SleepApplianceServiceCS#completion-review
