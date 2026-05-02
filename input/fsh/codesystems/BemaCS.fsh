CodeSystem: BemaCS
Id: bema
Title: "BEMA - Bewertungsmaßstab zahnärztlicher Leistungen"
Description: "Gebührenverzeichnis für zahnärztliche Leistungen im Rahmen der gesetzlichen Krankenversicherung (GKV). Herausgegeben von KZBV und GKV-Spitzenverband."
* ^url = "http://fhir.de/CodeSystem/kzbv/bema"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag)"
* ^copyright = "Volltext-Bezeichnungen (BEMA-Leistungstexte) sind Eigentum von KZBV/GKV-Spitzenverband und nicht im öffentlichen IG enthalten. Lizenzierte Volltexte über das private Paket de.cognovis.terminology.dental verfügbar."
* ^property[0].code = #punkte
* ^property[0].uri = "https://fhir.cognovis.de/dental/CodeSystem/property#punkte"
* ^property[0].description = "BEMA-Punktzahl"
* ^property[0].type = #integer

// Konservierende Behandlung (01-39)
* #01 "Eingehende Untersuchung" // copyright-allowlist: BEMA-Z Leistungstext
* #01a "Eingehende Untersuchung Nachkontrolle" // copyright-allowlist: BEMA-Z Leistungstext
* #04 "Lokale Anästhesie"
* #05 "Exstirpation Pulpa"
* #06 "Überkappung direkt" // copyright-allowlist: BEMA-Z Leistungstext
* #07 "Überkappung indirekt" // copyright-allowlist: BEMA-Z Leistungstext
* #08 "Devitalisierung Pulpa"
* #09 "Medikamentöse Einlage"
* #10 "Wurzelkanalaufbereitung einwurzelig"
* #11 "Wurzelkanalaufbereitung zweiwurzelig (zweiter Kanal)"
* #12 "Wurzelkanalaufbereitung mehrwurzelig (dritter Kanal)"
* #13a "Wurzelkanalfüllung einwurzelig"
* #13b "Wurzelkanalfüllung zweiwurzelig (zweiter Kanal)"
* #13c "Wurzelkanalfüllung mehrwurzelig (dritter Kanal)"
* #13d "Wurzelkanalfüllung (vierter Kanal)"
* #17 "Aufbaufüllung" // copyright-allowlist: BEMA-Z Leistungstext
* #18 "Kompositfüllung einflächig" // copyright-allowlist: BEMA-Z Leistungstext
* #19 "Kompositfüllung zweiflächig" // copyright-allowlist: BEMA-Z Leistungstext
* #20 "Kompositfüllung dreiflächig" // copyright-allowlist: BEMA-Z Leistungstext
* #21 "Einflächige Füllung Seitenzahn"
* #22 "Zweiflächige Füllung Seitenzahn"
* #23 "Dreiflächige Füllung Seitenzahn"
* #24 "Vier- oder mehrflächige Füllung Seitenzahn"
* #25 "Einflächige Füllung Frontzahn"
* #26 "Zweiflächige Füllung Frontzahn"
* #27 "Dreiflächige Füllung Frontzahn"
* #28 "Vier- oder mehrflächige Füllung Frontzahn"
* #29 "Fissurenversiegelung (kons.)" // copyright-allowlist: BEMA-Z Leistungstext
* #30 "Stillung einer übermäßigen Blutung"
* #31 "Versiegelung kariesfreier Fissuren"
* #32 "Adhäsive Befestigung"
* #33 "Provisorische Krone" // copyright-allowlist: BEMA-Z Leistungstext
* #34 "Teilkrone" // copyright-allowlist: BEMA-Z Leistungstext
* #35 "Verblendkrone"
* #36 "Stahlkrone als Aufbaukrone"
* #37 "Einlagefüllung (Inlay)"
* #38 "Behandlung Zahnhartsubstanzdefekt"
* #39 "Entfernung Füllungsmaterial"

// Chirurgische Leistungen (40-52)
//
// Hinweis (Vereinfachtes Nummernschema): Die Codenummern #40-52 dieses Fragments
// entsprechen NICHT den offiziellen BEMA-Z-Nummern des KZBV-Katalogs.
//
// Begründung: Der offizielle BEMA-Z-Katalog belegt die Nummern 40–41b für
// Leitungs- und Infiltrationsanästhesie (in diesem Fragment durch #04 abgedeckt)
// sowie 43–48 für Zahnentfernungen in verschiedenen Schwierigkeitsgraden.
// Dieses Fragment verwendet sequentielle vereinfachte Bezeichner #40–52, um
// Kollisionen mit den offiziellen Anästhesie-Positionen zu vermeiden und eine
// konsistente Nummerierung innerhalb der chirurgischen Leistungsgruppe zu gewährleisten.
//
// Näherungsweise Zuordnung zu offiziellen BEMA-Z-Positionen (Abschnitt III):
//   #40 (Zahnentfernung einwurzelig)          → BEMA-Z 43/44   (Extraktion einfach/erschwert)
//   #41 (Zahnentfernung mehrwurzelig)          → BEMA-Z 45/47   (Extraktion besonders erschwert, mehrwurzelig)
//   #42 (Zahnentfernung durch Osteotomie)      → BEMA-Z 46/48   (Operative Zahnentfernung mit Osteotomie)
//   #43 (Wurzelspitzenresektion einwurzelig)   → BEMA-Z 54a     (WSR einwurzelig)
//   #44 (Wurzelspitzenresektion mehrwurzelig)  → BEMA-Z 54b/54c (WSR zwei-/mehrwurzelig)
//   #45 (Behandlung einer Alveolitis)          → BEMA-Z Abschn. III (Alveolitis-Behandlung)
//   #46 (Inzision eines Abszesses)             → BEMA-Z Abschn. III (Inzision)
//   #47 (Naht zur Wundversorgung)              → BEMA-Z Abschn. III (Wundversorgung)
//   #48 (Exzision von Mundschleimhaut)         → BEMA-Z Abschn. III (Exzision Mundschleimhaut)
//   #49 (Entfernung einer Zyste)               → BEMA-Z Abschn. III (Zystenoperation)
//   #50 (Entfernung eines retinierten Zahnes)  → BEMA-Z Abschn. III (Retinierter/verlagerter Zahn)
//   #51 (Frenektomie)                          → BEMA-Z Abschn. III (Frenektomie)
//   #52 (Sequestrotomie)                       → BEMA-Z Abschn. III (Sequestrotomie)
//
// ConceptMap-Impact: Keine. Die Codes #40–52 werden in keiner der ConceptMaps
// (DicomModalityToBemaSuggestion, SidexisLogicalNameToBemaGoz) referenziert.
* #40 "Zahnentfernung einwurzelig"
* #41 "Zahnentfernung mehrwurzelig"
* #42 "Zahnentfernung durch Osteotomie" // copyright-allowlist: BEMA-Z Leistungstext
* #43 "Wurzelspitzenresektion einwurzelig"
* #44 "Wurzelspitzenresektion zweiwurzelig oder mehrwurzelig"
* #45 "Behandlung einer Alveolitis"
* #46 "Inzision eines Abszesses" // copyright-allowlist: BEMA-Z Leistungstext
* #47 "Naht zur Wundversorgung" // copyright-allowlist: BEMA-Z Leistungstext
* #48 "Exzision von Mundschleimhaut"
* #49 "Entfernung einer Zyste"
* #50 "Entfernung eines retinierten Zahnes"
* #51 "Frenektomie"
* #52 "Sequestrotomie"

// Parodontologie (100-108)
* #100 "Parodontalstatus" // copyright-allowlist: BEMA-Z Leistungstext
* #101 "Mundhygiene-Unterweisung"
* #102 "Supragingivale Zahnsteinentfernung"
* #103 "Subgingivale Instrumentierung je Quadrant"
* #104 "Lappenoperation parodontal" // copyright-allowlist: BEMA-Z Leistungstext
* #105 "Gingivektomie"
* #106 "Schienung parodontal gelockerter Zähne"
* #107 "Entfernen harter Zahnbeläge"
* #107a "Entfernen harter Zahnbeläge (Versicherte mit Pflegegrad oder Eingliederungshilfe)"
* #107b "Nachbehandlung PAR (weitere Sitzung)"
* #108 "Einschleifen des natürlichen Gebisses"

// Früherkennung / Kinderuntersuchungen (FU)
* #FU1 "Früherkennungsuntersuchung Säugling (ab 6. Lebensmonat)"
* #FU2 "Früherkennungsuntersuchung Kleinkind (12-24 Monate)" // copyright-allowlist: BEMA-Z Leistungstext
* #FU3 "Früherkennungsuntersuchung Kleinkind (24-36 Monate)" // copyright-allowlist: BEMA-Z Leistungstext
* #FU4 "Früherkennungsuntersuchung Kind (3-6 Jahre)"
* #FU5 "Früherkennungsuntersuchung Kind (6-9 Jahre)"
* #FU6 "Früherkennungsuntersuchung Kind (9-12 Jahre)"
* #FU7 "Früherkennungsuntersuchung Jugendlicher (12-15 Jahre)"
* #FU8 "Früherkennungsuntersuchung Jugendlicher (15-18 Jahre)"
* #FU9 "Früherkennungsuntersuchung für Kinder mit erhöhtem Kariesrisiko"

// Individualprophylaxe (IP)
* #IP1 "Mundhygienestatus Erhebung" // copyright-allowlist: BEMA-Z Leistungstext
* #IP2 "Mundhygiene-Unterweisung und -Instruktion"
* #IP3 "Zahnreinigung (professionell)"
* #IP4 "Fluoridierung lokale Applikation" // copyright-allowlist: BEMA-Z Leistungstext
* #IP5 "Fissurenversiegelung (IP)" // copyright-allowlist: BEMA-Z Leistungstext
* #IP6 "Remotivation und Erfolgskontrolle"

// Zahnersatz - Prothetische Leistungen (75-89b)
* #75 "Abformung für Zahnersatz"
* #76 "Kieferrelationsbestimmung"
* #77 "Anprobe Zahnersatz"
* #78 "Eingliederung Zahnersatz"
* #79 "Nachbehandlung Zahnersatz"
* #80 "Unterfütterung Prothese" // copyright-allowlist: BEMA-Z Leistungstext
* #81 "Reparatur Prothese" // copyright-allowlist: BEMA-Z Leistungstext
* #82 "Erneuerung Prothesenzahn"
* #84 "Nachsorge nach Implantatversorgung"
* #87a "Provisorische Krone oder Brückenglied (laborgefertigt)" // copyright-allowlist: BEMA-Z Leistungstext
* #87b "Provisorische Teilprothese (laborgefertigt)" // copyright-allowlist: BEMA-Z Leistungstext
// Hinweis: Implantatgetragene Versorgungen sind im GKV-Bereich (BEMA) nur bei
// bestimmten medizinischen Indikationen nach § 28 Abs. 2 SGB V erstattungsfähig.
* #89a "Implantatgetragene Krone (GKV-Indikation)"
* #89b "Implantatgetragene Brücke (GKV-Indikation)"

// Zahnersatz - Festzuschüsse (91a-98b)
// Hinweis: Der Festzuschuss nach § 55 SGB V basiert auf Befundklassen (z. B. 1.1, 2.1).
// Die Codes 91a-98b entsprechen keinen offiziellen BEMA-Z-Codenummern, sondern sind
// interne Bezeichner für die jeweiligen Befund-/Versorgungsgruppen im Festzuschuss-System.
* #91a "Einzelkrone (Regelversorgung)"
* #91b "Einzelkrone (gleichartige Versorgung)"
* #92 "Inlay oder Teilkrone" // copyright-allowlist: BEMA-Z Leistungstext
* #93a "Brückenglied (Regelversorgung)" // copyright-allowlist: BEMA-Z Leistungstext
* #93b "Brückenglied (gleichartige Versorgung)" // copyright-allowlist: BEMA-Z Leistungstext
* #94a "Prothesenzahn (Regelversorgung)"
* #94b "Prothesenzahn (gleichartige Versorgung)"
* #95a "Modellgussprothese (Regelversorgung)"
* #95b "Modellgussprothese (gleichartige Versorgung)"
* #96a "Totalprothese (Regelversorgung)" // copyright-allowlist: BEMA-Z Leistungstext
* #96b "Totalprothese (gleichartige Versorgung)" // copyright-allowlist: BEMA-Z Leistungstext
* #97a "Implantatgetragener Zahnersatz (Regelversorgung)"
* #97b "Implantatgetragener Zahnersatz (gleichartige Versorgung)"
* #98a "Wiederherstellung Zahnersatz (Regelversorgung)"
* #98b "Wiederherstellung Zahnersatz (gleichartige Versorgung)"

// Kieferorthopädie (119a-128)
* #119a "KFO-Untersuchung und Planung (Erstuntersuchung)"
* #119b "KFO-Untersuchung und Planung (Folgeuntersuchung)"
* #119c "KFO-Diagnostik Modellanalyse"
* #119d "KFO-Diagnostik Fernröntgen-Analyse"
* #120 "Herausnehmbare Apparatur einfach"
* #121 "Herausnehmbare Apparatur aufwendig"
* #122 "Aktivator oder Bionator" // copyright-allowlist: BEMA-Z Leistungstext
* #123 "Funktionskieferorthopädisches Gerät" // copyright-allowlist: BEMA-Z Leistungstext
* #124 "Festsitzende Apparatur je Zahn (Bracket)"
* #125 "Gaumennahterweiterungsgerät" // copyright-allowlist: BEMA-Z Leistungstext
* #126 "KFO-Retention herausnehmbar"
* #127 "KFO-Retention festsitzend"
* #128 "KFO-Nachsorge und Kontrolle"

// PAR-Leistungen nach PAR-Richtlinie 2021
* #ATG "Antiinfektiöse Therapie, subgingival, Full-Mouth"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 28
* #MHU "Mundhygieneunterweisung"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 45
* #AIT-a "Antiinfektiöse Therapie 1-3 Zähne"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #AIT-b "Antiinfektiöse Therapie 4 oder mehr Zähne"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #BEV "Befundevaluation nach antiinfektiöser Therapie"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 40
* #CPT-a "Chirurgische Parodontaltherapie 1-3 Zähne"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 30
* #CPT-b "Chirurgische Parodontaltherapie 4 oder mehr Zähne"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 55
* #UPT-a "Unterstützende Parodontaltherapie (Recall bis 3 Monate)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 200
* #UPT-b "Unterstützende Parodontaltherapie (Recall 4-6 Monate)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 160
* #UPT-c "Unterstützende Parodontaltherapie (Recall 7-12 Monate)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120
* #UPT-d "Unterstützende Parodontaltherapie (Recall über 12 Monate)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120

// Röntgenleistungen (Ä-Positionen, von GOÄ übernommen)
* #Ae925 "Intraorale Röntgenaufnahme (analog)" // copyright-allowlist: BEMA-Z Leistungstext
* #Ae925a "Intraorale Röntgenaufnahme (digital)" // copyright-allowlist: BEMA-Z Leistungstext
* #Ae5000 "Intraorale Röntgenaufnahme (GOÄ 5000)" // copyright-allowlist: BEMA-Z Leistungstext
* #Ae5002 "Panoramaaufnahme eines Kiefers (GOÄ 5002)"
* #Ae5004 "Panoramaschichtaufnahme (OPG, GOÄ 5004)" // copyright-allowlist: BEMA-Z Leistungstext
* #Ae934a "Fernröntgenaufnahme Schädel, eine Aufnahme (BEMA Ä934a)"
* #Ae935d "Orthopantomogramm, Panoramaaufnahme Ober- und Unterkiefer (BEMA Ä935d)"
* #Ae5370 "Digitale Volumentomographie (DVT, GOÄ 5370)"
