Profile: DentalCommunicationDE
Parent: PraxisCommunication
Id: dental-communication
Title: "Zahnärztliche Kommunikation (DE)"
Description: "Profil für zahnärztliche Kommunikation: Anweisungen, Aufklärungen und Mitteilungen im Behandlungskontext. Basiert auf dem gemeinsamen Praxis-DE-Kommunikationsprofil."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Category: instruction (aligned with HL7 Dental IG)
* category MS
* category contains dental 0..1 MS
* category[dental].coding 1..1
* category[dental].coding.system 1..1
* category[dental].coding.system = "https://fhir.cognovis.de/dental/CodeSystem/dental-category" (exactly)
* category[dental].coding.code 1..1
* category[dental].coding.code = #dental (exactly)

// Subject
* subject MS
* subject only Reference(Patient)

// Sender/Recipient
* sender MS
* recipient MS

// Payload
* payload 1..* MS
* payload.content[x] MS
