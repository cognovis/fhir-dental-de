// Beispiel: Zahnärztlicher Befund-Transport via KIM (ATF MessageBundle)
// Übermittlung eines PSI-Befunds (DentalFinding) und einer Kariesdiagnose (DentalCondition)
// vom Zahnarzt an eine Gemeinschaftspraxis über KIM-Adressen.
//
// Das Bundle ist konform zu BundleAppTransportFramework (de.gematik.fhir.atf#1.4.1).
// Der enthaltene MessageHeader folgt der ATF-Struktur, aber ohne formale Konformitätsaussage zu MessageHeaderAppTransportFramework, da kein Dental-Anwendungskennzeichen in service-identifier-vs vorhanden ist.

Alias: $atf-bundle    = https://gematik.de/fhir/atf/StructureDefinition/atf-message-bundle
Alias: $kim-sid       = http://gematik.de/fhir/sid/KIM-Adresse
Alias: $loinc         = http://loinc.org
Alias: $sct           = http://snomed.info/sct
Alias: $icd10gm       = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $fdiCS         = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi

// ============================================================
// Bundle — Äußere ATF-Nachricht
// ============================================================

Instance: ExampleDentalAtfBundle
InstanceOf: DentalAtfBundleDE
Usage: #example
Title: "Beispiel ATF-Bundle: Zahnbefund via KIM"
Description: "ATF-MessageBundle das einen PSI-Befund (Zahn 46) und eine Kariesdiagnose (K02.1) als Payload trägt. Versand von dr.schoell@zahnarzt.kim.telematik über KIM an gemeinschaftspraxis@praxis.kim.telematik. Patient Klaus Bergmann (AOK Bayern)."


// Eindeutige Nachrichten-ID (UUID)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:4d3f8a5c-1e2b-4a9d-b7c3-0f6e2d1a8b90"

* type = #message
* timestamp = "2026-01-10T09:35:00+01:00"

// --- Eintrag 0: MessageHeader ---
* entry[MessageHeader][0].fullUrl = "urn:uuid:aa11bb22-cc33-dd44-ee55-ff66aa77bb88"
* entry[MessageHeader][0].resource = AtfDentalMessageHeader

// --- Eintrag 1: DentalFinding (PSI-Befund Zahn 46) ---
* entry[DentalFinding][0].fullUrl = "urn:uuid:f47ac10b-58cc-4372-a567-0e02b2c3d479"
* entry[DentalFinding][0].resource = AtfDentalFindingZahn46

// --- Eintrag 2: DentalCondition (Kariesbefund Zahn 46) ---
* entry[DentalCondition][0].fullUrl = "urn:uuid:6ba7b810-9dad-11d1-80b4-00c04fd430c8"
* entry[DentalCondition][0].resource = AtfDentalConditionKaries46

// --- Eintrag 3: Patient ---
* entry[Patient][0].fullUrl = "urn:uuid:6ba7b811-9dad-11d1-80b4-00c04fd430c8"
* entry[Patient][0].resource = AtfPatient

// --- Eintrag 4: Practitioner (behandelnder Zahnarzt) ---
// entry[4]: Practitioner (no Practitioner slice in DentalAtfBundleDE profile — numeric index required)
* entry[4].fullUrl = "urn:uuid:7c9e2f34-a1b2-4c3d-8e5f-6a7b8c9d0e1f"
* entry[4].resource = AtfDentist

// ============================================================
// MessageHeader — ATF-Pflichtressource (folgt ATF-Struktur, ohne formale Konformitätsaussage)
// ============================================================

Instance: AtfDentalMessageHeader
InstanceOf: MessageHeader
Usage: #inline
Title: "ATF MessageHeader: Zahnbefund-Übermittlung"
Description: "MessageHeader für die KIM-basierte Übermittlung zahnärztlicher Befunddaten. Folgt der ATF-Struktur ohne formale Konformitätsaussage (kein Dental-Anwendungskennzeichen in service-identifier-vs verfügbar)."

// Note: meta.profile for atf-message-header intentionally omitted.
// The ATF service-identifier-vs has no dental application code (required binding).
// Conformance to atf-message-header is structural only (event, destination, source).
// See: https://gematik.de/fhir/atf/ValueSet/service-identifier-vs

// ATF-Pflicht: id muss mit dem letzten Segment der fullUrl übereinstimmen
// (fullUrl in entry[MessageHeader][0]: "urn:uuid:aa11bb22-cc33-dd44-ee55-ff66aa77bb88")
* id = "aa11bb22-cc33-dd44-ee55-ff66aa77bb88"

// eventUri: Dental-spezifischer Anwendungsfall
* eventUri = "https://fhir.cognovis.de/dental/service/dental-befund-transport"

// Ziel: KIM-Adresse der empfangenden Praxis
* destination[0].endpoint = "mailto:gemeinschaftspraxis@praxis.kim.telematik"
* destination[0].receiver.identifier.system = $kim-sid
* destination[0].receiver.identifier.value = "gemeinschaftspraxis@praxis.kim.telematik"
* destination[0].receiver.display = "Gemeinschaftspraxis Zahnarzt Nürnberg"

// Absender: Behandlungsorganisation (Zahnarztpraxis)
* sender.identifier.system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR"
* sender.identifier.value = "721234500"
* sender.display = "MIRA Demo-Praxis Mitte (Dr. Schöll)"

// Quellsystem: Praxisverwaltungssoftware
* source.name = "Mira Dental"
* source.software = "Mira PVS"
* source.version = "2.0.0"
* source.contact.system = #email
* source.contact.value = "support@cognovis.de"
* source.endpoint = "mailto:dr.schoell@zahnarzt.kim.telematik"

// Focus: Referenzen auf die Payload-Ressourcen (urn:uuid: matching the Bundle entry fullUrls)
* focus[0] = Reference(urn:uuid:f47ac10b-58cc-4372-a567-0e02b2c3d479)
* focus[1] = Reference(urn:uuid:6ba7b810-9dad-11d1-80b4-00c04fd430c8)

// ============================================================
// DentalFinding: PSI-Befund Zahn 46 (inline)
// ============================================================

Instance: AtfDentalFindingZahn46
InstanceOf: DentalFindingDE
Usage: #inline
Title: "PSI-Befund Zahn 46 (ATF-Payload)"

* id = "f47ac10b-58cc-4372-a567-0e02b2c3d479"
* status = #final
* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
// LOINC 8704-9 "Physical findings of Mouth and Throat and Teeth" — official display per CSIRO/LOINC 2.82
// Used as parent code to satisfy obs-7 constraint (Observation.code must differ from component.code).
* code = $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"
* subject = Reference(urn:uuid:6ba7b811-9dad-11d1-80b4-00c04fd430c8)
* performer[0] = Reference(urn:uuid:7c9e2f34-a1b2-4c3d-8e5f-6a7b8c9d0e1f)
* effectiveDateTime = "2026-01-10T09:30:00+01:00"
* valueCodeableConcept = $icd10gm#K05.3 "Chronische Parodontitis"
* valueCodeableConcept.text = "PSI-Code 2: Sondierungstiefe 4 mm, Tasche vorhanden"
// Tooth: FDI 46 — cognovis CodeSystem
* bodySite = $fdiCS#46 "46"
* bodySite.text = "Zahn 46 — erster unterer rechter Molar"

// ============================================================
// DentalCondition: Kariesdiagnose K02.1 Zahn 46 (inline)
// ============================================================

Instance: AtfDentalConditionKaries46
InstanceOf: DentalConditionDE
Usage: #inline
Title: "Kariesbefund K02.1 Zahn 46 (ATF-Payload)"

* id = "6ba7b810-9dad-11d1-80b4-00c04fd430c8"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"
* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* code = $icd10gm#K02.1 "Karies des Dentins"
* code.text = "Dentinkaries, Zahn 46"
* subject = Reference(urn:uuid:6ba7b811-9dad-11d1-80b4-00c04fd430c8)
* onsetDateTime = "2026-01-10"
* recordedDate = "2026-01-10"
// Tooth: FDI 46 — cognovis CodeSystem
* bodySite[0] = $fdiCS#46 "46"
* stage[0].summary = https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status#c "kariös"
* evidence[0].detail = Reference(urn:uuid:f47ac10b-58cc-4372-a567-0e02b2c3d479)

// ============================================================
// Patient (inline) — Klaus Bergmann (GKV)
// ============================================================

Instance: AtfPatient
InstanceOf: Patient
Usage: #inline
Title: "Patient Klaus Bergmann (ATF-Payload)"

* id = "6ba7b811-9dad-11d1-80b4-00c04fd430c8"
* identifier[0].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[0].value = "A100100101"
* name[0].use = #official
* name[0].family = "Bergmann"
* name[0].given[0] = "Klaus"
* birthDate = "1962-04-17"

// ============================================================
// Practitioner (inline) — Behandelnder Zahnarzt Dr. Schöll
// ============================================================

Instance: AtfDentist
InstanceOf: Practitioner
Usage: #inline
Title: "Zahnarzt Dr. Schöll (ATF-Payload)"

* id = "7c9e2f34-a1b2-4c3d-8e5f-6a7b8c9d0e1f"
* identifier[0].system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_ANR"
* identifier[0].value = "721234501"
* name[0].use = #official
* name[0].family = "Schöll"
* name[0].given[0] = "Martin"
* name[0].prefix[0] = "Dr."
