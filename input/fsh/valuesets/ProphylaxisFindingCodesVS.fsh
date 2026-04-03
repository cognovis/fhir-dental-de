Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct

ValueSet: ProphylaxisFindingCodesVS
Id: prophylaxis-finding-codes
Title: "Prophylaxe-Befundcodes"
Description: "LOINC- und SNOMED-CT-Codes fuer Prophylaxe-Befunde: Plaque-Index, Mundhygienestatus, Gingivitis-Index, PSI-Screening."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/prophylaxis-finding-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// LOINC codes for prophylaxis assessments
* $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"
* $loinc#32884-9 "Identification {Tooth}"

// SNOMED-CT prophylaxis finding concepts
* $sct#18949003 "Dental plaque"
* $sct#364126007 "Oral hygiene status"
* $sct#66383009 "Gingivitis"
* $sct#251309006 "Community periodontal index of treatment need"
