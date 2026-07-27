ValueSet: DentalProcedureCodesVS
Id: dental-procedure-codes
Title: "Zahnärztliche Leistungscodes"
Description: """Vereinigtes ValueSet für zahnärztliche Prozeduren: BEMA (GKV), GOZ (PKV)
und klinische Mechanismuskategorien für fokussierte parodontale Zusatzverfahren.
Die klinischen Kategorien enthalten keine Abrechnungs- oder Erstattungssemantik.
OPS surgical codes (5-23/5-24 descendants) remain usable via the extensible binding;
they are not composed with descendent-of filters here because those require a
terminology client and previously NPEd/hung IG Publisher builds (fmgt-5vw)."""
* ^url = "https://fhir.cognovis.de/dental/ValueSet/dental-procedure-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* include codes from system http://fhir.de/CodeSystem/kzbv/bema
* include codes from system GozCS
* include codes from system PeriodontalAdjunctiveProcedureTypeCS
