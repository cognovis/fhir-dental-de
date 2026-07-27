Extension: AlignerInterproximalReductionPlanExt
Id: aligner-interproximal-reduction-plan
Title: "Aligner Interproximal Reduction Plan"
Description: "Planned interproximal reduction amount between two FDI tooth positions."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/aligner-interproximal-reduction-plan"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* extension contains
    firstTooth 1..1 MS and
    secondTooth 1..1 MS and
    amount 1..1 MS
* extension[firstTooth].value[x] only code
* extension[firstTooth].valueCode from ToothIdentificationFDI_VS (required)
* extension[secondTooth].value[x] only code
* extension[secondTooth].valueCode from ToothIdentificationFDI_VS (required)
* extension[amount].value[x] only Quantity
* extension[amount].valueQuantity.system = "http://unitsofmeasure.org"
* extension[amount].valueQuantity.code = #mm
* value[x] 0..0
