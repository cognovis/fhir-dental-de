Extension: KfoRoentgenLinkExt
Id: kfo-roentgen-link
Title: "KFO Röntgenlink"
Description: "Verknüpft eine zahnärztliche Röntgenaufnahme (DentalImagingStudyDE) mit dem zugehörigen kieferorthopädischen Behandlungsplan (DentalCarePlanDE). Ermöglicht die direkte Referenz zwischen KFO-Plan und durchgeführten Röntgendiagnostiken."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-roentgen-link"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ImagingStudy"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only Reference(DentalImagingStudyDE or DentalCarePlanDE)
* value[x] ^short = "Referenz auf zugehörigen KFO-Behandlungsplan (CarePlan) oder Röntgenaufnahme (ImagingStudy)"
