// Extensions used in this profile (defined in input/fsh/extensions/)
// ze-befundkuerzel  → https://fhir.cognovis.de/dental/StructureDefinition/ze-befundkuerzel
// ze-therapiekuerzel → https://fhir.cognovis.de/dental/StructureDefinition/ze-therapiekuerzel
// ze-versorgungsart → https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart
//
// Note: ze-bonus-prozent context is Claim, not CarePlan — applied on the associated Claim resource.

Profile: ZeCarePlanDE
Parent: CarePlan
Id: de-mira-ze-care-plan
Title: "ZE/Festzuschüsse Behandlungsplan (DE)"
Description: "Profil für Zahnersatz-Behandlungspläne mit Festzuschuss-Berechnung nach §56 SGB V (KZBV DPF-Schlüssel). Bildet SWS 2.0 Satzart 11 ab. Enthält Befund-/Therapiekürzel und Versorgungsart (Regelversorgung, gleichartig, andersartig)."
* ^status = #draft
* ^publisher = "cognovis GmbH"

// --- Identifier (ZE-ID) ---
* identifier MS
* identifier ^short = "Interne ZE-ID (SWS: ZE-ID)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(KBV_PR_FOR_Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- Status ---
* status MS
* status ^short = "Planstatus: draft (Entwurf) | active (Genehmigt) | revoked (Abgelehnt)"

// --- Intent: immer plan ---
* intent = #plan
* intent ^short = "Planabsicht: immer 'plan'"

// --- Category: dental ZE ---
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"
* category[dental] ^short = "Behandlungsplantyp: Dental (ZE/Festzuschüsse)"

// --- Erstelldatum ---
* created MS
* created ^short = "Erstelldatum des ZE-Plans (SWS: Erstelldatum)"

// --- Gültigkeitszeitraum ---
* period MS
* period ^short = "Gültigkeitszeitraum des ZE-Plans"

// --- Extensions: ZE-Befundkürzel, Therapiekürzel, Versorgungsart ---
* extension contains
    ZeBefundkuerzelExt named zeBefundkuerzel 0..* MS and
    ZeTherapiekuerzelExt named zeTherapiekuerzel 0..* MS and
    ZeVersorgungsartExt named zeVersorgungsart 0..1 MS

* extension[zeBefundkuerzel] ^short = "ZE-Befundkürzel nach KZBV DPF (SWS: Befundkürzel): Ist-Zustand je Zahn"
* extension[zeTherapiekuerzel] ^short = "ZE-Therapiekürzel nach KZBV DPF (SWS: Therapiekürzel): geplante Soll-Versorgung"
* extension[zeVersorgungsart] ^short = "ZE-Versorgungsart (SWS: Versorgungsart): regelversorgung|gleichartig|andersartig"
