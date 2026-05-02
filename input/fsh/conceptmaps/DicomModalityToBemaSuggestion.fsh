// ConceptMap: DICOM Modality → BEMA Röntgenpositionen (DICOMweb-Adapter-Upstream)
// Bildet Standard-DICOM-Modalitäten auf zugehörige BEMA-Abrechnungspositionen ab.
// Dient als Kodierungsvorschlag im DICOMweb-Adapter-Upstream-Pfad (fdde-4kk).
//
// Purpose (Dental-PACS Kontext):
//   CT in diesem Mapping bedeutet CBCT/DVT (Cone-Beam CT, dentales Volumentomogramm),
//   NICHT medizinisches CT. Dental-PACS verwendet DICOM-Modalität CT auch für CBCT.
//
// Verhältnis zu fdde-6rt (Sidexis MSSQL → BEMA+GOZ):
//   Dieses ConceptMap deckt den DICOMweb-Pfad ab (Standard DICOM Modality → BEMA).
//   fdde-6rt deckt den proprietären Sidexis-MSSQL-Pfad ab (Sidexis-intern → BEMA+GOZ).
//   Beide Pfade sind orthogonal — unterschiedliche Upstream-Quellen, gleiche BEMA-Ziele.
//
// Mapping:
//   DX  → Ae5000 (Intraoral film / digitale Einzelzahnaufnahme)
//   IO  → Ae5000 (Intraoral explicit / intraorale Röntgenaufnahme)
//   PX  → Ae5002 (OPG/Panoramaschichtaufnahme)
//   CT  → Ae5370 (CBCT/DVT in Dental-PACS — NICHT medizinisches CT)
//   RG  → Ae925  (Fallback / allgemeine Röntgenaufnahme)

Instance: DicomModalityToBemaSuggestion
InstanceOf: ConceptMap
Usage: #definition
Title: "DICOM Modality → BEMA Vorschlag"
Description: "Vorschlagsmapping von DICOM-Modalitäten auf BEMA-Abrechnungspositionen im DICOMweb-Adapter-Upstream-Pfad. Dental-PACS-Kontext: CT entspricht CBCT/DVT (dentales Volumentomogramm), nicht medizinischem CT. Dient als automatischer Kodierungsvorschlag bei der Übernahme von DICOM-Aufnahmen in die Abrechnung."

* name = "DicomModalityToBemaSuggestionCM"
* url = "https://fhir.cognovis.de/dental/ConceptMap/dicom-modality-to-bema-suggestion"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* purpose = "Dental-PACS Kontext: CT = CBCT/DVT (Cone-Beam CT, dentales Volumentomogramm), NICHT medizinisches CT. Dieses Mapping gilt ausschließlich für den DICOMweb-Adapter-Upstream-Pfad (fdde-4kk), orthogonal zu fdde-6rt (Sidexis MSSQL)."
* sourceCanonical = "http://dicom.nema.org/resources/ontology/DCM"
* targetCanonical = "http://fhir.de/CodeSystem/kzbv/bema"

* group[0].source = "http://dicom.nema.org/resources/ontology/DCM"
* group[0].target = "http://fhir.de/CodeSystem/kzbv/bema"

// DX → Ae5000 (Intraoral film / digitale Einzelzahnaufnahme)
* group[0].element[0].code = #DX
* group[0].element[0].display = "Digital Radiography"
* group[0].element[0].target[0].code = #Ae5000
* group[0].element[0].target[0].display = "BEMA-Ae5000 (Intraorale Röntgenaufnahme)"
* group[0].element[0].target[0].equivalence = #equivalent
* group[0].element[0].target[0].comment = "Intraoral film"

// IO → Ae5000 (Intraoral explicit / intraorale Röntgenaufnahme)
* group[0].element[1].code = #IO
* group[0].element[1].display = "Intra-oral Radiography"
* group[0].element[1].target[0].code = #Ae5000
* group[0].element[1].target[0].display = "BEMA-Ae5000 (Intraorale Röntgenaufnahme)"
* group[0].element[1].target[0].equivalence = #equivalent
* group[0].element[1].target[0].comment = "Intraoral (explicit)"

// PX → Ae5002 (OPG/Panoramaschichtaufnahme)
* group[0].element[2].code = #PX
* group[0].element[2].display = "Panoramic X-Ray"
* group[0].element[2].target[0].code = #Ae5002
* group[0].element[2].target[0].display = "BEMA-Ae5002 (Panoramaschichtaufnahme/OPG)"
* group[0].element[2].target[0].equivalence = #equivalent
* group[0].element[2].target[0].comment = "OPG/Panorama"

// CT → Ae5370 (CBCT/DVT in Dental-PACS — NICHT medizinisches CT)
* group[0].element[3].code = #CT
* group[0].element[3].display = "Computed Tomography"
* group[0].element[3].target[0].code = #Ae5370
* group[0].element[3].target[0].display = "BEMA-Ae5370 (Digitales Volumentomogramm/DVT)"
* group[0].element[3].target[0].equivalence = #equivalent
* group[0].element[3].target[0].comment = "CBCT/DVT in Dental-PACS"

// RG → Ae925 (Fallback / allgemeine Röntgenaufnahme)
* group[0].element[4].code = #RG
* group[0].element[4].display = "Radiographic imaging"
* group[0].element[4].target[0].code = #Ae925
* group[0].element[4].target[0].display = "BEMA-Ae925 (Röntgenaufnahme allgemein)"
* group[0].element[4].target[0].equivalence = #wider
* group[0].element[4].target[0].comment = "Fallback"
