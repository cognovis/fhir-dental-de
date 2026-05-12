CodeSystem: ZeBefundkuerzelCS
Id: ze-befundkuerzel
Title: "ZE-Befundkürzel (cognovis erweiterte Dental-Status-Taxonomie)"
Description: """
Cognovis-redaktionelle, **erweiterte** Befundkürzel-Liste für den Zahnersatz-Ist-Zustand. Verwendet im fhir-dental-de IG, wo eine breitere Differenzierung benötigt wird als die offizielle KZBV-DPF-Liste hergibt (z.B. "kr"=Kronreparatur nötig, "Atx"=Attachment, "MagA"=Magnetanker — Konzepte, die EBZ Anlage 2 nicht abbildet).

**Dies ist NICHT die offizielle KZBV-DPF-Kürzel-Liste.** Für KZBV-EBZ-konforme Workflows (Anträge, Genehmigungsverfahren, Reconciliation) ist die authoritative Code-Liste:

  - **`http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel`** (33 Codes, EBZ Anlage 2 2022-05-25)
  - distributed via `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` auf `npm.cognovis.de`

Achtung **Semantik-Konflikt** zwischen den beiden CSes:

| Code | KZBV DPF              | cognovis (dieses CS)      |
|------|------------------------|----------------------------|
| `e`  | ersetzter Zahn         | Eigener Zahn (Gegenteil!) |
| `k`  | klinisch intakte Krone | Krone (allgemein)         |
| `b`  | Brückenglied           | Brücke                    |

Anwendungs-Schicht muss explizit wählen welcher Namespace gemeint ist. Siehe ADR-004 in fhir-terminology-de.
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag — erweitert KZBV DPF, nicht identisch)"

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
