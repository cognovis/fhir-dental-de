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
* ^property[0].code = #punkte
* ^property[0].uri = "https://fhir.cognovis.de/dental/CodeSystem/property#punkte"
* ^property[0].description = "BEMA-Punktzahl"
* ^property[0].type = #integer

// Konservierende Behandlung (01-39)
* #01 "Eingehende Untersuchung"
* #01a "Zuschlag Untersuchung bei FLA"
* #04 "Vitalitätsprüfung"
* #05 "Besondere Untersuchung"
* #06 "Notfallbehandlung"
* #07 "Beratung"
* #08 "Sensibilitätsprüfung"
* #09 "Lokalanästhesie"
* #10 "Leitungsanästhesie"
* #11 "Intraligamentäre Anästhesie"
* #12 "Kompositfüllung einflächig (Milchzahn)"
* #13a "Kompositfüllung einflächig"
* #13b "Kompositfüllung zweiflächig"
* #13c "Kompositfüllung dreiflächig"
* #13d "Kompositfüllung mehr als dreiflächig"
* #17 "Amalgamfüllung einflächig"
* #18 "Amalgamfüllung zweiflächig"
* #19 "Amalgamfüllung dreiflächig"
* #20 "Amalgamfüllung mehr als dreiflächig"
* #21 "Zementfüllung"
* #22 "Glasionomerfüllung"
* #23 "Provisorische Füllung"
* #24 "Sedative Einlage"
* #25 "Unterfüllung"
* #26 "Überkappung direkt"
* #27 "Überkappung indirekt"
* #28 "Wurzelkanalbehandlung Frontzahn"
* #29 "Wurzelkanalbehandlung Prämolar"
* #30 "Wurzelkanalbehandlung Molar"
* #31 "Wurzelkanalaufbereitung je Kanal"
* #32 "Wurzelkanalfüllung je Kanal"
* #33 "Replantation"
* #34 "Revision Wurzelkanalbehandlung"
* #35 "Wurzelspitzenresektion Frontzahn"
* #36 "Wurzelspitzenresektion Prämolar"
* #37 "Wurzelspitzenresektion Molar"
* #38 "Stiftverankerung"
* #39 "Aufbaufüllung"

// Chirurgische Leistungen (40-52)
* #40 "Inzision"
* #41 "Trepanation"
* #42 "Alveolitis-Behandlung"
* #43 "Wundbehandlung"
* #44 "Extraktion"
* #45 "Operative Zahnentfernung"
* #46 "Osteotomie"
* #47 "Stillung einer Blutung"
* #48 "Wundrevision"
* #49 "Naht"
* #50 "Nahtentfernung"
* #51 "Lappenbildung"
* #52 "Zystenoperation"

// Parodontologie (100-108)
* #100 "PAR-Vorbehandlung"
* #101 "PSI-Screening"
* #102 "Parodontalstatus"
* #103 "Subgingivale Instrumentierung je Zahn"
* #104 "Parodontalchirurgie"
* #105 "Lappenoperation"
* #106 "Gingivektomie je Zahn"
* #107 "Subgingivale Instrumentierung je Zahn (PAR-Richtlinie)"
* #107a "Instrumentierung Frontzahn"
* #107b "Instrumentierung Seitenzahn"
* #108 "Nachsorge parodontal"

// Früherkennung / Kinderuntersuchungen (FU)
* #FU1 "Früherkennungsuntersuchung 6-9 Monate"
* #FU2 "Früherkennungsuntersuchung 10-20 Monate"
* #FU3 "Früherkennungsuntersuchung 21-33 Monate"
* #FU4 "Früherkennungsuntersuchung 34-48 Monate"
* #FU5 "Früherkennungsuntersuchung 49-60 Monate"
* #FU6 "Früherkennungsuntersuchung 61-72 Monate"
* #FU7 "Früherkennungsuntersuchung Kleinkind"
* #FU8 "Früherkennungsuntersuchung Vorschulkind"
* #FU9 "Früherkennungsuntersuchung Schulkind"

// Individualprophylaxe (IP)
* #IP1 "Mundhygienestatus"
* #IP2 "Aufklärung Mundhygiene"
* #IP3 "Mundgesundheitserziehung"
* #IP4 "Fluoridierung"
* #IP5 "Fissurenversiegelung"
* #IP6 "Intensivprophylaxe"

// Zahnersatz - Prothetische Leistungen (75-89b)
* #75 "Abformung Zahnersatz"
* #76 "Registrierung Kiefer"
* #77 "Vollprothese"
* #78 "Teilprothese"
* #79 "Reparatur Prothese"
* #80 "Prothesenbasis erneuern"
* #81 "Prothesenzahn ersetzen"
* #82 "Prothesenunterfütterung"
* #84 "Implantologischer Befund"
* #87a "Stiftaufbau"
* #87b "Stiftaufbau komplex"
* #89a "Provisorische Krone"
* #89b "Langzeitprovisorium"

// Zahnersatz - Festzuschüsse (91a-98b)
* #91a "Kronenversorgung"
* #91b "Kronenversorgung mit Verblendung"
* #92 "Teilkrone"
* #93a "Brückenglied"
* #93b "Brückenglied mit Verblendung"
* #94a "Brückenpfeiler Krone"
* #94b "Brückenpfeiler Krone mit Verblendung"
* #95a "Teleskopkrone"
* #95b "Teleskopkrone mit Verblendung"
* #96a "Abnehmbare Teilprothese"
* #96b "Abnehmbare Teilprothese erweitertes Heil- und Kostenplan"
* #97a "Totalprothese"
* #97b "Totalprothese Oberkiefer und Unterkiefer"
* #98a "Reparatur Zahnersatz"
* #98b "Unterfütterung Prothese"

// Kieferorthopädie (119a-128)
* #119a "Diagnostik KFO Einfach"
* #119b "Diagnostik KFO Aufwendig"
* #119c "KFO Behandlungsplanung"
* #119d "KFO Behandlungsplan schriftlich"
* #120 "Aktivator"
* #121 "Funktionskieferorthopädisches Gerät"
* #122 "Herausnehmbare Zahnspange einfach"
* #123 "Herausnehmbare Zahnspange aufwendig"
* #124 "Festsitzende Klammer"
* #125 "Multiband-Apparatur"
* #126 "KFO Retention"
* #127 "KFO Abschlussuntersuchung"
* #128 "KFO Nachsorge"

// PAR-Leistungen nach PAR-Richtlinie 2021
* #ATG "Parodontologisches Aufklärungs- und Therapiegespräch (28 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 28
* #MHU "Patientenindividuelle Mundhygieneunterweisung (45 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 45
* #AIT-a "Antiinfektiöse Therapie geschlossen (pro Zahn) (7 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #AIT-b "Antiinfektiöse Therapie offen (pro Zahn) (7 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #BEV "Befundevaluation (40 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 40
* #CPT-a "Chirurgische PAR-Therapie Lappenoperation (pro Zahn) (30 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 30
* #CPT-b "Chirurgische PAR-Therapie regenerativ (pro Zahn) (55 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 55
* #UPT-a "Unterstützende Parodontitistherapie bis 6. Monat (200 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 200
* #UPT-b "Unterstützende Parodontitistherapie 7.-12. Monat (160 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 160
* #UPT-c "Unterstützende Parodontitistherapie 13.-18. Monat (120 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120
* #UPT-d "Unterstützende Parodontitistherapie 19.-24. Monat (120 Punkte)"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120

// Röntgenleistungen (Ä-Positionen, von GOÄ übernommen)
* #Ae925 "Panoramaschichtaufnahme"
* #Ae5000 "Intraorale Röntgenaufnahme"
* #Ae5002 "Intraorale Röntgenaufnahme (zweite)"
* #Ae5004 "Intraorale Röntgenaufnahme (weitere)"
