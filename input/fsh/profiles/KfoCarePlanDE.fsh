// Extensions used in this profile (defined in input/fsh/extensions/)
// kfo-behandlungsphase  → https://fhir.cognovis.de/dental/StructureDefinition/kfo-behandlungsphase
// kfo-apparatus-type    → https://fhir.cognovis.de/dental/StructureDefinition/kfo-apparatus-type
//
// Note: kfo-angle-klasse and kfo-kig-punkte are applied on the associated Condition resource
// (context = Condition), not directly on CarePlan. Reference the Condition from CarePlan.addresses.

Profile: KfoCarePlanDE
Parent: CarePlan
Id: de-mira-kfo-care-plan
Title: "KFO-Behandlungsplan (DE)"
Description: "Profil für kieferorthopädische Behandlungspläne und Anträge nach BEMA §28 Abs. 2 SGB V. Bildet SWS 2.0 Satzart 10 ab. Enthält Behandlungsphase, Apparaturtyp und Verweis auf KFO-Diagnose (Condition mit Angle-Klasse und KIG-Punkten)."
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"

// --- Identifier (KFO-Plan-ID) ---
* identifier MS
* identifier ^short = "Interne KFO-Plan-ID (SWS: KFO-Plan-ID)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- Status ---
* status MS
* status ^short = "Planstatus: draft (Antrag) | active (Genehmigt) | revoked (Abgelehnt)"

// --- Intent: immer plan ---
* intent = #plan
* intent ^short = "Planabsicht: immer 'plan'"

// --- Category: dental KFO ---
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"
* category[dental] ^short = "Behandlungsplantyp: Dental (KFO)"

// --- Erstelldatum ---
* created MS
* created ^short = "Erstelldatum des KFO-Plans (SWS: Erstelldatum)"

// --- Behandlungszeitraum (Beginn + geplantes Ende) ---
* period MS
* period ^short = "Behandlungszeitraum: Beginn (SWS: Behandlungsbeginn) + geplantes Ende (SWS: Geplante Dauer)"

// --- Addresses: Verweis auf KFO-Diagnose (Condition mit Angle-Klasse + KIG-Punkten) ---
* addresses MS
* addresses only Reference(Condition)
* addresses ^short = "KFO-Diagnose (Condition mit kfo-angle-klasse + kfo-kig-punkte Extensions)"

// --- Extensions: Behandlungsphase und Apparaturtyp ---
* extension contains
    KfoBehandlungsphaseExt named kfoBehandlungsphase 0..1 MS and
    KfoApparatusTypeExt named kfoApparatusType 0..1 MS

* extension[kfoBehandlungsphase] ^short = "KFO-Behandlungsphase (SWS: Behandlungsphase): aktiv|retention|abschluss"
* extension[kfoApparatusType] ^short = "Apparaturtyp (SWS: Apparaturtyp): festsitzend|herausnehmbar"
