// Example: Parodontalbefund Zahn 16 — 6-Punkt-Messung mit BOP und Rezession

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi

Instance: ExamplePeriodontalObservation
InstanceOf: PeriodontalObservationDE
Usage: #example
Title: "Beispiel Parodontalbefund Zahn 16"
Description: "6-Punkt-Sondierungstiefe, Rezession und BOP fuer Zahn 16 (erster oberer rechter Molar). Typischer PA-Status-Befund. Patient Friedrich Hartmann (Beihilfe)."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #16

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#32884-9 "Periodontal pocket depth [Length] Mouth by Periodontal probing"

* subject = Reference(Patient/pat-beihilfe-01)

* effectiveDateTime = "2026-02-05T22:15:00+01:00"

// Tooth: FDI 16 — cognovis CodeSystem
* bodySite = $fdiCS#16 "16"
* bodySite.text = "Zahn 16 — erster oberer rechter Molar"

// 6x Sondierungstiefe (mesio-bukkal, bukkal, disto-bukkal, mesio-lingual, lingual, disto-lingual)
* component[probingDepth][0].code = $loinc#32884-9
* component[probingDepth][0].code.text = "Sondierungstiefe mesio-bukkal"
* component[probingDepth][0].valueQuantity.value = 5
* component[probingDepth][0].valueQuantity.unit = "mm"
* component[probingDepth][0].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][0].valueQuantity.code = #mm

* component[probingDepth][1].code = $loinc#32884-9
* component[probingDepth][1].code.text = "Sondierungstiefe bukkal"
* component[probingDepth][1].valueQuantity.value = 4
* component[probingDepth][1].valueQuantity.unit = "mm"
* component[probingDepth][1].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][1].valueQuantity.code = #mm

* component[probingDepth][2].code = $loinc#32884-9
* component[probingDepth][2].code.text = "Sondierungstiefe disto-bukkal"
* component[probingDepth][2].valueQuantity.value = 5
* component[probingDepth][2].valueQuantity.unit = "mm"
* component[probingDepth][2].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][2].valueQuantity.code = #mm

* component[probingDepth][3].code = $loinc#32884-9
* component[probingDepth][3].code.text = "Sondierungstiefe mesio-lingual"
* component[probingDepth][3].valueQuantity.value = 4
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
* component[probingDepth][5].valueQuantity.value = 4
* component[probingDepth][5].valueQuantity.unit = "mm"
* component[probingDepth][5].valueQuantity.system = "http://unitsofmeasure.org"
* component[probingDepth][5].valueQuantity.code = #mm

// 6x BOP (mesio-bukkal, bukkal, disto-bukkal, mesio-lingual, lingual, disto-lingual)
* component[bop][0].code = $sct#86276007
* component[bop][0].code.text = "BOP mesio-bukkal"
* component[bop][0].valueBoolean = true

* component[bop][1].code = $sct#86276007
* component[bop][1].code.text = "BOP bukkal"
* component[bop][1].valueBoolean = false

* component[bop][2].code = $sct#86276007
* component[bop][2].code.text = "BOP disto-bukkal"
* component[bop][2].valueBoolean = true

* component[bop][3].code = $sct#86276007
* component[bop][3].code.text = "BOP mesio-lingual"
* component[bop][3].valueBoolean = true

* component[bop][4].code = $sct#86276007
* component[bop][4].code.text = "BOP lingual"
* component[bop][4].valueBoolean = false

* component[bop][5].code = $sct#86276007
* component[bop][5].code.text = "BOP disto-lingual"
* component[bop][5].valueBoolean = false

// 2x Rezession (bukkal, lingual)
* component[recession][0].code = $sct#6288001
* component[recession][0].code.text = "Rezession bukkal"
* component[recession][0].valueQuantity.value = 2
* component[recession][0].valueQuantity.unit = "mm"
* component[recession][0].valueQuantity.system = "http://unitsofmeasure.org"
* component[recession][0].valueQuantity.code = #mm

* component[recession][1].code = $sct#6288001
* component[recession][1].code.text = "Rezession lingual"
* component[recession][1].valueQuantity.value = 0
* component[recession][1].valueQuantity.unit = "mm"
* component[recession][1].valueQuantity.system = "http://unitsofmeasure.org"
* component[recession][1].valueQuantity.code = #mm

// Furkation: Grad II
* component[furcation].code = $sct#109728009
* component[furcation].code.text = "Furkationsbeteiligung"
* component[furcation].valueInteger = 2
