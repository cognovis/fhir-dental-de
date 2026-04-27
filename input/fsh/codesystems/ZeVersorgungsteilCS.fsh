CodeSystem: ZeVersorgungsteilCS
Id: ze-versorgungsteil
Title: "ZE Versorgungsteil (Festzuschuss-Punkte)"
Description: """
Versorgungsteile / Bauelemente einer prothetischen Versorgung, wie sie im Heil- und Kostenplan Zahnersatz auf einzelne Festzuschuss-Punkte abgebildet werden. Die Code-Liste folgt der Nummerierung des KZBV-Festzuschuss-Kompendiums (§55 SGB V Festzuschuss-Richtlinie). Codes sind in allen deutschen dentalen PVS-Systemen identisch (SWS 2.0 / EBZ).

Display-Strings in diesem öffentlichen IG sind selbstverfasste, neutrale Kurzbezeichnungen. Vollständige Originaltexte werden nicht im Public IG publiziert (KZBV-Lizenz) — sie liegen als CodeSystem Supplement im internen Paket `de.cognovis.terminology.dental` (Verdaccio).
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-versorgungsteil"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH"
* ^copyright = "Code-Struktur basiert auf KZBV Festzuschuss-Kompendium 2025 (§55 SGB V). Quelle: https://www.kzbv.de/wp-content/uploads/KZBV_FZ-Kompendium_2025-01-01_2.pdf — Volltexte im internen Supplement-Paket de.cognovis.terminology.dental."
* ^jurisdiction = urn:iso:std:iso:3166#DE

* #1 "Krone als Einzelversorgung oder Brückenanker"
* #2 "Zwischenglied einer Brücke"
* #3 "Verblendung im sichtbaren Bereich"
* #4.1 "Teilprothese aus Kunststoff"
* #4.2 "Teilprothese mit Modellguss-Basis"
* #4.3 "Pro ersetztem Zahn in Teilprothese"
* #4.4 "Teleskop-, Konus- oder Verbindungselement"
* #5 "Vollprothese (zahnloser Kiefer)"
* #6.1 "Reparatur Prothese ohne Abdruck"
* #6.2 "Reparatur Prothese mit Abdruck"
* #6.21 "Reparatur/Erweiterung mit Drahtklammern"
* #6.3 "Reparatur/Erweiterung Modellguss-Anteil"
* #6.4 "Unterfütterung ohne Randgestaltung"
* #6.5 "Unterfütterung mit Randgestaltung"
* #6.6 "Reparatur festsitzender Zahnersatz"
