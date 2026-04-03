Extension: EigenanteilAndersartigExt
Id: eigenanteil-andersartig
Title: "Eigenanteil andersartige Versorgung"
Description: "Patientenanteil bei andersartiger Versorgung (höherwertiger Zahnersatz über Regelversorgung hinaus). Umfasst die vollständigen Mehrkosten, da der Festzuschuss nur den Regelversorgungsanteil abdeckt."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/eigenanteil-andersartig"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Claim"

* value[x] only Money
* value[x] ^short = "Patientenanteil bei andersartiger Versorgung (EUR)"
