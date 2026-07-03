// NamingSystem for the German dentist billing identifier system.
Instance: zanr-identifier
InstanceOf: NamingSystem
Usage: #definition
Title: "ZANR Identifier System"
Description: "Identifier system for Zahnarzt-Nummer (ZANR), the KZV billing identifier for dentists."
* name = "ZANR"
* status = #active
* kind = #identifier
* date = "2026-07-03"
* publisher = "cognovis GmbH"
* description = "Zahnarzt-Nummer (ZANR), KZV billing identifier for dentists. System: http://fhir.de/sid/kzbv/zahnarztnummer"
* uniqueId[+].type = #uri
* uniqueId[=].value = "http://fhir.de/sid/kzbv/zahnarztnummer"
* uniqueId[=].preferred = true
