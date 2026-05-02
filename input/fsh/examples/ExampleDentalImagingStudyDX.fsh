// Example: Intraorale Röntgenaufnahme (digitale Einzelzahnaufnahme, DX-Modalität)
// SWS 2.0 Satzart 12 — Röntgendiagnostik
// Note: $dicom alias is defined globally in aliases.fsh
//
// Abrechnungsvorschlag: DicomModalityToBemaSuggestion ConceptMap
//   DICOM Modality DX → BEMA Ae5000 (Intraorale Röntgenaufnahme)
//   Canonical: https://fhir.cognovis.de/dental/ConceptMap/dicom-modality-to-bema-suggestion

Instance: ExampleDentalImagingStudyDX
InstanceOf: DentalImagingStudyDE
Usage: #example
Title: "Beispiel Intraorale Röntgenaufnahme (DX)"
Description: "Digitale intraorale Röntgenaufnahme (DX-Modalität) eines Einzelzahns. Indikation: Kariesdiagnostik. DICOM Modality DX wird gemäß DicomModalityToBemaSuggestion ConceptMap auf BEMA Ae5000 abgebildet."

* identifier[0].system = "https://example-dental-practice.de/pacs"
* identifier[0].value = "DX-2026-0117"

* status = #available

* subject = Reference(Patient/pat-beihilfe-01)

* started = "2026-04-15T10:30:00+02:00"

* numberOfSeries = 1
* numberOfInstances = 1

// Indikation: Karies
* reasonCode[0] = http://fhir.de/CodeSystem/bfarm/icd-10-gm#K02.1 "Karies am Dentin"

// Series: Intraorale Röntgenaufnahme (DICOM Modality DX = Digital Radiography)
// Abrechnungsvorschlag via DicomModalityToBemaSuggestion: DX → BEMA Ae5000
* series[0].uid = "1.2.276.0.7230010.3.1.4.2026041510300001"
* series[0].number = 1
* series[0].modality = $dicom#DX "Digital Radiography"
* series[0].description = "Intraorale Röntgenaufnahme Regio 36 — Einzelzahnaufnahme"
* series[0].numberOfInstances = 1

// Instance: das eigentliche DICOM-Bild
* series[0].instance[0].uid = "1.2.276.0.7230010.3.1.4.2026041510300001.1"
* series[0].instance[0].sopClass = urn:ietf:rfc:3986#urn:oid:1.2.840.10008.5.1.4.1.1.1.1 "Digital X-Ray Image Storage"
* series[0].instance[0].number = 1
* series[0].instance[0].title = "DX Regio 36 2026-04-15"
