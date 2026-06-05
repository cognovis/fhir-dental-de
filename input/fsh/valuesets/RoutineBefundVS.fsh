ValueSet: RoutineBefundVS
Id: routine-befund-vs
Title: "Routine Dental Finding Codes"
Description: "Combined ValueSet for routine dental findings (BEMA-01 and GOZ-0010). Includes both public (BEMA) and private (GOZ) insurance routine examination codes."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/routine-befund"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* include codes from system https://fhir.cognovis.de/dental/CodeSystem/bema-01-mindestpflicht-befund
* include codes from system https://fhir.cognovis.de/dental/CodeSystem/dental-praxis-konvention-befund
