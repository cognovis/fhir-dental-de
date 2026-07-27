Profile: PeriImplantObservationDE
Parent: DentalFindingDE
Id: peri-implant-observation
Title: "Peri-Implant Observation (DE)"
Description: "Site-level probing depth, bleeding, suppuration, and boolean mobility findings around one referenced dental implant."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* code = PeriImplantFindingCS#assessment
* bodySite 0..1 MS
* focus 1..1 MS
* focus only Reference(DentalImplantDE)
* derivedFrom MS
* derivedFrom only Reference(RadiographicBoneLossObservationDE)

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component contains
    probingDepth 0..6 MS and
    bop 0..6 MS and
    suppuration 0..6 MS and
    implantMobility 0..1 MS

* component[probingDepth].code = http://loinc.org#32910-2
* component[probingDepth].value[x] only Quantity
* component[probingDepth].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth].valueQuantity.code = #mm
* component[probingDepth].extension contains PeriodontalMeasurementSiteExt named measurementSite 1..1 MS

* component[bop].code = http://snomed.info/sct#86276007
* component[bop].value[x] only boolean
* component[bop].extension contains PeriodontalMeasurementSiteExt named measurementSite 1..1 MS

* component[suppuration].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#suppuration-on-probing
* component[suppuration].value[x] only boolean
* component[suppuration].extension contains PeriodontalMeasurementSiteExt named measurementSite 1..1 MS

* component[implantMobility].code = PeriImplantFindingCS#implant-mobility
* component[implantMobility].value[x] only boolean
