Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $pabefund = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type

Instance: ExampleRadiographicBoneLoss
InstanceOf: RadiographicBoneLossObservationDE
Usage: #example
Title: "Radiographic Bone Loss at Reference Tooth"
Description: "Forty percent radiographic bone loss at tooth 16 for a 60-year-old patient. The explicit ratio is 40 divided by 60, rounded to 0.67."
* status = #final
* code = $sct#109706009
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-02-05T11:00:00+01:00"
* bodySite = $fdiCS#16
* valueQuantity.value = 40
* valueQuantity.unit = "%"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%
* component[patientAgeAtMeasurement].code = $pabefund#patient-age-at-measurement
* component[patientAgeAtMeasurement].valueInteger = 60
* component[boneLossPerAge].code = $pabefund#bone-loss-per-age
* component[boneLossPerAge].valueRatio.numerator.value = 40
* component[boneLossPerAge].valueRatio.numerator.unit = "%"
* component[boneLossPerAge].valueRatio.numerator.system = "http://unitsofmeasure.org"
* component[boneLossPerAge].valueRatio.numerator.code = #%
* component[boneLossPerAge].valueRatio.denominator.value = 60
* component[boneLossPerAge].valueRatio.denominator.unit = "years"
* component[boneLossPerAge].valueRatio.denominator.system = "http://unitsofmeasure.org"
* component[boneLossPerAge].valueRatio.denominator.code = #a

Instance: ExampleHbA1cForParGrading
InstanceOf: HbA1cObservationDE
Usage: #example
Title: "HbA1c Evidence for PAR Grading"
Description: "HbA1c measurement represented with the shared Praxis-DE HbA1cObservationDE profile and referenced as periodontal grading evidence."
* status = #final
* category[laboratory] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* code.coding[loinc].system = "http://loinc.org"
* code.coding[loinc].code = #4548-4
* code.coding[loinc].display = "Hämoglobin A1c/Hämoglobin.gesamt in Blut"
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-02-05T11:05:00+01:00"
* valueQuantity.value = 6.8
* valueQuantity.unit = "%"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #%

Instance: ExampleSmokingStatusForParGrading
InstanceOf: SmokingStatusDE
Usage: #example
Title: "Smoking Status Evidence for PAR Grading"
Description: "Smoking status represented with the shared Praxis-DE SmokingStatusDE profile and referenced as periodontal grading evidence."
* status = #final
* category[social-history] = http://terminology.hl7.org/CodeSystem/observation-category#social-history
* code.coding[loinc].system = "http://loinc.org"
* code.coding[loinc].code = #72166-2
* code.coding[loinc].display = "Raucherstatus"
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-02-05T10:55:00+01:00"
* valueCodeableConcept.coding.system = "http://loinc.org"
* valueCodeableConcept.coding.code = #LA15920-4
* valueCodeableConcept.coding.display = "Former smoker"
