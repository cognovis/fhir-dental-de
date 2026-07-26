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
    api 0..1 MS and
    qhi 0..1 MS and
    pi 0..1 MS and
    sbi 0..1 MS and
    pbi 0..1 MS and
    gi 0..1 MS and
    psiScore 0..6 MS and
    oralHygieneStatus 0..1 MS and
    cariesRisk 0..1 MS

// Each aggregate index method is an explicit component code. Scales are not interchangeable.
* component[api].code = ProphylaxisIndexMethodCS#API
* component[api].value[x] only Quantity
* component[api].valueQuantity.system = "http://unitsofmeasure.org"
* component[api].valueQuantity.code = #%

* component[qhi].code = ProphylaxisIndexMethodCS#QHI
* component[qhi].value[x] only Quantity

* component[pi].code = ProphylaxisIndexMethodCS#PI
* component[pi].value[x] only Quantity

* component[sbi].code = ProphylaxisIndexMethodCS#SBI
* component[sbi].value[x] only Quantity
* component[sbi].valueQuantity.system = "http://unitsofmeasure.org"
* component[sbi].valueQuantity.code = #%

* component[pbi].code = ProphylaxisIndexMethodCS#PBI
* component[pbi].value[x] only Quantity

* component[gi].code = ProphylaxisIndexMethodCS#GI
* component[gi].value[x] only Quantity

// PSI score per sextant (0-4); the star is an independent modifier.
* component[psiScore].code = http://snomed.info/sct#251309006
* component[psiScore].value[x] only CodeableConcept
* component[psiScore].valueCodeableConcept from PsiScoreVS (required)
* component[psiScore].extension contains
    PsiSextantExt named sextant 1..1 MS and
    PsiAdditionalFindingExt named additionalFinding 0..1 MS

// Oral hygiene status: overall assessment (CodeableConcept)
* component[oralHygieneStatus].code = http://snomed.info/sct#364126007
* component[oralHygieneStatus].value[x] only CodeableConcept

// Aggregate caries-risk assessment, distinct from a lesion or diagnosis
* component[cariesRisk].code = http://snomed.info/sct#74024006
* component[cariesRisk].value[x] only CodeableConcept
* component[cariesRisk].valueCodeableConcept from KariesrisikoLevelVS (required)

// Preserve measurement authorship without requiring it when the source omitted it.
* performer MS
* performer only Reference(Practitioner or PractitionerRole or Organization)
