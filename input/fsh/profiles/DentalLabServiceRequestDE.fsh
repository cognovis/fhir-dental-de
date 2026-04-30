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
//
// Klinischer Block:
//   Ueber Extensions werden klinische Informationen fuer das Dentallabor abgebildet,
//   die ueber die reine Abrechnung hinausgehen: Restaurationstyp, Zahnfarbe (VITA),
//   Materialvorgabe, Praaparationsform, Okklusionskonzept, Implantatsystem.
//   International existiert kein vergleichbarer FHIR-Standard fuer klinische
//   Zahntechnik-Auftraege (analog zu VisionPrescription fuer Optik).

Profile: DentalLabServiceRequestDE
Parent: ServiceRequest
Id: dental-lab-service-request
Title: "Zahntechnischer Laborauftrag (DE)"
Description: "Profil fuer zahntechnische Laborauftraege — verbindet administrative Daten (BEL II / beb'97, SWS 2.0 Satzart 13) mit klinischen Informationen fuer das Dentallabor. Klinische Extensions erfassen Restaurationstyp, Zahnfarbe (VITA), Materialvorgabe, Praaparationsform, Okklusionskonzept und Implantatsystem. International existiert kein vergleichbarer Standard — dieses Profil schliesst eine Luecke analog zu FHIR VisionPrescription fuer die Optik."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// =====================================================================
// Administrativer Block (SWS 2.0 Satzart 13) — bestehend
// =====================================================================

// --- Status + Intent (required by FHIR R4 base) ---
* status MS
* intent MS

// --- Identifier: Labor-ID ---
* identifier MS
* identifier ^short = "Laborauftrag-ID (SWS: Labor-ID)"

// --- Category: Auftragstyp ---
* category MS
* category ^short = "Art des Laborauftrags (festsitzend, herausnehmbar, kombiniert, etc.)"
* category from DentalLabOrderTypeVS (extensible)

// --- Code: Hauptleistung ---
* code MS
* code ^short = "Beschreibung der beauftragten Leistung"

// --- Subject: Patient ---
* subject MS
* subject only Reference(Patient)
* subject ^short = "Patient (SWS: Patient-Ref)"

// --- BasedOn: Verweis auf ZE-Behandlungsplan (HKP/CarePlan Satzart 11) ---
* basedOn MS
* basedOn only Reference(CarePlan)
* basedOn ^short = "Verweis auf ZE-Behandlungsplan (SWS: Bezug ZE-Plan → CarePlan Satzart 11)"
* basedOn ^definition = "Verknuepfung mit dem Heil- und Kostenplan (HKP / ZE-CarePlan, Satzart 11), fuer den der Laborauftrag erteilt wurde."

// --- Performer: Dentallabor (Organization) ---
* performer MS
* performer only Reference(Organization)
* performer ^short = "Ausfuehrendes Dentallabor (SWS: Labor-Name → Organization)"
* performer ^definition = "Referenz auf das Dentallabor als FHIR Organization-Ressource. Das Labor kann mit DentalOrganizationDE profiliert werden."

// =====================================================================
// Klinischer Block — zahntechnische Spezifikationen
// =====================================================================

// --- Betroffene Zaehne (FDI) ---
* bodySite MS
* bodySite from ToothIdentificationFDI_VS (extensible)
* bodySite ^short = "Betroffene Zaehne nach FDI-Schema (ISO 3950)"

// --- Klinische Extensions ---
* extension contains
    RestorationTypeExt named restorationType 0..*
    and ToothColorVitaExt named toothColor 0..1
    and MaterialSpecificationExt named material 0..*
    and PreparationTypeExt named preparation 0..1
    and AntagonistSituationExt named antagonist 0..1
    and OcclusionConceptExt named occlusion 0..1
    and ImplantAbutmentExt named implantAbutment 0..1

* extension[restorationType] MS
* extension[restorationType] ^short = "Restaurationstyp (Krone, Bruecke, Prothese, etc.)"
* extension[toothColor] MS
* extension[toothColor] ^short = "Zahnfarbe nach VITA Classical (A1-D4)"
* extension[material] MS
* extension[material] ^short = "Materialvorgabe (Zirkon, NEM, Keramik, etc.)"
* extension[preparation] ^short = "Praaparationsform (Stufe, Hohlkehle, etc.)"
* extension[antagonist] ^short = "Beschreibung der Antagonistensituation"
* extension[occlusion] ^short = "Gewuenschtes Okklusionskonzept"
* extension[implantAbutment] ^short = "Implantatsystem und Abutment-Angaben"

// --- Digitale Unterlagen (Scans, Fotos, Bissregistrat) ---
* supportingInfo MS
* supportingInfo ^short = "Digitale Abformung, Fotos, Bissregistrat, Modellscans"

// --- Freitext-Anweisungen ans Labor ---
* note MS
* note ^short = "Zusaetzliche Anweisungen an das Labor (Freitext)"

// --- Terminvorgabe ---
* occurrencePeriod MS
* occurrencePeriod ^short = "Gewuenschter Fertigstellungszeitraum"
