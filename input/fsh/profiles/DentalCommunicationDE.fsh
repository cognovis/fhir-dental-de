Profile: DentalCommunicationDE
Parent: Communication
Id: de-mira-dental-communication
Title: "Zahnärztliche Kommunikation (DE)"
Description: "Profil für zahnärztliche Kommunikation: Anweisungen, Aufklärungen und Mitteilungen im Behandlungskontext. Basiert auf FHIR R4 Communication."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Category: instruction (aligned with HL7 Dental IG)
* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 0..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"

// Subject
* subject MS
* subject only Reference(Patient)

// Sender/Recipient
* sender MS
* recipient MS

// Payload
* payload 1..* MS
* payload.content[x] MS
