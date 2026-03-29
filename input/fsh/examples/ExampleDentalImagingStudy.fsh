// Example: OPG-Aufnahme (Panoramaschichtaufnahme)
// SWS 2.0 Satzart 12 — Röntgendiagnostik

Alias: $dicom  = http://dicom.nema.org/resources/ontology/DCM

Instance: ExampleDentalImagingStudy
InstanceOf: DentalImagingStudyDE
Usage: #example
Title: "Beispiel OPG-Aufnahme Panoramaschichtaufnahme"
Description: "Orthopantomogramm (OPG) zur Übersichtsaufnahme des gesamten Kiefers. Indikation: Kariesdiagnostik und parodontologische Statuserhebung. Aufnahme vom 2026-01-15."

* identifier[0].system = "https://mira.cognovis.de/fhir/identifier/roentgen-id"
* identifier[0].value = "RTG-2026-000087"

* status = #available

* subject = Reference(ExamplePatient)

* started = "2026-01-15T08:45:00+01:00"

* numberOfSeries = 1
* numberOfInstances = 1

// Indikation: Karies + Parodontaldiagnostik
* reasonCode[0] = $sct#80967001 "Dental caries"
* reasonCode[0].text = "Kariesdiagnostik und parodontologische Statuserhebung"

// Series: OPG (DICOM Modality PX = Panoramic X-Ray)
* series[0].uid = "2.16.840.1.114362.1.12345678.20260115084500.999.1"
* series[0].number = 1
* series[0].modality = $dicom#PX "Panoramic X-Ray"
* series[0].description = "OPG Gesamtkiefer — Panoramaschichtaufnahme"
* series[0].numberOfInstances = 1

// Link zu Encounter
* encounter = Reference(ExampleDentalEncounter)

// Instance: das eigentliche DICOM-Bild
* series[0].instance[0].uid = "2.16.840.1.114362.1.12345678.20260115084500.999.1.1"
* series[0].instance[0].sopClass = urn:ietf:rfc:3986#urn:oid:1.2.840.10008.5.1.4.1.1.1 "Computed Radiography Image Storage"
* series[0].instance[0].number = 1
* series[0].instance[0].title = "OPG 2026-01-15 — Mustermann Max"
