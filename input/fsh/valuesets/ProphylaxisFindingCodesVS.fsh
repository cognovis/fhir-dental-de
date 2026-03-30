Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct

ValueSet: ProphylaxisFindingCodesVS
Id: prophylaxis-finding-codes
Title: "Prophylaxe-Befundcodes"
Description: "LOINC- und SNOMED-CT-Codes fuer Prophylaxe-Befunde: Plaque-Index, Mundhygienestatus, Gingivitis-Index, PSI-Screening."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/prophylaxis-finding-codes"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"

// LOINC codes for prophylaxis assessments
* $loinc#34552-0 "Dental findings"
* $loinc#32884-9 "Periodontal pocket depth"

// SNOMED-CT prophylaxis finding concepts
* $sct#18949003 "Dental plaque"
* $sct#129851006 "Oral hygiene assessment"
* $sct#37397005 "Gingivitis"
* $sct#427182008 "Periodontal screening"
