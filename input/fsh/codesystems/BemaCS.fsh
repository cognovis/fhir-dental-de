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
* #01 ""
* #01a ""
* #04 ""
* #05 ""
* #06 ""
* #07 ""
* #08 ""
* #09 ""
* #10 ""
* #11 ""
* #12 ""
* #13a ""
* #13b ""
* #13c ""
* #13d ""
* #17 ""
* #18 ""
* #19 ""
* #20 ""
* #21 ""
* #22 ""
* #23 ""
* #24 ""
* #25 ""
* #26 ""
* #27 ""
* #28 ""
* #29 ""
* #30 ""
* #31 ""
* #32 ""
* #33 ""
* #34 ""
* #35 ""
* #36 ""
* #37 ""
* #38 ""
* #39 ""

// Chirurgische Leistungen (40-52)
* #40 ""
* #41 ""
* #42 ""
* #43 ""
* #44 ""
* #45 ""
* #46 ""
* #47 ""
* #48 ""
* #49 ""
* #50 ""
* #51 ""
* #52 ""

// Parodontologie (100-108)
* #100 ""
* #101 ""
* #102 ""
* #103 ""
* #104 ""
* #105 ""
* #106 ""
* #107 ""
* #107a ""
* #107b ""
* #108 ""

// Früherkennung / Kinderuntersuchungen (FU)
* #FU1 ""
* #FU2 ""
* #FU3 ""
* #FU4 ""
* #FU5 ""
* #FU6 ""
* #FU7 ""
* #FU8 ""
* #FU9 ""

// Individualprophylaxe (IP)
* #IP1 ""
* #IP2 ""
* #IP3 ""
* #IP4 ""
* #IP5 ""
* #IP6 ""

// Zahnersatz - Prothetische Leistungen (75-89b)
* #75 ""
* #76 ""
* #77 ""
* #78 ""
* #79 ""
* #80 ""
* #81 ""
* #82 ""
* #84 ""
* #87a ""
* #87b ""
* #89a ""
* #89b ""

// Zahnersatz - Festzuschüsse (91a-98b)
* #91a ""
* #91b ""
* #92 ""
* #93a ""
* #93b ""
* #94a ""
* #94b ""
* #95a ""
* #95b ""
* #96a ""
* #96b ""
* #97a ""
* #97b ""
* #98a ""
* #98b ""

// Kieferorthopädie (119a-128)
* #119a ""
* #119b ""
* #119c ""
* #119d ""
* #120 ""
* #121 ""
* #122 ""
* #123 ""
* #124 ""
* #125 ""
* #126 ""
* #127 ""
* #128 ""

// PAR-Leistungen nach PAR-Richtlinie 2021
* #ATG ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 28
* #MHU ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 45
* #AIT-a ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #AIT-b ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #BEV ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 40
* #CPT-a ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 30
* #CPT-b ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 55
* #UPT-a ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 200
* #UPT-b ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 160
* #UPT-c ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120
* #UPT-d ""
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120

// Röntgenleistungen (Ä-Positionen, von GOÄ übernommen)
* #Ae925 ""
* #Ae5000 ""
* #Ae5002 ""
* #Ae5004 ""
