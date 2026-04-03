// SWS 2.0 Satzart 13: Labordaten / ZTL-Daten
// Primary FHIR resource: ServiceRequest
// Fields: Labor-ID (identifier), Patient-Ref (subject),
//         Bezug ZE-Plan (basedOn → CarePlan), Labor-Ref (performer → Organization)
//
// Associated ChargeItems (BEL II / beb'97 positions):
//   The BEL-II / beb'97 line items are modelled as separate ChargeItem resources
//   linked to this ServiceRequest via ChargeItem.requestingOrganization or
//   ChargeItem.context. The BEL II extensions are applied on those ChargeItems:
//     - bel-punkte   → https://fhir.cognovis.de/dental/StructureDefinition/bel-punkte
//     - ztl-material → https://fhir.cognovis.de/dental/StructureDefinition/ztl-material
//
// Note: These extensions are already defined and are applied on ChargeItem resources,
//       not on this ServiceRequest directly.

Profile: DentalLabServiceRequestDE
Parent: ServiceRequest
Id: de-mira-dental-lab-service-request
Title: "Zahntechnischer Laborauftrag (DE)"
Description: "Profil für zahntechnische Laboraufträge (BEL II / beb'97). Bildet SWS 2.0 Satzart 13 ab. Verknüpft den Laborauftrag mit dem Patienten, dem zugehörigen ZE-Behandlungsplan (CarePlan) und dem ausführenden Dentallabor. Einzelne BEL-II- und beb'97-Leistungspositionen werden als ChargeItem-Ressourcen mit den Extensions bel-punkte und ztl-material erfasst."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- Status + Intent (required by FHIR R4 base) ---
* status MS
* intent MS

// --- Identifier: Labor-ID ---
* identifier MS
* identifier ^short = "Laborauftrag-ID (SWS: Labor-ID)"

// --- Subject: Patient ---
* subject MS
* subject only Reference(Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- BasedOn: Verweis auf ZE-Behandlungsplan (HKP/CarePlan Satzart 11) ---
* basedOn MS
* basedOn only Reference(CarePlan)
* basedOn ^short = "Verweis auf ZE-Behandlungsplan (SWS: Bezug ZE-Plan → CarePlan Satzart 11)"
* basedOn ^definition = "Verknüpfung mit dem Heil- und Kostenplan (HKP / ZE-CarePlan, Satzart 11), für den der Laborauftrag erteilt wurde."

// --- Performer: Dentallabor (Organization) ---
* performer MS
* performer only Reference(Organization)
* performer ^short = "Ausführendes Dentallabor (SWS: Labor-Name → Organization)"
* performer ^definition = "Referenz auf das Dentallabor als FHIR Organization-Ressource. Das Labor kann mit DentalOrganizationDE profiliert werden."
