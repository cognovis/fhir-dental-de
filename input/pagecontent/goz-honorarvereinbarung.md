# GOZ fee agreement under § 2

`GozChargeItemDE` distinguishes two evidence paths:

1. A medically indicated service with `factorOverride > 3.5` requires
   `GozHonorarvereinbarungExt`, representing the written fee agreement under
   GOZ § 2(1)-(2).
2. A requested service without medical necessity uses
   `VerlangensleistungExt` and its required written treatment and cost plan
   under GOZ § 2(3).

The primary source is
[GOZ § 2](https://www.gesetze-im-internet.de/goz_1987/__2.html).

## Structured agreement evidence

`GozHonorarvereinbarungExt` contains:

- a `DocumentReference` to the written agreement;
- the agreement date, which must be before `occurrenceDateTime`;
- the resulting agreed amount in EUR; and
- a fixed `reimbursementNoticeGiven = true` assertion.

The referenced document remains authoritative for the service number and
description, agreed factor, personal discussion, signatures, copy handover, and
the reimbursement warning. The IG does not infer those process facts merely
because a reference exists.

Factor `3.5` is the boundary and does not trigger the extension. A factor above
`3.5` without either the § 2(1)-(2) agreement or the separate requested-service
path violates `goz-factor-agreement`.

## Invoice boundary

[GOZ § 10](https://www.gesetze-im-internet.de/goz_1987/__10.html) requires
invoice details and a service-specific reason above factor 2.3. It does not
establish a generic rule that the § 2 agreement must be attached to the
invoice, so this IG adds no such invariant.

`GozInvoiceDE` references `GozChargeItemDE` from each DiPag line item. A line
under § 2(1)-(2) therefore reaches both the structured reimbursement notice and
the agreement `DocumentReference` through `GozHonorarvereinbarungExt`. The
`ExampleGozAgreementInvoice` example demonstrates this chain without
duplicating the agreement on the invoice.

See [Billing and Legal Sources](billing-legal-sources.html) for the complete
source register and rejected assertions.
