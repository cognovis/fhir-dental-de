// Central alias definitions — shared across all FSH files in this IG.
// SUSHI processes all .fsh files globally, so aliases defined here are
// available everywhere without re-declaration.

Alias: $icd10gm    = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $fdiCS      = https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi
Alias: $sct        = http://snomed.info/sct
Alias: $fdi-tooth  = http://terminology.hl7.org/CodeSystem/ex-tooth
Alias: $fdi-surface = http://terminology.hl7.org/CodeSystem/FDI-surface

// DICOM
Alias: $dicom = http://dicom.nema.org/resources/ontology/DCM

// Praxis-DE CodeSystem aliases (de.cognovis.fhir.praxis 0.43.1)
Alias: $RadiologyRoleCS            = https://fhir.cognovis.de/praxis/CodeSystem/radiology-role
Alias: $ReportSubstatusCS          = https://fhir.cognovis.de/praxis/CodeSystem/report-substatus
Alias: $ReportDistributionChannelCS = https://fhir.cognovis.de/praxis/CodeSystem/report-distribution-channel

// Praxis-DE Extension + ValueSet aliases (0.43.1 — use directly, do NOT redefine in dental IG)
Alias: $ReportSubstatusExt = https://fhir.cognovis.de/praxis/StructureDefinition/report-substatus
Alias: $ReportSubstatusVS  = https://fhir.cognovis.de/praxis/ValueSet/report-substatus
