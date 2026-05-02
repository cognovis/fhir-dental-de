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
* #01 "Eingehende Untersuchung"
* #01a "Eingehende Untersuchung Nachkontrolle"
* #04 "Lokale Anästhesie"
* #05 "Exstirpation Pulpa"
* #06 "Überkappung direkt"
* #07 "Überkappung indirekt"
* #08 "Devitalisierung Pulpa"
* #09 "Einlage Medikament (Einlage)"
* #10 "Wurzelkanalaufbereitung einwurzelig"
* #11 "Wurzelkanalaufbereitung zweiw. (zweiter Kanal)"
* #12 "Wurzelkanalaufbereitung mehrw. (dritter Kanal)"
* #13a "Wurzelkanalfüllung einwurzelig"
* #13b "Wurzelkanalfüllung zweiw. (zweiter Kanal)"
* #13c "Wurzelkanalfüllung mehrw. (dritter Kanal)"
* #13d "Wurzelkanalfüllung (vierter Kanal)"
* #17 "Aufbaufüllung"
* #18 "Kompositfüllung einflächig"
* #19 "Kompositfüllung zweiflächig"
* #20 "Kompositfüllung dreiflächig"
* #21 "Einflächige Füllung Seitenzahn"
* #22 "Zweiflächige Füllung Seitenzahn"
* #23 "Dreiflächige Füllung Seitenzahn"
* #24 "Vier- oder mehrflächige Füllung Seitenzahn"
* #25 "Einflächige Füllung Frontzahn"
* #26 "Zweiflächige Füllung Frontzahn"
* #27 "Dreiflächige Füllung Frontzahn"
* #28 "Vier- oder mehrflächige Füllung Frontzahn"
* #29 "Fissurenversiegelung"
* #30 "Nachbehandlung nach Extraktion"
* #31 "Versiegelung kariesfreier Fissuren"
* #32 "Adhäsive Befestigung"
* #33 "Provisorische Krone"
* #34 "Teilkrone"
* #35 "Verblendkrone"
* #36 "Stahlkrone als Aufbaukrone"
* #37 "Einlagefüllung (Inlay)"
* #38 "Behandlung Zahnhartsubstanzdefekt"
* #39 "Entfernung Füllungsmaterial"

// Chirurgische Leistungen (40-52)
* #40 "Einfache Extraktion"
* #41 "Operative Zahnentfernung"
* #42 "Wurzelspitzenresektion einwurzelig"
* #43 "Wurzelspitzenresektion zweiw. oder mehrw."
* #44 "Alveolitis-Behandlung"
* #45 "Inzision Abszess"
* #46 "Naht Wundversorgung"
* #47 "Exzision Schleimhaut"
* #48 "Entfernung Zyste"
* #49 "Entfernung retinierten Zahnes (Osteotomie)"
* #50 "Plastische Deckung Alveole"
* #51 "Frenektomie"
* #52 "Sequestrotomie"

// Parodontologie (100-108)
* #100 "Parodontalstatus"
* #101 "Mundhygiene-Unterweisung"
* #102 "Supragingivale Zahnsteinentfernung"
* #103 "Subgingivale Instrumentierung je Quadrant"
* #104 "Lappenoperation parodontal"
* #105 "Gingivektomie"
* #106 "Schienung parodontal gelockerter Zähne"
* #107 "Nachbehandlung nach PAR-Therapie"
* #107a "Nachbehandlung PAR (erste Sitzung)"
* #107b "Nachbehandlung PAR (weitere Sitzung)"
* #108 "Knochenregeneration parodontal"

// Früherkennung / Kinderuntersuchungen (FU)
* #FU1 "Früherkennungsuntersuchung Säugling (ab 6. Lebensmonat)"
* #FU2 "Früherkennungsuntersuchung Kleinkind (12-24 Monate)"
* #FU3 "Früherkennungsuntersuchung Kleinkind (24-36 Monate)"
* #FU4 "Früherkennungsuntersuchung Kind (3-6 Jahre)"
* #FU5 "Früherkennungsuntersuchung Kind (6-9 Jahre)"
* #FU6 "Früherkennungsuntersuchung Kind (9-12 Jahre)"
* #FU7 "Früherkennungsuntersuchung Jugendlicher (12-15 Jahre)"
* #FU8 "Früherkennungsuntersuchung Jugendlicher (15-18 Jahre)"
* #FU9 "Früherkennungsuntersuchung für Kinder mit erhöhtem Kariesrisiko"

// Individualprophylaxe (IP)
* #IP1 "Mundhygienestatus Erhebung"
* #IP2 "Mundhygiene-Unterweisung und -Instruktion"
* #IP3 "Zahnreinigung (professionell)"
* #IP4 "Fluoridierung lokale Applikation"
* #IP5 "Fissurenversiegelung"
* #IP6 "Remotivation und Erfolgskontrolle"

// Zahnersatz - Prothetische Leistungen (75-89b)
* #75 "Abformung für Zahnersatz"
* #76 "Kieferrelationsbestimmung"
* #77 "Anprobe Zahnersatz"
* #78 "Eingliederung Zahnersatz"
* #79 "Nachbehandlung Zahnersatz"
* #80 "Unterfütterung Prothese"
* #81 "Reparatur Prothese"
* #82 "Erneuerung Prothesenzahn"
* #84 "Implantologische Nachsorge"
* #87a "Provisorische Krone oder Brückenglied (laborgefertigt)"
* #87b "Provisorische Teilprothese (laborgefertigt)"
* #89a "Implantatgetragene Krone"
* #89b "Implantatgetragene Brücke"

// Zahnersatz - Festzuschüsse (91a-98b)
* #91a "Festzuschuss: Einzelkrone (Standardversorgung)"
* #91b "Festzuschuss: Einzelkrone (gleichartige Versorgung)"
* #92 "Festzuschuss: Inlay oder Teilkrone"
* #93a "Festzuschuss: Brückenglied (Standardversorgung)"
* #93b "Festzuschuss: Brückenglied (gleichartige Versorgung)"
* #94a "Festzuschuss: Prothesenzahn (Standardversorgung)"
* #94b "Festzuschuss: Prothesenzahn (gleichartige Versorgung)"
* #95a "Festzuschuss: Modellgussprothese (Standardversorgung)"
* #95b "Festzuschuss: Modellgussprothese (gleichartige Versorgung)"
* #96a "Festzuschuss: Totalprothese (Standardversorgung)"
* #96b "Festzuschuss: Totalprothese (gleichartige Versorgung)"
* #97a "Festzuschuss: Implantatgetragener Zahnersatz (Standardversorgung)"
* #97b "Festzuschuss: Implantatgetragener Zahnersatz (gleichartige Versorgung)"
* #98a "Festzuschuss: Wiederherstellung (Standardversorgung)"
* #98b "Festzuschuss: Wiederherstellung (gleichartige Versorgung)"

// Kieferorthopädie (119a-128)
* #119a "KFO-Untersuchung und Planung (Erstuntersuchung)"
* #119b "KFO-Untersuchung und Planung (Folgeuntersuchung)"
* #119c "KFO-Diagnostik Modellanalyse"
* #119d "KFO-Diagnostik Fernröntgen-Analyse"
* #120 "Herausnehmbare Apparatur einfach"
* #121 "Herausnehmbare Apparatur aufwendig"
* #122 "Aktivator oder Bionator"
* #123 "Funktionskieferorthopädisches Gerät"
* #124 "Festsitzende Apparatur je Zahn (Bracket)"
* #125 "Gaumennahterweiterungsgerät"
* #126 "KFO-Retention herausnehmbar"
* #127 "KFO-Retention festsitzend"
* #128 "KFO-Nachsorge und Kontrolle"

// PAR-Leistungen nach PAR-Richtlinie 2021
* #ATG "Antiinfektiöse Therapie, subgingival, Full-Mouth"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 28
* #MHU "Mund- und Hygieneunterweisung"
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
* #Ae925 "Intraorale Röntgenaufnahme (analog)"
* #Ae925a "Intraorale Röntgenaufnahme (digital)"
* #Ae5000 "Intraorale Röntgenaufnahme (GOÄ 5000)"
* #Ae5002 "Intraorale Röntgenaufnahme, zweite Aufnahme (GOÄ 5002)"
* #Ae5004 "Panoramaschichtaufnahme (OPG, GOÄ 5004)"
* #Ae934a "Schädelaufnahme in zwei Ebenen (GOÄ 934a)"
* #Ae935d "Fernröntgenaufnahme Seitenprofil (GOÄ 935d)"
* #Ae5370 "Digitale Volumentomographie (DVT, GOÄ 5370)"
