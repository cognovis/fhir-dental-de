Profile: GingivaRecessionDE
Parent: PeriodontalObservationDE
Id: gingiva-recession
Title: "Gingival Recession Assessment (DE)"
Description: "Profile for gingival recession classification using Miller (1985) and Cairo (2011) classification systems. Extends PeriodontalObservationDE with specific component slices for recession typing."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: gingival recession observation
* code from PeriodontalFindingCodesVS (extensible)
* code ^short = "Gingival recession observation code"

// bodySite is mandatory (specific tooth)
* bodySite 1..1 MS

// Extend parent's component slices with recession classification slices
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

// Add Miller gingival recession and Cairo recession component slices
* component contains
    millerGingivalRecession 0..1 MS and
    cairoGingivalRecession 0..1 MS

// Miller Gingival Recession Classification (I-IV)
* component[millerGingivalRecession].code = http://snomed.info/sct#6288001
* component[millerGingivalRecession].code.text = "Miller gingival recession class"
* component[millerGingivalRecession].value[x] only CodeableConcept
* component[millerGingivalRecession].valueCodeableConcept from MillerGingivalRecession1985VS (required)
* component[millerGingivalRecession].valueCodeableConcept ^short = "Miller Class I, II, III, or IV (1985)"

// Cairo Gingival Recession Classification (RT1-RT3)
* component[cairoGingivalRecession].code = http://snomed.info/sct#6288001
* component[cairoGingivalRecession].code.text = "Cairo gingival recession type"
* component[cairoGingivalRecession].value[x] only CodeableConcept
* component[cairoGingivalRecession].valueCodeableConcept from CairoGingivalRecession2011VS (required)
* component[cairoGingivalRecession].valueCodeableConcept ^short = "Cairo Type RT1, RT2, or RT3 (2011)"
