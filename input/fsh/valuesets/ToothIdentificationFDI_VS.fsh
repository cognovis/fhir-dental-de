ValueSet: ToothIdentificationFDI_VS
Id: tooth-identification-fdi
Title: "Zahnidentifikation nach FDI/ISO 3950"
Description: "Permanente Zähne (11-48) nach dem FDI-Zahnschema (ISO 3950), übernommen aus dem HL7 Terminology CodeSystem ex-tooth."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/tooth-identification-fdi"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// HL7 Terminology tooth codes use FDI numbering for permanent teeth.
* include codes from system http://terminology.hl7.org/CodeSystem/ex-tooth
