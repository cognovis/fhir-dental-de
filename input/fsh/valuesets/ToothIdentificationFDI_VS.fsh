ValueSet: ToothIdentificationFDI_VS
Id: tooth-identification-fdi
Title: "Zahnidentifikation nach FDI/ISO 3950"
Description: "Zahnidentifikation nach dem FDI-Zahnschema (ISO 3950). Permanente Zähne (11-48), Milchzähne (51-85)."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/tooth-identification-fdi"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"

// FHIR R4 built-in tooth codes (FDI-based)
* include codes from system http://terminology.hl7.org/CodeSystem/ex-tooth
