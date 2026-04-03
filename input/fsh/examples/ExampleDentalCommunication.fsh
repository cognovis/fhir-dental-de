// Example: Laborauftragskommunikation an Dentallabor
// DentalCommunicationDE — Zahnärztliche Kommunikation

Instance: ExampleDentalCommunication
InstanceOf: DentalCommunicationDE
Usage: #example
Title: "Beispiel Laborauftragskommunikation — Keramik-Inlay Zahn 15"
Description: "Kommunikation von Lena Uselmann (Plärrer) an Zahntechnik Nürnberg GmbH für Keramik-Inlay Zahn 15. Patientin Charlotte von Hohenstein (DKV)."

* status = #completed

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(Patient/pat-pkv-01)

// Sender: Behandlerin
* sender = Reference(PractitionerRole/role-schoell-gibitzenhof)

// Recipient: Dentallabor
* recipient[0] = Reference(ExampleDentallabor)

// Encounter-Kontext
* encounter = Reference(Encounter/enc-dental-02-privatschein)

* sent = "2026-01-22T10:30:00+01:00"

// Payload: Laborauftrag Inhalt
* payload[0].contentString = "Keramik-Inlay Zahn 15, MOD, Farbe A2. Bitte CAD/CAM-Fertigung. Abholung Freitag."

* payload[1].contentString = "Befund: Keramik-Inlay zweiflächig (GOZ 2150), Steigerungsfaktor 2,3. Präparation am 2026-01-22."
