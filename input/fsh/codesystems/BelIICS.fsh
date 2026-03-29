CodeSystem: BelIICS
Id: bel-ii
Title: "BEL II - Bundeseinheitliche Leistungsbeschreibung für zahntechnische Leistungen"
Description: "Leistungsbeschreibung für zahntechnische Leistungen bei GKV-Versicherten. BEL II ist die Grundlage für die Abrechnung zahntechnischer Leistungen im Rahmen der gesetzlichen Krankenversicherung."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/bel-ii"
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag)"

// Vollgusskronen (001-020)
* #001 "Vollgusskrone NEM"
* #002 "Vollgusskrone NEM mit Schulter"
* #003 "Vollgusskrone Edelmetall"
* #004 "Vollgusskrone EM mit Schulter"
* #005 "Teleskopkrone NEM Primärteil"
* #006 "Teleskopkrone NEM Sekundärteil"
* #007 "Teleskopkrone EM Primärteil"
* #008 "Teleskopkrone EM Sekundärteil"
* #009 "Konuskrone NEM"
* #010 "Konuskrone EM"

// Verblendkronen (011-030)
* #011 "Verblendkrone NEM Kunststoff"
* #012 "Verblendkrone NEM Keramik"
* #013 "Verblendkrone EM Kunststoff"
* #014 "Verblendkrone EM Keramik"
* #015 "Vollkeramikkrone"
* #016 "Zirkonoxidkrone"
* #017 "Presskeramikkrone"

// Teilkronen / Inlays (031-060)
* #031 "Teilkrone NEM"
* #032 "Teilkrone EM"
* #033 "Metallgusskrone Molar NEM"
* #034 "Inlay NEM einflächig"
* #035 "Inlay NEM zweiflächig"
* #036 "Inlay NEM dreiflächig"
* #037 "Inlay EM einflächig"
* #038 "Inlay EM zweiflächig"
* #039 "Inlay EM dreiflächig"
* #040 "Keramikinlay einflächig"
* #041 "Keramikinlay zweiflächig"
* #042 "Keramikinlay dreiflächig"
* #043 "Kompositinlay einflächig"
* #044 "Kompositinlay zweiflächig"
* #045 "Kompositinlay dreiflächig"

// Brücken (061-090)
* #061 "Brückengerüst NEM je Glied"
* #062 "Brückengerüst EM je Glied"
* #063 "Brückenglied NEM"
* #064 "Brückenglied NEM verblendet"
* #065 "Brückenglied EM"
* #066 "Brückenglied EM verblendet"
* #067 "Brückenglied Vollkeramik"
* #068 "Klebebrücke (Maryland) NEM"
* #069 "Klebebrücke (Maryland) EM"
* #070 "Implantatbrücke NEM"

// Prothesen (091-130)
* #091 "Modellgussprothese Metallbasis"
* #092 "Modellgussprothese Klammer"
* #093 "Kunststoffteilprothese Basis"
* #094 "Kunststoffteilprothese Zahn"
* #095 "Totalprothese Oberkiefer"
* #096 "Totalprothese Unterkiefer"
* #097 "Totalprothese Oberkiefer Funktionsabdruck"
* #098 "Totalprothese Unterkiefer Funktionsabdruck"
* #099 "Prothese Aufstellung je Zahn"
* #100 "Prothesenbasis Kunststoff"
* #101 "Prothesenbasis PMMA"
* #102 "Deckprothese"
* #103 "Implantatgetragene Deckprothese"
* #104 "Stegprothese"
* #105 "Teleskopprothese"
* #106 "Hybridprothese"

// Implantologie (131-150)
* #131 "Implantataufbau konfektioniert"
* #132 "Implantataufbau individuell NEM"
* #133 "Implantataufbau individuell EM"
* #134 "Implantatkrone verschraubt"
* #135 "Implantatkrone zementiert"
* #136 "Implantatbrückengerüst"
* #137 "Locator-Attachment Matrize"
* #138 "Kugelkopf-Matrize"
* #139 "Steg auf Implantaten"
* #140 "Teleskopkrone auf Implantat"

// Schienentherapie (151-160)
* #151 "Okklusionsschiene Hart"
* #152 "Okklusionsschiene Weich"
* #153 "Aufbissschiene Michigan"
* #154 "Protrusionsschiene"
* #155 "Knirscherschiene"
* #156 "Repositionierungsschiene"

// Kieferorthopädie (161-175)
* #161 "Herausnehmbare KFO-Apparatur"
* #162 "Aktivator"
* #163 "Funktionskieferorthopädisches Gerät"
* #164 "Retainer herausnehmbar"
* #165 "Retainer festsitzend"
* #166 "Gaumennahterweiterungsgerät"

// Reparaturen (176-200)
* #176 "Reparatur Bruch Prothesenbasis"
* #177 "Reparatur Zahnfraktur"
* #178 "Reparatur Klammer"
* #179 "Unterfütterung Prothese direkt"
* #180 "Unterfütterung Prothese indirekt"
* #181 "Verblendung Reparatur"
* #182 "Krone Reparatur Verblendung"
* #183 "Prothese reinigen polieren"
* #184 "Prothesenreparatur einfach"
* #185 "Prothesenreparatur komplex"
* #186 "Implantataufbau Wechsel"
* #187 "Schraubenlockerung beheben"
* #188 "Zahnersatz anpassen"
* #189 "Zahnersatz erweitern je Zahn"
* #190 "Zahnersatz umarbeiten"

// Abformung / Modellarbeit (201-215)
* #201 "Modell Gips"
* #202 "Modell Superhartgips"
* #203 "Sägemodell"
* #204 "Situationsabdruck"
* #205 "Funktionsabdruck"
* #206 "Registrierung"
* #207 "Gesichtsbogen-Übertragung"
* #208 "Bisssplint"
* #209 "Okklusionsanalyse"
