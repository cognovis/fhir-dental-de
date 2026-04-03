Extension: KfoApparatusTypeExt
Id: kfo-apparatus-type
Title: "KFO Apparaturtyp"
Description: "Typ der kieferorthopädischen Apparatur: festsitzend (Brackets, Bänder) oder herausnehmbar (Platten, Aligner). Bestimmt die abrechnungsrelevante BEMA-Gruppe (BEMA §28 Abs. 2 SGB V)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-apparatus-type"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from KfoApparatusTypeVS (required)
* value[x] ^short = "Apparaturtyp (festsitzend|herausnehmbar)"
