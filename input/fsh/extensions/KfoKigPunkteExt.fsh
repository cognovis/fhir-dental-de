Extension: KfoKigPunkteExt
Id: kfo-kig-punkte
Title: "KFO KIG-Punkte"
Description: "Kieferorthopädischer Indikationsgrad (KIG) nach BEMA §28 Abs. 2 SGB V. Stufen 1–5 bestimmen den Anspruch auf kassenärztliche KFO-Behandlung (KIG 3–5 genehmigungspflichtig)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-kig-punkte"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Condition"
* ^context[+].type = #element
* ^context[=].expression = "Claim"

* value[x] only integer
* value[x] ^short = "KIG-Stufe (1–5), wobei 3–5 Kassenleistungsanspruch begründen"
