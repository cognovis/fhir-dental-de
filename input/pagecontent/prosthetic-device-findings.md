# Prosthetic Device Findings

Technical defects are observations about an identified Device. They are not
diagnoses about the patient and do not belong in a local tooth-status namespace.

`DentalProsthesisDE` identifies a removable prosthesis.
`ImplantSuprastructureDE` identifies an implant-supported crown, bridge, or
other suprastructure. The corresponding observations reference the Device
through `Observation.focus`:

- `ProsthesisFindingDE` for removable prostheses; and
- `SuprastructureFindingDE` for implant suprastructures.

The finding terminology is manufacturer-neutral. Implant-supported removable
prostheses can reference supporting `DentalImplantDE` resources without
encoding a product system or brand.

## Billing suggestions

The finding-to-BEMA and finding-to-GOZ `ConceptMap` resources provide candidate
codes only. They use `relatedto` mappings because a technical finding alone
does not establish which service was performed or whether that service is
billable. Billing systems must evaluate the performed procedure, applicable
rules, and the current catalog version separately.
