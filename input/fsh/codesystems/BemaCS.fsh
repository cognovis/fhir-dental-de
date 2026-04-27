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
* #01 "BEMA-01"
* #01a "BEMA-01a"
* #04 "BEMA-04"
* #05 "BEMA-05"
* #06 "BEMA-06"
* #07 "BEMA-07"
* #08 "BEMA-08"
* #09 "BEMA-09"
* #10 "BEMA-10"
* #11 "BEMA-11"
* #12 "BEMA-12"
* #13a "BEMA-13a"
* #13b "BEMA-13b"
* #13c "BEMA-13c"
* #13d "BEMA-13d"
* #17 "BEMA-17"
* #18 "BEMA-18"
* #19 "BEMA-19"
* #20 "BEMA-20"
* #21 "BEMA-21"
* #22 "BEMA-22"
* #23 "BEMA-23"
* #24 "BEMA-24"
* #25 "BEMA-25"
* #26 "BEMA-26"
* #27 "BEMA-27"
* #28 "BEMA-28"
* #29 "BEMA-29"
* #30 "BEMA-30"
* #31 "BEMA-31"
* #32 "BEMA-32"
* #33 "BEMA-33"
* #34 "BEMA-34"
* #35 "BEMA-35"
* #36 "BEMA-36"
* #37 "BEMA-37"
* #38 "BEMA-38"
* #39 "BEMA-39"

// Chirurgische Leistungen (40-52)
* #40 "BEMA-40"
* #41 "BEMA-41"
* #42 "BEMA-42"
* #43 "BEMA-43"
* #44 "BEMA-44"
* #45 "BEMA-45"
* #46 "BEMA-46"
* #47 "BEMA-47"
* #48 "BEMA-48"
* #49 "BEMA-49"
* #50 "BEMA-50"
* #51 "BEMA-51"
* #52 "BEMA-52"

// Parodontologie (100-108)
* #100 "BEMA-100"
* #101 "BEMA-101"
* #102 "BEMA-102"
* #103 "BEMA-103"
* #104 "BEMA-104"
* #105 "BEMA-105"
* #106 "BEMA-106"
* #107 "BEMA-107"
* #107a "BEMA-107a"
* #107b "BEMA-107b"
* #108 "BEMA-108"

// Früherkennung / Kinderuntersuchungen (FU)
* #FU1 "BEMA-FU1"
* #FU2 "BEMA-FU2"
* #FU3 "BEMA-FU3"
* #FU4 "BEMA-FU4"
* #FU5 "BEMA-FU5"
* #FU6 "BEMA-FU6"
* #FU7 "BEMA-FU7"
* #FU8 "BEMA-FU8"
* #FU9 "BEMA-FU9"

// Individualprophylaxe (IP)
* #IP1 "BEMA-IP1"
* #IP2 "BEMA-IP2"
* #IP3 "BEMA-IP3"
* #IP4 "BEMA-IP4"
* #IP5 "BEMA-IP5"
* #IP6 "BEMA-IP6"

// Zahnersatz - Prothetische Leistungen (75-89b)
* #75 "BEMA-75"
* #76 "BEMA-76"
* #77 "BEMA-77"
* #78 "BEMA-78"
* #79 "BEMA-79"
* #80 "BEMA-80"
* #81 "BEMA-81"
* #82 "BEMA-82"
* #84 "BEMA-84"
* #87a "BEMA-87a"
* #87b "BEMA-87b"
* #89a "BEMA-89a"
* #89b "BEMA-89b"

// Zahnersatz - Festzuschüsse (91a-98b)
* #91a "BEMA-91a"
* #91b "BEMA-91b"
* #92 "BEMA-92"
* #93a "BEMA-93a"
* #93b "BEMA-93b"
* #94a "BEMA-94a"
* #94b "BEMA-94b"
* #95a "BEMA-95a"
* #95b "BEMA-95b"
* #96a "BEMA-96a"
* #96b "BEMA-96b"
* #97a "BEMA-97a"
* #97b "BEMA-97b"
* #98a "BEMA-98a"
* #98b "BEMA-98b"

// Kieferorthopädie (119a-128)
* #119a "BEMA-119a"
* #119b "BEMA-119b"
* #119c "BEMA-119c"
* #119d "BEMA-119d"
* #120 "BEMA-120"
* #121 "BEMA-121"
* #122 "BEMA-122"
* #123 "BEMA-123"
* #124 "BEMA-124"
* #125 "BEMA-125"
* #126 "BEMA-126"
* #127 "BEMA-127"
* #128 "BEMA-128"

// PAR-Leistungen nach PAR-Richtlinie 2021
* #ATG "BEMA-ATG"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 28
* #MHU "BEMA-MHU"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 45
* #AIT-a "BEMA-AIT-a"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #AIT-b "BEMA-AIT-b"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 7
* #BEV "BEMA-BEV"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 40
* #CPT-a "BEMA-CPT-a"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 30
* #CPT-b "BEMA-CPT-b"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 55
* #UPT-a "BEMA-UPT-a"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 200
* #UPT-b "BEMA-UPT-b"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 160
* #UPT-c "BEMA-UPT-c"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120
* #UPT-d "BEMA-UPT-d"
  * ^property[0].code = #punkte
  * ^property[0].valueInteger = 120

// Röntgenleistungen (Ä-Positionen, von GOÄ übernommen)
* #Ae925 "BEMA-Ae925"
* #Ae5000 "BEMA-Ae5000"
* #Ae5002 "BEMA-Ae5002"
* #Ae5004 "BEMA-Ae5004"
