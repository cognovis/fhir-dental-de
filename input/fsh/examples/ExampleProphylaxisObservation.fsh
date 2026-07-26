// Example: Prophylaxe-Befund — Mundhygienestatus mit API, SBI und PSI-Sextanten

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $indexMethod = https://fhir.cognovis.de/dental/CodeSystem/prophylaxis-index-method
Alias: $psiScore = https://fhir.cognovis.de/dental/CodeSystem/psi-score
Alias: $psiSextant = https://fhir.cognovis.de/dental/CodeSystem/psi-sextant
Alias: $cariesRisk = https://fhir.cognovis.de/dental/CodeSystem/kariesrisiko-level

Instance: ExampleProphylaxisObservation
InstanceOf: ProphylaxisObservationDE
Usage: #example
Title: "Beispiel Prophylaxe-Befund"
Description: "Mundhygienestatus mit Plaque-Index (API 22%), Gingivitis-Index (SBI 15%), PSI-Sextanten-Scores und Mundhygiene-Bewertung. Patient Aylin Özdemir (GKV+ZZV). Typischer Befund vor PZR."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $sct#364126007 "Oral hygiene status"

* subject = Reference(Patient/pat-gkv-dental-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-01-15T09:30:00+01:00"

// Plaque-Index: API 22%
* component[api].code = $indexMethod#API
* component[api].valueQuantity.value = 22
* component[api].valueQuantity.unit = "%"
* component[api].valueQuantity.system = "http://unitsofmeasure.org"
* component[api].valueQuantity.code = #%

// Gingivitis-Index: SBI 15%
* component[sbi].code = $indexMethod#SBI
* component[sbi].valueQuantity.value = 15
* component[sbi].valueQuantity.unit = "%"
* component[sbi].valueQuantity.system = "http://unitsofmeasure.org"
* component[sbi].valueQuantity.code = #%

// PSI per Sextant (Sextant 1-6: oben rechts, oben frontal, oben links, unten links, unten frontal, unten rechts)
* component[psiScore][0].code = $sct#251309006
* component[psiScore][0].extension[sextant].valueCodeableConcept = $psiSextant#1
* component[psiScore][0].valueCodeableConcept = $psiScore#1

* component[psiScore][1].code = $sct#251309006
* component[psiScore][1].extension[sextant].valueCodeableConcept = $psiSextant#2
* component[psiScore][1].valueCodeableConcept = $psiScore#2

* component[psiScore][2].code = $sct#251309006
* component[psiScore][2].extension[sextant].valueCodeableConcept = $psiSextant#3
* component[psiScore][2].extension[additionalFinding].valueBoolean = true
* component[psiScore][2].valueCodeableConcept = $psiScore#3

* component[psiScore][3].code = $sct#251309006
* component[psiScore][3].extension[sextant].valueCodeableConcept = $psiSextant#4
* component[psiScore][3].valueCodeableConcept = $psiScore#4

* component[psiScore][4].code = $sct#251309006
* component[psiScore][4].extension[sextant].valueCodeableConcept = $psiSextant#5
* component[psiScore][4].valueCodeableConcept = $psiScore#1

* component[psiScore][5].code = $sct#251309006
* component[psiScore][5].extension[sextant].valueCodeableConcept = $psiSextant#6
* component[psiScore][5].valueCodeableConcept = $psiScore#0

// Mundhygienestatus: befriedigend
* component[oralHygieneStatus].code = $sct#364126007
* component[oralHygieneStatus].code.text = "Mundhygienestatus"
* component[oralHygieneStatus].valueCodeableConcept.text = "Befriedigend — geringe Plaqueanlagerungen interproximal"

// Aggregate caries risk is not a caries lesion diagnosis.
* component[cariesRisk].code = $sct#74024006
* component[cariesRisk].valueCodeableConcept = $cariesRisk#hoch

Instance: ExampleProphylaxisObservationUnavailableSextant
InstanceOf: ProphylaxisObservationDE
Usage: #example
Title: "PSI with an Unavailable Sextant"
Description: "An unassessable sextant uses dataAbsentReason instead of an invented PSI result code."
* status = #final
* code = $sct#364126007
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-01-15T09:45:00+01:00"
* component[psiScore].code = $sct#251309006
* component[psiScore].extension[sextant].valueCodeableConcept = $psiSextant#6
* component[psiScore].dataAbsentReason = http://terminology.hl7.org/CodeSystem/data-absent-reason#not-applicable

Instance: ExampleProphylaxisObservationReordered
InstanceOf: ProphylaxisObservationDE
Usage: #example
Title: "PSI with Reordered Sextant Components"
Description: "The six PSI components are deliberately out of sextant order; each result retains its sextant identity through explicit coding."
* status = #final
* code = $sct#364126007
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-01-15T10:00:00+01:00"
* component[psiScore][0].code = $sct#251309006
* component[psiScore][0].extension[sextant].valueCodeableConcept = $psiSextant#4
* component[psiScore][0].valueCodeableConcept = $psiScore#4
* component[psiScore][1].code = $sct#251309006
* component[psiScore][1].extension[sextant].valueCodeableConcept = $psiSextant#1
* component[psiScore][1].valueCodeableConcept = $psiScore#1
* component[psiScore][2].code = $sct#251309006
* component[psiScore][2].extension[sextant].valueCodeableConcept = $psiSextant#6
* component[psiScore][2].valueCodeableConcept = $psiScore#0
* component[psiScore][3].code = $sct#251309006
* component[psiScore][3].extension[sextant].valueCodeableConcept = $psiSextant#2
* component[psiScore][3].valueCodeableConcept = $psiScore#2
* component[psiScore][4].code = $sct#251309006
* component[psiScore][4].extension[sextant].valueCodeableConcept = $psiSextant#5
* component[psiScore][4].valueCodeableConcept = $psiScore#1
* component[psiScore][5].code = $sct#251309006
* component[psiScore][5].extension[sextant].valueCodeableConcept = $psiSextant#3
* component[psiScore][5].extension[additionalFinding].valueBoolean = true
* component[psiScore][5].valueCodeableConcept = $psiScore#3

Instance: ExampleProphylaxisObservationFollowUp
InstanceOf: ProphylaxisObservationDE
Usage: #example
Title: "UPT Prophylaxis Follow-Up"
Description: "A follow-up prophylaxis assessment linked as the outcome of a UPT CarePlan activity."
* status = #final
* code = $sct#364126007
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-08-05T09:30:00+02:00"
* component[api].code = $indexMethod#API
* component[api].valueQuantity.value = 12
* component[api].valueQuantity.unit = "%"
* component[api].valueQuantity.system = "http://unitsofmeasure.org"
* component[api].valueQuantity.code = #%
