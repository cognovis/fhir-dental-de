CodeSystem: ZeBefundkuerzelCS
Id: ze-befundkuerzel
Title: "ZE-Befundkürzel (KZBV DPF)"
Description: "Befundkürzel für den Zahnersatz-Befund (Ist-Zustand) gemäß KZBV Digitaler Planungsbogen für Zahnersatz (DPF)."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel"
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag)"

// Fehlende Zähne
* #x "Zahn fehlt"
* #xb "Fehlend, mit Zahnersatz versorgt"
* #xw "Fehlend, wird nicht ersetzt"

// Eigene Zähne
* #e "Eigener Zahn"
* #ek "Eigener Zahn mit Krone"
* #ep "Eigener Zahn mit Teilkrone/Inlay"

// Kronen und Brücken
* #k "Krone"
* #tK "Teleskopkrone"
* #kb "Krone als Brückenpfeiler"
* #kbw "Krone als Brückenpfeiler und -zwischenglied"
* #bg "Brückenglied"
* #b "Brücke"

// Parodontologie
* #pa "Parodontal behandlungsbedürftig"
* #pw "Erhaltungswürdiger Zahn mit partieller Zerstörung" "Eigener Zahn mit partieller Substanzzerstörung, erhaltungswürdig"

// Wurzelversorgung
* #w "Wurzelstift"
* #wk "Wurzelstift mit Krone"

// Implantate
* #impl "Implantat"
* #ikr "Implantatgetragene Krone"
* #ibrg "Implantatgetragenes Brückenglied"

// Prothesen
* #p "Teilprothese"
* #pp "Totalprothese (Vollprothese)"
* #pr "Prothese mit Resilienzverankerung"
* #psr "Prothese mit Schieberesilienz"

// Spezielle Konstruktionen
* #ga "Gegossene Basis"
* #ga-p "Gegossene Basis Prothese"
* #TK "Teleskopkrone (Großbuchstabe)"
* #Sup "Suprakonstruktion"
* #Atx "Attachment"
* #Bar "Stegverankerung"
* #HerA "Herausnehmbares Attachment"
* #StegP "Stegprothese"
* #LocA "Locator-Attachment"
* #BallA "Kugelkopf-Attachment"
* #MagA "Magnetanker"
* #Sp "Spezialanker"

// Erweiterte Befundkürzel
* #zw "Zahn (Wurzelrest)"
* #fe "Fehlend, ersetzt durch Implantat"
* #fp "Fehlend, Prothese geplant"
* #ku "Krone ungünstig"
* #kr "Kronreparatur nötig"
* #kd "Krone defekt"
* #ie "Inlay-Ersatz"
* #ia "Inlay (Amalgam)"
* #ik "Inlay (Kunststoff)"
* #ig "Inlay (Gold/Guß)"
* #ic "Inlay (Keramik)"
* #vn "Veneer"
* #prd "Prothese reparaturbedürftig"
* #pd "Prothese defekt"
* #pe "Prothesenzahn fehlt"
* #si "Stiftaufbau (gegossen)"
