// Example: OPG-Befundbericht (Panoramaschichtaufnahme)
// Demonstriert DentalImagingDiagnosticReportDE mit Referenz auf DentalImagingStudyDE
// und einem zahnärztlichen Befund (DentalFindingDE).
// Note: $dicom and $sct aliases are defined globally in aliases.fsh

Instance: ExampleDentalImagingDiagnosticReport
InstanceOf: DentalImagingDiagnosticReportDE
Usage: #example
Title: "Beispiel OPG-Röntgenbefundbericht"
Description: "Befundbericht zu einem Orthopantomogramm (OPG) bei Patient Friedrich Hartmann. Indikation: parodontologische Statuserhebung. Befund: generalisierte chronische Parodontitis mit Knochenabbau im Seitenzahnbereich."

* status = #final

// Category: dental
* category[dental] = DentalCategoryCS#dental "Dental"

// Code: OPG-Untersuchung (SNOMED CT)
* code = $sct#4381000179102 "Dental panoramic X-ray"

// Subject: Patient
* subject = Reference(Patient/pat-beihilfe-01)

// Effective: Datum der Aufnahme
* effectiveDateTime = "2026-02-05"

// Issued: Befunderstellung
* issued = "2026-02-05T14:30:00+01:00"

// Performer: befundender Zahnarzt
* performer[0].display = "Dr. Max Mustermann, Zahnarzt"

// ImagingStudy: Referenz auf die OPG-Aufnahme
* imagingStudy[0] = Reference(ImagingStudy/ExampleDentalImagingStudy)

// Conclusion: Freitext-Befundtext
* conclusion = "OPG vom 05.02.2026: Generalisierte chronische Parodontitis mit horizontalem Knochenabbau bis 1/3 der Wurzellänge im Seitenzahnbereich bilateral. Keine apikalen Aufhellungen sichtbar. Kieferhöhlen regelrecht dargestellt. Empfehlung: PAR-Behandlung einleiten."
