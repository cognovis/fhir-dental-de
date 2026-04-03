// Example: Röntgenbefund — apikale Aufhellung Zahn 46
// Radiologischer Befund aus OPG/Zahnfilm

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdi   = http://terminology.hl7.org/CodeSystem/ex-tooth

Instance: ExampleDentalFindingRoentgen46
InstanceOf: DentalFindingDE
Usage: #example
Title: "Beispiel Röntgenbefund — Apikale Aufhellung Zahn 46"
Description: "Radiologischer Befund: apikale Aufhellung an Zahn 46 (erster unterer rechter Molar), vereinbar mit periapikaler Parodontitis."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #46

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#34552-0 "Dental findings"

* subject = Reference(ExamplePatient)

* effectiveDateTime = "2026-03-15T10:15:00+01:00"

* valueCodeableConcept = $sct#27867005 "Periapical abscess"
* valueCodeableConcept.text = "Apikale Aufhellung — V.a. periapikale Parodontitis"

* bodySite = $fdi#46 "46"
* bodySite.text = "Zahn 46 — erster unterer rechter Molar"

// Befundquelle
* component[0].code = $sct#168537006 "Plain radiograph"
* component[0].code.text = "Befundquelle"
* component[0].valueString = "OPG vom 2026-03-15"
