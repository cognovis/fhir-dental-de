Profile: BoneSiteObservationDE
Parent: DentalFindingDE
Id: bone-site-observation
Title: "Bone Site Assessment (DE)"
Description: "Profile for assessing bone characteristics at implant sites using the Lekholm-Zarb classification. Captures bone shape (A-E) and bone quality (1-4) for implant planning."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: bone structure observation
* code from DentalFindingCodesVS (extensible)
* code ^short = "Bone site assessment code"
* code ^comment = "Typically SNOMED 113192009 'Bone structure of jaw' or local dental finding code"

// bodySite: jaw region (mandatory)
* bodySite 1..1 MS
* bodySite ^short = "Jaw region (maxilla/mandible, specific site)"
* bodySite from ToothIdentificationFDI_VS (preferred)

// Components: bone shape and quality measurements
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Lekholm-Zarb bone classification components"

* component contains
    boneShape 0..1 MS and
    boneQuality 0..1 MS

// Bone Shape: Lekholm-Zarb jawbone shape classification (A-E)
* component[boneShape].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#pocket-depth-encoded
* component[boneShape].code ^short = "Bone shape component"
* component[boneShape].value[x] only CodeableConcept
* component[boneShape].valueCodeableConcept from LekholmZarbJawboneShapeVS (required)
* component[boneShape].valueCodeableConcept ^short = "A (preserved) through E (extreme atrophy)"

// Bone Quality: Lekholm-Zarb jawbone quality classification (1-4)
* component[boneQuality].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#attachment-loss
* component[boneQuality].code ^short = "Bone quality component"
* component[boneQuality].value[x] only CodeableConcept
* component[boneQuality].valueCodeableConcept from LekholmZarbJawboneQualityVS (required)
* component[boneQuality].valueCodeableConcept ^short = "1 (homogeneous compact) through 4 (sparse cancellous)"
