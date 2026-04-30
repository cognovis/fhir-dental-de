Extension: KfoBehandlungsphaseExt
Id: kfo-behandlungsphase
Title: "KFO Behandlungsphase"
Description: "Phase der kieferorthopädischen Behandlung: aktive Behandlungsphase, Retentionsphase oder Abschluss. Ergänzt CarePlan.status für den KFO-spezifischen Phasenverlauf."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-behandlungsphase"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from KfoBehandlungsphaseVS (required)
* value[x] ^short = "KFO-Behandlungsphase (aktiv|retention|abschluss)"
