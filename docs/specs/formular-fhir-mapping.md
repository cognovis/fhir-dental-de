# Dental forms to FHIR resource mapping

Status: Research baseline, 2026-07-28.

This document inventories how the principal German dental plan, application,
finding, and laboratory-order families can be decomposed into reusable FHIR R4
resources. It also records which components already exist in FHIR Dental DE.

It is not an EBZ wire-format specification. The KZBV EBZ contract remains the
authoritative operational exchange format. A FHIR representation can support
the clinical record, Polaris/MIRA processing, validation, and future standards
discussion without claiming wire compatibility with EBZ.

## Executive result

FHIR Dental DE already contains most of the reusable clinical components needed
to demonstrate the major dental form graphs:

- one generic `DentalCarePlanDE` for ZE/HKP, PAR, KFO, KBR, KGL, and PMB plans;
- `DentalConditionDE` and a broad family of dental finding `Observation`
  profiles;
- `DentalLabServiceRequestDE`, including VITA shade and other clinical
  laboratory instructions;
- `DentalClaimDE`, BEMA/GOZ `ChargeItem` profiles, and examples for mixed
  reimbursement;
- dental practitioner, role, organization, encounter, imaging, device, and
  communication profiles;
- `DentalAtfBundleDE` for an ATF message carrying dental findings and
  conditions.

The principal gaps are document and authorization envelopes:

- no dental form-specific `Composition`;
- no EBZ application Bundle profile;
- no dental `ClaimResponse` profile separating a payer decision from the
  clinical plan;
- no normative graph tying plan, findings, requested services, costs, payer
  decision, and transport metadata together.

Therefore the claim "we have composed the necessary component data" is already
credible for ZE/HKP, PAR, KFO, and the dental laboratory order, with different
degrees of completeness. It is not yet equivalent to "we implement the EBZ
contract".

## Architectural layers

```text
Reusable record layer
├── DentalCarePlanDE
├── DentalConditionDE
├── DentalFindingDE and specialized Observations
├── DentalProcedureDE
├── DentalLabServiceRequestDE
├── DentalClaimDE and ChargeItems
├── Dental devices and imaging
└── Patient, practitioner role, organization, encounter, coverage

Optional document layer
├── form-specific Composition
└── Bundle(type=document)

External workflow/transport layer
├── EBZ request and payer response
├── KIM or another mandated transport
└── ATF message where the ATF use case applies
```

The layers must remain separable. In particular,
[DentalAtfBundleDE](../../input/fsh/profiles/DentalAtfBundleDE.fsh) is a
`message` Bundle led by `MessageHeader`; it is not a generic dental document
Bundle and does not replace an EBZ application contract.

## External publication status

The following status is current as of 2026-07-28:

| Subject | External publisher state | Consequence for FHIR Dental DE |
|---|---|---|
| KZBV EBZ | Operational and mandatory for the covered dental application and approval processes since 2023 | EBZ is the production contract. No official KZBV FHIR package for ZE/eHKP, PAR, KFO, KBR, or KGL was identified in the reviewed sources. Local FHIR profiles must not claim EBZ conformance. |
| Electronic therapeutic remedies | gematik prerelease `gemF_VO_Heilmittel` 1.0.0_CC, published 2026-07-17 for commentary through 2026-09-30 | The concept explicitly cites the dental therapeutic-remedy directive. It is a draft functional concept, not a released technical FHIR contract. Dental applicability must be monitored and cross-mapped. |
| Dental laboratory order | No official KZBV or gematik FHIR ballot/package was identified | `DentalLabServiceRequestDE` is a local, reusable implementation that already covers VITA shade and other instructions. It is not an externally released form contract. |
| ATF findings transfer | Local `DentalAtfBundleDE` profile | This is delivered in this IG for its stated message payload, but it is not a KZBV EBZ release and not a generic dental form envelope. |
| FHIR Dental DE resource layer | Local IG artifacts | These profiles demonstrate resource-level composability. Their publication state and version are independent of KBV, KZBV, and gematik standardization status. |

No ballot was found for the dental form families in the sources reviewed. The
only current formal consultation directly affecting this inventory is the
gematik therapeutic-remedy prerelease. "No package identified" is intentionally
scoped to the official KZBV, KBV, gematik, and public FHIR package sources
reviewed; it is not a claim that no vendor format exists.

## Maturity labels

External and local maturity must be read separately:

| Label | Meaning |
|---|---|
| Operational external | The KZBV contract is in production, even when it is not a FHIR package. |
| Commentary / draft | A public prerelease may still change and is not a stable dependency. |
| No official FHIR package identified | No matching released or ballot FHIR package was found in the reviewed official sources. |
| Delivered | A dedicated reusable profile exists in this repository. |
| Partial | Most domain components exist, but a complete form or authorization graph does not. |
| Example only | The graph is demonstrated by examples but is not normatively constrained as a form. |
| Envelope gap | No form-specific `Composition` or Bundle contract exists. |
| External | The authoritative operational contract is outside this IG. |

## Form-family matrix

| Family | Reusable FHIR graph | External stage | Existing components | Local state | Principal gap |
|---|---|---|---|---|---|
| ZE treatment plan | `DentalCarePlanDE` + dental findings + planned devices/procedures + BEMA/GOZ costs | KZBV EBZ operational; no official FHIR package identified | Care plan, ZE finding/therapy extensions, care type, hardship, claims, ChargeItems, examples | Partial, strong | Formal application/decision graph and envelope |
| eHKP authorization | ZE graph + payer request/response + coverage | KZBV EBZ operational; no official FHIR package identified | eHKP identifier and embedded approval-status extension | Partial | Separate `Claim`/`ClaimResponse` semantics and EBZ envelope |
| PAR plan | `DentalCarePlanDE` + `DentalConditionDE` + periodontal findings + grading evidence + planned activities | KZBV EBZ operational; no official FHIR package identified | PAR stage/grade/phase, UPT interval, findings, HbA1c/smoking evidence, examples | Partial, strong | Formal application/decision graph and envelope |
| KFO plan | `DentalCarePlanDE` + orthodontic condition + imaging/findings + planned activities/appliance | KZBV EBZ operational; no official FHIR package identified | KFO phase, apparatus, Angle class, KIG, care-plan example, imaging | Partial | Detailed service/activity constraints, payer response, envelope |
| KBR plan | `DentalCarePlanDE` + trauma/condition/imaging + procedures | KZBV EBZ operational; no official FHIR package identified | Plan type and example; trauma and imaging profiles | Partial | KBR-specific normative constraints and authorization envelope |
| KGL plan | `DentalCarePlanDE` + condition/findings + therapy activities | KZBV EBZ operational; no official FHIR package identified | Plan type and example | Partial | KGL-specific findings, activities, and authorization envelope |
| PMB plan | `DentalCarePlanDE` + prophylaxis findings + recall activities | No official FHIR package identified | Plan type, example, prophylaxis observations | Partial | Plan-specific normative constraints |
| Dental laboratory order | `DentalLabServiceRequestDE` + plan + laboratory organization + clinical instructions + optional ChargeItems | No official KZBV/gematik FHIR package identified | Dedicated profile, extensions, terminology, examples | Delivered, strong | Order document/message envelope and explicit manufactured-output linkage |
| Findings transfer | dental findings + conditions + patient + sender/recipient | Local IG contract, not KZBV EBZ | `DentalAtfBundleDE` and example | Delivered for stated ATF payload | Narrow payload; not a plan/application bundle |
| Dental therapeutic-remedy order | `ServiceRequest` + diagnosis + remedy details + dental requester/context | gematik functional concept 1.0.0_CC in commentary | Shared Praxis therapeutic-remedy profile is relevant prior art; no dental graph is claimed | Gap / external draft | Decide shared versus dental specialization after crosswalk |
| Private treatment and cost plan | care plan + GOZ ChargeItems + coverage + invoice/claim context | No official FHIR package identified | Care plan, GOZ ChargeItems, requested-service and fee-agreement support | Partial | Dedicated cost-plan profile and signed document envelope |

## Shared context resources

The following profiles can be reused across all dental form families:

- [DentalPractitionerDE](../../input/fsh/profiles/DentalPractitionerDE.fsh)
- [DentalPractitionerRoleDE](../../input/fsh/profiles/DentalPractitionerRoleDE.fsh)
- [DentalOrganizationDE](../../input/fsh/profiles/DentalOrganizationDE.fsh)
- [DentalEncounterDE](../../input/fsh/profiles/DentalEncounterDE.fsh)
- patient and coverage profiles inherited from FHIR Praxis DE;
- [DentalCommunicationDE](../../input/fsh/profiles/DentalCommunicationDE.fsh)
  for communication records, not as a replacement for the exchanged payload.

## ZE and eHKP

[DentalCarePlanDE](../../input/fsh/profiles/DentalCarePlanDE.fsh) is the central
record resource. It distinguishes plan types through `category[planType]` and
already supports:

- ZE finding and therapy codes;
- regular, same-type, and different-type care;
- hardship;
- eHKP identifier;
- embedded submission and approval status;
- conditions through `addresses`;
- findings through `supportingInfo`;
- activities and timing.

Supporting reimbursement resources are:

- [DentalClaimDE](../../input/fsh/profiles/DentalClaimDE.fsh);
- [BemaChargeItemDE](../../input/fsh/profiles/BemaChargeItemDE.fsh);
- [GozChargeItemDE](../../input/fsh/profiles/GozChargeItemDE.fsh);
- [ExampleHkpCarePlan](../../input/fsh/examples/ExampleHkpCarePlan.fsh);
- [ExampleZeCarePlan](../../input/fsh/examples/ExampleZeCarePlan.fsh).

This is enough for a clinical record and a proof graph. It is not yet an ideal
authorization model. A payer decision should eventually be representable as a
separate response resource rather than only as an extension embedded in the
plan. The existing FHIR Praxis DE PAS profiles are useful prior art for
`Claim`, `ClaimResponse`, and `Task`.

## PAR

The PAR component graph is particularly mature:

- [DentalCarePlanDE](../../input/fsh/profiles/DentalCarePlanDE.fsh) for plan,
  phase, UPT interval, activities, and supporting information;
- [DentalConditionDE](../../input/fsh/profiles/DentalConditionDE.fsh) with PAR
  stage and grade extensions;
- [PeriodontalObservationDE](../../input/fsh/profiles/PeriodontalObservationDE.fsh);
- [RadiographicBoneLossObservationDE](../../input/fsh/profiles/RadiographicBoneLossObservationDE.fsh);
- [ProphylaxisObservationDE](../../input/fsh/profiles/ProphylaxisObservationDE.fsh);
- HbA1c and smoking-status evidence from FHIR Praxis DE;
- [ExampleParCarePlan](../../input/fsh/examples/ExampleParCarePlan.fsh).

The reusable resources cover diagnosis, evidence, treatment phase, and recall.
The remaining work is primarily the normative application/response envelope and
any precise parity check against the authoritative EBZ fields.

## KFO, KBR, KGL, and PMB

All four plan types are represented by `DentalCarePlanDE` and examples:

- [KFO](../../input/fsh/examples/ExampleKfoCarePlan.fsh)
- [KBR](../../input/fsh/examples/ExampleKbrCarePlan.fsh)
- [KGL](../../input/fsh/examples/ExampleKglCarePlan.fsh)
- [PMB](../../input/fsh/examples/ExamplePmbCarePlan.fsh)

KFO also has dedicated extensions and terminology for treatment phase,
apparatus, Angle class, and KIG. KBR can reuse trauma and imaging profiles.
KGL and PMB currently rely more heavily on generic CarePlan fields and examples.

This distinction matters: an example demonstrates representability, while a
profile proves conformance constraints. The matrix therefore classifies these
families as partial rather than complete.

## Dental laboratory order

The suspected VITA preparation is already implemented. The core resource is
[DentalLabServiceRequestDE](../../input/fsh/profiles/DentalLabServiceRequestDE.fsh).
It covers:

| Content | FHIR representation | Existing artifact |
|---|---|---|
| Order identity | `ServiceRequest.identifier` | Profile constraint |
| Patient | `ServiceRequest.subject` | Profile constraint |
| ZE/HKP relationship | `ServiceRequest.basedOn` to `CarePlan` | Profile constraint |
| Dental laboratory | `ServiceRequest.performer` to `Organization` | Profile constraint and dental organization example |
| Ordering dentist | `ServiceRequest.requester` | Profile constraint |
| Requested work | `ServiceRequest.code`, category, note | Profile constraint and value set |
| Tooth/region | body site and dental identifiers as used by examples/profile | Existing dental terminology |
| Restoration type | extension | `RestorationTypeExt` |
| VITA Classical shade | extension | `ToothColorVitaExt` + `VitaClassicalVS` |
| Material | extension | `MaterialSpecificationExt` |
| Preparation | extension | `PreparationTypeExt` + value set |
| Antagonist situation | extension | `AntagonistSituationExt` |
| Occlusion concept | extension | `OcclusionConceptExt` + value set |
| Implant/abutment | extension | `ImplantAbutmentExt` |
| Delivery deadline | `occurrence[x]` and shared manufacturing extension where applicable | Existing profile/extensions |
| Laboratory costs | separate BEL/GOZ `ChargeItem` resources | Existing profiles and examples |
| Manufactured result | `Device`/prosthesis and `Procedure` | Existing dental device/procedure profiles, but linkage is not yet normative |

Evidence examples include:

- [ExampleDentalLabServiceRequest](../../input/fsh/examples/ExampleDentalLabServiceRequest.fsh)
- [ExampleLabOrderZirkonkrone](../../input/fsh/examples/ExampleLabOrderZirkonkrone.fsh)
- [ExampleLabOrderTeleskopprothese](../../input/fsh/examples/ExampleLabOrderTeleskopprothese.fsh)

The next useful step is not another standalone shade profile. It is a complete
order graph example or Bundle that links:

```text
DentalLabServiceRequestDE
├── basedOn -> DentalCarePlanDE
├── performer -> DentalOrganizationDE
├── requester -> DentalPractitionerRoleDE
├── supportingInfo -> scans, images, and findings
├── output -> manufactured Device/prosthesis (agreed linkage)
└── accounting -> BEL/GOZ ChargeItems
```

FHIR R4 `ServiceRequest` has no general `output` element. The result linkage
therefore needs a deliberate pattern, for example `Procedure.basedOn`,
`DeviceRequest`/`Device`, a report, or a narrowly justified extension. It
should not be improvised in the form Bundle.

## Should Dental DE define Composition and Bundle profiles?

It can. A dental document Bundle can constrain a `Composition` plus the plan,
findings, context, costs, and payer resources. This is useful when it proves a
real contract, not merely because the paper or XML form groups fields together.

### Recommended sequence

1. Treat the existing profiles as the canonical reusable record layer.
2. Add non-normative complete graph examples for ZE/eHKP, PAR, KFO, and the
   dental laboratory order.
3. Validate each graph against the corresponding operational field inventory.
4. Add a thin form-specific `Composition` and document Bundle only when needed
   for rendering, signing, exchange, external review, or a formal proposal.
5. Model payer request and response separately before declaring an EBZ graph
   complete.

### Suggested first envelopes

| Candidate | Value | Recommendation |
|---|---|---|
| Dental laboratory order | Direct practice-to-lab consumer, strong component profiles, visible VITA use case | First proof Bundle; normative only with a transport consumer |
| ZE/eHKP | Broadest existing plan/cost/approval component set | First authorization graph; resolve payer response before normative Bundle |
| PAR | Strong clinical evidence graph | Second authorization graph |
| KFO | Useful but activity/service detail is less constrained | Follow after ZE/PAR |
| KBR/KGL/PMB | Mostly generic plan plus examples | Keep as examples until constraints are consumer-driven |

The existing ATF Bundle should remain separate. It proves that the IG can
profile transport Bundles, but its message semantics and payload are not a
template for document Bundles.

## Recommended backlog

| Priority | Outcome |
|---|---|
| 1 | Complete dental laboratory order graph with plan, findings/attachments, laboratory, requester, manufactured result, and costs |
| 2 | Define a shared dental application/authorization graph using separate request and payer-response resources |
| 3 | Compare ZE/eHKP and PAR graphs field by field with the authoritative EBZ contract |
| 4 | Add complete non-normative Bundle examples for laboratory, ZE/eHKP, PAR, and KFO |
| 5 | Promote only consumer-backed examples to form-specific Composition and Bundle profiles |
| 6 | Add KBR, KGL, and PMB constraints when their examples no longer provide sufficient validation |

## Sources

- [KZBV: Electronic application and approval procedure (EBZ)][kzbv-ebz]
- [KZBV EBZ questions and answers][kzbv-ebz-faq]
- [gematik: therapeutic-remedy prerelease 1.0.0_CC](https://gemspec.gematik.de/prereleases/Draft_VO_Heilmittel_26_1/)
- [FHIR package registry: de.gevko.evo.hlm](https://packages.fhir.org/de.gevko.evo.hlm)
- [FHIR R4 Composition](https://hl7.org/fhir/R4/composition.html)
- [FHIR R4 documents and document Bundles](https://hl7.org/fhir/R4/documents.html)
- [FHIR R4 ServiceRequest](https://hl7.org/fhir/R4/servicerequest.html)
- Repository FSH profiles and examples linked throughout this document

[kzbv-ebz]: https://www.kzbv.de/zahnaerzte/digitales/elektronisches-beantragungs-und-genehmigungsverfahren/
[kzbv-ebz-faq]: https://www.kzbv.de/zahnaerzte/digitales/elektronisches-beantragungs-und-genehmigungsverfahren/wichtige-fragen-und-antworten/
