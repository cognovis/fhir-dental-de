CodeSystem: ZeVersorgungsartCS
Id: ze-versorgungsart
Title: "ZE Versorgungsart"
Description: "Art der Zahnersatz-Versorgung nach §56 SGB V. Bestimmt die Berechnung des Festzuschusses und die Eigenanteilspflicht des Patienten."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-versorgungsart"
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

* #regelversorgung "Regelversorgung" "Kassenübliche Standardversorgung; Festzuschuss deckt den Standardkostenanteil (§56 Abs. 1 SGB V)"
* #gleichartig "Gleichartige Versorgung" "Anderes Material, aber gleichwertige Funktion wie Regelversorgung; Festzuschuss wie Regelversorgung, Patient trägt Mehrkosten (§56 Abs. 2 SGB V)"
* #andersartig "Andersartige Versorgung" "Höherwertiger Zahnersatz über Regelversorgung hinaus; Festzuschuss nur auf Regelversorgungsbasis, Patient trägt alle Mehrkosten (§56 Abs. 2 SGB V)"
