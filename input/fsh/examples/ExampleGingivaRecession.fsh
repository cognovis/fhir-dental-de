// Example: Gingival recession — Miller and Cairo classification

Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $miller = https://fhir.cognovis.de/dental/CodeSystem/miller-gingival-recession-1985
Alias: $cairo = https://fhir.cognovis.de/dental/CodeSystem/cairo-gingival-recession-2011

Instance: ExampleGingivaRecession
InstanceOf: GingivaRecessionDE
Usage: #example
Title: "Example Gingival Recession Assessment"
Description: "Gingival recession on tooth 34 (mandible left, canine) classified as Miller Class III and Cairo Type RT2. Patient Friedrich Hartmann."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// Code: gingival recession finding
* code = http://loinc.org#8704-9 "Physical findings of Mouth and Throat and Teeth"

* subject = Reference(Patient/pat-beihilfe-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-02-20T11:45:00+01:00"

// Tooth: FDI 34 — mandible left canine
* bodySite = $fdiCS#34 "34"
* bodySite.text = "Zahn 34 — Eckzahn unterer linker"

// FDI Tooth Number extension (for consistency with PeriodontalObservationDE pattern)
* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #34

// Miller Gingival Recession: Class III (recession extends beyond mucogingival junction, without loss of interdental bone support)
* component[millerGingivalRecession].code = $sct#6288001
* component[millerGingivalRecession].code.text = "Miller gingival recession class"
* component[millerGingivalRecession].valueCodeableConcept = $miller#III "Class III"

// Cairo Gingival Recession: Type RT2 (recession with loss of interdental bone and/or soft tissue)
* component[cairoGingivalRecession].code = $sct#6288001
* component[cairoGingivalRecession].code.text = "Cairo gingival recession type"
* component[cairoGingivalRecession].valueCodeableConcept = $cairo#RT2 "Type RT2"
