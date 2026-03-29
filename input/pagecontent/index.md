### Introduction

This Implementation Guide defines FHIR R4 profiles for dental practice data in the German healthcare system.

It provides profiles for dental procedures (with BEMA/GOZ billing codes), conditions, clinical findings (Zahnschema), and communication — built on the German FHIR base profiles.

### Background

While the [HL7 Dental Data Exchange IG](https://build.fhir.org/ig/HL7/dental-data-exchange/) provides a comprehensive framework for dental data exchange in the US, German dental practice has fundamental differences in billing systems (BEMA/GOZ vs. CDT), tooth identification (FDI vs. ADA Universal), and regulatory requirements (KZBV, Gematik).

This IG adapts the structural concepts from the US IG while binding to German terminology and conforming to the German FHIR profile ecosystem.
