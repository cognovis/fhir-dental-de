Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct

ValueSet: PeriodontalFindingCodesVS
Id: periodontal-finding-codes
Title: "Parodontale Befundcodes"
Description: "LOINC- und SNOMED-CT-Codes fuer parodontale Befunde: Sondierungstiefe, Rezession, BOP, Furkation, Attachment-Level."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/periodontal-finding-codes"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"

// LOINC codes for periodontal measurements
* $loinc#32884-9 "Periodontal pocket depth"
* $loinc#32881-5 "Periodontal attachment loss"
* $loinc#LP96685-5 "Dental caries risk assessment"

// SNOMED-CT periodontal finding concepts
* $sct#40104002 "Periodontal pocket"
* $sct#6288001 "Gingival recession"
* $sct#86276007 "Bleeding on probing"
* $sct#109728009 "Furcation involvement"
* $sct#3877005 "Periodontal disease"
