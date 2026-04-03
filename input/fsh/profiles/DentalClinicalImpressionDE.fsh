// SWS 2.0 Satzart 3: Krankenblatt / Behandlungsjournal
// Primary FHIR resource: ClinicalImpression
// Fields: Eintrags-Datum, Freitext (note), Behandler-Ref (assessor),
//         Patient-Ref (subject), Encounter-Ref (encounter), finding → Observation

Profile: DentalClinicalImpressionDE
Parent: ClinicalImpression
Id: de-mira-dental-clinical-impression
Title: "Zahnärztlicher Behandlungsjournaleintrag (DE)"
Description: "Profil für Einträge im zahnärztlichen Behandlungsjournal (Krankenblatt). Bildet SWS 2.0 Satzart 3 ab. Enthält Freitext-Notizen, klinische Einschätzungen und Verweise auf strukturierte Befunde (Observations)."
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"

// --- Status (required by FHIR R4 base, no change needed) ---
* status MS

// --- Date: Eintrags-Datum ---
* date MS
* date ^short = "Datum des Journaleintrags (SWS: Eintrags-Datum)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- Encounter: Fallreferenz ---
* encounter MS
* encounter only Reference(Encounter)
* encounter ^short = "Abrechnungsfall (SWS: Encounter-Ref)"

// --- Assessor: Dokumentierender Behandler ---
* assessor MS
* assessor only Reference(Practitioner or PractitionerRole)
* assessor ^short = "Dokumentierender Behandler (SWS: Behandler-Ref)"

// --- Note: Freitext-Einträge (Annotation) ---
* note MS
* note ^short = "Freitext-Einträge des Behandlungsjournals (SWS: Freitext)"
* note ^definition = "Freitextnotizen, Anamnese und Verlaufsdokumentation aus dem Behandlungsjournal. Kann mehrere Annotationen enthalten (z.B. pro Behandlungssitzung eine)."

// --- Finding: Strukturierte Befundreferenzen ---
// finding.itemReference → Observation (z.B. Röntgenhinweis, Zahnschema-Observation)
* finding MS
* finding.itemReference MS
// Note: R4 base already types itemReference as Reference(Observation|Condition) — no constraint needed.
* finding ^short = "Verknüpfte Befunde (Observation, Condition)"
* finding ^definition = "Referenzen auf strukturierte Befunde aus dem Behandlungsjournal. Z.B. Röntgenhinweise (→ ImagingStudy via Observation) oder Zahnschema-Befunde (→ DentalFindingDE)."
* finding.itemReference ^short = "Befund-Referenz (Observation oder Condition)"
