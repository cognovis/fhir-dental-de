// Example: Bone site assessment — Lekholm-Zarb classification for implant planning

Alias: $sct   = http://snomed.info/sct
Alias: $fdiCS = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $boneshape = https://fhir.cognovis.de/dental/CodeSystem/lekholm-zarb-jawbone-shape
Alias: $bonequality = https://fhir.cognovis.de/dental/CodeSystem/lekholm-zarb-jawbone-quality

Instance: ExampleBoneSiteObservation
InstanceOf: BoneSiteObservationDE
Usage: #example
Title: "Example Bone Site Assessment — Lekholm-Zarb Classification"
Description: "Bone site (maxilla, anterior) assessed for implant planning using Lekholm-Zarb classification. Patient Max Mustermann, bone shape C (complete alveolar resorption) and bone quality 3 (thin cortex with dense cancellous)."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// SNOMED 113192009: Bone structure of jaw
* code = $sct#113192009 "Bone structure of jaw"

* subject = Reference(Patient/pat-gkv-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-02-15T10:30:00+01:00"

// Implant site: maxilla anterior region (use FDI 10-tooth notation or body site text)
* bodySite = $fdiCS#21 "21"
* bodySite.text = "Maxilla anterior (implant site)"

// Bone Shape: C (complete alveolar atrophy)
* component[boneShape].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#pocket-depth-encoded
* component[boneShape].code.text = "Lekholm-Zarb bone shape"
* component[boneShape].valueCodeableConcept = $boneshape#C "Complete alveolar bone atrophy"

// Bone Quality: 3 (thin cortex surrounding dense cancellous bone)
* component[boneQuality].code = https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type#attachment-loss
* component[boneQuality].code.text = "Lekholm-Zarb bone quality"
* component[boneQuality].valueCodeableConcept = $bonequality#3 "Thin cortex surrounding dense cancellous bone"
