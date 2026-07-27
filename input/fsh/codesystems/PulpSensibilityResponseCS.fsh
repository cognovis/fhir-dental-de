CodeSystem: PulpSensibilityResponseCS
Id: pulp-sensibility-response
Title: "Pulp Sensibility Response"
Description: "Coded qualitative responses to pulp sensibility tests."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/pulp-sensibility-response"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

* #no-response "No response" "No sensory response was elicited."
* #normal-response "Normal response" "A response within the expected range was elicited."
* #heightened-response "Heightened response" "A stronger than expected response was elicited without a lingering response."
* #lingering-response "Lingering response" "The response persisted after removal of the stimulus."
* #inconclusive "Inconclusive" "The test did not produce an interpretable result."
