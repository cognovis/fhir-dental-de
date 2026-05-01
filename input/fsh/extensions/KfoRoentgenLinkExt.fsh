// KFO Röntgenlink — split into two focused extensions (one per context).
//
// KfoRoentgenLinkFromStudyExt: on ImagingStudy → references the KFO CarePlan
// KfoRoentgenLinkFromCarePlanExt: on CarePlan → references the ImagingStudy

Extension: KfoRoentgenLinkFromStudyExt
Id: kfo-roentgen-link-from-study
Title: "KFO Röntgenlink (von ImagingStudy)"
Description: "Verknüpft eine zahnärztliche Röntgenaufnahme (DentalImagingStudyDE) mit dem zugehörigen kieferorthopädischen Behandlungsplan (DentalCarePlanDE)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-roentgen-link-from-study"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ImagingStudy"

* value[x] only Reference(DentalCarePlanDE)
* value[x] ^short = "Referenz auf den zugehörigen KFO-Behandlungsplan (DentalCarePlanDE)"

// ---------------------------------------------------------------------------

Extension: KfoRoentgenLinkFromCarePlanExt
Id: kfo-roentgen-link-from-care-plan
Title: "KFO Röntgenlink (von CarePlan)"
Description: "Verknüpft einen kieferorthopädischen Behandlungsplan (DentalCarePlanDE) mit der zugehörigen Röntgenaufnahme (DentalImagingStudyDE)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-roentgen-link-from-care-plan"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only Reference(DentalImagingStudyDE)
* value[x] ^short = "Referenz auf die zugehörige Röntgenaufnahme (DentalImagingStudyDE)"
