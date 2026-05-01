// Dental Imaging Diagnostic Report
// Befundbericht zur zahnärztlichen Röntgendiagnostik (EZA, OPG, DVT, FRS)
// Verbindet ImagingStudy (Aufnahme) mit Findings (Befunden) und dem untersuchenden Arzt.

Profile: DentalImagingDiagnosticReportDE
Parent: DiagnosticReport
Id: dental-imaging-diagnostic-report
Title: "Zahnärztlicher Röntgenbefundbericht (DE)"
Description: "Profil für zahnärztliche Röntgenbefundberichte. Verbindet eine oder mehrere Röntgenaufnahmen (DentalImagingStudyDE) mit den erstellten Befunden (DentalFindingDE) und dem befundenden Zahnarzt."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Status (required by base) ---
* status MS
* status ^short = "Status des Befundberichts: registered | partial | preliminary | final | amended | corrected | appended | cancelled | entered-in-error | unknown"

// --- Category: dental slice ---
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"
* category[dental] ^short = "Dental-Kategorie (immer 'dental')"

// --- Code: type of imaging procedure ---
* code 1..1 MS
* code ^short = "Art der Röntgenuntersuchung (z.B. SNOMED CT oder BEMA-Code)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patient, dem die Aufnahme zugeordnet ist"

// --- Effective: Datum der Untersuchung ---
* effective[x] MS
* effective[x] ^short = "Datum/Zeitraum der Röntgenuntersuchung"

// --- Issued: Zeitpunkt der Befunderstellung ---
* issued MS
* issued ^short = "Zeitpunkt der Befunderstellung"

// --- Performer: befundender Zahnarzt ---
* performer MS
* performer ^short = "Befundender Zahnarzt / Radiologischer Dienst"

// --- ImagingStudy: only DentalImagingStudyDE ---
* imagingStudy only Reference(DentalImagingStudyDE)
* imagingStudy MS
* imagingStudy ^short = "Zugehörige Röntgenaufnahme(n) (DentalImagingStudyDE)"

// --- Result: zahnärztliche Befunde (optional — Bericht ohne Einzelbefunde ist valide) ---
* result only Reference(DentalFindingDE)
* result MS
* result ^short = "Zahnärztliche Einzelbefunde (DentalFindingDE), die aus der Aufnahme abgeleitet wurden"

// --- Conclusion: Freitext-Befundtext ---
* conclusion MS
* conclusion ^short = "Befundtext (Freitext-Zusammenfassung des Röntgenbefunds)"

// --- Extension: ReportSubstatus from praxis 0.43.1 (defined in praxis, reused here) ---
* extension contains $ReportSubstatusExt named reportSubstatus 0..1 MS
* extension[reportSubstatus] ^short = "Erweiterter Substatus des Befundberichts (praxis: ReportSubstatusCS)"
