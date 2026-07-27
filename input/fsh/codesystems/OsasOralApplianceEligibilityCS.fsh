CodeSystem: OsasOralApplianceEligibilityCS
Id: osas-oral-appliance-eligibility
Title: "OSAS Oral Appliance Eligibility"
Description: "Dental disposition after assessing whether oral appliance therapy can proceed. Medical diagnosis remains outside this code system."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/osas-oral-appliance-eligibility"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

* #eligible "Eligible" "Dental assessment supports proceeding with oral appliance therapy."
* #temporarily-not-eligible "Temporarily not eligible" "A remediable dental issue currently prevents proceeding."
* #not-eligible "Not eligible" "Dental assessment does not support proceeding with oral appliance therapy."
* #requires-medical-clarification "Requires medical clarification" "The pathway requires clarification by the responsible medical clinician."
