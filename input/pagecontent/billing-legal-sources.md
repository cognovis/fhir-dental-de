# Billing and legal source register

This page records the authoritative sources and the implementation boundary for
dental billing assertions used by this IG. It is a review register, not legal
advice. A rule that is not supported here must not be turned into a profile
invariant or a published amount table.

## Festzuschuss amounts and bonus levels (`fdde-tc4`)

| Assertion | Source | Decision |
|---|---|---|
| The standard subsidy is 60 percent, increases to 70 percent after the five-year evidence period, and to 75 percent after the ten-year evidence period. Hardship adds up to another 40 percent of the reference amount, capped by actual costs. | [SGB V § 55](https://www.gesetze-im-internet.de/sgb_5/__55.html) | Model the legal percentage levels separately from the annually versioned monetary amount. Do not use the historic 50/60/70 levels. |
| Reference amounts are negotiated for the following year and depend on annual dental and laboratory amounts. | [SGB V § 57](https://www.gesetze-im-internet.de/sgb_5/__57.html) | Every monetary amount must carry an effective period and provenance. |
| KZBV publishes a 2026 accounting aid and states that the amounts took effect on 1 January 2026. | [KZBV Festzuschuss amounts 2026](https://www.kzbv.de/zahnaerzte/rechtsgrundlagen/festzuschuesse/festzuschussbetraege/) | The public IG demonstrates the data shape with explicitly synthetic amounts only. |
| KZBV identifies the current Festzuschuss guideline, annual amount decisions, and combination rules as separate source artifacts. | [KZBV Festzuschuss guideline](https://www.kzbv.de/zahnaerzte/rechtsgrundlagen/festzuschuesse/festzuschuss-richtlinie/) | A production dataset must bind each release to the exact source edition; the IG does not infer combinations. |

Real KZBV amount tables and catalog wording are excluded from the CC-BY public
package. They may be distributed only in a separately governed internal
terminology package after the operator has verified the applicable reuse rights.
Until that verification and ingestion exist, consumers must provide their own
licensed and current dataset. Synthetic public examples are not billing values.

## GOZ § 2 agreement (`fdde-co8`)

| Assertion | Source | Decision |
|---|---|---|
| An amount deviating from the GOZ may be agreed, but emergency and acute pain treatment may not depend on such an agreement. | [GOZ § 2(1)](https://www.gesetze-im-internet.de/goz_1987/__2.html) | The IG represents evidence of an agreement; it does not authorize one. |
| The agreement follows a personal case-specific discussion, is made in writing before the service, and includes the service number and description, agreed factor, resulting amount, and reimbursement warning. A copy is handed to the payer. | [GOZ § 2(2)](https://www.gesetze-im-internet.de/goz_1987/__2.html) | Model the document reference, agreement date, reimbursement-warning assertion, and agreed amount. Signatures, handover, and personal discussion remain document or process evidence and are not inferred from a FHIR reference. |
| Requested services under GOZ § 1(2) sentence 2 require a written treatment and cost plan before the service. | [GOZ § 2(3)](https://www.gesetze-im-internet.de/goz_1987/__2.html) | The existing claim that the written-agreement duty simply “does not apply” is rejected. Requested services use their own § 2(3) evidence path and are outside the § 2(1)-(2) invariant. |
| The invoice identifies the service date, number, description, amount and factor; factors above 2.3 require a comprehensible service-specific reason. | [GOZ § 10](https://www.gesetze-im-internet.de/goz_1987/__10.html) | § 10 does not support a generic requirement to attach the § 2 agreement to the invoice. No such attachment invariant is added. |

The bead's assertion that a missing agreement necessarily makes the amount above
3.5 unenforceable or recoverable is not implemented: no primary court decision
was supplied or verified for that proposition.

## Mixed BEMA/GOZ claims (`fdde-xht`)

| Assertion | Source | Decision |
|---|---|---|
| For equal-type prostheses, insured persons bear the additional costs above the listed standard-care services. For other-type prostheses, insurers reimburse the approved subsidy. | [SGB V § 55(4)-(5)](https://www.gesetze-im-internet.de/sgb_5/__55.html) | A mixed claim may carry BEMA and GOZ lines and must label each line's care type. |
| Festzuschuss findings are established before treatment and entered in the treatment and cost plan; annual amounts and billing rules are maintained independently. | [KZBV Festzuschuss guideline](https://www.kzbv.de/zahnaerzte/rechtsgrundlagen/festzuschuesse/festzuschuss-richtlinie/) | Keep planning (`CarePlan` or `ServiceRequest`), performed charges (`ChargeItem`), and the submitted claim (`Claim`) as separate resources. |

The public sources above support the distinction between standard, equal-type,
and other-type care. They do not by themselves prove that every equal-type FHIR
claim must contain both a BEMA and a GOZ line in the same `Claim` resource.
The IG therefore validates the machine-readable line classification and links
to typed charge items, while documenting the BEMA-plus-GOZ mixed example as an
interoperability pattern rather than a universal legal invariant.

## PAR prerequisites (`fdde-094`)

The authoritative policy surface is the
[G-BA PAR guideline](https://www.g-ba.de/richtlinien/78/). The specific assertion
that MHU 107/107a must have occurred in the preceding six months was not verified
from the source material reviewed for this stream. It must remain documentation
or follow-up work and must not become a profile constraint.

## Review checklist

A domain reviewer can approve or reject this register without reading the
implementation diff by checking:

1. each asserted rule against the linked primary source;
2. each Decision cell against the public/private boundary above;
3. that rejected or unverified claims do not appear as profile invariants; and
4. that production amount packages identify an exact source edition and
   effective period.
