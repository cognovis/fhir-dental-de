Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct

ValueSet: PeriodontalFindingCodesVS
Id: periodontal-finding-codes
Title: "Parodontale Befundcodes"
Description: "LOINC- und SNOMED-CT-Codes fuer parodontale Befunde: Sondierungstiefe, Rezession, BOP, Furkation, Attachment-Level."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/periodontal-finding-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// LOINC codes for periodontal measurements
* $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"
* $loinc#32884-9 "Identification {Tooth}"
* $loinc#32881-5 "Periodontal attachment loss"

// SNOMED-CT periodontal finding concepts
* $sct#109629007 "Periodontal pocket"
* $sct#6288001 "Gingival recession"
* $sct#86276007 "Bleeding on probing"
* $sct#109728009 "Furcation involvement"
* $sct#2556008 "Periodontal disease"

// SNOMED-CT bone resorption concepts
* $sct#95570007 "Alveolar bone loss"
* $sct#427936003 "Localized alveolar bone loss"
* $sct#428245007 "Generalized alveolar bone loss"
