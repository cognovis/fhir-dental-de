// Extensions used in this profile (defined in input/fsh/extensions/)
// hkp-genehmigungsstatus → https://fhir.cognovis.de/dental/StructureDefinition/hkp-genehmigungsstatus
// ehkp-id               → https://fhir.cognovis.de/dental/StructureDefinition/ehkp-id
// ze-befundkuerzel      → https://fhir.cognovis.de/dental/StructureDefinition/ze-befundkuerzel

Profile: HkpCarePlanDE
Parent: CarePlan
Id: de-mira-hkp-care-plan
Title: "HKP/KV Behandlungsplan (DE)"
Description: "Profil für Heil- und Kostenpläne (HKP) und Kostenvoranschläge (KV) nach KZBV-Richtlinien. Bildet SWS 2.0 Satzart 8 ab. Unterstützt den Genehmigungsworkflow (Da Vinci PAS-Muster) über ClaimResponse."
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"

// --- Identifier (Plan-ID) ---
* identifier MS
* identifier ^short = "Interne Plan-ID (SWS: Plan-ID)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- Status: draft|active|revoked ---
* status MS
* status ^short = "Planstatus: draft (Entwurf) | active (Genehmigt) | revoked (Abgelehnt)"

// --- Intent: immer plan ---
* intent = #plan
* intent ^short = "Planabsicht: immer 'plan'"

// --- Category: dental HKP ---
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"
* category[dental] ^short = "Behandlungsplantyp: Dental (HKP/KV)"

// --- Erstelldatum ---
* created MS
* created ^short = "Erstelldatum des Plans (SWS: Erstelldatum)"

// --- Gültigkeitszeitraum ---
* period MS
* period ^short = "Gültigkeitszeitraum des Plans (SWS: Gültigkeitsende)"

// --- Extensions: HKP-Genehmigung, eHKP-ID, ZE-Befundkürzel ---
* extension contains
    HkpGenehmigungsstatusExt named hkpGenehmigungsstatus 0..1 MS and
    EhkpIdExt named ehkpId 0..1 MS and
    ZeBefundkuerzelExt named zeBefundkuerzel 0..* MS

* extension[hkpGenehmigungsstatus] ^short = "Genehmigungsstatus bei der Krankenkasse (SWS: Genehmigungsstatus)"
* extension[ehkpId] ^short = "EBZ-Referenznummer des elektronischen HKP (SWS: E-HKP-ID)"
* extension[zeBefundkuerzel] ^short = "ZE-Befundkürzel nach KZBV DPF (SWS: Befundkürzel ZE)"
