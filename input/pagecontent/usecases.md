### Use Cases

#### SWS 2.0 Import
Import patient data from the Systemwechselschnittstelle 2.0 (KZBV/gematik standard for dental PVS data migration) into FHIR R4 resources. See [SWS 2.0 Mapping](sws-mapping.html) for the complete field-level mapping.

#### Dental Billing (BEMA/GOZ)
Represent GKV (statutory) and PKV (private) dental billing data using BemaChargeItemDE and GozChargeItemDE profiles with proper coding, tooth references, and billing extensions.

#### Treatment Plan Management
Model HKP (Heil- und Kostenplan), PAR, KFO, and ZE treatment plans with approval workflows, using the CarePlan profiles with domain-specific extensions.
