// Example: Zahnbefund — Karies an Zahn 26
// Typischer Einzelbefund aus dem Zahnschema (Befundaufnahme)

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdi   = http://terminology.hl7.org/CodeSystem/ex-tooth

Instance: ExampleDentalFindingKaries26
InstanceOf: DentalFindingDE
Usage: #example
Title: "Beispiel Zahnbefund — Karies Zahn 26"
Description: "Kariöse Läsion an Zahn 26 (erster oberer linker Molar), mesial-okklusal, ICDAS-Code 4."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #26

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#34552-0 "Dental findings"

* subject = Reference(ExamplePatient)

* effectiveDateTime = "2026-03-15T10:00:00+01:00"

* valueCodeableConcept = $sct#80967001 "Dental caries"
* valueCodeableConcept.text = "Karies ICDAS 4 — Schattenbildung im Dentin"

* bodySite = $fdi#26 "26"
* bodySite.text = "Zahn 26 — erster oberer linker Molar"

// Betroffene Flächen
* component[0].code = $sct#245647007 "Surface of tooth"
* component[0].code.text = "Betroffene Zahnfläche"
* component[0].valueCodeableConcept = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces#M "Mesial"

* component[1].code = $sct#245647007 "Surface of tooth"
* component[1].code.text = "Betroffene Zahnfläche"
* component[1].valueCodeableConcept = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces#O "Okklusal"
