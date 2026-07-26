# PAR and Prophylaxis Exchange

## PSI

`ProphylaxisObservationDE` is the canonical PSI carrier. Every PSI component
contains a base score from 0 through 4 and a required `psi-sextant` extension.
Component order has no meaning.

The `psi-additional-finding` extension represents the KZBV star modifier
separately from the base score. A sextant that cannot be assessed uses
`dataAbsentReason`; it is not assigned an invented clinical score.

## Whole-mouth index methods

API, QHI, PI, SBI, PBI, and GI are distinct machine-readable component codes.
Their values are not interchangeable. API and SBI use percent in the published
examples. Producers must retain the source scale for other methods and must not
convert between methods without an explicit, externally governed rule.

## Caries risk

The `cariesRisk` component exchanges one qualitative risk level. It is not a
caries lesion, diagnosis, recall rule, or treatment recommendation. The IG
defines no thresholds for deriving the level.

## Clinical deposits

`DentalDepositObservationDE` represents one deposit finding with:

- a clinical deposit type,
- a vertical location relative to the gingival margin,
- an affected surface or prosthetic structure, and
- a body site.

The profile supports tooth, implant, and pontic findings without nested
Observation components. Deposit terminology contains no fee codes or billing
eligibility semantics.

## Mobility and suppuration

`PeriodontalObservationDE` retains one mobility component bound to the
authoritative PAR mobility ValueSet. Suppuration on probing is a separate,
optional boolean component with the canonical periodontal measurement-site
extension.

## CarePlan linkage

A PAR CarePlan may reference baseline prophylaxis and periodontal observations
through `CarePlan.supportingInfo`. A UPT activity may reference follow-up
observations through `CarePlan.activity.outcomeReference`.

The current PAR-Richtlinie does not support a general hard invariant that PSI or
MHU must have occurred within the previous six months. This IG therefore
preserves source observations and dates without enforcing that rule.

## Performer and delegation boundary

Periodontal and prophylaxis profiles mark `Observation.performer` as Must
Support but do not make it mandatory when the source omitted it. The delegated
assessment Bundle demonstrates a measurement performed through one
PractitionerRole and a diagnosis asserted separately by a dentist.

The Observation records authorship; it does not prove authorization. A
qualification audit requires resolved Practitioner or PractitionerRole
references plus application or server policy. Measurement performer, diagnosis
asserter, and billing provider are separate roles.

## Radiographic bone loss and grading evidence

`RadiographicBoneLossObservationDE` records percentage bone loss at a reference
tooth. When `boneLossPerAge` is present, it is the bone-loss percentage divided
by the explicit age in completed years recorded in the same Observation.

The reviewed grading thresholds are below 0.25 for grade A, 0.25 through 1.0
for grade B, and above 1.0 for grade C. The ratio and related smoking or HbA1c
Observations are evidence references; the IG does not calculate age, assign a
grade, or override clinical judgment.

New Conditions reference those observations through
`Condition.evidence.detail`. The retired `ParGradingEvidenceExt` remains
resolvable only for compatibility with existing resources. HbA1c and smoking
evidence reuse the `HbA1cObservationDE` and `SmokingStatusDE` profiles from the
declared `de.cognovis.fhir.praxis` dependency. A smoking-status component in an
oral screening is only a derived summary and does not replace the independent
`SmokingStatusDE` evidence resource.
