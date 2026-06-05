Profile: ImpactedToothObservationDE
Parent: DentalFindingDE
Id: impacted-tooth-observation
Title: "Impacted Tooth Assessment (DE)"
Description: "Profile for assessing impacted/unerupted teeth using Winter's angulation, Pell-Gregory space classification, and Pell-Gregory depth classification."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: impacted tooth observation
* code from DentalFindingCodesVS (extensible)
* code ^short = "Impacted tooth assessment code"
* code ^comment = "Typically SNOMED 89362005 'Impacted tooth' or local dental finding code"

// FDI Tooth Reference (required extension)
* extension contains https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number named fdiToothNumber 1..1 MS
* extension[fdiToothNumber] ^short = "FDI tooth number (1-8, 11-18, 21-28, 31-38, 41-48)"

// bodySite is optional (redundant with extension, but permitted)
* bodySite 0..1
* bodySite from ToothIdentificationFDI_VS (preferred)

// Components: Winter angulation, Pell-Gregory space, Pell-Gregory depth
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Impaction classification components"

* component contains
    winterAngulation 0..1 MS and
    pellGregorySpace 0..1 MS and
    pellGregoryDepth 0..1 MS

// Winter Impaction Angulation (vertical/horizontal/mesioangular/distoangular)
* component[winterAngulation].code = http://snomed.info/sct#48205001
* component[winterAngulation].code ^short = "Winter impaction angulation"
* component[winterAngulation].value[x] only CodeableConcept
* component[winterAngulation].valueCodeableConcept from WinterImpactionAngulationVS (required)
* component[winterAngulation].valueCodeableConcept ^short = "Vertical, Horizontal, Mesioangular, or Distoangular"

// Pell-Gregory Space Classification (1-3)
* component[pellGregorySpace].code = http://snomed.info/sct#127863009
* component[pellGregorySpace].code ^short = "Pell-Gregory space class"
* component[pellGregorySpace].value[x] only CodeableConcept
* component[pellGregorySpace].valueCodeableConcept from PellGregorySpaceVS (required)
* component[pellGregorySpace].valueCodeableConcept ^short = "Space 1, 2, or 3"

// Pell-Gregory Depth Classification (A-C)
* component[pellGregoryDepth].code = http://snomed.info/sct#128540008
* component[pellGregoryDepth].code ^short = "Pell-Gregory depth class"
* component[pellGregoryDepth].value[x] only CodeableConcept
* component[pellGregoryDepth].valueCodeableConcept from PellGregoryDepthVS (required)
* component[pellGregoryDepth].valueCodeableConcept ^short = "Depth A, B, or C"
