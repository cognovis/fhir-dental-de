# Consolidated Dental Findings, Device Findings, OSAS, and Invoice Contract

## Feature Description

Complete the remaining clinically useful dental IG surfaces in one integration
worktree:

1. verify the already-merged SWS 2.0 migration;
2. add a lesion-level ICDAS caries observation;
3. add pulp sensibility testing without conflating sensibility, vitality, and
   periapical findings;
4. add a shared device-focused model for removable-prosthesis and implant-
   suprastructure technical findings, with billing suggestions kept separate;
5. add the medically ordered OSAS oral-appliance pathway on the existing sleep
   appliance foundation; and
6. integrate a GOZ invoice profile directly on the official gematik
   `DiPagRechnung` contract after the required Praxis release is available.

The adapter implementation is outside this repository. The Charly schema
inventory is read-only evidence for which source fields a later mapper can
reasonably populate.

## Approaches Considered

### Approach A: Implement each legacy bead literally

- Pros: closest to the old descriptions.
- Cons: duplicates the existing SWS, implant Device, sleep pathway, and
  invoice foundations; mixes clinical findings with billing triggers;
  retains incorrect ICDAS and GOZ assumptions.

### Approach B: Consolidate around reusable FHIR R4 boundaries

- Pros: reuses existing profiles, keeps clinical/device/billing semantics
  separate, provides one coherent public contract, and supports the future
  adapter without vendor-specific fields.
- Cons: names and structures differ from some legacy bead sketches.

### Approach C: Defer all terminology to a separate terminology release

- Pros: strongest package separation.
- Cons: blocks useful profile work and is unnecessary for the small,
  workflow-bound code systems introduced here.

### Recommendation

Approach B. It minimizes duplicate artifacts and uses native R4 relationships:
`Observation.focus` for device findings, `CarePlan.supportingInfo` for the
medical order, and `Invoice.lineItem.chargeItemReference` for performed GOZ
charges.

## Break Analysis

**Risk Level:** YELLOW

| Dimension | Level | Evidence | Mitigation |
|---|---|---|---|
| Technical complexity | YELLOW | Multiple new profiles and FHIRPath constraints | Add focused examples and inspect generated snapshots |
| Blast radius | YELLOW | New artifacts affect package and IG navigation | Additive profiles; reuse existing canonicals |
| Reversibility | GREEN | Git-tracked FSH and documentation only | One feature branch/worktree |
| Data integrity | GREEN | No runtime data migration | Adapter remains out of scope |
| Security impact | GREEN | No credentials or external writes | Public, vendor-neutral artifacts only |

### Assumptions

- `de.cognovis.fhir.praxis#0.88.0` provides the shared Account and ChargeItem
  foundations, while `de.gematik.dipag#1.0.8` provides the invoice contract.
- The future adapter can map invoice headers from its invoice table and line
  details from its performed-charge table.
- The current US Dental Data Exchange ballot is an alignment target, not a
  package dependency.

### Fragile Points

- FHIR R4 `Invoice` has a limited supporting-document surface.
- Some technical device findings have multiple possible billing outcomes.
- Clinical eligibility thresholds for OSAS appliances must not become hard
  validator rules.

## Developer Decisions

1. Work is performed in one worktree and one feature branch.
2. The public IG must contain no PVS vendor or internal product references.
3. The invoice profile derives directly from `DiPagRechnung`; Dental adds only
   GOZ-specific line and Account constraints.
4. GOZ section 2 agreements may be linked as supporting documents but are not
   required attachments to every invoice.
5. Billing mappings are suggestions in `ConceptMap`, never properties that
   automatically trigger a charge.
6. ICDAS lesion scores contain only codes 0 through 6.
7. Thermal and electric tests are modeled as pulp sensibility; true vitality
   tests and periapical findings are separate concepts.

## Relevant Files

- `input/fsh/profiles/DentalFindingDE.fsh`
- `input/fsh/profiles/PrimarySnoringCarePlanDE.fsh`
- `input/fsh/profiles/ImplantSuprastructureDE.fsh`
- `input/fsh/profiles/GozChargeItemDE.fsh`
- `input/fsh/aliases.fsh`
- `input/fsh/codesystems/`
- `input/fsh/valuesets/`
- `input/fsh/conceptmaps/`
- `input/fsh/examples/`
- `input/pagecontent/`
- `test/Profile/`
- `sushi-config.yaml`

## Step by Step Tasks

### Task 1: Verify the SWS migration baseline

**Files:** `sushi-config.yaml`, `input/fsh/profiles/DentalConditionDE.fsh`,
`input/fsh/examples/ExampleDentalFindingZahnbefund.fsh`

**Change:** Confirm the published SWS package is pinned, tooth status is not a
Condition stage, and examples use the published canonical.

**Red test:** Not applicable; this behavior is already merged.

**Green code:** No code unless verification reveals drift.

**Verify:** repository search and `sushi .`.

### Task 2: Add lesion-level caries findings

**Files:** new ICDAS CodeSystem/ValueSet, `CariesObservationDE.fsh`, example,
profile validation request, and narrative.

**Change:** Require one FDI tooth, allow explicit surfaces, bind the result to
ICDAS 0-6, and keep radiographic and aggregate DMFT observations separate.

**Red test:** Add a negative validation request using ICDAS code 7.

**Green code:** Add the profile and terminology so codes 0-6 validate and code 7
does not.

**Verify:** `sushi .`, generated profile inspection, profile validation fixture.

### Task 3: Add pulp sensibility findings

**Files:** new component terminology, `PulpSensibilityObservationDE.fsh`,
example, validation request, and narrative.

**Change:** Model cold, heat, and electric sensibility results; use native
`Observation.device`; keep percussion, palpation, and mobility out of this
profile.

**Red test:** Add a negative validation request that attempts to use an
unsupported periapical component.

**Green code:** Add the constrained component slices and example.

**Verify:** `sushi .`, generated profile inspection, profile validation fixture.

### Task 4: Add prosthetic-device technical findings

**Files:** new `DentalProsthesisDE`, shared device-finding terminology and
profile, removable and implant-specific child profiles, examples, ConceptMaps,
tests, and narrative.

**Change:** Reference durable prosthetic Devices through `Observation.focus`.
Keep billing suggestions in separate ConceptMaps and avoid automatic triggers.

**Red test:** Add negative validation requests for the wrong focus profile and
out-of-scope finding code.

**Green code:** Implement the Device and finding profiles plus suggestion maps.

**Verify:** `sushi .`, generated profile/ConceptMap inspection, validation
fixtures.

### Task 5: Add the medically ordered OSAS pathway

**Files:** new eligibility/complication terminology,
`OsasOralApplianceCarePlanDE.fsh`, focused observation profiles, example,
tests, and sleep-appliance narrative.

**Change:** Require the medical `ServiceRequest`, reuse
`SleepAppliancePathwayCS#osas-medical-order`, reference the appliance Device,
and avoid manufacturer-specific systems or hard clinical thresholds.

**Red test:** Add a negative validation request without a medical order.

**Green code:** Add the profile and supporting observations.

**Verify:** `sushi .`, generated profile inspection, validation fixture.

### Task 6: Add the GOZ invoice contract

**State:** Implemented after publication of Praxis 0.88.0 and direct pinning of
DiPag 1.0.8.

**Files:** new invoice supporting-document extension, `GozInvoiceDE.fsh`,
invoice examples, tests, billing narrative, profiles list, and interoperability
guidance.

**Change:** Derive directly from `DiPagRechnung`; require an Account and at
least one `GozChargeItemDE` reference. Reuse all DiPag totals, tax, payment,
correction, laboratory, deduction, and attachment semantics without asserting a
universal agreement attachment duty.

**Red test:** Add negative validation requests for an invoice without line
items and for an inline billing code instead of a ChargeItem reference.

**Green code:** Implement the profile and representative tax-free and mixed-tax
examples.

**Verify:** `sushi .`, generated snapshot inspection, profile validation
fixtures.

### Task 7: Complete documentation and package verification

**Files:** `input/pagecontent/*.md`, `CHANGELOG.md`, `sushi-config.yaml`.

**Change:** Document resource boundaries, source authority, international
alignment, and the future adapter mapping contract without naming a vendor in
public IG surfaces.

**Red test:** Not applicable to documentation.

**Green code:** Update the IG pages, navigation, and changelog.

**Verify:** full Publisher build, vendor guard, copyright guard, and package
build.

## Test Plan

### Test Framework

- SUSHI compilation: `sushi .`
- IG Publisher: `scripts/build-local-ig.sh`
- Static guards: `scripts/vendor-leak-guard.sh`,
  `scripts/check-copyright.sh`
- Package check: `scripts/build-package.sh --skip-sushi`
- Runtime profile fixtures: existing `test/Profile/*.http`

### Expected Results

- SUSHI reports zero errors.
- Publisher adds no unexplained errors for changed artifacts.
- All new profiles and examples are emitted.
- Public-source guards pass.
- The SWS migration remains intact.

## Acceptance Criteria

1. SWS 2.0 remains the only active tooth-status namespace.
2. ICDAS lesion findings exchange scores 0-6 without restoration-status
   conflation.
3. Pulp sensibility observations distinguish sensibility from vitality and
   periapical findings.
4. Removable-prosthesis and implant-suprastructure technical findings reuse a
   shared device-focused model with separate billing suggestions.
5. Medically ordered OSAS appliance care requires an external medical order and
   contains no manufacturer-specific terminology.
6. The GOZ invoice derives directly from `DiPagRechnung` and adds no duplicate
   local invoice financial contract.
7. Documentation, SUSHI, Publisher, and repository guards for tasks 1 through 5
   are green.

## Means of Compliance

| # | Criterion | MoC | Planned Evidence |
|---|---|---|---|
| 1 | SWS migration intact | review | repository search and SUSHI output |
| 2 | ICDAS 0-6 | integ | generated ValueSet/profile and validation fixture |
| 3 | Sensibility boundary | review | profile component diff and example |
| 4 | Device findings | integ | profiles, examples, ConceptMaps |
| 5 | OSAS medical order | integ | profile invariant and examples |
| 6 | GOZ invoice contract | integ | generated snapshot and invoice examples |
| 7 | Build quality | smoke | SUSHI, Publisher, guards, package build |

### Recommendation

Ready to implement.
