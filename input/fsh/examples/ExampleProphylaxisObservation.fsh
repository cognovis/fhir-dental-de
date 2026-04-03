// Example: Prophylaxe-Befund — Mundhygienestatus mit API, SBI und PSI-Sextanten

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct

Instance: ExampleProphylaxisObservation
InstanceOf: ProphylaxisObservationDE
Usage: #example
Title: "Beispiel Prophylaxe-Befund"
Description: "Mundhygienestatus mit Plaque-Index (API 22%), Gingivitis-Index (SBI 15%), PSI-Sextanten-Scores und Mundhygiene-Bewertung. Patient Aylin Özdemir (GKV+ZZV). Typischer Befund vor PZR."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $sct#129851006 "Oral hygiene assessment"

* subject = Reference(Patient/pat-gkv-dental-01)

* effectiveDateTime = "2026-01-15T09:30:00+01:00"

// Plaque-Index: API 22%
* component[plaqueIndex].code = $sct#18949003
* component[plaqueIndex].code.text = "Approximalraum-Plaque-Index (API)"
* component[plaqueIndex].valueQuantity.value = 22
* component[plaqueIndex].valueQuantity.unit = "%"
* component[plaqueIndex].valueQuantity.system = "http://unitsofmeasure.org"
* component[plaqueIndex].valueQuantity.code = #%

// Gingivitis-Index: SBI 15%
* component[gingivitisIndex].code = $sct#37397005
* component[gingivitisIndex].code.text = "Sulcus-Blutungs-Index (SBI)"
* component[gingivitisIndex].valueQuantity.value = 15
* component[gingivitisIndex].valueQuantity.unit = "%"
* component[gingivitisIndex].valueQuantity.system = "http://unitsofmeasure.org"
* component[gingivitisIndex].valueQuantity.code = #%

// PSI per Sextant (Sextant 1-6: oben rechts, oben frontal, oben links, unten links, unten frontal, unten rechts)
* component[psiScore][0].code = $sct#427182008
* component[psiScore][0].code.text = "PSI Sextant 1 (oben rechts)"
* component[psiScore][0].valueInteger = 1

* component[psiScore][1].code = $sct#427182008
* component[psiScore][1].code.text = "PSI Sextant 2 (oben frontal)"
* component[psiScore][1].valueInteger = 1

* component[psiScore][2].code = $sct#427182008
* component[psiScore][2].code.text = "PSI Sextant 3 (oben links)"
* component[psiScore][2].valueInteger = 1

* component[psiScore][3].code = $sct#427182008
* component[psiScore][3].code.text = "PSI Sextant 4 (unten links)"
* component[psiScore][3].valueInteger = 1

* component[psiScore][4].code = $sct#427182008
* component[psiScore][4].code.text = "PSI Sextant 5 (unten frontal)"
* component[psiScore][4].valueInteger = 1

* component[psiScore][5].code = $sct#427182008
* component[psiScore][5].code.text = "PSI Sextant 6 (unten rechts)"
* component[psiScore][5].valueInteger = 1

// Mundhygienestatus: befriedigend
* component[oralHygieneStatus].code = $sct#129851006
* component[oralHygieneStatus].code.text = "Mundhygienestatus"
* component[oralHygieneStatus].valueCodeableConcept.text = "Befriedigend — geringe Plaqueanlagerungen interproximal"
