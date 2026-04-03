ValueSet: DentalFindingCodesVS
Id: dental-finding-codes
Title: "Zahnärztliche Befundcodes"
Description: "Codes für zahnärztliche Befundarten: LOINC für standardisierte Beobachtungen, SNOMED-CT für klinische Befunde."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/dental-finding-codes"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"

// LOINC codes for dental observations
* $loinc#34552-0 "Dental findings"
* $loinc#34553-8 "Dental history"
* $loinc#32884-9 "Periodontal attachment level"

// SNOMED-CT dental finding concepts
* include codes from system $sct
  where concept is-a #404684003   // Clinical finding (oral subset)

Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct
