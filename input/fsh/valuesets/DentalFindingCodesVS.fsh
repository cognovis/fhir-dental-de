ValueSet: DentalFindingCodesVS
Id: dental-finding-codes
Title: "Zahnärztliche Befundcodes"
Description: "Codes für zahnärztliche Befundarten: LOINC für standardisierte Beobachtungen, SNOMED-CT für klinische Befunde."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/dental-finding-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// LOINC codes for dental observations
* $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"
* $loinc#34553-8 "Dental history"
* $loinc#32884-9 "Identification {Tooth}"

// Explicit SNOMED-CT dental observation codes used by this IG.
// Do NOT use `is-a #404684003` (Clinical finding) — that hierarchy is too large
// for IG Publisher / tx.fhir.org and previously NPEd under -tx n/a (fmgt-5vw).
* $sct#364126007 "Oral hygiene status"
* $sct#113192009 "Bone structure of jaw"
* $sct#89362005 "Impacted tooth"
* $sct#80967001 "Dental caries"
* $sct#427936003 "Localized alveolar bone loss"
* $sct#718052004 "Asymptomatic periapical periodontitis"
* $sct#25780007 "Bruxism"
* $sct#87715008 "Xerostomia"
* $sct#128139000 "Inflammatory disorder of mouth"

Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct
