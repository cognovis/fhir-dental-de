// Example: Impacted tooth assessment — Winter and Pell-Gregory classification

Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $winter = https://fhir.cognovis.de/dental/CodeSystem/winter-impaction-angulation
Alias: $pellspace = https://fhir.cognovis.de/dental/CodeSystem/pell-gregory-space
Alias: $pelldepth = https://fhir.cognovis.de/dental/CodeSystem/pell-gregory-depth

Instance: ExampleImpactedToothObservation
InstanceOf: ImpactedToothObservationDE
Usage: #example
Title: "Example Impacted Tooth Assessment"
Description: "Impacted third molar (tooth 38) assessment using Winter angulation, Pell-Gregory space, and Pell-Gregory depth classifications. Patient Friedrich Hartmann, mesioangular impaction, Space 2, Depth B."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// SNOMED 89362005: Impacted tooth
* code = $sct#89362005 "Impacted tooth"

* subject = Reference(Patient/pat-beihilfe-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-03-10T14:00:00+01:00"

// FDI Tooth Reference: 38 (third molar, mandible, right)
* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number"
* extension[0].valueCode = #38

// Optional bodySite for anatomical region
* bodySite = $fdiCS#38 "38"
* bodySite.text = "Zahn 38 — dritter unterer rechter Molar"

// Winter Impaction Angulation: Mesioangular
* component[winterAngulation].code = $sct#48205001
* component[winterAngulation].code.text = "Winter impaction angulation"
* component[winterAngulation].valueCodeableConcept = $winter#mesioangular "Mesioangular"

// Pell-Gregory Space Class: 2
* component[pellGregorySpace].code = $sct#127863009
* component[pellGregorySpace].code.text = "Pell-Gregory space class"
* component[pellGregorySpace].valueCodeableConcept = $pellspace#2 "Class 2"

// Pell-Gregory Depth Class: B
* component[pellGregoryDepth].code = $sct#128540008
* component[pellGregoryDepth].code.text = "Pell-Gregory depth class"
* component[pellGregoryDepth].valueCodeableConcept = $pelldepth#B "Depth B"
