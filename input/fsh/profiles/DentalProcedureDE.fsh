Profile: DentalProcedureDE
Parent: Procedure
Id: de-mira-dental-procedure
Title: "Zahnärztliche Behandlung (DE)"
Description: "Profil für zahnärztliche Behandlungen in deutschen Praxen. Leistungscodes binden an BEMA (GKV) und GOZ (PKV) statt CDT."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Category: dental (Procedure.category is 0..1 in R4, not sliceable)
* category 1..1 MS
* category = DentalCategoryCS#dental "Dental"

// Procedure code: BEMA/GOZ/OPS
* code 1..1 MS
* code from DentalProcedureCodesVS (extensible)

// Subject, performer
* subject 1..1 MS
* subject only Reference(Patient)
* performer MS

// Timing
* performed[x] MS

// Tooth identification via bodySite (FDI)
* bodySite MS
* bodySite from ToothIdentificationFDI_VS (preferred)
