CodeSystem: DentalBefundStatusCS
Id: dental-befund-status
Title: "Zahnärztlicher Befundstatus"
Description: "Statuscodes für den zahnärztlichen Befund (B-Zeile im HKP). Kleinbuchstaben = Befund, Großbuchstaben = geplante Therapie. Nach KZBV-Befundschema."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

// Befund (Kleinbuchstaben)
* #f "fehlend" "Zahn fehlt"
* #z "zerstört" "Zahn ist zerstört und nicht erhaltungswürdig"
* #c "kariös" "Zahn hat Karies"
* #x "extraktionswürdig" "Zahn ist extraktionswürdig"
* #e "ersetzt" "Zahn ist durch Zahnersatz ersetzt"
* #k "Krone vorhanden" "Zahn ist mit einer Krone versorgt"
* #b "Brückenglied vorhanden" "Zahn ist als Brückenglied versorgt"
* #i "Implantat vorhanden" "Implantat ist vorhanden"
* #t "Teleskopkrone" "Zahn ist mit einer Teleskopkrone versorgt"
* #pw "erhaltungswürdiger Zahn mit partieller Zerstörung" "Teilweise zerstört, aber erhaltungswürdig"
* #ww "weitgehend zerstört, Erhaltungswürdigkeit fraglich" "Weitgehend zerstört"
* #ur "überkronungsbedürftig, Restzahnsubstanz reicht für Aufbau" "Überkronungsbedürftig"
* #uw "überkronungsbedürftig, Aufbau nötig" "Überkronungsbedürftig mit Aufbaufüllung"

// Therapie (Großbuchstaben)
* #E "Extraktion geplant" "Zahn soll extrahiert werden"
* #K "Krone geplant" "Kronenversorgung geplant"
* #B "Brückenglied geplant" "Brückenversorgung geplant"
* #PK "Teilkrone geplant" "Teilkrone geplant"
* #V "Veneer geplant" "Veneer geplant"
* #I "Implantat geplant" "Implantation geplant"
* #T "Teleskopkrone geplant" "Teleskopkrone geplant"
* #R "Regelversorgung" "Regelversorgung nach Festzuschuss-Richtlinie"
