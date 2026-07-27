# Oral Appliances for Sleep-Related Care

`PrimarySnoringCarePlanDE` identifies the primary-snoring pathway explicitly.
It references the clinical indication, available sleep-medicine assessment
evidence, the supplied Device, and any recorded Consent or DocumentReference.

Primary snoring and OSAS care are not interchangeable. An OSAS pathway is
identified separately as `osas-medical-order` and is based on a medical
diagnosis or order. A screening result alone does not establish the absence of
OSAS.

This clinical contract does not determine reimbursement, product eligibility,
or legal compliance. Missing consent or disclosure documentation is not an
automatic rejection rule.

## Medically ordered OSAS pathway

`OsasOralApplianceServiceRequestDE` represents the medical order that initiates
the dental pathway. `OsasOralApplianceEligibilityObservationDE` records the
dental disposition and references the dental observations that informed it.
The OSAS diagnosis remains a separate `Condition`.

`OsasOralApplianceCarePlanDE` requires:

- one medical order;
- one or more dental eligibility observations;
- one identified `OsasOralApplianceDeviceDE`; and
- one or more coded clinical activities.

The service-stage terminology maps to BEMA UP1 through UP6 only through a
non-authoritative `ConceptMap`. A pathway stage does not establish billability.

Eligibility values intentionally contain no AHI thresholds, medical
contraindication rules, or product brands. Those decisions remain with the
responsible clinicians and current external guidance.

Complications are separate
`OsasOralApplianceComplicationObservationDE` resources focused on the identified
Device. This preserves the history of both the appliance and the observed
clinical or technical issue.
