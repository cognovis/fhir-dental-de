// Example: Behandlungsjournal-Eintrag
// SWS 2.0 Satzart 3 — Krankenblatt / Behandlungsjournal

Instance: ExampleDentalClinicalImpression
InstanceOf: DentalClinicalImpressionDE
Usage: #example
Title: "Beispiel Behandlungsjournal-Eintrag 2026-01-10"
Description: "Journaleintrag zur Behandlungssitzung am 2026-01-10: Befundaufnahme und Kompositfüllung BEMA 13c Zahn 46. Patient Klaus Bergmann (AOK Bayern). Verlauf unauffällig."

* status = #completed

* date = "2026-01-10T10:30:00+01:00"

* subject = Reference(Patient/pat-gkv-01)

* encounter = Reference(Encounter/enc-dental-01-kassenschein)

* assessor = Reference(PractitionerRole/role-schoell-gibitzenhof)

* note[0].text = "Anamnese: Keine Einnahme von Antikoagulanzien. Keine Allergien bekannt. Patient beschwerdefrei."
* note[0].time = "2026-01-10T09:00:00+01:00"

* note[1].text = "Befund: Zahn 46 — Dentinkaries K02.1 MO (mesial-okklusal), Sondierungstiefe 4 mm bukkal. Vitalität positiv."
* note[1].time = "2026-01-10T09:30:00+01:00"

* note[2].text = "Behandlung: Lokalanästhesie BEMA 09. Kariesexkavation Zahn 46. Kompositfüllung zweiflächig MO BEMA 13c, Material: Tetric PowerFill (Ivoclar), lichthärtend. Okklusionskontrolle. Behandlungsdauer 35 min."
* note[2].time = "2026-01-10T10:00:00+01:00"

* note[3].text = "Nachsorge: Nächster Termin zur Kontrolle und ggf. Planung HKP für Zahn 46 Krone."
* note[3].time = "2026-01-10T10:30:00+01:00"

// Strukturierte Befundreferenzen
* finding[0].itemReference = Reference(ExampleDentalFinding)
* finding[1].itemReference = Reference(ExampleDentalCondition)
