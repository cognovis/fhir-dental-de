// DVT/CBCT-Subprofil von DentalImagingStudyDE
// Cone Beam Computed Tomography (CBCT) / Digitale Volumentomographie (DVT)
// DICOM-Modalität: CT (Computed Tomography)
//
// Einsatzbereiche: implantologische Planung, KFO-Chirurgie, Wurzelkanaldiagnostik,
// Kiefergelenkdiagnostik, Fremdkörperlokalisation.

Profile: DentalCbctImagingStudyDE
Parent: DentalImagingStudyDE
Id: dental-cbct-imaging-study
Title: "Zahnärztliche DVT/CBCT-Aufnahme (DE)"
Description: "Subprofil für zahnärztliche DVT- und CBCT-Aufnahmen (Digitale Volumentomographie / Cone Beam CT). Constrainiert die DICOM-Modalität auf CT. Geeignet für implantologische Planung, KFO-Chirurgie und 3D-Diagnostik."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Series: Modalität muss CT sein (DICOM-Code für Computed Tomography / DVT) ---
* series 1..*
* series.modality = $dicom#CT "Computed Tomography"
* series.modality ^short = "Modalität: CT (DICOM) — Pflicht für DVT/CBCT-Aufnahmen"

// --- ReasonCode: Klinische Indikation für DVT ---
* reasonCode 1..*
* reasonCode ^short = "Pflichtfeld für DVT: klinische Indikation (z.B. implantologische Planung, chirurgischer Eingriff)"

// --- Description: Aufnahmebeschreibung ---
* description MS
* description ^short = "Beschreibung des DVT-Scan-Volumens (z.B. Regio 34-37, ganzer Kiefer)"

// --- Note: Dosisbegründung / Strahlenexposition ---
* note MS
* note ^short = "Dosisbegründung und Angaben zur Strahlenexposition (Strahlenschutz-Anforderung bei DVT)"
