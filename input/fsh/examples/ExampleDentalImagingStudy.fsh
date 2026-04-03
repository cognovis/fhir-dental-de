// Example: OPG-Aufnahme (Panoramaschichtaufnahme)
// SWS 2.0 Satzart 12 — Röntgendiagnostik

Alias: $dicom  = http://dicom.nema.org/resources/ontology/DCM
Alias: $sct    = http://snomed.info/sct
Alias: $fdiCS  = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi

Instance: ExampleDentalImagingStudy
InstanceOf: DentalImagingStudyDE
Usage: #example
Title: "Beispiel OPG-Aufnahme Panoramaschichtaufnahme"
Description: "Orthopantomogramm (OPG) zur Übersichtsaufnahme des gesamten Kiefers. Indikation: parodontologische Statuserhebung. Patient Friedrich Hartmann (Beihilfe). Aufnahme vom 2026-02-05."

* identifier[0].system = "https://mira-demo-mvz.de/pacs"
* identifier[0].value = "OPG-2026-0042"

* status = #available

* subject = Reference(Patient/pat-beihilfe-01)

* started = "2026-02-05T22:20:00+01:00"

* numberOfSeries = 1
* numberOfInstances = 1

// Indikation: Parodontitis
* reasonCode[0] = http://fhir.de/CodeSystem/bfarm/icd-10-gm#K05.31 "Chronische Parodontitis, generalisiert"

// Series: OPG (DICOM Modality PX = Panoramic X-Ray)
* series[0].uid = "1.2.276.0.7230010.3.1.4.2026020522200001"
* series[0].number = 1
* series[0].modality = $dicom#PX "Panoramic X-Ray"
* series[0].description = "OPG Gesamtkiefer — Panoramaschichtaufnahme"
* series[0].numberOfInstances = 1
* series[0].bodySite = $fdiCS#00 "Gesamtgebiss"

// Instance: das eigentliche DICOM-Bild
* series[0].instance[0].uid = "1.2.276.0.7230010.3.1.4.2026020522200001.1"
* series[0].instance[0].sopClass = urn:ietf:rfc:3986#urn:oid:1.2.840.10008.5.1.4.1.1.1 "Computed Radiography Image Storage"
* series[0].instance[0].number = 1
* series[0].instance[0].title = "OPG 2026-02-05 — Hartmann Friedrich"
