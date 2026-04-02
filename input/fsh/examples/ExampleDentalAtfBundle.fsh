// Beispiel: Zahnärztlicher Befund-Transport via KIM (ATF MessageBundle)
// Übermittlung eines PSI-Befunds (DentalFinding) und einer Kariesdiagnose (DentalCondition)
// vom Zahnarzt an eine Gemeinschaftspraxis über KIM-Adressen.
//
// Das Bundle ist konform zu BundleAppTransportFramework (de.gematik.fhir.atf#1.4.1).
// Der enthaltene MessageHeader ist konform zu MessageHeaderAppTransportFramework.

Alias: $atf-bundle    = https://gematik.de/fhir/atf/StructureDefinition/atf-message-bundle
Alias: $atf-header    = https://gematik.de/fhir/atf/StructureDefinition/atf-message-header
Alias: $atf-svc-cs    = https://gematik.de/fhir/atf/CodeSystem/service-identifier-cs
Alias: $kim-sid       = http://gematik.de/fhir/sid/KIM-Adresse
Alias: $loinc         = http://loinc.org
Alias: $sct           = http://snomed.info/sct
Alias: $fdi           = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $icd10gm       = http://fhir.de/CodeSystem/bfarm/icd-10-gm

// ============================================================
// Bundle — Äußere ATF-Nachricht
// ============================================================

Instance: ExampleDentalAtfBundle
InstanceOf: DentalAtfBundleDE
Usage: #example
Title: "Beispiel ATF-Bundle: Zahnbefund via KIM"
Description: "ATF-MessageBundle das einen PSI-Befund (Zahn 46) und eine Kariesdiagnose (K02.1) als Payload trägt. Versand von dr.mueller@zahnarzt.kim.telematik über KIM an gemeinschaftspraxis@praxis.kim.telematik. Das Bundle deklariert Konformität zu BundleAppTransportFramework."


// Eindeutige Nachrichten-ID (UUID)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:4d3f8a5c-1e2b-4a9d-b7c3-0f6e2d1a8b90"

* type = #message
* timestamp = "2026-01-15T09:35:00+01:00"

// --- Eintrag 0: MessageHeader ---
* entry[MessageHeader][0].fullUrl = "urn:uuid:aa11bb22-cc33-dd44-ee55-ff66aa77bb88"
* entry[MessageHeader][0].resource = AtfDentalMessageHeader

// --- Eintrag 1: DentalFinding (PSI-Befund Zahn 46) ---
* entry[DentalFinding][0].fullUrl = "urn:uuid:finding-psi-46-001"
* entry[DentalFinding][0].resource = AtfDentalFindingZahn46

// --- Eintrag 2: DentalCondition (Kariesbefund Zahn 46) ---
* entry[DentalCondition][0].fullUrl = "urn:uuid:condition-k021-46-001"
* entry[DentalCondition][0].resource = AtfDentalConditionKaries46

// --- Eintrag 3: Patient ---
* entry[Patient][0].fullUrl = "urn:uuid:patient-max-mustermann"
* entry[Patient][0].resource = AtfPatient

// ============================================================
// MessageHeader — ATF-Pflichtressource (konform zu atf-message-header)
// ============================================================

Instance: AtfDentalMessageHeader
InstanceOf: MessageHeader
Usage: #inline
Title: "ATF MessageHeader: Zahnbefund-Übermittlung"
Description: "MessageHeader für die KIM-basierte Übermittlung zahnärztlicher Befunddaten. Konform zu MessageHeaderAppTransportFramework (de.gematik.fhir.atf)."

* meta.profile[0] = $atf-header

// Erfordert eine ID (ATF-Pflicht)
* id = "aa11bb22-cc33-dd44-ee55-ff66aa77bb88"

// eventCoding: Dental-spezifischer Anwendungsfall
* eventCoding = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// Ziel: KIM-Adresse der empfangenden Praxis
* destination[0].endpoint = "mailto:gemeinschaftspraxis@praxis.kim.telematik"
* destination[0].receiver.identifier.system = $kim-sid
* destination[0].receiver.identifier.value = "gemeinschaftspraxis@praxis.kim.telematik"
* destination[0].receiver.display = "Gemeinschaftspraxis Zahnarzt Berlin"

// Absender: Behandlungsorganisation (Zahnarztpraxis) — Identifier-basierte Referenz
* sender.identifier.system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR"
* sender.identifier.value = "721234500"
* sender.display = "Zahnarztpraxis Dr. Müller"

// Quellsystem: Praxisverwaltungssoftware
* source.name = "Mira Dental"
* source.software = "Mira PVS"
* source.version = "2.0.0"
* source.contact.system = #email
* source.contact.value = "support@cognovis.de"
* source.endpoint = "mailto:dr.mueller@zahnarzt.kim.telematik"

// Focus: Referenzen auf die Payload-Ressourcen
* focus[0] = Reference(AtfDentalFindingZahn46)
* focus[1] = Reference(AtfDentalConditionKaries46)

// ============================================================
// DentalFinding: PSI-Befund Zahn 46 (inline)
// ============================================================

Instance: AtfDentalFindingZahn46
InstanceOf: DentalFindingDE
Usage: #inline
Title: "PSI-Befund Zahn 46 (ATF-Payload)"

* id = "finding-psi-46-001"
* status = #final
* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* code = $loinc#32884-9 "Periodontal pocket depth [Length] Mouth by Periodontal probing"
* subject = Reference(AtfPatient)
* effectiveDateTime = "2026-01-15T09:30:00+01:00"
* valueCodeableConcept = $sct#40104002 "Periodontal pocket"
* valueCodeableConcept.text = "PSI-Code 2: Sondierungstiefe 4 mm, Tasche vorhanden"
* bodySite = $fdi#46 "46"
* bodySite.text = "Zahn 46 — erster unterer rechter Molar"

// ============================================================
// DentalCondition: Kariesdiagnose K02.1 Zahn 46 (inline)
// ============================================================

Instance: AtfDentalConditionKaries46
InstanceOf: DentalConditionDE
Usage: #inline
Title: "Kariesbefund K02.1 Zahn 46 (ATF-Payload)"

* id = "condition-k021-46-001"
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"
* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* code = $icd10gm#K02.1 "Karies des Dentins"
* code.text = "Dentinkaries, Zahn 46"
* subject = Reference(AtfPatient)
* onsetDateTime = "2026-01-15"
* recordedDate = "2026-01-15"
* bodySite[0] = $fdi#46 "46"
* stage[0].summary = https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status#c "kariös"
* evidence[0].detail = Reference(AtfDentalFindingZahn46)

// ============================================================
// Patient (inline)
// ============================================================

Instance: AtfPatient
InstanceOf: Patient
Usage: #inline
Title: "Patient Max Mustermann (ATF-Payload)"

* id = "patient-max-mustermann"
* identifier[0].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[0].value = "A123456789"
* name[0].use = #official
* name[0].family = "Mustermann"
* name[0].given[0] = "Max"
* birthDate = "1985-06-15"
