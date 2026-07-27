Alias: $loinc = http://loinc.org
Alias: $fdiCS = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $periodontalSite = https://fhir.cognovis.de/dental/CodeSystem/periodontal-measurement-site

Instance: ExamplePeriodontalObservationReordered
InstanceOf: PeriodontalObservationDE
Usage: #example
Title: "Reordered Six-Site Periodontal Observation"
Description: "Six probing-depth components in a deliberately non-anatomical array order. Site extensions preserve their meaning."

* status = #final
* code = $loinc#8704-9
* subject = Reference(Patient/pat-beihilfe-01)
* effectiveDateTime = "2026-02-05T22:20:00+01:00"
* bodySite = $fdiCS#16

* component[probingDepth][0].code = $loinc#32910-2
* component[probingDepth][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#distolingual
* component[probingDepth][0].valueQuantity = 4 'mm'

* component[probingDepth][1].code = $loinc#32910-2
* component[probingDepth][1].extension[measurementSite].valueCodeableConcept = $periodontalSite#mesiobuccal
* component[probingDepth][1].valueQuantity = 5 'mm'

* component[probingDepth][2].code = $loinc#32910-2
* component[probingDepth][2].extension[measurementSite].valueCodeableConcept = $periodontalSite#lingual
* component[probingDepth][2].valueQuantity = 3 'mm'

* component[probingDepth][3].code = $loinc#32910-2
* component[probingDepth][3].extension[measurementSite].valueCodeableConcept = $periodontalSite#distobuccal
* component[probingDepth][3].valueQuantity = 5 'mm'

* component[probingDepth][4].code = $loinc#32910-2
* component[probingDepth][4].extension[measurementSite].valueCodeableConcept = $periodontalSite#mesiolingual
* component[probingDepth][4].valueQuantity = 4 'mm'

* component[probingDepth][5].code = $loinc#32910-2
* component[probingDepth][5].extension[measurementSite].valueCodeableConcept = $periodontalSite#buccal
* component[probingDepth][5].valueQuantity = 4 'mm'
