// Example: Röntgenbefund — apikale Aufhellung Zahn 46
// Radiologischer Befund aus OPG/Zahnfilm

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi

Instance: ExampleDentalFindingRoentgen46
InstanceOf: DentalFindingDE
Usage: #example
Title: "Beispiel Röntgenbefund — Apikale Aufhellung Zahn 46"
Description: "Radiologischer Befund: apikale Aufhellung an Zahn 46 (erster unterer rechter Molar), vereinbar mit periapikaler Parodontitis. Patient Friedrich Hartmann (Beihilfe)."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #46

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#34552-0 "Dental findings"

* subject = Reference(Patient/pat-beihilfe-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-02-05T22:20:00+01:00"

* valueCodeableConcept = $sct#27867005 "Periapical abscess"
* valueCodeableConcept.text = "Apikale Aufhellung — V.a. periapikale Parodontitis"

// Tooth: FDI 46 — cognovis CodeSystem
* bodySite = $fdiCS#46 "46"
* bodySite.text = "Zahn 46 — erster unterer rechter Molar"

// Befundquelle
* component[0].code = $sct#168537006 "Plain radiograph"
* component[0].code.text = "Befundquelle"
* component[0].valueString = "OPG vom 2026-02-05"
