// Generisches Dental-Behandlungsplan-Profil
// Ersetzt ZeCarePlanDE, HkpCarePlanDE, KfoCarePlanDE, ParCarePlanDE
// Plantyp wird ueber category[planType]-Slice mit DentalCarePlanTypeVS unterschieden.
//
// Extensions (alle optional — typ-spezifisch):
// ze-befundkuerzel      → https://fhir.cognovis.de/dental/StructureDefinition/ze-befundkuerzel
// ze-therapiekuerzel    → https://fhir.cognovis.de/dental/StructureDefinition/ze-therapiekuerzel
// ze-versorgungsart     → https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart
// hkp-genehmigungsstatus → https://fhir.cognovis.de/dental/StructureDefinition/hkp-genehmigungsstatus
// ehkp-id               → https://fhir.cognovis.de/dental/StructureDefinition/ehkp-id
// kfo-behandlungsphase  → https://fhir.cognovis.de/dental/StructureDefinition/kfo-behandlungsphase
// kfo-apparatus-type    → https://fhir.cognovis.de/dental/StructureDefinition/kfo-apparatus-type
// par-upt-intervall     → https://fhir.cognovis.de/dental/StructureDefinition/par-upt-intervall
// ze-haerte-fall       → https://fhir.cognovis.de/dental/StructureDefinition/ze-haerte-fall

Profile: DentalCarePlanDE
Parent: CarePlan
Id: de-mira-dental-care-plan
Title: "Dental Behandlungsplan (DE)"
Description: "Generisches Profil fuer Dental-Behandlungsplaene. Unterscheidet Plantypen (ZE, HKP, PAR, KFO, KBR, KGL, PMB) ueber category[planType]-Slice."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Identifier ---
* identifier MS
* identifier ^short = "Interne Plan-ID"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Patient"

// --- Status ---
* status MS
* status ^short = "Planstatus: draft | active | revoked"

// --- Intent: immer plan ---
* intent = #plan
* intent ^short = "Planabsicht: immer 'plan'"

// --- Category: zwei Slices — dental (Pflicht) + planType (Pflicht) ---
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS and planType 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"
* category[dental] ^short = "Dental-Kategorie (immer 'dental')"
* category[planType] from DentalCarePlanTypeVS (required)
* category[planType] ^short = "Plantyp: ze | hkp | par | kfo | kbr | kgl | pmb"

// --- Erstelldatum ---
* created MS
* created ^short = "Erstelldatum des Plans"

// --- Gueltigkeitszeitraum ---
* period MS
* period ^short = "Behandlungszeitraum"

// --- Addresses (KFO + PAR) ---
// Note: intentionally unconstrained (was Reference(Condition) in old KFO/PAR profiles, relaxed for generic use)
* addresses MS
* addresses ^short = "Verweis auf zugehoerige Diagnose (Condition)"

// --- Supporting Info (PAR) ---
* supportingInfo MS
* supportingInfo ^short = "Unterstuetzende Informationen (z.B. PA-Statuserhebung)"

// --- Activity (PAR: UPT-Recall) ---
* activity MS
* activity.detail MS
* activity.detail.scheduledTiming MS
// Note: periodUnit not fixed (was #mo in old ParCarePlanDE, relaxed for generic use)
* activity.detail.scheduledTiming ^short = "Recall-Intervall (scheduledTiming.repeat.period)"

// --- Extensions: alle Typ-spezifischen Extensions als optional ---
* extension contains
    ZeBefundkuerzelExt named zeBefundkuerzel 0..* MS and
    ZeTherapiekuerzelExt named zeTherapiekuerzel 0..* MS and
    ZeVersorgungsartExt named zeVersorgungsart 0..1 MS and
    HkpGenehmigungsstatusExt named hkpGenehmigungsstatus 0..1 MS and
    EhkpIdExt named ehkpId 0..1 MS and
    KfoBehandlungsphaseExt named kfoBehandlungsphase 0..1 MS and
    KfoApparatusTypeExt named kfoApparatusType 0..1 MS and
    ParUptIntervallExt named parUptIntervall 0..1 MS and
    ZeHaerteFallExt named zeHaerteFall 0..1 MS

* extension[zeBefundkuerzel] ^short = "ZE-Befundkuerzel nach KZBV DPF (Ist-Zustand je Zahn)"
* extension[zeTherapiekuerzel] ^short = "ZE-Therapiekuerzel nach KZBV DPF (geplante Soll-Versorgung)"
* extension[zeVersorgungsart] ^short = "ZE-Versorgungsart: regelversorgung | gleichartig | andersartig"
* extension[hkpGenehmigungsstatus] ^short = "Genehmigungsstatus bei der Krankenkasse (HKP)"
* extension[ehkpId] ^short = "EBZ-Referenznummer des elektronischen HKP"
* extension[kfoBehandlungsphase] ^short = "KFO-Behandlungsphase: aktiv | retention | abschluss"
* extension[kfoApparatusType] ^short = "KFO-Apparaturtyp: festsitzend | herausnehmbar"
* extension[parUptIntervall] ^short = "UPT-Recall-Intervall in Monaten (typisch 3/6/12)"
* extension[zeHaerteFall] ^short = "Härtefall nach § 55 SGB V: erhöhter Festzuschuss"
