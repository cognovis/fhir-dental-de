Extension: AlignerAttachmentPlanExt
Id: aligner-attachment-plan
Title: "Aligner Attachment Plan"
Description: "Planned aligner attachment at one FDI tooth position."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/aligner-attachment-plan"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* extension contains tooth 1..1 MS
* extension[tooth].value[x] only code
* extension[tooth].valueCode from ToothIdentificationFDI_VS (required)
* value[x] 0..0
