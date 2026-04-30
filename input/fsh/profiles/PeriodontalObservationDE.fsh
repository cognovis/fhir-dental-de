Profile: PeriodontalObservationDE
Parent: DentalFindingDE
Id: periodontal-observation
Title: "Parodontalbefund (DE)"
Description: "Profil fuer parodontale Befunde: 6-Punkt-Sondierungstiefe, Rezession, BOP und Furkationsbeteiligung pro Zahn. Spezialisierung von DentalFindingDE mit fester component-Struktur."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: must be from periodontal finding codes
* code from PeriodontalFindingCodesVS (extensible)

// bodySite is mandatory for periodontal findings (always per-tooth)
* bodySite 1..1 MS

// Components: structured periodontal measurements
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component ^slicing.description = "Slicing for periodontal measurement components"

// Probing depth (6 sites per tooth)
* component contains
    probingDepth 0..6 MS and
    recession 0..6 MS and
    bop 0..6 MS and
    furcation 0..1 MS

// Probing depth: Sondierungstiefe in mm
* component[probingDepth].code = http://loinc.org#32884-9
* component[probingDepth].value[x] only Quantity
* component[probingDepth].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth].valueQuantity.code = #mm

// Recession: Rezession in mm
* component[recession].code = http://snomed.info/sct#6288001
* component[recession].value[x] only Quantity
* component[recession].valueQuantity.system = "http://unitsofmeasure.org"
* component[recession].valueQuantity.code = #mm

// Bleeding on probing: BOP ja/nein
* component[bop].code = http://snomed.info/sct#86276007
* component[bop].value[x] only boolean

// Furcation involvement: Furkationsgrad (0-3)
* component[furcation].code = http://snomed.info/sct#109728009
* component[furcation].value[x] only integer
