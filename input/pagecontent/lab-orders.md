### Clinical Dental Lab Orders

This page describes how **DentalLabServiceRequestDE** models the complete communication between dental practice and dental laboratory — combining administrative data (BEL II / beb'97 billing) with clinical specifications for the lab technician.

---

#### The Gap This Profile Fills

Internationally, no FHIR standard exists for clinical dental laboratory orders. The VDDS Laborschnittstelle (Germany) and its successor eLABZ cover only billing data (BEL II positions, invoices). Clinical information — what shade, what material, what preparation type — is still communicated via free-text notes, paper slips, or proprietary formats.

FHIR has exactly one comparable resource: **VisionPrescription** for optometry (lens specifications). DentalLabServiceRequestDE follows the same principle: structured clinical parameters for a custom-manufactured medical device.

| Standard | Scope | Clinical Content |
|---|---|---|
| VDDS Laborschnittstelle (XML) | Billing (BEL II / beb'97) | No |
| eLABZ (TI/KIM) | Billing via Telematikinfrastruktur | No |
| ISO 18618 (CAD/CAM) | Digital design file transfer | Technical only |
| **DentalLabServiceRequestDE** | **Billing + Clinical** | **Yes** |

---

#### Profile Structure

The profile combines an **administrative block** (SWS 2.0 compatible) with a **clinical block** via extensions:

##### Administrative Block (existing)

| Element | Description |
|---|---|
| `identifier` | Lab order ID |
| `subject` | Patient reference |
| `basedOn` | Link to HKP / CarePlan (Satzart 11) |
| `performer` | Dental laboratory (Organization) |
| `category` | Order type: festsitzend, herausnehmbar, kombiniert, reparatur, kfo, schiene, implantat |

Associated **ChargeItem** resources carry BEL II / beb'97 billing positions with `bel-punkte` and `ztl-material` extensions.

##### Clinical Block (new)

| Extension | Type | Description | Example |
|---|---|---|---|
| [RestorationTypeExt](StructureDefinition-restoration-type.html) | CodeableConcept (0..\*) | Type of restoration | Krone, Bruecke, Teleskop |
| [ToothColorVitaExt](StructureDefinition-tooth-color-vita.html) | CodeableConcept (0..1) | Tooth shade (VITA Classical A1-D4) | A3 |
| [MaterialSpecificationExt](StructureDefinition-material-specification.html) | CodeableConcept (0..\*) | Material for framework/veneer | Zirkon, NEM, Keramik |
| [PreparationTypeExt](StructureDefinition-preparation-type.html) | CodeableConcept (0..1) | Preparation form | Stufe, Hohlkehle |
| [AntagonistSituationExt](StructureDefinition-antagonist-situation.html) | string (0..1) | Opposing arch description | "Natural dentition with composite on 36" |
| [OcclusionConceptExt](StructureDefinition-occlusion-concept.html) | CodeableConcept (0..1) | Desired occlusion scheme | Front-Eckzahn-Fuehrung |
| [ImplantAbutmentExt](StructureDefinition-implant-abutment.html) | complex (0..1) | Implant system, abutment type, platform diameter | Straumann BLT, 4.1mm |

##### Supporting Data

| Element | Description |
|---|---|
| `bodySite` | Affected teeth (FDI notation, ISO 3950) |
| `supportingInfo` | References to digital impressions (STL), photos, bite registrations |
| `note` | Free-text instructions to the lab technician |
| `occurrencePeriod` | Requested delivery timeframe |

---

#### Code Systems

This feature introduces 6 new CodeSystems:

| CodeSystem | Codes | Description |
|---|---|---|
| [RestorationTypeCS](CodeSystem-restoration-type.html) | 23 | All restoration types (festsitzend, herausnehmbar, KFO, sonstiges) |
| [VitaClassicalCS](CodeSystem-vita-classical.html) | 20 | VITA Classical shade guide A1-D4 incl. Bleach shades |
| [DentalMaterialCS](CodeSystem-dental-material.html) | 15 | Material classes (keramik, metall, kunststoff, kombinationen) |
| [PreparationTypeCS](CodeSystem-preparation-type.html) | 5 | Preparation forms (Stufe, Hohlkehle, Tangential, etc.) |
| [DentalLabOrderTypeCS](CodeSystem-dental-lab-order-type.html) | 7 | Order categories |
| [OcclusionConceptCS](CodeSystem-occlusion-concept.html) | 4 | Occlusion concepts |

All ValueSets use `extensible` binding — labs and practices can add custom codes.

---

#### Examples

##### Simple: Zirconia Crown on Tooth 26

A monolithic zirconia crown (Stufenpraeparation, shade A3, digital workflow):

- [ExampleLabOrderZirkonkrone26](ServiceRequest-ExampleLabOrderZirkonkrone26.html)

##### Complex: Telescopic Denture on 4 Implants

A combined prosthesis (NEM primary telescopes, PMMA base) on Straumann BLT implants:

- [ExampleLabOrderTeleskopUK](ServiceRequest-ExampleLabOrderTeleskopUK.html)

---

#### Relationship to Other Standards

```
                    ┌─────────────────────────────────┐
                    │  DentalLabServiceRequestDE       │
                    │  (this profile)                  │
                    │                                  │
                    │  Administrative + Clinical       │
                    └──────────┬──────────────────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
    ┌─────────▼──────┐  ┌─────▼──────┐  ┌──────▼─────────┐
    �� VDDS/eLABZ     │  │ ISO 18618  │  │ VisionPrescript │
    │ (Billing)      │  │ (CAD/CAM)  │  │ (Optik-Analog)  │
    │ BEL II/beb'97  │  │ STL/Design │  │ Sph/Cyl/Axis   │
    └────────────────┘  └────────────┘  └────────────────┘
```

- **VDDS/eLABZ** covers the billing layer — DentalLabServiceRequestDE adds the clinical layer on top
- **ISO 18618** covers CAD/CAM file transfer — referenced via `supportingInfo`
- **VisionPrescription** is the conceptual model — same pattern (clinical specs for custom device), different domain

---

#### International Relevance

This profile addresses a gap that exists globally. No country has standardized clinical dental lab orders in FHIR. The extensions and CodeSystems are designed to be internationally applicable:

- **FDI tooth numbering** (ISO 3950) — used in 150+ countries
- **VITA shade system** — de facto global standard for dental shade matching
- **Material classifications** — based on material science, not national codes
- **Preparation types** — universal prosthodontic terminology

The billing layer (BEL II / beb'97) is Germany-specific, but the clinical layer is ready for international adoption.
