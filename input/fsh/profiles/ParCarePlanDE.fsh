// Extensions used in this profile (defined in input/fsh/extensions/)
// par-upt-intervall → https://fhir.cognovis.de/dental/StructureDefinition/par-upt-intervall
//
// Note: par-stadium is applied on the associated Condition resource (context = Condition),
// not directly on CarePlan. Reference the Condition from CarePlan.addresses.

Profile: ParCarePlanDE
Parent: CarePlan
Id: de-mira-par-care-plan
Title: "PAR-Behandlungsplan (DE)"
Description: "Profil für parodontologische Behandlungspläne nach PAR-Richtlinie (07/2021). Bildet SWS 2.0 Satzart 9 ab. Enthält UPT-Recall-Intervall und Verweise auf PA-Statuserhebung (Observation) sowie Antibiotika-Therapie (MedicationRequest)."
* ^status = #draft
* ^publisher = "cognovis GmbH"

// --- Identifier (PAR-Plan-ID) ---
* identifier MS
* identifier ^short = "Interne PAR-Plan-ID (SWS: PAR-Plan-ID)"

// --- Subject: Patient (Pflichtfeld) ---
* subject 1..1 MS
* subject only Reference(KBV_PR_FOR_Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- Status ---
* status MS
* status ^short = "Planstatus: draft (Entwurf) | active (Aktiv) | revoked (Widerrufen)"

// --- Intent: immer plan ---
* intent = #plan
* intent ^short = "Planabsicht: immer 'plan'"

// --- Category: dental PAR ---
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains dental 1..1 MS
* category[dental] = DentalCategoryCS#dental "Dental"
* category[dental] ^short = "Behandlungsplantyp: Dental (PAR)"

// --- Erstelldatum ---
* created MS
* created ^short = "Erstelldatum des PAR-Plans (SWS: Erstelldatum)"

// --- Gültigkeitszeitraum ---
* period MS
* period ^short = "Behandlungszeitraum (PAR-Richtlinie: aktive Phase + UPT bis 2 Jahre)"

// --- Addresses: Verweis auf Parodontitis-Diagnose (Condition mit par-stadium Extension) ---
* addresses MS
* addresses only Reference(Condition)
* addresses ^short = "Parodontitis-Diagnose (Condition mit par-stadium Extension)"

// --- Supporting Info: PA-Statuserhebung (Observation) ---
* supportingInfo MS
* supportingInfo ^short = "PA-Statuserhebung (Observation: Taschentiefe, BOP, Furkation)"

// --- Activity: UPT-Recall mit scheduledTiming ---
* activity MS
* activity.detail MS
* activity.detail.scheduledTiming MS
* activity.detail.scheduledTiming ^short = "UPT-Recall-Intervall (scheduledTiming.repeat.period in Monaten)"
* activity.detail.scheduledTiming.repeat.periodUnit = #mo
* activity.detail.scheduledTiming.repeat.periodUnit ^short = "Zeiteinheit: Monate (mo)"

// --- Extension: UPT-Intervall auf CarePlan ---
* extension contains
    ParUptIntervallExt named parUptIntervall 0..1 MS

* extension[parUptIntervall] ^short = "UPT-Recall-Intervall in Monaten (SWS: UPT-Intervall, typisch 3/6/12)"
