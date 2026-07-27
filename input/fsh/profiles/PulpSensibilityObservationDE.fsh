Invariant: fdde-pulp-1
Description: "A quantitative electric pulp test result requires a referenced test device."
Expression: "component.where(code.coding.where(system = 'https://fhir.cognovis.de/dental/CodeSystem/pulp-sensibility-component' and code = 'electric-pulp-test').exists() and value is Quantity).empty() or device.exists()"
Severity: #error

Profile: PulpSensibilityObservationDE
Parent: DentalFindingDE
Id: pulp-sensibility-observation
Title: "Pulp Sensibility Observation (DE)"
Description: "Tooth-specific thermal and electric pulp sensibility results. This profile does not assert pulpal blood flow or periapical status."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = DentalAssessmentTypeCS#pulp-sensibility-assessment
* bodySite 1..1 MS
* value[x] 0..0
* device MS
* device only Reference(Device)

* component 1..3 MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #closed
* component ^slicing.ordered = false
* component contains
    coldTest 0..1 MS and
    heatTest 0..1 MS and
    electricPulpTest 0..1 MS

* component[coldTest].code = PulpSensibilityComponentCS#cold-test
* component[coldTest].value[x] 1..1 MS
* component[coldTest].value[x] only CodeableConcept
* component[coldTest].valueCodeableConcept from PulpSensibilityResponseVS (required)

* component[heatTest].code = PulpSensibilityComponentCS#heat-test
* component[heatTest].value[x] 1..1 MS
* component[heatTest].value[x] only CodeableConcept
* component[heatTest].valueCodeableConcept from PulpSensibilityResponseVS (required)

* component[electricPulpTest].code = PulpSensibilityComponentCS#electric-pulp-test
* component[electricPulpTest].value[x] 1..1 MS
* component[electricPulpTest].value[x] only CodeableConcept or Quantity
* component[electricPulpTest].valueCodeableConcept from PulpSensibilityResponseVS (required)
* obeys fdde-pulp-1
