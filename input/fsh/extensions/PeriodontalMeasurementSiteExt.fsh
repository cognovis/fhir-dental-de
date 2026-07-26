Extension: PeriodontalMeasurementSiteExt
Id: periodontal-measurement-site
Title: "Periodontal Measurement Site"
Description: "Identifies the site around a tooth to which one periodontal Observation component applies."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/periodontal-measurement-site"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Observation.component"

* value[x] only CodeableConcept
* value[x] from PeriodontalMeasurementSiteVS (required)
