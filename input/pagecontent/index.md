### Introduction

This Implementation Guide defines FHIR R4 profiles for dental practice data in the German healthcare system. It is the first open FHIR Implementation Guide that covers the full breadth of German dental workflows — from clinical findings and billing to treatment plans and lab orders.

The IG provides standardized profiles for:

- **Clinical findings** — Zahnschema (dental chart) using FDI notation, diagnoses (ICD-10-GM), procedures
- **Billing** — BEMA (GKV statutory) and GOZ (PKV private) charge items with Steigerungsfaktoren, Begründungen, and tooth/surface references
- **Treatment plans** — HKP (Heil- und Kostenplan), PAR (Parodontologie), KFO (Kieferorthopädie), ZE (Zahnersatz) with approval workflows
- **Communication** — Structured dental messages (eHKP, eRechnung, KIM/TIM-ready)
- **Diagnostics** — Dental imaging (OPG, DVT), lab orders (BEL II / beb'97)

### Scope and Audience

This IG is intended for:

- **PVS vendors** (Dampsoft, Solutio/CGM, EVIDENT, medatixx) implementing FHIR-based data exchange
- **Health insurers** (GKV/PKV) processing digital treatment plans (E-HKP) and claims
- **Dental AI companies** integrating imaging analysis (DentalXrai, Overjet, Pearl) or clinical decision support
- **KZVs and KZBV** moving toward FHIR-based regulatory reporting
- **Dental practices and labs** seeking interoperability between systems

### Background

While the [HL7 Dental Data Exchange IG](https://build.fhir.org/ig/HL7/dental-data-exchange/) provides a comprehensive framework for dental data exchange in the US, German dental practice has fundamental differences:

| Aspect | US | Germany |
|---|---|---|
| Billing codes | CDT (ADA) | BEMA (KZBV) / GOZ (BZÄK) |
| Tooth identification | ADA Universal Numbering | FDI Two-Digit Notation |
| Insurance model | Commercial / Medicaid | GKV (statutory) / PKV (private) dual system |
| Treatment plan approval | Prior authorization (varies) | E-HKP via EBZ-Verfahren (mandatory for ZE) |
| Regulatory bodies | ADA, CMS | KZBV, KZVs, G-BA, Gematik |

This IG adapts the structural concepts from the US IG while binding to German terminology and conforming to the German FHIR profile ecosystem (de.basisprofil.r4, KBV Basisprofile).

### Dependencies

This IG builds on:

- [**de.basisprofil.r4**](https://simplifier.net/basisprofil-de-r4) (1.6.0-ballot2) — German FHIR base profiles (Patient, Organization, Identifier systems)
- [**kbv.basis**](https://simplifier.net/kbv-basis) (1.8.0) — KBV base profiles (Condition, Practitioner)
- [**kbv.ita.for**](https://simplifier.net/kbv-ita-for) (1.3.1) — KBV form requirements (KBV_PR_FOR_Patient)
- [**de.gematik.fhir.atf**](https://simplifier.net/atf) (1.4.1) — ATF MessageHeader for KIM/TIM transport
- [**de.cognovis.fhir.praxis**](https://github.com/cognovis/fhir-praxis-de) (0.13.0) — Shared extensions (Abrechnungsquartal, Scheintyp, Steigerungsfaktor)

### Conformance Expectations

This IG uses the conformance verbs MUST, SHOULD, and MAY as defined in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

Profiles in this IG mark elements with [Must Support](https://www.hl7.org/fhir/conformance-rules.html#mustSupport) where implementations are expected to meaningfully handle these elements. Specifically:

- **Sending systems** MUST populate Must Support elements if the data is available.
- **Receiving systems** MUST be capable of processing Must Support elements without error.

### Maturity

This IG is published as **Trial Use** (STU). It has been validated against real dental practice data from German PVS systems (Solutio charly, x.isynet) and tested with the [Aidbox FHIR server](https://www.health-samurai.io/aidbox). Feedback from implementers is welcome via [GitHub Issues](https://github.com/cognovis/fhir-dental-de/issues).

### IP Statements

This IG is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). BEMA and GOZ code systems are referenced but not reproduced; implementers must obtain these from KZBV/BZÄK respectively.
