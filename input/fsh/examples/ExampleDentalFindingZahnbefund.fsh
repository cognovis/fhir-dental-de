// Example: Zahnbefund — Karies an Zahn 26
// Typischer Einzelbefund aus dem Zahnschema (Befundaufnahme)

Alias: $loinc   = http://loinc.org
Alias: $sct     = http://snomed.info/sct
Alias: $fdiCS   = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $surfCS  = https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces

Instance: ExampleDentalFindingKaries26
InstanceOf: DentalFindingDE
Usage: #example
Title: "Beispiel Zahnbefund — Karies Zahn 26"
Description: "Kariöse Läsion an Zahn 26 (erster oberer linker Molar), mesial-okklusal, ICDAS-Code 4. Patient Aylin Özdemir (GKV+ZZV)."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #26

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#34552-0 "Dental findings"

* subject = Reference(Patient/pat-gkv-dental-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-01-15T10:00:00+01:00"

* valueCodeableConcept = $sct#80967001 "Dental caries"
* valueCodeableConcept.text = "Karies ICDAS 4 — Schattenbildung im Dentin"

// Tooth: FDI 26 — cognovis CodeSystem
* bodySite = $fdiCS#26 "26"
* bodySite.text = "Zahn 26 — erster oberer linker Molar"

// Betroffene Flächen — cognovis tooth-surfaces CodeSystem
// SCT 245647007 "Entire vestibular surface of tooth" — IG Publisher canonical display (validated 2026)
* component[0].code = $sct#245647007 "Entire vestibular surface of tooth"
* component[0].code.text = "Betroffene Zahnfläche"
* component[0].valueCodeableConcept = $surfCS#M "Mesial"

* component[1].code = $sct#245647007 "Entire vestibular surface of tooth"
* component[1].code.text = "Betroffene Zahnfläche"
* component[1].valueCodeableConcept = $surfCS#O "Okklusal"
