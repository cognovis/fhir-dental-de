// Example: PSI-Screening Befund, Zahn 36, Sondierungstiefe 4 mm
// SWS 2.0 Satzart 3 — Zahnärztlicher Befund (Observation)

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdi   = http://terminology.hl7.org/CodeSystem/ex-tooth

Instance: ExampleDentalFinding
InstanceOf: DentalFindingDE
Usage: #example
Title: "Beispiel PSI-Befund Zahn 36"
Description: "Parodontaler Screening-Index (PSI) Befund für Zahn 36 (erster unterer linker Molar). Sondierungstiefe 4 mm, PSI-Code 2."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #36

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// LOINC: Periodontal attachment level measurement
* code = $loinc#32884-9 "Periodontal attachment level"

* subject = Reference(ExamplePatient)

* effectiveDateTime = "2026-01-15T09:30:00+01:00"

// PSI-Code 2: Sondierungstiefe 3,5–5,5 mm (Tasche vorhanden)
* valueCodeableConcept = http://fhir.de/CodeSystem/bfarm/icd-10-gm#K05.3 "Chronische Parodontitis"
* valueCodeableConcept.text = "PSI-Code 2: Sondierungstiefe 4 mm, Tasche vorhanden"

// Tooth: FDI 36 (lower-left first molar)
* bodySite = $fdi#36 "36"
* bodySite.text = "Zahn 36 — erster unterer linker Molar"

// Components: six probing depths (mesio-bukkal, bukkal, disto-bukkal, mesio-lingual, lingual, disto-lingual)
* component[0].code = $loinc#32884-9 "Periodontal attachment level"
* component[0].code.text = "Sondierungstiefe mesio-bukkal"
* component[0].valueQuantity.value = 4
* component[0].valueQuantity.unit = "mm"
* component[0].valueQuantity.system = "http://unitsofmeasure.org"
* component[0].valueQuantity.code = #mm

* component[1].code = $loinc#32884-9 "Periodontal attachment level"
* component[1].code.text = "Sondierungstiefe bukkal"
* component[1].valueQuantity.value = 3
* component[1].valueQuantity.unit = "mm"
* component[1].valueQuantity.system = "http://unitsofmeasure.org"
* component[1].valueQuantity.code = #mm

* component[2].code = $loinc#32884-9 "Periodontal attachment level"
* component[2].code.text = "Sondierungstiefe disto-bukkal"
* component[2].valueQuantity.value = 4
* component[2].valueQuantity.unit = "mm"
* component[2].valueQuantity.system = "http://unitsofmeasure.org"
* component[2].valueQuantity.code = #mm

* component[3].code = $loinc#32884-9 "Periodontal attachment level"
* component[3].code.text = "Sondierungstiefe mesio-lingual"
* component[3].valueQuantity.value = 3
* component[3].valueQuantity.unit = "mm"
* component[3].valueQuantity.system = "http://unitsofmeasure.org"
* component[3].valueQuantity.code = #mm

* component[4].code = $loinc#32884-9 "Periodontal attachment level"
* component[4].code.text = "Sondierungstiefe lingual"
* component[4].valueQuantity.value = 3
* component[4].valueQuantity.unit = "mm"
* component[4].valueQuantity.system = "http://unitsofmeasure.org"
* component[4].valueQuantity.code = #mm

* component[5].code = $loinc#32884-9 "Periodontal attachment level"
* component[5].code.text = "Sondierungstiefe disto-lingual"
* component[5].valueQuantity.value = 2
* component[5].valueQuantity.unit = "mm"
* component[5].valueQuantity.system = "http://unitsofmeasure.org"
* component[5].valueQuantity.code = #mm
