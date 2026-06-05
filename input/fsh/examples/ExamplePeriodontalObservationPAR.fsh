// Example: Periodontal observation with PAR-Richtlinie components

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $pabefund = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type
Alias: $pargrad = https://fhir.cognovis.de/dental/CodeSystem/par-grad
Alias: $parthase = https://fhir.cognovis.de/dental/CodeSystem/par-behandlungs-phase
Alias: $parloc = https://fhir.cognovis.de/dental/CodeSystem/par-lockerungsgrad
Alias: $parfurk = https://fhir.cognovis.de/dental/CodeSystem/par-furkationsbefall
Alias: $partreat = https://fhir.cognovis.de/dental/CodeSystem/par-behandlungsbeduerftigkeit

Instance: ExamplePeriodontalObservationPAR
InstanceOf: PeriodontalObservationDE
Usage: #example
Title: "Example Periodontal Observation with PAR-Richtlinie Components"
Description: "Complete periodontal observation on tooth 16 with PAR-Richtlinie staging. Includes probing depths, BOP, recession, furcation, and comprehensive PAR assessment (Grad I, initial treatment phase, no mobility, furcation Class I, basic treatment needed)."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"

* subject = Reference(Patient/pat-beihilfe-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-03-05T15:30:00+01:00"

// Tooth: FDI 16 — first upper right molar
* bodySite = $fdiCS#16 "16"
* bodySite.text = "Zahn 16 — erster oberer rechter Molar"

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #16

// Probing depths (6 sites: mesio-buccal, buccal, disto-buccal, mesio-lingual, lingual, disto-lingual)
* component[probingDepth][0].code = $loinc#32884-9
* component[probingDepth][0].code.text = "Sondierungstiefe mesio-bukkal"
* component[probingDepth][0].valueQuantity.value = 4
* component[probingDepth][0].valueQuantity.unit = "mm"
* component[probingDepth][0].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][0].valueQuantity.code = #mm

* component[probingDepth][1].code = $loinc#32884-9
* component[probingDepth][1].code.text = "Sondierungstiefe bukkal"
* component[probingDepth][1].valueQuantity.value = 3
* component[probingDepth][1].valueQuantity.unit = "mm"
* component[probingDepth][1].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][1].valueQuantity.code = #mm

* component[probingDepth][2].code = $loinc#32884-9
* component[probingDepth][2].code.text = "Sondierungstiefe disto-bukkal"
* component[probingDepth][2].valueQuantity.value = 4
* component[probingDepth][2].valueQuantity.unit = "mm"
* component[probingDepth][2].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][2].valueQuantity.code = #mm

* component[probingDepth][3].code = $loinc#32884-9
* component[probingDepth][3].code.text = "Sondierungstiefe mesio-lingual"
* component[probingDepth][3].valueQuantity.value = 3
* component[probingDepth][3].valueQuantity.unit = "mm"
* component[probingDepth][3].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][3].valueQuantity.code = #mm

* component[probingDepth][4].code = $loinc#32884-9
* component[probingDepth][4].code.text = "Sondierungstiefe lingual"
* component[probingDepth][4].valueQuantity.value = 3
* component[probingDepth][4].valueQuantity.unit = "mm"
* component[probingDepth][4].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][4].valueQuantity.code = #mm

* component[probingDepth][5].code = $loinc#32884-9
* component[probingDepth][5].code.text = "Sondierungstiefe disto-lingual"
* component[probingDepth][5].valueQuantity.value = 3
* component[probingDepth][5].valueQuantity.unit = "mm"
* component[probingDepth][5].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][5].valueQuantity.code = #mm

// BOP (2 sites: buccal, lingual) — simplified for example
* component[bop][0].code = $sct#86276007
* component[bop][0].code.text = "BOP bukkal"
* component[bop][0].valueBoolean = true

* component[bop][1].code = $sct#86276007
* component[bop][1].code.text = "BOP lingual"
* component[bop][1].valueBoolean = false

// Recession (2 sites: buccal, lingual)
* component[recession][0].code = $sct#6288001
* component[recession][0].code.text = "Rezession bukkal"
* component[recession][0].valueQuantity.value = 1
* component[recession][0].valueQuantity.unit = "mm"
* component[recession][0].valueQuantity.system = "http://unitsofmeasure.org"
* component[recession][0].valueQuantity.code = #mm

* component[recession][1].code = $sct#6288001
* component[recession][1].code.text = "Rezession lingual"
* component[recession][1].valueQuantity.value = 0
* component[recession][1].valueQuantity.unit = "mm"
* component[recession][1].valueQuantity.system = "http://unitsofmeasure.org"
* component[recession][1].valueQuantity.code = #mm

// Furcation: Grade I
* component[furcation].code = $sct#109728009
* component[furcation].code.text = "Furkationsbeteiligung"
* component[furcation].valueInteger = 1

// PAR-Richtlinie components
// PAR Grad: I (mild periodontitis)
* component[parGrad].code = $pabefund#par-grad
* component[parGrad].code.text = "PAR Grad"
* component[parGrad].valueCodeableConcept = $pargrad#I "Grad I"

// PAR Treatment Phase: Initial phase (Initialphase)
* component[parBehandlungsphase][0].code = $pabefund#par-behandlungsphase
* component[parBehandlungsphase][0].code.text = "PAR Behandlungsphase"
* component[parBehandlungsphase][0].valueCodeableConcept = $parthase#Initialphase "Initialphase"

// PAR Mobility: Grade 0 (no mobility)
* component[parLockerungsgrad].code = $pabefund#par-lockerungsgrad
* component[parLockerungsgrad].code.text = "Lockerungsgrad"
* component[parLockerungsgrad].valueCodeableConcept = $parloc#0 "0"

// PAR Furcation: Class I
* component[parFurkationsbefall].code = $pabefund#par-furkationsbefall
* component[parFurkationsbefall].code.text = "PAR Furkationsbefall"
* component[parFurkationsbefall].valueCodeableConcept = $parfurk#I "Klasse I"

// PAR Treatment Need: Basic therapy required
* component[parBehandlungsbeduerftigkeit].code = $pabefund#par-behandlungsbeduerftigkeit
* component[parBehandlungsbeduerftigkeit].code.text = "PAR Behandlungsbeduerftigkeit"
* component[parBehandlungsbeduerftigkeit].valueCodeableConcept = $partreat#basic-therapy "Basic therapy required"
