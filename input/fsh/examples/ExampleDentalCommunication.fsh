// Example: Aufklärungsgespräch vor Behandlung
// DentalCommunicationDE — Zahnärztliche Kommunikation

Instance: ExampleDentalCommunication
InstanceOf: DentalCommunicationDE
Usage: #example
Title: "Beispiel Aufklärungsgespräch vor Kompositfüllung"
Description: "Aufklärungsgespräch mit Patient Max Mustermann vor der Kompositfüllung an Zahn 36. Erläuterung der geplanten Behandlung, Alternativen und möglicher Risiken."

* status = #completed

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* subject = Reference(ExamplePatient)

// Sender: Behandler (Practitioner — inline reference)
* sender = Reference(ExamplePractitioner)

// Recipient: Patient
* recipient[0] = Reference(ExamplePatient)

// Encounter-Kontext
* encounter = Reference(ExampleDentalEncounter)

* sent = "2026-01-15T09:15:00+01:00"

// Payload: Aufklärungsinhalt
* payload[0].contentString = "Patient wurde über geplante dreiflächige Kompositfüllung (MOD) an Zahn 36 aufgeklärt. Erläutert: Behandlungsablauf, Verwendung von Komposit als GKV-Leistung (BEMA 13c), Lokalanästhesie, postoperative Beschwerden möglich (Sensitivität), Alternativen (Amalgamfüllung, Keramikinlay). Patient hat Einwilligung erteilt. Fragen beantwortet."

* payload[1].contentString = "Befund: Dentinkaries K02.1 mesio-okklusal-distal, Sondierungstiefe 4 mm. Behandlungsbedarf dringend empfohlen."

// -----------------------------------------------------------------------
// Inline Practitioner — referenced by Communication and other examples
// -----------------------------------------------------------------------
Instance: ExamplePractitioner
InstanceOf: Practitioner
Usage: #example
Title: "Beispiel Zahnärztin Dr. Mustermann"
Description: "Behandelnde Zahnärztin Dr. Anna Mustermann, LANR 123456789."

* identifier[0].system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_ANR"
* identifier[0].value = "123456789"

* name[0].use = #official
* name[0].family = "Mustermann"
* name[0].given[0] = "Anna"
* name[0].prefix[0] = "Dr. med. dent."

* qualification[0].code = http://terminology.hl7.org/CodeSystem/v2-0360#DDS "Doctor of Dental Surgery"
