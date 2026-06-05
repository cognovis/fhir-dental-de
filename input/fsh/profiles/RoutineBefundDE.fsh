Profile: RoutineBefundDE
Parent: DentalFindingDE
Id: routine-befund
Title: "Routine Dental Findings (DE)"
Description: "Profile for routine dental findings (BEMA-01 / GOZ-0010 eingehende Untersuchung). Binds the code element to standardized routine finding ValueSets for billing and documentation purposes."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: routine finding code from BEMA-01 or GOZ-0010
* code 1..1 MS
* code from RoutineBefundVS (extensible)
* code ^short = "BEMA-01 or GOZ-0010 routine finding code"
* code ^definition = "Code identifying the type of routine dental finding documented during initial examination (eingehende Untersuchung). Codes from BEMA (public insurance, KZV) or GOZ (private insurance)."

// Subject
* subject 1..1 MS
* subject only Reference(Patient)

// Timing
* effective[x] 1..1 MS

// bodySite is optional
* bodySite 0..1
* bodySite from ToothIdentificationFDI_VS (preferred)
