// Central alias definitions — shared across all FSH files in this IG.
// SUSHI processes all .fsh files globally, so aliases defined here are
// available everywhere without re-declaration.

Alias: $icd10gm    = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $fdiCS      = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $sct        = http://snomed.info/sct
Alias: $fdi-tooth  = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $fdi-surface = http://terminology.hl7.org/CodeSystem/FDI-surface
Alias: $swsToothStatusCS = https://fhir.cognovis.de/dental/CodeSystem/sws2-zahnstatus
Alias: $swsToothStatusVS = https://fhir.cognovis.de/dental/ValueSet/sws2-zahnstatus-complete
Alias: $bruxismCircadianTypeCS = https://fhir.cognovis.de/dental/CodeSystem/bruxism-circadian-type
Alias: $bruxismCircadianTypeVS = https://fhir.cognovis.de/dental/ValueSet/bruxism-circadian-type
Alias: $bruxismDiagnosticGradeCS = https://fhir.cognovis.de/dental/CodeSystem/bruxism-diagnostic-grade
Alias: $bruxismDiagnosticGradeVS = https://fhir.cognovis.de/dental/ValueSet/bruxism-diagnostic-grade
Alias: $icd11Mms = http://id.who.int/icd/release/11/mms
Alias: $icd11Na0dTraumaVS = https://fhir.cognovis.de/dental/ValueSet/icd11-na0d-trauma

// DICOM
Alias: $dicom = http://dicom.nema.org/resources/ontology/DCM

// Praxis-DE CodeSystem aliases (de.cognovis.fhir.praxis 0.43.1)
Alias: $ReportSubstatusCS          = https://fhir.cognovis.de/praxis/CodeSystem/report-substatus

// Praxis-DE Extension + ValueSet aliases (0.43.1 — use directly, do NOT redefine in dental IG)
Alias: $ReportSubstatusExt = https://fhir.cognovis.de/praxis/StructureDefinition/report-substatus
Alias: $ReportSubstatusVS  = https://fhir.cognovis.de/praxis/ValueSet/report-substatus

// Praxis-DE Tax aliases (0.61.0 — used in BEMA/GOZ ChargeItem Tax-Pattern)
Alias: $TaxCategoryExt        = https://fhir.cognovis.de/praxis/StructureDefinition/ext-tax-category
Alias: $TaxExemptionReasonExt = https://fhir.cognovis.de/praxis/StructureDefinition/ext-tax-exemption-reason
// TaxCategory codes come from UN/CEFACT codelist 5305 (EN 16931 aligned: S/AA/E/AE/Z)
Alias: $UnCefact5305          = urn:un:unece:uncefact:codelist:standard:5305
Alias: $UStBefreiungsgrundCS  = https://fhir.cognovis.de/praxis/CodeSystem/ust-befreiungsgrund
