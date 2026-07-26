# Dental mixed billing claim

`DentalClaimDE` is the validation anchor for a structured dental claim that can
carry BEMA and GOZ lines in one billing event.

## Resource boundary

The resources remain separated by responsibility:

1. `DentalCarePlanDE` represents alternatives (`intent = option`) and the
   selected executable plan (`intent = plan`).
2. BEMA and GOZ `ServiceRequest` resources represent the planned services.
3. `BemaChargeItemDE` and `GozChargeItemDE` represent performed charges and
   carry the billing `Account` context.
4. `DentalClaimDE` submits machine-readable lines and coverage order.

The Claim does not embed a ChargeItem in `item.detail`. FHIR R4 has no
ChargeItem reference at that path. Instead, each typed ChargeItem is carried in
`supportingInfo.valueReference`; the Claim line points to its supporting entry
through `item.informationSequence`.

## Line contract

`DentalClaimDE.item` has open BEMA and GOZ slices, discriminated by the coding
system in `productOrService`. Each prosthesis line may carry:

- `careType` using `regelversorgung`, `gleichartig`, or `andersartig`;
- `festzuschussAmount` with finding, benefit percentage, amount, effective
  period, and exact source edition; and
- `informationSequence` linking the line to its performed ChargeItem.

Within this profile, any `gleichartig` line activates the
`dental-claim-equal-type-mix` rule: at least one BEMA and one GOZ line must be
present. This is the IG's interoperability contract for a mixed equal-type
claim, not a statement that every legal billing transport uses one FHIR Claim.

## Coverage order

`insurance.sequence` expresses payer order. The example uses the statutory
coverage as focal sequence 1 and a supplementary dental coverage as sequence 2.
Coverage sequence does not change the BEMA or GOZ identity of a line.

## Examples and invalid variant

`ExampleDentalClaimMixed` contains:

- BEMA 91d and GOZ 5040 lines marked `gleichartig`;
- typed links to `ExampleMixedBemaChargeItem` and
  `ExampleMixedGozChargeItem`;
- GKV and supplementary dental coverage; and
- a clearly synthetic 2026 Festzuschuss amount.

Removing the BEMA line while retaining a `gleichartig` GOZ line violates
`dental-claim-equal-type-mix`. A BEMA-only `regelversorgung` claim and a
GOZ-only `andersartig` claim do not activate that rule.

See [Billing and Legal Sources](billing-legal-sources.html) for source scope and
the public/private amount boundary.
