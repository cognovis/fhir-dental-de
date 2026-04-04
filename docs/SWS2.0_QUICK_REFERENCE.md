# SWS 2.0 — Quick Reference for FHIR Gap Analysis

## Data Domains & FHIR Mapping

| SWS Domain | Record Series | FHIR Resource(s) | Coverage | Notes |
|------------|---------------|-----------------|----------|-------|
| **Patient Demographics** | S001-S008 | Patient, RelatedPerson | ✅ Complete | Name, DOB, gender, address, insured party relation |
| **Insurance/Coverage** | V000-V032, K001-K007 | Coverage, Organization | ✅ Complete | Multiple KVK/eGK reads, insurance company data |
| **Providers** | C001-C004, A001-A007 | Practitioner, Organization | ✅ Complete | Dentist/provider + external referrers, license numbers |
| **Clinical Findings** | L001, L002 | Observation, Condition | ✅ Most | Tooth-level caries/treatment status via clinical codes |
| **Procedures/Services** | L001 | Procedure, Claim | ✅ Complete | Date, provider, tooth, surface, code, cost, billing mode |
| **Billing/Invoices** | R001-R002 | Claim, Invoice, Account | ✅ Complete | Invoice number, date, amount, due date, payment tracking |
| **Treatment Plans** | P001, F001, Z001, W001, U001 | CarePlan, RequestGroup | ✅ Partial | Periodontal, Ortho, Denture, Jaw fracture, TMJ plans |
| **Lab Referrals** | SWS-FLAB/ | ServiceRequest, Communication | ✅ Partial | Foreign lab documents (XML), no detail specification |
| **eGK Requests** | SWS-EBZ/ | ServiceRequest | ✅ Partial | Electronic treatment requests (XML) + responses |
| **Text Templates** | D001-D003 | DocumentReference, Annotation | ⚠️ Partial | Diagnosis, medication, anamnesis, justification texts |
| **Imaging** | L001 (X-ray ref) | DiagnosticReport, Media | ❌ Missing | Only classification code; no actual image storage |

---

## Record Type Hierarchy

### Block 1: Practice Configuration (Always First)
```
X000-X006  → X010-X026 → X030-X032
    ↓
K001-K007 (Insurance master)
    ↓
B001 (Bank accounts)
    ↓
A001-A007 (External addresses)
    ↓
C001-C004 (Dentists)
    ↓
D001-D003 (Text templates)
    ↓
E001-E... (Material catalogs)
    ↓
G001-G... (Fee-for-service templates)
```

### Block 2: Patient Data (Per Stage)
**Stage 1:**
```
S000-S008 → V000-V032 (repeating per card read)
```

**Stage 2:** Add
```
R000-R001 (invoices)
L000-L001 (services)
I-series (prophylaxis findings)
```

**Stage 3:** Add
```
P001-... (Periodontal plans)
F001-... (KFO plans)
```

**Stage 4:** Add
```
Z001-... (Denture plans)
W001-... (Jaw fracture plans)
U001-... (TMJ plans)
```

**Always:** X006 (summary counts) — LAST

---

## Critical Field Mappings

### Patient Identity
| SWS Field | Type | FHIR Equivalent | Required |
|-----------|------|-----------------|----------|
| S000 | a/n | Patient.identifier | Yes |
| S001 | a^a^g^a^a^a^a^a | Patient.name + Patient.birthDate + Patient.gender | Yes |
| S002-01 | d | Patient.birthDate | Yes (non-zero) |
| S002-02 | d | Patient.deceased | No |
| S003 | a^a^a^a^a | Patient.address | Conditional |
| S004-S008 | (conditional) | RelatedPerson / Patient.contact | Conditional |

### Insurance Coverage
| SWS Field | Type | FHIR Equivalent | Key Detail |
|-----------|------|-----------------|------------|
| V000 | a/n | Coverage.relationship.patient | Patient ID |
| V001-V009 | name data | Coverage.subscriber + Coverage.subscriberId | Insured party identification |
| V010-V021 | address, insurance#, dates | Coverage.identifier + Coverage.period | KVK card data |
| V022 | card type + generation | Coverage.type + meta.profile | eGK P/K/S, generation 0/1/1+/2 |
| V023 | q | Coverage.period.start | Quarter membership |
| K001-K003 | insurance ID + name | Coverage.payor (Organization) | Insurance company |
| K007 | point values (18 fields) | Organization.extension[points] | Fee schedule per region + area |

### Service/Procedure
| SWS Field | Type | FHIR Equivalent | Key Detail |
|-----------|------|-----------------|------------|
| L001-01 | d | Procedure.performedDateTime | Date of service |
| L001-03 | n/a | Procedure.performer.actor (Practitioner) | Provider ID |
| L001-06 | a | Procedure.code | Service code (K/P + C/Z/Ä/K/N/A/X/Y) |
| L001-07 | z | Procedure.bodySite (tooth) | DIN 13910 tooth number |
| L001-08 | a | Procedure.extension[surfaces] | Filling surfaces (o/m/d/i/c/etc) |
| L001-09 | n | Claim.item.unitPrice | Unit price (Pf/€) |
| L001-10 | k(3,2) | Claim.item.factor | Multiplier (1.0-3.0+) |
| L001-16 | n | Claim.category | Billing area (1-10) |

### Invoice/Claim
| SWS Field | Type | FHIR Equivalent | Key Detail |
|-----------|------|-----------------|------------|
| R001-01 | n/a | Claim.identifier / Invoice.identifier | Invoice/claim number |
| R001-02 | d | Claim.created / Invoice.date | Date of invoice |
| R001-03 | n | Claim.type | Invoice type (1-9) |
| R001-06 | a | Claim.total / Invoice.totalNetAmount | Total amount (Pf/€) |
| R001-08 | d | Claim.item.servicedDate | Service period |
| R001-11 | n | Account.balance | Outstanding balance (Pf/€) |
| R001-12 | d | Claim.insuranceReviewDate | Last reminder date |
| R001-13 | n | Account.coverage (Claim.status) | Reminder level |

### Treatment Plan
| SWS Field | Type | FHIR Equivalent | Key Detail |
|-----------|------|-----------------|------------|
| P001, F001, Z001, W001, U001 | [varied] | CarePlan.activity | Plan type (PA/KFO/ZE/KBR/KGL) |
| R002-01 | n/a | Claim.item.careTeamSequence | Linked plan ID |
| R002-03 | b | Claim.item.discount | Discount applied |

---

## Gap Summary for FHIR IG

### What SWS 2.0 Provides ✅
1. **Complete patient master data** with gender, DOB, address, name variants
2. **Insurance coverage history** with multiple eGK/KVK reads, validity dates, coverage types
3. **Provider identification** with license numbers (Zahnarztnr), stamp numbers
4. **Clinical findings** using DIN 13910 tooth notation + detailed clinical status codes
5. **Billing procedures** with dates, costs, tooth/surface specificity, multipliers
6. **Invoice tracking** with open items, reminder levels, payment dates
7. **Treatment plans** for 5 specialties (PA, KFO, ZE, KBR, KGL)
8. **Electronic treatment requests** via EBZ (XML files in subdirectories)
9. **Lab case referrals** (foreign lab documents, XML format)

### What SWS 2.0 Lacks ❌
1. **Imaging data storage** — No DICOM or image binary; only classification reference code
2. **Three-dimensional scans** — CBCT, intraoral scans not supported
3. **Digital signatures** — No audit trail or signature infrastructure
4. **Real-time synchronization** — Static export format, not event-driven
5. **Genetics/genealogy** — No hereditary condition data
6. **Medications** — Limited to text template references; no structured medication list
7. **Consent management** — No explicit consent/legal basis fields
8. **Video/multimedia** — Text-only documentation

---

## Data Type Quick Lookup

| Notation | Meaning | Example | Usage |
|----------|---------|---------|-------|
| a | Alphanumeric text | "Schmidt-König" | Names, descriptions |
| n | Numeric integer | "2024" | Counts, codes |
| k(3,2) | Decimal (3 int, 2 decimal) | "123.45" | Multipliers, ratios |
| p | Points (1/100,000) | "154320" = 1.5432 Pkte | Billing point values |
| b | Boolean | "j" or "n" | Flags, yes/no |
| z | Tooth (DIN 13910) | "18" (UR molars), "51-85" (deciduous) | Tooth-specific procedures |
| d | Date DDMMYYYY | "31122024" | All date fields |
| q | Quarter QJJJJ | "12024" = Q1 2024 | Quarterly data |
| g | Gender | "m"/"w"/"d"/"u"/"x" | Patient gender |

---

## Import Validation Checklist

- [ ] X005 present and KZV-Abrechnungs-Nr matches practice
- [ ] X006 last record with count validation
- [ ] All field separators consistent (default: ^)
- [ ] Character encoding declared (X000)
- [ ] All referenced K/B/A/C records present before use
- [ ] All S-series patients have unique S000 IDs
- [ ] All V000 linked to valid S000 patients
- [ ] All L001 tooth numbers valid per DIN 13910
- [ ] All plan IDs (L001 field 11) present in P/F/Z/W/U series
- [ ] R001 invoice types match billing area in L001
- [ ] Date fields non-zero and logically sequenced
- [ ] Amount fields positive except for credits (negative)

---

## Version Compatibility

| Field | v1.2 Status | v2.0 Status | Action |
|-------|------------|-----------|--------|
| **EBZ plans (Z/W/U)** | Not present | New (Stage 4) | Add new parse logic |
| **Zahnarztnr (C004)** | Optional | Mandatory for dentists | Enforce if provider type |
| **K007 point values** | Present | Present (extended) | Expand from 12 to 18 fields |
| **Deprecated fields** | Marked `<>` | Removed or `^^` placeholder | Support backward compat 1 version |
| **eGK generation** | Not specified | 0/1/1+/2 | Add generation tracking |
| **V031 audit records** | Not present | New (V022+) | Support verification history |

---

## File Export Checklist

**Before export:**
- [ ] All patients have S001 name + S002 DOB
- [ ] All insurance reads have V000 + V001-V021
- [ ] All services have L001 provider, code, amount
- [ ] All invoices have R001 date + amount + due date
- [ ] Plan-related services have L001 field 11 (Plan-ID) populated

**Export order:**
- [ ] X000-X006, X010-X026, X030-X032 (first)
- [ ] K001-K007, B001, A001-A007, C001-C004, D001-D003, E001, G001
- [ ] Per patient: S-series → V-series → R-series → L-series → (P/F/Z/W/U)-series
- [ ] X006 (last, with correct counts)

---

**Last Updated:** 2024-02-08 (SWS 2.0 Release)
**For:** German Dental Practice FHIR Implementation Guide (fhir-praxis-de)
