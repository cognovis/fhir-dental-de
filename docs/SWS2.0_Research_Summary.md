# SWS 2.0 (Systemwechselschnittstelle) — Complete Field-Level Specification

## Document Information
- **Standard Name:** Spezifikation der Systemwechselschnittstelle
- **Version:** 2.0
- **Date:** 08.02.2024
- **Authority:** KZBV (Kassenzahnärztliche Bundesvereinigung)
- **Status:** Official standard for German dental practice data migration
- **Source INA:** https://www.ina.gematik.de/detailansicht/standard/spezifikation-der-systemwechselschnittstelle-10086
- **Technical Format:** Text-based record format with field separators (delimiter: ^)
- **File Format:** SWS-KART.nnn (where nnn = practice stamp number)

---

## 1. DATA STRUCTURE OVERVIEW

### File Organization
- **Format:** Line-oriented text file, variable record length (max 1024 bytes per record)
- **Encoding:** Configurable (ANSI, ASCII, Codepage 437, Codepage 850)
- **Delimiter:** ^ (configurable via X001)
- **Escape Character:** \ (configurable via X002)
- **Directory Structure:**
  - SWS-KART.nnn (main data file per practice stamp)
  - SWS-EBZ/ (subdirectory for EBZ electronic treatment request files)
  - SWS-FLAB/ (subdirectory for foreign lab documents)

### Data Export Stages
1. **Ausbaustufe 1 (Stage 1):** Patient master data + insurance cards
2. **Ausbaustufe 2 (Stage 2):** + Invoice data + dental services + prophylaxis findings
3. **Ausbaustufe 3 (Stage 3):** + Periodontal/Ortho treatment plans
4. **Ausbaustufe 4 (Stage 4):** + EBZ electronic treatment plans (ZE, KBR, KGL)

---

## 2. DATA CATEGORIES & RECORD TYPES

### 2.1 PARAMETRIC RECORDS (X-Series) — Practice Configuration
**Purpose:** System metadata and export parameters

| Record | Fields | Purpose |
|--------|--------|---------|
| **X000** | Zeichensatz (character set) | Define encoding (ANSI/ASCII/CP850/CP437) |
| **X001** | Feldtrennzeichen | Field delimiter (default: ^) |
| **X002** | Escape-Zeichen | Escape character (default: \) |
| **X003** | Exportprogramm, Datum, Uhrzeit, Version | Exporting software name, date, time, SWS version |
| **X004** | Stempelnummer | Practice stamp/billing number |
| **X005** | Praxisangaben: KZV-Nr, 6 address lines | Practice ID, billing address lines 1-6 |
| **X006** | 14 count fields | Summary counts of all record types exported (MANDATORY - last record) |
| **X010-X026** | Schlüsselinformation | Key definitions for insurance, bank, address, treatment, patient, plan numbering schemes |
| **X030** | Mahnabstände | Reminder intervals (days between notices) |
| **X031** | Recallarten | Recall types and intervals (months) |
| **X032** | Merkmale/Karteireiter | Custom tab/attribute definitions (Nos. 1-99 reserved) |

---

### 2.2 PRACTICE-LEVEL DATA (Non-Patient-Specific)

#### K-Series: Insurance/Kasse Master Data
| Record | Fields | Data |
|--------|--------|------|
| **K001** | Kassenidentifikation, Name | Insurance company ID, name |
| **K002** | Kassennummer | Insurance reference number (federal registry) |
| **K003** | [Kassenkurzname] | Short name |
| **K004** | [Kartennummer] | Insurance card reference number |
| **K005** | [Adresse] | Address (street, country, ZIP, city, addendum) |
| **K006** | [Telefon/Fax] | Contact: phone, fax, 2nd phone |
| **K007** | Ankreuzgruppe + 18 Punktwerte + Gruppenbez. + Kassenart + gültig ab | Billing point scale values (18 fields: Cons/Chir W+O, PA W+O, KBR W+O, ZE W+O, KFO W+O, IP-Alt/New W+O, GOZ/GOÄ W+O) + class + valid-from date |

**Note:** K007 contains fee-for-service point values for different billing areas (West/East German regions).

#### B-Series: Bank Account Master Data
| Record | Fields | Data |
|--------|--------|------|
| **B001** | Bank ID, Name, [BLZ], [Account No.], [IBAN], [BIC] | Bank identification (unique), name, routing number, account, or IBAN+BIC |

#### A-Series: External Address/Referrer Master Data
| Record | Fields | Data |
|--------|--------|------|
| **A001** | Überweiser-ID, Typ | Unique external party ID, type (1=Private, 2=Referrer, 3=GP/Dentist, 4=Continuation, 5=BG, 6=Other practices, 7=Labs, 8=Billing services) |
| **A002** | Name, Vorname, Geschlecht, Anrede, Titel, Zusatz, Vorsatzwort, [Zahnarztnr.] | Full name structure (required for dentists with license number) |
| **A003** | [Adresse] | Street, country code, ZIP, city, addendum |
| **A004-A007** | [Bezeichnung, Telefon, Fax, E-Mail] | Title, phone, fax, email |

#### C-Series: Dentist/Treating Provider Data
| Record | Fields | Data |
|--------|--------|------|
| **C001** | Behandler-ID | Unique provider identifier |
| **C002** | Name, aktiv (j/n) | Name, active flag |
| **C003** | Stempelnummer | Associated practice stamp |
| **C004** | [Zahnarztnr., gültig ab] | [License number, valid-from date] |

#### D-Series: Text Templates/Shortcuts
| Record | Fields | Data |
|--------|--------|------|
| **D001** | Textkürzel-ID | Unique template ID |
| **D002** | [Textzeile(n)] | Text content (multiline) |
| **D003** | Identifikator | Type: 0=General, 1=GOZ justification, 2=Diagnosis/Finding, 3=Medication, 4=Anamnesis, 5=Ortho justification, 6=HKP remark, 7=Referral text |

#### E-Series: Material & Lab Catalog Data
| Record | Fields | Data |
|--------|--------|------|
| **E001-E...** | Material/Lab master data for BEB-/BEL catalogs | (Specification for own lab billing) |

#### G-Series: GOZ/BEMA Follow-up Position Templates
| Record | Fields | Data |
|--------|--------|------|
| **G001** | [Template data for fee-for-service follow-up items] | (Used to define composite fee items) |

---

### 2.3 PATIENT-LEVEL DATA

#### S-Series: Patient Master Data (Ausbaustufe 1)
| Record | Fields | Data |
|--------|--------|------|
| **S000** | Patientenidentifikation | Unique patient ID (alphanumeric or numeric, per X015) |
| **S001** | Name, Vorname, Geschlecht, Anrede, Titel, Zusatz, Briefanrede, Vorsatzwort | Full patient name structure (8 fields) |
| **S002** | Geburtsdatum[, Verstorbendatum][, Löschdatum][, Löschdatum Patientenwunsch] | DOB (required), death date, practice deletion, patient-requested deletion |
| **S003** | [Adresse] | Street, country, ZIP, city, addendum |
| **S004-S008** | [Versichertendaten, Adresse] | **CONDITIONAL:** If exported, includes insured party (bill-payer) name/address; if present, S005-S006 become mandatory |

**Roles:**
- **Patient:** Person to be treated
- **Insured:** Payment-responsible party (may differ)
- **Relative:** Contact person for correspondence

#### V-Series: Insurance Card / eGK Electronic Health Card Data (Ausbaustufe 1)
| Record | Fields | Data |
|--------|--------|------|
| **V000** | Patientenidentifikation | Patient ID (per X015) |
| **V001-V009** | Insurance holder name, DOB, address | Insured party full identification |
| **V010-V021** | Insurance number, status, member number, street, ZIP, city, ZIP-postbox, city-postbox, postcode, city name, validity date, read date | Complete KVK (Krankenkassenkarte) data |
| **V022** | Kartenart, Kartenkennzeichen, ICCSN, Generation, VSDM/CDM Version, Anspruchsart | eGK: Card type (P/K/S), eGK indicator, ICCSN, generation (0/1/1+/2), schema version 5.2.0, claim type |
| **V023** | Quartalszugehörigkeit | Quarter membership |
| **V024** | [Kostenerstattung] | [Cost reimbursement: physician, hospital, dental, other services] |
| **V025** | [Zuzahlstatus, bis] | [Copay status + expiry date] |
| **V026-V027** | [PKV Privatversicherung] | [Private insurance: tariff, supplementary, co-pay limits] |
| **V028** | [Zulassungskennzeichen Reader] | [Reader authorization ID] |
| **V029** | [Selektivverträge] | [Selective contracts: physician, dental, type] |
| **V030** | [Ruhender Leistungsanspruch] | [Suspended claims: begin date, end date, type] |
| **V031** | [Prüfnachweise] | [Audit records: quarter, SMC-B ICCSN, eGK ICCSN, read date, time, result, error code] (repeating) |
| **V032** | [Aktenzeichen] | [Other payer reference numbers] |

**Card Types:** P=Private, K=Insurance, S=Other proof of entitlement
**eGK Generations:** 0, 1, 1+, 2 (schema currently 5.2.0)

---

### 2.4 INVOICE & SERVICE DATA (Ausbaustufe 2)

#### R-Series: Invoice/Billing Records
| Record | Fields | Data |
|--------|--------|------|
| **R000** | Patientenidentifikation | Patient ID |
| **R001** | Rechnungsnummer, Datum, Typ, Verrechnungstyp, Rechnungstext, Betrag, Fälligkeitsdatum, Zahlungsdatum, Offener Betrag, Mahnungsdatum, Mahnstufe, Mahngebühr, Behandler-ID, Euro-Kennzeichen, Rechnungs-ID | Invoice number, date, type (1=Private liquid., 2=Insurance liquid., 3=Ortho priv., 4=Ortho insur., 5=Insurance fill therapy, 6=KCH, 7-9=Denture), billing mode (normal/RZ/direct debit), description, amount (Pf/€), due date, last payment, outstanding balance, reminder date, reminder level, accumulated reminder fee, provider ID, currency flag (1=DM/2=€), internal system invoice ID |
| **R002** | [Planidentifikation, Quartal, Abschlag, Leerquartal] | [CONDITIONAL for Ortho/Denture: Plan ID, quarter, discount flag, empty-quarter flag] |

**Invoice Types:**
- 1, 2: Regular fee-for-service billing
- 3, 4: Orthodontic billing (tied to treatment plan)
- 5: Special insurance filling therapy
- 6: Denture coverage (KCH)
- 7-9: Denture direct billing

#### L-Series: Dental Service Records (Ausbaustufe 2)
| Record | Fields | Data |
|--------|--------|------|
| **L000** | Patientenidentifikation | Patient ID |
| **L001** | Datum, Sitzungsnr., Behandler-ID, Anzahl, Abrechnungsmodus, Leistungsbezeichnung, Zahnangabe, Flächen, Einzelpreis, Faktor, Plan-ID, Uhrzeit, Röntgenklassif., Anästhesiebereich, Gebühr%, Abrechnungsbereich, [Bemerkung(en)...] | Date of service, session number (per day, starting 1), provider ID, quantity, billing mode (a=billed/e=rendered/k=insurance-billed/o=not-billable), service code & description, tooth number(s) per DIN 13910, surface(s) (occlusal/mesial/distal/etc.), unit price (Pf/€ or 1/100 points), multiplier (e.g., 230 = 2.3x), plan ID (mandatory if plan-related), time of service, X-ray classification, anesthetic area (5=Denture), partial fee %, billing area (1=Cons-Chir, 2=PA, 3=KBR, 4=ZE, 5=KFO, 6=General, 7=FAL, 8=Implant, 9=KFO-Flat, 10=TMJ-disorder), remarks (may include ICD/OPS codes) |

**Billing Modes:**
- a = abgerechnet (billed)
- e = erbracht (provided but not billed)
- k = kassenabgerechnet (insurance-billed)
- o = ohne Berechnung (no charge)

**Billing Areas:**
- 1 = Conservative/Surgical
- 2 = Periodontology
- 3 = Jaw fracture
- 4 = Prosthodontics (Dentures)
- 5 = Orthodontics
- 6 = General dentistry
- 7 = Functional Analysis
- 8 = Implantology
- 9 = Ortho flat-fee
- 10 = Temporomandibular joint disorder

**Service Code Format:** 1st char: K=Insurance/P=Private; 2nd char: C=GOZ2012, Z=GOZ88, Ä=GOÄ96, K=BEMA, N=BEMA post-2004, etc.

#### L002-Series: Clinical Findings Records (Ausbaustufe 2)
*Specification mentions Prophylaxis findings (I-Series) but details preserved from VDDS-Transfer v2.25*

---

### 2.5 TREATMENT PLANS (Ausbaustufe 3 & 4)

#### P-Series: Periodontal Treatment Plans (Ausbaustufe 3)
| Record | Fields | Data |
|--------|--------|------|
| **P001** | [Plan identification, date, status, tooth/surface designations, treatment items] | Periodontology plan with specific tooth/implant notation |

#### F-Series: Orthodontic (KFO) Treatment Plans (Ausbaustufe 3)
| Record | Fields | Data |
|--------|--------|------|
| **F001** | [Plan ID, date, status, appliance type, treatment goals, monthly data] | KFO plan with staged treatment phases |

#### Z-Series: Prosthodontic/Denture (ZE) EBZ Treatment Plans (Ausbaustufe 4)
| Record | Fields | Data |
|--------|--------|------|
| **Z001** | [Plan ID, eGK treatment request number, items, coverage details] | Electronic treatment request integration |

#### W-Series: Jaw Fracture (KBR) EBZ Plans (Ausbaustufe 4)
| Record | Fields | Data |
|--------|--------|------|
| **W001** | [Plan ID, eGK request number, surgical items, fixation method] | KBR plan data |

#### U-Series: Temporomandibular Joint Disorder (KGL) EBZ Plans (Ausbaustufe 4)
| Record | Fields | Data |
|--------|--------|------|
| **U001** | [Plan ID, eGK request number, therapy items, follow-up intervals] | TMJ disorder treatment plan |

**EBZ Integration:**
- Plans stored in XML format
- Directory structure: SWS-EBZ/<Patient-Nr>/*.xml
- Includes both electronic treatment request files AND payer response files
- Plan number provides linkage (not eGK request number)

---

## 3. FIELD NOTATION & DATA TYPES

### Data Type Codes
| Code | Format | Example |
|------|--------|---------|
| **a** | Alphanumeric (any text) | "Schmidt" |
| **n** | Numeric | "2024" |
| **k(x,y)** | Decimal number (x=integer, y=decimal places) | k(3,2) = "123.45" |
| **p** | Point value (1/100,000 points), no decimal shown | "154320" = 1.5432 points |
| **b** | Boolean | "j" or "n" |
| **z** | Tooth number (DIN 13910) | "18" (upper right 1st molar), "01"=Maxilla, "02"=Mandible, "51-85"=Deciduous, "19,29,39,49,59,69,79,89"=Supernumerary |
| **d** | Date (8 char: DDMMYYYY) | "31122024" |
| **q** | Quarter (5 char: QJJJJ) | "12024" = Q1 2024 |
| **g** | Gender | "m"=male, "w"=female, "d"=diverse, "u"=unknown, "x"=not applicable |

### Tooth Notation (DIN 13910)
- **Permanent teeth:** 18-48 (right-left, top-bottom; e.g., 18=upper-right-1st-molar, 48=lower-left-1st-molar)
- **Deciduous (milk teeth):** 51-85
- **Supernumerary:** 19, 29, 39, 49, 59, 69, 79, 89
- **Jaw only:** 01 (maxilla), 02 (mandible)

### Surface/Area Notation (Filling Surfaces)
- o=occlusal, i=incisal, c=cervical, d=distal, m=mesial, v=vestibular, a=labial, b=buccal, l=lingual, p=palatal
- Numeric (1-5) per 1997 insurance billing spec

### Clinical Finding Codes
**Comprehensive notation from DIN standards:**
- f = missing
- c/C = carious (with/without filling)
- z = destroyed
- e = replaced
- x = to be extracted
- w = worth preserving
- g = healthy
- k = crown
- j = carious crown
- K = defective crown
- p = provisional crown
- t = telescope
- A = amalgam filling
- U = composite filling
- b/B = bridge abutment
- F = root filling (intact)
- i = implant
- V = sealant
- And 30+ additional codes for specific clinical conditions

---

## 4. VERSION HISTORY

### Version 2.0 (2024-02-08) — Current
**Key Updates:**
- Integrated EBZ (elektronisches Antragsverfahren = electronic treatment request)
- Added ZE (Zahnersatz = denture), KBR (Kieferbruch = jaw fracture), KGL (Kiefergelenkserkrankung = TMJ disorder) plans
- New EBZ folder structure (SWS-EBZ/, SWS-FLAB/)
- Extended plan transfer capabilities
- New provider license number (Zahnarztnr) field requirements

### Version 1.2 (2022-11-10) — Previous
- First consolidated standard by KZBV
- Based on VDDS-Transfer v2.25
- Covers Stages 1-3 (Ausbaustufen 1-3)

### Version History Notes
- **Deprecated fields** marked with `<>` must be supported for one full version after deprecation
- Deprecated data fields shown as `^^` (field placeholder) in output

---

## 5. TECHNICAL REQUIREMENTS

### File Structure
- **Primary file:** SWS-KART.nnn (nnn = practice stamp number)
- **Subdirectories (optional):**
  - SWS-EBZ/<Pat-Nr>/ (XML treatment requests + responses)
  - SWS-FLAB/<Pat-Nr>/ (XML foreign lab documents)

### Encoding & Delimiters
- **Configurable via X000, X001, X002:**
  - Character set: ANSI, ASCII, CP437, CP850
  - Field delimiter: default ^ (configurable)
  - Escape character: default \ (configurable)

### Line Terminators
- Windows/DOS: CR+LF (X'0D0A')
- Unix/Linux: LF (X'0A')

### Record Constraints
- **Max record length:** 1024 bytes (excluding line terminator)
- **Variable-length fields:** Trailing empty fields may be omitted

---

## 6. MANDATORY vs. OPTIONAL RECORDS

### Block 1 (Practice Configuration) — Always Required
- X000, X003, X004, X005, X006 (minimum)
- X010-X015 (if respective data types exported)
- K001-K007 (for any insurance data)
- B001 (if practice has bank accounts)
- C001-C004 (all treating providers)
- D001-D003 (if text templates used)

### Block 2 (Patient Data) — Stage-Dependent
**Stage 1:** S-series, V-series
**Stage 2:** + R-series, L-series (I-series for prophylaxis)
**Stage 3:** + P-series (PA plans), F-series (KFO plans)
**Stage 4:** + Z-series, W-series, U-series (EBZ plans)

---

## 7. GAP ANALYSIS CHECKLIST FOR FHIR MAPPING

### Fully Covered by SWS 2.0
- ✅ Patient demographics (name, DOB, address, gender)
- ✅ Insurance/coverage relationships (multiple KVK/eGK reads)
- ✅ Provider/clinician identification
- ✅ Clinical findings (tooth-level caries/treatment status)
- ✅ Billing procedures (with codes, dates, amounts)
- ✅ Invoice records (open items, payment tracking)
- ✅ Treatment plans (periodontal, orthodontic, prostho, TMJ)
- ✅ EBZ electronic treatment requests
- ✅ Lab case referrals (foreign lab documents)

### Partially Covered
- ⚠️ **Imaging:** No explicit DICOM/X-ray image storage (only references via L001 X-ray classification code)
- ⚠️ **Documents:** Text-based notes only; no binary attachment support
- ⚠️ **Genealogy:** No genetic/hereditary data capture
- ⚠️ **Medication:** Limited to text template references (D003 type 3)

### Not Covered by SWS 2.0
- ❌ Video/multimedia treatment documentation
- ❌ Three-dimensional scan data (CBCT, intraoral scans)
- ❌ Implant CAD/planning data
- ❌ Patient portals/consent tracking
- ❌ Real-time appointment synchronization
- ❌ Electronic signature/audit logs
- ❌ Encryption keys or PKI infrastructure

---

## 8. EXPORT RECORD SEQUENCE (Recommended)

**Block 1: Practice Configuration (always first)**
- X000-X004 (must precede X005)
- K001-K007 (insurance configuration)
- B001 (bank accounts)
- A001-A007 (external addresses)
- C001-C004 (treating providers)
- D001-D003 (text templates)
- E001-E... (material catalogs)
- G001... (fee-for-service templates)

**Block 2A: Patient-Centric Ordering**
For each patient:
- S001-S008 (patient master)
- V000-V032 (insurance cards, repeating)
- R001-R002 (invoices)
- I-series (prophylaxis findings)
- P001-... (PA plans)
- F001-... (KFO plans)
- Z001-... (denture plans)
- W001-... (jaw fracture plans)
- U001-... (TMJ plans)
- L001-... (services)

**Block 2B: Record-Type-Centric Ordering** (alternative)
- All S-series (all patients)
- All V-series (all insurance cards)
- All R-series (all invoices)
- All L-series (all services)
- All I-series (all findings)
- All P-series (all PA plans)
- All F-series (all ortho plans)
- All Z-series (all denture plans)
- All W-series (all jaw fracture plans)
- All U-series (all TMJ plans)

**Closing Record (always last)**
- X006 (summary counts of all exported record types)

---

## 9. SOURCES & REFERENCES

| Source | URL/Reference |
|--------|-----------------|
| **INA (gematik)** | https://www.ina.gematik.de/detailansicht/standard/spezifikation-der-systemwechselschnittstelle-10086 |
| **Official PDF v2.0** | https://www.ina.gematik.de/fileadmin/user_upload/Systemwechselschnittstelle_Spezifikation_Version_2.0.pdf |
| **Previous v1.2** | https://www.ina.gematik.de/fileadmin/user_upload/Systemwechselschnittstelle_Spezifikation_Version_1_2.pdf (status: previous version) |
| **VDDS-Transfer** | Evolved from VDDS-transfer Specification v2.25 |
| **KZBV** | Kassenzahnärztliche Bundesvereinigung (official German dental association) |
| **Related Standards** | Federal unified insurance company registry, DIN 13910 (tooth notation) |

---

## 10. IMPLEMENTATION NOTES

### Mandatory Behavior
1. **Field sequencing:** Records must be sent in documented order
2. **Field preservation:** All fields that can be exported MUST be sent (even if empty)
3. **Backward compatibility:** Systems must support X006 record counts for validation
4. **Plan linkage:** If services are tied to plans, L001 Feld 11 (Plan-ID) is MANDATORY

### Import Validation
- Must reject import if X005 missing or KZV-Abrechnungs-Nr mismatches
- X006 record must be present and contain matching counts
- All deprecated fields `<>` supported for one version after deprecation date

### Data Integrity
- Partial payments sent as separate R001 records (not deltas)
- Corrections sent as negative-amount records
- Credits as negative-amount R001 (type 0)
- Pre-payments as zero-amount R001 + negative outstanding balance

---

**Document Version:** 2024-02-08 (SWS 2.0 Release)
**Prepared for:** FHIR Implementation Guide Gap Analysis
**Scope:** Complete field-level data dictionary for German dental PVS system migration
