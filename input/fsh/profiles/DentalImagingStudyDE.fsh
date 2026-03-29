// SWS 2.0 Satzart 12: Röntgendiagnostik
// Primary FHIR resource: ImagingStudy
// Fields: Röntgen-ID (identifier), Aufnahmedatum (started), Aufnahmetyp (series.modality),
//         Zahnnummer (series.bodySite + FdiToothNumberExt), Indikation (reasonCode)
//
// DICOM modality codes:
//   DX  = Digital Radiography       (Einzelzahnaufnahme EZA)
//   IO  = Intra-Oral Radiography     (Intraoral)
//   PX  = Panoramic X-Ray           (OPG / Panoramaschichtaufnahme)
//   CT  = Computed Tomography       (DVT / Digitale Volumentomographie / FRS)

// Extensions used in this profile (already defined in input/fsh/extensions/):
//   fdi-tooth-number → https://fhir.cognovis.de/dental/StructureDefinition/fdi-tooth-number

Profile: DentalImagingStudyDE
Parent: ImagingStudy
Id: de-mira-dental-imaging-study
Title: "Zahnärztliche Röntgendiagnostik (DE)"
Description: "Profil für zahnärztliche Röntgenaufnahmen (EZA, OPG, DVT, FRS, Aufbiss). Bildet SWS 2.0 Satzart 12 ab. Modality-Codes nach DICOM (DX, IO, PX, CT). Zahnbezug über FDI-Zahnnummer."
* ^status = #draft
* ^publisher = "cognovis GmbH"

// --- Identifier: Röntgen-ID ---
* identifier MS
* identifier ^short = "Interne Röntgen-ID (SWS: Röntgen-ID)"

// --- Status (required by base; no additional constraint) ---
* status MS

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(KBV_PR_FOR_Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- Started: Aufnahmedatum ---
* started MS
* started ^short = "Aufnahmedatum (SWS: Aufnahmedatum)"

// --- ReasonCode: Klinische Indikation ---
* reasonCode MS
* reasonCode ^short = "Klinische Indikation (z.B. SNOMED CT: Verdacht auf Karies)"

// --- Series ---
* series MS
* series ^short = "Röntgenserie (eine Serie = ein Aufnahmetyp)"

// Series: modality (Aufnahmetyp nach DICOM)
* series.modality MS
* series.modality ^short = "Aufnahmetyp (DICOM: DX=EZA, IO=Intraoral, PX=OPG, CT=DVT/FRS)"
// Note: R4 base already binds series.modality extensibly to DICOM CID 29 — no re-binding needed.

// Series: bodySite (FDI-Zahnbezug bei EZA)
* series.bodySite MS
* series.bodySite from ToothIdentificationFDI_VS (preferred)
* series.bodySite ^short = "Bezugszahn nach FDI-Zahnschema (SWS: Zahnnummer, bei EZA)"

// --- FDI-Zahnnummer is captured via series.bodySite binding to ToothIdentificationFDI_VS above.
// No additional extension needed at root level — bodySite already carries the FDI code.
