Extension: HkpGenehmigungsstatusExt
Id: hkp-genehmigungsstatus
Title: "HKP Genehmigungsstatus"
Description: "Genehmigungsstatus des Heil- und Kostenplans (HKP) bei der Krankenkasse. Enthält Status, Datum der Einreichung, Datum der Genehmigung und optionalen Änderungsgrund. Die EBZ-Referenznummer (E-HKP-ID) wird separat über die Extension `ehkp-id` (EhkpIdExt) gesetzt."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/hkp-genehmigungsstatus"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* extension contains
    status 1..1 and
    eingereicht-am 0..1 and
    genehmigt-am 0..1 and
    aenderungsgrund 0..1

* extension[status].value[x] only code
* extension[status].value[x] from HkpGenehmigungsstatusVS (required)
* extension[status].value[x] ^short = "Genehmigungsstatus (eingereicht|in-pruefung|genehmigt|abgelehnt|geaendert-genehmigt)"

* extension[eingereicht-am].value[x] only dateTime
* extension[eingereicht-am].value[x] ^short = "Datum der Einreichung bei der Krankenkasse"

* extension[genehmigt-am].value[x] only dateTime
* extension[genehmigt-am].value[x] ^short = "Datum der Genehmigung durch die Krankenkasse"

* extension[aenderungsgrund].value[x] only string
* extension[aenderungsgrund].value[x] ^short = "Begründung bei geändertem HKP"
