Extension: PrivatgebuehrSteigerungsfaktorExt
Id: privatgebuehr-steigerungsfaktor
Title: "Privatgebühr Steigerungsfaktor"
Description: "GOÄ §5 Abs. 2 / GOZ §5 Abs. 2 Steigerungsfaktor mit Begründungspflicht bei Überschreitung des Schwellenwerts (2,3-fach persönlich / 1,8-fach technisch)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/privatgebuehr-steigerungsfaktor"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* extension contains
    faktor 1..1 and
    schwellenwert 0..1 and
    leistungsart 0..1 and
    begruendungstext 0..1 and
    begruendungskategorie 0..1

* extension[faktor].value[x] only decimal
* extension[faktor].value[x] ^short = "Angewandter Steigerungsfaktor (z.B. 2.3, 3.5)"

* extension[schwellenwert].value[x] only decimal
* extension[schwellenwert].value[x] ^short = "Schwellenwert für Begründungspflicht (2.3 persönlich, 1.8 technisch)"

* extension[leistungsart].value[x] only code
* extension[leistungsart].value[x] from PrivatgebuehrLeistungsartVS (required)
* extension[leistungsart].value[x] ^short = "Leistungsart (persoenlich|technisch)"

* extension[begruendungstext].value[x] only string
* extension[begruendungstext].value[x] ^short = "Schriftliche Begründung bei Faktor >Schwellenwert (GOÄ/GOZ §5 Abs. 2)"

* extension[begruendungskategorie].value[x] only code
* extension[begruendungskategorie].value[x] from PrivatgebuehrBegruendungskategorieVS (required)
* extension[begruendungskategorie].value[x] ^short = "Kategorie der Begründung"
