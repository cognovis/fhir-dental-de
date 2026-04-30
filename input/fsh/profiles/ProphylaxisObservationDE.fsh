Profile: ProphylaxisObservationDE
Parent: DentalFindingDE
Id: prophylaxis-observation
Title: "Prophylaxe-Befund (DE)"
Description: "Profil fuer Prophylaxe-Befunde: Plaque-Index (API/QHI), Mundhygienestatus, Gingivitis-Index, PSI-Screening. Gesamtmund-Scores als Grundlage fuer Prophylaxe-Massnahmen (IP/PZR). Spezialisierung von DentalFindingDE."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: must be from prophylaxis finding codes
* code from ProphylaxisFindingCodesVS (extensible)

// bodySite is optional (prophylaxis findings are typically whole-mouth)
* bodySite 0..1

// Components: prophylaxis assessment scores
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component ^slicing.description = "Slicing for prophylaxis assessment components"

* component contains
    plaqueIndex 0..1 MS and
    gingivitisIndex 0..1 MS and
    psiScore 0..6 MS and
    oralHygieneStatus 0..1 MS

// Plaque index: Approximalraum-Plaque-Index (API) or Quigley-Hein-Index (QHI), 0-100%
* component[plaqueIndex].code = http://snomed.info/sct#18949003
* component[plaqueIndex].value[x] only Quantity
* component[plaqueIndex].valueQuantity.system = "http://unitsofmeasure.org"
* component[plaqueIndex].valueQuantity.code = #%

// Gingivitis index: Sulcus-Blutungs-Index (SBI) or PBI, 0-100%
* component[gingivitisIndex].code = http://snomed.info/sct#66383009
* component[gingivitisIndex].value[x] only Quantity
* component[gingivitisIndex].valueQuantity.system = "http://unitsofmeasure.org"
* component[gingivitisIndex].valueQuantity.code = #%

// PSI score per sextant (0-4, codes * and X)
* component[psiScore].code = http://snomed.info/sct#251309006
* component[psiScore].value[x] only integer

// Oral hygiene status: overall assessment (CodeableConcept)
* component[oralHygieneStatus].code = http://snomed.info/sct#364126007
* component[oralHygieneStatus].value[x] only CodeableConcept
