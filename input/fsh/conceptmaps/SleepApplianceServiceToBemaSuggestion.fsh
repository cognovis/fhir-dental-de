Instance: SleepApplianceServiceToBemaSuggestion
InstanceOf: ConceptMap
Usage: #definition
Title: "Sleep Appliance Service to BEMA Suggestion"
Description: "Non-authoritative candidate mapping from oral-appliance service stages to BEMA positions. The performed service and current billing rules remain decisive."
* name = "SleepApplianceServiceToBemaSuggestion"
* id = "sleep-appliance-service-to-bema-suggestion"
* url = "https://fhir.cognovis.de/dental/ConceptMap/sleep-appliance-service-to-bema-suggestion"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* sourceCanonical = "https://fhir.cognovis.de/dental/ValueSet/sleep-appliance-service"
* targetUri = "http://fhir.de/CodeSystem/kzbv/bema"
* group.source = "https://fhir.cognovis.de/dental/CodeSystem/sleep-appliance-service"
* group.target = "http://fhir.de/CodeSystem/kzbv/bema"
* group.element[0].code = #initial-dental-assessment
* group.element[0].target.code = #UP1
* group.element[0].target.equivalence = #relatedto
* group.element[1].code = #impression-and-registration
* group.element[1].target.code = #UP2
* group.element[1].target.equivalence = #relatedto
* group.element[2].code = #appliance-insertion
* group.element[2].target.code = #UP3
* group.element[2].target.equivalence = #relatedto
* group.element[3].code = #follow-up-adjustment
* group.element[3].target.code = #UP4
* group.element[3].target.equivalence = #relatedto
* group.element[4].code = #additional-adjustment
* group.element[4].target.code = #UP5
* group.element[4].target.equivalence = #relatedto
* group.element[5].code = #completion-review
* group.element[5].target.code = #UP6
* group.element[5].target.equivalence = #relatedto
