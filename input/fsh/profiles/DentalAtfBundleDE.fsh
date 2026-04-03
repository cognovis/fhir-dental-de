// ATF-Transport-Profil für zahnärztliche Befundübermittlung über KIM/TIM
// Parent: Bundle (not BundleAppTransportFramework) due to missing snapshot in atf#1.4.1

Alias: $atf-bundle    = https://gematik.de/fhir/atf/StructureDefinition/atf-message-bundle
Alias: $atf-header    = https://gematik.de/fhir/atf/StructureDefinition/atf-message-header
Alias: $kim-sid       = http://gematik.de/fhir/sid/KIM-Adresse

Profile: DentalAtfBundleDE
Parent: Bundle
Id: de-mira-dental-atf-bundle
Title: "Zahnärztliches ATF-MessageBundle (DE)"
Description: "Profil für den Transport zahnärztlicher Befunde (DentalFinding, DentalCondition) über das gematik Application Transport Framework (ATF) via KIM oder TIM."
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"

// ATF-Pflicht: Bundle-Identifier zur eindeutigen Nachrichtenidentifikation
* identifier 1..1 MS
* identifier.system 1..1 MS
* identifier.value 1..1 MS

// Bundle-Typ: immer message
* type = #message

// ATF-Pflicht: Zeitstempel der Nachricht
* timestamp 1..1 MS

// Einträge: mindestens 1 (MessageHeader), plus Dental-Payload
* entry 1..* MS
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slices: MessageHeader (ATF), DentalFinding, DentalCondition, Patient"

* entry contains
    MessageHeader 1..1 MS and
    DentalFinding 0..* MS and
    DentalCondition 0..* MS and
    Patient 0..1 MS

// MessageHeader: ATF-Pflichtressource — erster Eintrag im Bundle
// Ressourcentyp MessageHeader; Konformität zu atf-message-header wird in Beispielinstanz
// über meta.profile deklariert (SUSHI kann atf-message-header wegen fehlender Snapshot nicht direkt typisieren)
* entry[MessageHeader].fullUrl 1..1 MS
* entry[MessageHeader].resource only MessageHeader

// Dental-Payload
* entry[DentalFinding].fullUrl 1..1 MS
* entry[DentalFinding].resource only DentalFindingDE

* entry[DentalCondition].fullUrl 1..1 MS
* entry[DentalCondition].resource only DentalConditionDE

* entry[Patient].fullUrl 1..1 MS
* entry[Patient].resource only Patient
