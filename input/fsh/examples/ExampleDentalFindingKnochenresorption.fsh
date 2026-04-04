// Example: Knochenresorption — lokalisierter Knochenabbau Zahn 36
// Parodontaler Befund aus OPG

Alias: $loinc = http://loinc.org
Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi

Instance: ExampleDentalFindingKnochenresorption
InstanceOf: DentalFindingDE
Usage: #example
Title: "Beispiel Knochenresorption — Lokalisierter Knochenabbau Zahn 36"
Description: "Parodontaler Befund: lokalisierter Knochenabbau an Zahn 36 (erster unterer linker Molar), 4mm vertikal. Befund aus OPG. Patient Friedrich Hartmann (Beihilfe)."

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #36

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"

* subject = Reference(Patient/pat-beihilfe-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-02-05T22:20:00+01:00"

* valueCodeableConcept = $sct#427936003 "Localized alveolar bone loss"
* valueCodeableConcept.text = "Lokalisierter Knochenabbau — 4mm vertikal"

// Tooth: FDI 36 — cognovis CodeSystem
* bodySite = $fdiCS#36 "36"
* bodySite.text = "Zahn 36 — erster unterer linker Molar"

// Befund abgeleitet aus Bildgebung (OPG)
* derivedFrom = Reference(ImagingStudy/ExampleDentalImagingStudy)

// Befundquelle
// SCT 168537006 "Plain film" — IG Publisher canonical display (validated 2026)
* component[0].code = $sct#168537006 "Plain film"
* component[0].code.text = "Befundquelle"
* component[0].valueString = "OPG vom 2026-02-05"

// Knochenabbau vertikal in mm
* component[1].code = $sct#410668003 "Length"
* component[1].code.text = "Knochenabbau vertikal"
* component[1].valueQuantity.value = 4
* component[1].valueQuantity.unit = "mm"
* component[1].valueQuantity.system = "http://unitsofmeasure.org"
* component[1].valueQuantity.code = #mm
