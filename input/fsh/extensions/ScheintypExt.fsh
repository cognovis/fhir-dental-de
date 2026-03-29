Extension: ScheintypExt
Id: scheintyp
Title: "Scheintyp"
Description: "Art des Behandlungsscheins: Kassenschein, Überweisungsschein, Notfallschein oder Privatschein. Unterscheidet den abrechnungsrelevanten Zugangsweg zum Behandlungsfall (Satzart 2)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/scheintyp"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Encounter"

* value[x] only code
* value[x] from ScheintypVS (required)
* value[x] ^short = "Scheintyp (kassenschein|ueberweisungsschein|notfallschein|privatschein)"
