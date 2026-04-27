Extension: ZeHaerteFallExt
Id: ze-haerte-fall
Title: "ZE Härtefall"
Description: "Kennzeichnung als Härtefall nach § 55 SGB V. Patienten mit regelmäßiger Zahnarztbehandlung erhalten einen erhöhten Festzuschuss bei Zahnersatz."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-haerte-fall"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only boolean
* value[x] ^short = "Härtefall: true wenn Festzuschuss-Erhöhung nach § 55 SGB V greift"
