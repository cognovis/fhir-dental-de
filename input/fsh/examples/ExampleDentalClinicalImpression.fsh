// Example: Behandlungsjournal-Eintrag
// SWS 2.0 Satzart 3 — Krankenblatt / Behandlungsjournal

Instance: ExampleDentalClinicalImpression
InstanceOf: DentalClinicalImpressionDE
Usage: #example
Title: "Beispiel Behandlungsjournal-Eintrag 2026-01-15"
Description: "Journaleintrag zur Behandlungssitzung am 2026-01-15: Anamnese, Befund, durchgeführte Behandlung (Kompositfüllung BEMA 13c Zahn 36), Verlauf unauffällig."

* status = #completed

* date = "2026-01-15T10:30:00+01:00"

* subject = Reference(ExamplePatient)

* encounter = Reference(ExampleDentalEncounter)

* assessor = Reference(ExamplePractitioner)

* note[0].text = "Anamnese: Kein Einnahme von Antikoagulanzien. Keine Allergien bekannt. Patient beschwerdefrei, Routine-Kontrolltermin + Behandlung."
* note[0].time = "2026-01-15T09:00:00+01:00"

* note[1].text = "Befund: Zahn 36 — Dentinkaries K02.1 MOD (mesial-okklusal-distal), Sondierungstiefe 4 mm bukkal. Vitalität positiv. Zahn 46 — Dentinkaries K02.1 fortgeschritten, Planung HKP Krone."
* note[1].time = "2026-01-15T09:30:00+01:00"

* note[2].text = "Behandlung: Lokalanästhesie BEMA 09 (Infiltrationsanästhesie Regio 36). Kariesexkavation Zahn 36. Kompositfüllung dreiflächig MOD BEMA 13c, Material: Tetric PowerFill (Ivoclar), Schichtfüllung, lichthärtend. Okklusionskontrolle mit Artikulationspapier, Feinpolitur. Behandlungsdauer 45 min. Patient toleriert Behandlung gut."
* note[2].time = "2026-01-15T10:00:00+01:00"

* note[3].text = "Nachsorge: Patient angewiesen, für 2 Stunden keine farbstoffreichen Speisen/Getränke. Nächster Termin: Zahn 46 HKP-Präparation nach Genehmigung."
* note[3].time = "2026-01-15T10:30:00+01:00"

// Strukturierte Befundreferenzen
* finding[0].itemReference = Reference(ExampleDentalFinding)
* finding[1].itemReference = Reference(ExampleDentalCondition)
