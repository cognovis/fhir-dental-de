Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org

ValueSet: OralHealthScreeningCodesVS
Id: oral-health-screening-codes
Title: "Oral Health Screening Codes"
Description: "SNOMED-CT- und LOINC-Codes fuer Oral Health Screening: Parafunktionale Habits, orale Risikofaktoren, systemische Screening-Befunde."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/oral-health-screening-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// LOINC code for oral/dental physical findings
* $loinc#8704-9 "Physical findings of Mouth and Throat and Teeth"

// SNOMED-CT screening concepts
* $sct#110353005 "Parafunctional activity"
* $sct#364126007 "Oral hygiene status"
* $sct#102616008 "Oral cavity finding"
