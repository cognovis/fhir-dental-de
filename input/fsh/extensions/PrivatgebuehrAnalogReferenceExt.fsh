Extension: PrivatgebuehrAnalogReferenceExt
Id: privatgebuehr-analog-reference
Title: "Privatgebühr Analogleistung"
Description: "GOÄ §6 Abs. 2 / GOZ §6 Abs. 1 Analogleistungsbezug: Verweis auf die analoge Gebührennummer mit Gebührenordnung und Begründungstext."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-analog-reference"
* ^status = #active
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* extension contains
    analoge-nummer 1..1 and
    gebuehrenordnung 1..1 and
    begruendung 0..1

* extension[analoge-nummer].value[x] only string
* extension[analoge-nummer].value[x] ^short = "Analoge Gebührennummer (z.B. '2080' für analoges Vorgehen nach GOZ)"

* extension[gebuehrenordnung].value[x] only code
* extension[gebuehrenordnung].value[x] from GebuehrenordnungVS (required)
* extension[gebuehrenordnung].value[x] ^short = "Gebührenordnung (goae|goz)"

* extension[begruendung].value[x] only string
* extension[begruendung].value[x] ^short = "Begründung für die Analogabrechnung gemäß §6 GOÄ/GOZ"
