CodeSystem: FestzuschussBefundCS
Id: festzuschuss-befund
Title: "Festzuschuss-Befund nach §55 SGB V"
Description: """
Befund-Codes nach der Festzuschuss-Richtlinie des Gemeinsamen Bundesausschusses (G-BA) gemäß §55 SGB V (Festzuschuss-Kompendium der KZBV). Definiert die Befunde, die einen Festzuschuss zum Zahnersatz auslösen (Befund 1.1 bis 8.6). Codes sind in allen deutschen dentalen PVS-Systemen identisch (SWS 2.0 / EBZ).

Display-Strings in diesem öffentlichen IG sind selbstverfasste, neutrale Kurzbezeichnungen. Vollständige Originaltexte des FZ-Kompendiums werden nicht im Public IG publiziert (KZBV-Lizenz) — sie liegen als CodeSystem Supplement im internen Paket `de.cognovis.terminology.dental` (Verdaccio).
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH"
* ^copyright = "Code-Struktur basiert auf G-BA Festzuschuss-Richtlinie §55 SGB V (KZBV Festzuschuss-Kompendium 2025). Quelle: https://www.kzbv.de/wp-content/uploads/KZBV_FZ-Kompendium_2025-01-01_2.pdf — Volltexte im internen Supplement-Paket de.cognovis.terminology.dental."
* ^jurisdiction = urn:iso:std:iso:3166#DE

// Befund 1: Erhaltungswürdige Zähne
* #1.1 "Zahn weitgehend zerstört, je Zahn"
* #1.2 "Zahn mit großen Substanzdefekten, je Zahn"
* #1.3 "Zerstörter Zahn im Verblendbereich, je Verblendung"
* #1.4 "Endo-Zahn mit konfektioniertem Stiftaufbau, je Zahn"
* #1.5 "Endo-Zahn mit gegossenem Stiftaufbau, je Zahn"

// Befund 2: Zahnbegrenzte Lücken
* #2.1 "Zahnbegrenzte Lücke, ein Zahn fehlt"
* #2.2 "Zahnbegrenzte Lücke, zwei Zähne fehlen"
* #2.3 "Zahnbegrenzte Lücke, drei Zähne fehlen, je Kiefer"
* #2.4 "Frontzahnlücke, vier Zähne fehlen, je Kiefer"
* #2.5 "Angrenzende weitere Lücke mit einem Zahn"
* #2.6 "Disparallele Pfeilerzähne, Zuschlag je Lücke"
* #2.7 "Lücke im Verblendbereich, je Verblendung"

// Befund 3: Sonstige Lücken / Verkürzte Zahnreihe
* #3.1 "Sonstige Lücke oder Freiendsituation, je Kiefer"
* #3.2 "Verkürzte Zahnreihe, je Kiefer"

// Befund 4: Reduzierter Restzahnbestand
* #4.1 "Restzahnbestand bis 3 Zähne im Oberkiefer"
* #4.2 "Zahnloser Oberkiefer"
* #4.3 "Restzahnbestand bis 3 Zähne im Unterkiefer"
* #4.4 "Zahnloser Unterkiefer"
* #4.5 "Metallbasis-Zuschlag, je Kiefer"
* #4.6 "Restzahnbestand mit dentaler Verankerung, je Ankerzahn"
* #4.7 "Verblendung Teleskopkrone, Zuschlag je Ankerzahn"
* #4.8 "Restzahnbestand mit Wurzelstiftkappen, je Ankerzahn"
* #4.9 "Stützstiftregistrierung, Zuschlag je Befund"

// Befund 5: Interimsversorgung
* #5.1 "Lückengebiss bis 4 Zähne, Interimsversorgung"
* #5.2 "Lückengebiss 5–8 Zähne, Interimsversorgung"
* #5.3 "Lückengebiss über 8 Zähne, Interimsversorgung"
* #5.4 "Zahnloser Kiefer, Interimsversorgung"

// Befund 6: Wiederherstellung / Erweiterung vorhandener Versorgung
* #6.0 "Reparatur Prothese ohne Abdruck/Labor"
* #6.1 "Reparatur Prothese ohne Abdruck"
* #6.2 "Reparatur Prothese mit Abdruck (Kunststoff)"
* #6.3 "Reparatur Prothese mit Metallarbeit"
* #6.4 "Erweiterung Prothese im Kunststoff, je Zahn"
* #6.4.1 "Erweiterung Prothese Kunststoff, weiterer Zahn"
* #6.5 "Erweiterung Prothese im Metall, je Zahn"
* #6.5.1 "Erweiterung Prothese Metall, weiterer Zahn"
* #6.6 "Verändertes Prothesenlager, Teilprothese"
* #6.7 "Verändertes Prothesenlager, Total-/Deckprothese"
* #6.8 "Festsitzender Zahnersatz rezementierbar, je Zahn"
* #6.8.1 "Reparatur Adhäsivbrücke, je Flügel"
* #6.9 "Reparatur Verblendung/Facette, je Verblendung"
* #6.10 "Erneuerung Primär-/Sekundärteleskop, je Zahn"

// Befund 7: Implantatgetragener Zahnersatz
* #7.1 "Erneuerung Suprakonstruktion Einzelzahn, je Krone"
* #7.2 "Erneuerung Suprakonstruktion erweitert, je Element"
* #7.3 "Reparatur Suprakonstruktion (Facette), je Facette"
* #7.4 "Reparatur festsitzender Implantatersatz, je Element"
* #7.5 "Erneuerung implantatgetragene Prothese"
* #7.6 "Implantatgetragener Konnektor, atrophierter Kiefer"
* #7.7 "Umgestaltung Totalprothese zur Suprakonstruktion"

// Befund 8: Befunde nach Präparation / Abformung
* #8.1 "Befund nach Präparation Zahn (50 % Festzuschuss)"
* #8.2 "Befund nach Präparation Zahn erweitert (75 %)"
* #8.3 "Befund nach Präparation Brückenanker (50 %)"
* #8.4 "Befund nach Präparation Brückenanker erweitert (75 %)"
* #8.5 "Befund nach Abformung Prothese (50 %)"
* #8.6 "Befund nach Abformung Prothese erweitert (75 %)"
